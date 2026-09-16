#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# https://mise.jdx.dev - installs ~/.local/bin/mise, idempotent
install_mise () {
    command -v mise >/dev/null 2>&1 && return 0
    curl -fsSL https://mise.run | sh
    mkdir -p "$HOME/.local/share/bash-completion/completions"
    mise completion bash > "$HOME/.local/share/bash-completion/completions/mise"
}


if confirm "Do you want to install Python tools (uv, pipenv, poetry)"; then
    curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh

    # managed interpreter; --default also links python/python3 into ~/.local/bin
    uv python install 3.13 --default

    uv tool install pipenv
    uv tool install poetry
fi


if confirm "Do you want to install node.js and tools (nodenv, npm, yarn, pnpm)"; then
    git_clone_or_pull https://github.com/nodenv/nodenv.git ~/.nodenv
    (cd ~/.nodenv && src/configure && make -C src) || warn "nodenv bash extension build failed (optional)"
    git_clone_or_pull https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
    git_clone_or_pull https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs

    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
    nodenv update-version-defs >/dev/null 2>&1 || true

    # newest release of a major line, e.g. nodenv_latest 22 -> 22.x.y
    nodenv_latest () { nodenv install -l | grep -E "^$1\." | sort -V | tail -1; }

    for major in 22 24; do
        version="$(nodenv_latest "$major")"
        echo "Installing node version $version"
        nodenv install --skip-existing "$version"
        nodenv global "$version"
        npm install -g npm yarn pnpm
    done
fi


if confirm "Do you want to install elixir and erlang (mise)"; then
    # kerl build deps (no wx / javac, see KERL_CONFIGURE_OPTIONS)
    apt_install build-essential autoconf m4 libncurses-dev libssl-dev \
        unixodbc-dev libssh-dev xsltproc fop libxml2-utils

    install_mise

    export KERL_CONFIGURE_OPTIONS="\
        --without-javac \
        --without-wx"

    mise use -g erlang@latest elixir@latest
fi


if confirm "Do you want to install ocaml"; then
    apt_install ocaml opam

    # bubblewrap sandbox is blocked by the unprivileged-userns AppArmor
    # restriction on Ubuntu >= 24.04
    opam init -y --disable-sandboxing
    eval "$(opam env)"
    opam install -y merlin ocaml-lsp-server user-setup
    opam user-setup install
fi


if confirm "Do you want to install VirtualBox"; then
    apt_install virtualbox virtualbox-guest-additions-iso
    sudo usermod -aG vboxusers "$USER"
fi


if confirm "Do you want to install rust and rustup.rs"; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
    export PATH="$HOME/.cargo/bin:$PATH"

    mkdir -p "$HOME/.local/share/bash-completion/completions"
    rustup completions bash > "$HOME/.local/share/bash-completion/completions/rustup"
    rustup completions bash cargo > "$HOME/.local/share/bash-completion/completions/cargo"

    rustup install nightly
    rustup default nightly

    cargo install eza
    cargo install fd-find
    cargo install skim
fi


if confirm "Do you want to install PHP and composer"; then
    apt_install php php-fpm php-mysql composer
fi


if confirm "Do you want to install nginx"; then
    apt_install nginx
fi


if confirm "Do you want to install deno"; then
    curl -fsSL https://deno.land/install.sh | sh -s -- --yes
fi


if confirm "Do you want to install bun"; then
    curl -fsSL https://bun.sh/install | bash
fi


if confirm "Do you want to install MariaDB"; then
    apt_install mariadb-server mariadb-client
fi


if confirm "Do you want to install Java (8, 21, 25) and tools"; then
    apt_install openjdk-8-jdk openjdk-21-jdk openjdk-25-jdk maven gradle ant
    sudo update-java-alternatives -s java-1.21.0-openjdk-amd64
fi


if confirm "Do you want to install Scala and sbt (coursier; uses installed Java or fetches a JVM)"; then
    # scala-lang.org recommended installer: scala, scalac, scala-cli, sbt, sbtn, scalafmt, ...
    tmp="$(mktemp -d)"
    curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz \
        | gzip -d > "$tmp/cs"
    chmod +x "$tmp/cs"
    # --env: print exports instead of editing shell profiles
    eval "$("$tmp/cs" setup --yes --env --install-dir "$HOME/.local/bin")"
    rm -rf "$tmp"
fi


if confirm "Do you want to install Clojure and lein"; then
    apt_install leiningen clojure
fi


if confirm "Do you want to install Haskell (ghcup: ghc, cabal, stack, hls)"; then
    apt_install build-essential curl libffi-dev libffi8 libgmp-dev libgmp10 \
        libncurses-dev pkg-config
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
    BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
    BOOTSTRAP_HASKELL_ADJUST_BASHRC=0 \
        sh -c 'curl --proto "=https" --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh'
fi


if confirm "Do you want to install go-lang"; then
    apt_install golang
fi


if confirm "Do you want to install Ruby (mise)"; then
    # only needed when no precompiled binary exists and mise falls back to ruby-build
    apt_install libyaml-dev libssl-dev libreadline-dev zlib1g-dev libgmp-dev libffi-dev

    install_mise
    mise use -g ruby@3.4
fi


if confirm "Do you want to install Terraform and tfenv"; then
    git_clone_or_pull https://github.com/tfutils/tfenv.git ~/.tfenv
    export PATH="$HOME/.tfenv/bin:$PATH"
    tfenv install latest
    tfenv use latest
fi


if confirm "Do you want to install Crystal (official apt repo)"; then
    # sets up the crystal-lang OBS apt repo for this Ubuntu release
    curl -fsSL https://crystal-lang.org/install.sh | sudo bash
fi


if confirm "Do you want to install nix"; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
fi


if confirm "Do you want to install docker (with buildx and compose plugins)"; then
    apt_keyring docker https://download.docker.com/linux/ubuntu/gpg
    apt_source docker https://download.docker.com/linux/ubuntu "$(ubuntu_codename)" stable
    apt_update
    apt_install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo groupadd -f docker
    sudo usermod -aG docker "$USER"
fi


if confirm "Do you want to install Android Studio"; then
    apt_install qemu-system-x86 libvirt-daemon-system libvirt-clients bridge-utils
    sudo usermod -aG kvm,libvirt "$USER"
    snap_install android-studio --classic
fi


if confirm "Do you want to install zig"; then
    snap_install zig --classic --beta
fi
