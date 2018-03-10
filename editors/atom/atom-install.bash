#!/usr/bin/env bash
# shellcheck disable=SC1090

DIR="$(dirname "$(readlink -f "$0")")"
source "$DIR/../install/nix-install.bash"

tput setaf 2; echo "Installing Atom Editor "; tput sgr0
nix-env --install atom-1.24.0

tput setaf 2; echo "Installing sync-settings "; tput sgr0
apm install sync-settings
