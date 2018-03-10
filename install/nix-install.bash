#!/usr/bin/env bash

tput setaf 2; echo "Installing nix"; tput sgr0
curl https://nixos.org/nix/install | sh

tput setaf 2; echo "Loading nix profile"; tput sgr0
source "$HOME/.nix-profile/etc/profile.d/nix.sh"
