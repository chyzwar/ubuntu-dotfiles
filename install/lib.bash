#!/usr/bin/env bash
# Shared helpers for install scripts. Source it, don't run it.
# shellcheck disable=SC2034

DOTFILES_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.." && pwd)"
export DOTFILES_DIR

info () { tput setaf 2; echo "$*"; tput sgr0; }
warn () { tput setaf 3; echo "$*"; tput sgr0; }
error () { tput setaf 1; echo "$*" >&2; tput sgr0; }

# confirm "Question" -> 0 on Yes, 1 on No
confirm () {
    info "$1"
    local yn
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) return 0;;
            No )  return 1;;
        esac
    done
}

apt_update () {
    sudo apt-get update -qq
}

# Install all packages at once; if that fails, retry one at a time so a
# single missing package name doesn't take the whole batch down.
apt_install () {
    if ! sudo apt-get install -y "$@"; then
        warn "Batch install failed, retrying one package at a time"
        local pkg
        for pkg in "$@"; do
            sudo apt-get install -y "$pkg" || warn "Could not install $pkg"
        done
    fi
}

snap_install () {
    sudo snap install "$@"
}

# apt_repo NAME KEY_URL URI SUITES [COMPONENTS] [ARCHITECTURES]
# Writes /etc/apt/sources.list.d/NAME.sources with the signing key embedded in
# Signed-By, as apt-secure(8) recommends, so there is no separate keyring file.
# Embedding needs an armored key, so a binary one is armored first. An empty
# COMPONENTS makes a flat repository. Keep NAME stable: a second file for the
# same repository with a different key makes apt refuse to read any sources.
apt_repo () {
    local name=$1 key_url=$2 uri=$3 suites=$4 components=$5
    local arch=${6:-$(dpkg --print-architecture)}
    local tmp key
    tmp="$(mktemp -d)"
    if ! curl -fsSL "$key_url" -o "$tmp/key"; then
        warn "Could not fetch the signing key for $name"
        rm -rf "$tmp"
        return 1
    fi
    if grep -q -- '-----BEGIN PGP PUBLIC KEY BLOCK-----' "$tmp/key"; then
        key="$(cat "$tmp/key")"
    else
        # a throwaway keyring, so nothing lands in the user's own
        GNUPGHOME="$tmp" gpg --quiet --import "$tmp/key" 2>/dev/null
        key="$(GNUPGHOME="$tmp" gpg --export-options export-minimal --armor --export)"
        gpgconf --homedir "$tmp" --kill all 2>/dev/null
    fi
    rm -rf "$tmp"
    if [ -z "$key" ]; then
        warn "Could not read the signing key for $name"
        return 1
    fi

    {
        echo "Types: deb"
        echo "URIs: $uri"
        echo "Suites: $suites"
        [ -n "$components" ] && echo "Components: $components"
        echo "Architectures: $arch"
        echo "Signed-By:"
        # deb822 continuation lines: indent, and a lone dot for a blank line
        printf '%s\n' "$key" | sed -e 's/^$/./' -e 's/^/ /'
    } | sudo tee "/etc/apt/sources.list.d/$name.sources" >/dev/null

    # the keyring the old two-step setup left behind, now unused
    sudo rm -f "/etc/apt/keyrings/$name.asc" "/etc/apt/keyrings/$name.gpg"
}

ubuntu_codename () {
    # shellcheck disable=SC1091
    . /etc/os-release
    echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}"
}

# sysctl_set KEY VALUE -> upsert into /etc/sysctl.d/99-dotfiles.conf
sysctl_set () {
    local key=$1 value=$2 file=/etc/sysctl.d/99-dotfiles.conf
    sudo touch "$file"
    if grep -q "^$key=" "$file"; then
        sudo sed -i "s|^$key=.*|$key=$value|" "$file"
    else
        echo "$key=$value" | sudo tee -a "$file" >/dev/null
    fi
    sudo sysctl --system >/dev/null
}

# git_clone_or_pull URL DIR [extra git clone args...]
git_clone_or_pull () {
    local url=$1 dir=$2
    shift 2
    if [ -d "$dir/.git" ]; then
        git -C "$dir" pull --ff-only
    else
        git clone "$@" "$url" "$dir"
    fi
}

# link SRC DST
link () {
    ln -sfnv "$1" "$2"
}

# deb_install URL [NAME]
deb_install () {
    local url=$1 name=${2:-package}
    local tmp
    tmp="$(mktemp -d)"
    curl -fL "$url" -o "$tmp/$name.deb"
    sudo apt-get install -y "$tmp/$name.deb"
    rm -rf "$tmp"
}

# github_latest_tag OWNER/REPO [--prerelease] [PREFIX]
# Prints the newest release tag (version-sorted). With --prerelease, pre-releases
# whose tag starts with PREFIX are candidates too; falls back to the latest release.
github_latest_tag () {
    local repo=$1 prerelease=0 prefix=""
    shift
    while [ $# -gt 0 ]; do
        case $1 in
            --prerelease) prerelease=1;;
            *) prefix=$1;;
        esac
        shift
    done
    local tag=""
    if [ "$prerelease" = 1 ]; then
        tag="$(curl -fsSL "https://api.github.com/repos/$repo/releases?per_page=30" \
            | python3 -c '
import json, sys
prefix = sys.argv[1]
for r in json.load(sys.stdin):
    if r["tag_name"].startswith(prefix):
        print(r["tag_name"])
' "$prefix" 2>/dev/null | sort -V | tail -1)"
    fi
    if [ -z "$tag" ]; then
        tag="$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" \
            | python3 -c 'import json,sys; print(json.load(sys.stdin)["tag_name"])' 2>/dev/null)"
    fi
    [ -n "$tag" ] && echo "$tag"
}
