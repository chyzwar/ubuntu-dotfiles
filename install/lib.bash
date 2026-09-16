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

# apt_keyring NAME URL -> /etc/apt/keyrings/NAME.asc (ASCII-armored keys)
apt_keyring () {
    local name=$1 url=$2
    sudo install -d -m 0755 /etc/apt/keyrings
    sudo curl -fsSL "$url" -o "/etc/apt/keyrings/$name.asc"
}

# apt_source NAME URI SUITES COMPONENTS [ARCHITECTURES]
# Writes a deb822 source signed by /etc/apt/keyrings/NAME.asc
apt_source () {
    local name=$1 uri=$2 suites=$3 components=$4
    local arch=${5:-$(dpkg --print-architecture)}
    sudo tee "/etc/apt/sources.list.d/$name.sources" >/dev/null <<SRC
Types: deb
URIs: $uri
Suites: $suites
Components: $components
Architectures: $arch
Signed-By: /etc/apt/keyrings/$name.asc
SRC
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
