#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install yakuake (drop-down terminal)"
apt_install yakuake

info "Install foot terminal"
apt_install foot

info "Install liquidprompt"
apt_install liquidprompt

info "Install hishtory"
# api.hishtory.dev is dead (ddworken/hishtory#355): release binary, local-only history
hishtory_bin="$(mktemp)"
curl -fsSL -o "$hishtory_bin" \
  "https://github.com/ddworken/hishtory/releases/latest/download/hishtory-linux-$(dpkg --print-architecture)" &&
  chmod +x "$hishtory_bin" &&
  "$hishtory_bin" install --offline --skip-config-modification
rm -f "$hishtory_bin"

info "Create symlinks"
link "$DOTFILES_DIR/etc/bash/.bashrc" "$HOME/.bashrc"
link "$DOTFILES_DIR/etc/readline/.inputrc" "$HOME/.inputrc"
link "$DOTFILES_DIR/etc/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/etc/git/.gitignore" "$HOME/.gitignore"
link "$DOTFILES_DIR/etc/git/.gitattributes" "$HOME/.gitattributes"

