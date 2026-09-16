#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install yakuake (drop-down terminal)"
apt_install yakuake

info "Install foot terminal"
apt_install foot

info "Install liquidprompt"
apt_install liquidprompt

info "Create symlinks"
link "$DOTFILES_DIR/etc/bash/.bashrc" "$HOME/.bashrc"
link "$DOTFILES_DIR/etc/readline/.inputrc" "$HOME/.inputrc"
link "$DOTFILES_DIR/etc/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/etc/git/.gitignore" "$HOME/.gitignore"
link "$DOTFILES_DIR/etc/git/.gitattributes" "$HOME/.gitattributes"

info "Install hishtory"
curl https://hishtory.dev/install.py | python3 -
