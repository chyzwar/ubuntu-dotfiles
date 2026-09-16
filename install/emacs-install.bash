#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install emacs"
snap_install emacs --classic

info "Install spacemacs"
git_clone_or_pull https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d" --recursive
