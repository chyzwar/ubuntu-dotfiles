#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install vim"
apt_install vim

info "Link .vimrc"
link "$DOTFILES_DIR/etc/vim/.vimrc" "$HOME/.vimrc"
