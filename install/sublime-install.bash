#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install Sublime Text (official apt repo, dev channel)"
# flat repo: no Components
apt_repo sublime-text https://download.sublimetext.com/sublimehq-pub.gpg \
    https://download.sublimetext.com/ apt/dev/ ""
# the keyring the old setup kept under a different name
sudo rm -f /etc/apt/keyrings/sublimehq-pub.asc
apt_update
apt_install sublime-text
