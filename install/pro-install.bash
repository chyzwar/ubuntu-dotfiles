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


if confirm "Do you want to install ocaml (opam via mise)"; then
    install_mise
    mise use -g opam@latest

    # opam sandboxes builds with bwrap; the static opam binary from mise does not pull it in.
    # Ubuntu >= 25.04 ships /etc/apparmor.d/bwrap-userns-restrict in the apparmor package,
    # so the sandbox works despite kernel.apparmor_restrict_unprivileged_userns=1
    # (ocaml/opam#5968). If init still reports "Sandboxing is not working",
    # rerun with: opam init --disable-sandboxing
    apt_install bubblewrap
    # compiles the latest OCaml into the default switch
    opam init
    eval "$(opam env)"
    opam install merlin ocaml-lsp-server user-setup
    opam user-setup install
fi


if confirm "Do you want to install VirtualBox"; then
    apt_install virtualbox virtualbox-guest-additions-iso
    sudo usermod -aG vboxusers "$USER"
fi


if confirm "Do you want to install rust and rustup.rs"; then
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
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


if confirm "Do you want to install deno"; then
    curl -fsSL https://deno.land/install.sh | sh
fi


if confirm "Do you want to install bun"; then
    curl -fsSL https://bun.sh/install | bash
fi


if confirm "Do you want to install Java (8, 21, 25) and tools"; then
    apt_install openjdk-8-jdk openjdk-21-jdk openjdk-25-jdk maven gradle ant
    sudo update-java-alternatives -s java-1.21.0-openjdk-amd64
fi


if confirm "Do you want to install Scala, sbt and scala-cli (mise; assumes Java is installed)"; then
    install_mise
    mise use -g scala@latest sbt@latest scala-cli@latest
fi


if confirm "Do you want to install Clojure and lein"; then
    apt_install leiningen clojure
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


if confirm "Do you want to install Terraform (mise)"; then
    install_mise
    mise use -g terraform@latest
fi

if confirm "Do you want to install zig (mise: nightly master + latest stable)"; then
    install_mise
    mise use -g zig@master zig@latest
fi

if confirm "Do you want to install Crystal (mise)"; then
    # link-time deps of the official binaries, as declared by the crystal deb
    # (Depends + Recommends: openssl, zlib, xml, gmp, yaml stdlib bindings)
    apt_install gcc pkg-config libpcre2-dev libevent-dev \
        libssl-dev zlib1g-dev libxml2-dev libgmp-dev libyaml-dev

    install_mise
    mise use -g crystal@latest
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





if confirm "Do you want to install roc (official installer, nightly)"; then
    # https://www.roc-lang.org/install/unix
    # The installer downloads and extracts into $PWD, so run it from a temp dir.
    # ROC_INSTALL_DIR makes it copy the binary out; answer "no" to the PATH prompt,
    # ~/.local/bin is already on PATH.
    (
        cd "$(mktemp -d)" || exit 1
        export ROC_INSTALL_DIR="$HOME/.local/bin"
        curl -fsSL https://roc-lang.org/install_roc.sh | sh
    )
fi
