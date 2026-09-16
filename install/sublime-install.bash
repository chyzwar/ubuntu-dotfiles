#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install Sublime Text (official apt repo, dev channel)"
apt_keyring sublimehq-pub https://download.sublimetext.com/sublimehq-pub.gpg
# flat repo: no Components, so not apt_source
sudo tee /etc/apt/sources.list.d/sublime-text.sources >/dev/null <<'SRC'
Types: deb
URIs: https://download.sublimetext.com/
Suites: apt/dev/
Signed-By: /etc/apt/keyrings/sublimehq-pub.asc
SRC
apt_update
apt_install sublime-text
