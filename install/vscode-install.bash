#!/usr/bin/env bash
# shellcheck source=install/lib.bash
source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.bash"

info "Install VSCode and VSCode Insiders (Microsoft apt repo)"
apt_keyring microsoft https://packages.microsoft.com/keys/microsoft.asc
apt_source microsoft https://packages.microsoft.com/repos/code stable main "amd64 arm64 armhf"
apt_update
apt_install code code-insiders
