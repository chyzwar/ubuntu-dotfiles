#!/usr/bin/env bash

tput setaf 2; echo "Installing nix"; tput sgr0
curl https://nixos.org/nix/install | sh

tput setaf 2; echo "Loading nix profile"; tput sgr0
source "$HOME/.nix-profile/etc/profile.d/nix.sh"

tput setaf 2; echo "Installing git "; tput sgr0
nix-env --install git-2.16.2

tput setaf 2; echo "Installing wget "; tput sgr0
nix-env --install wget-1.19.4

tput setaf 2; echo "Installing wget "; tput sgr0
nix-env --install wget-1.19.4

tput setaf 2; echo "Installing curl "; tput sgr0
nix-env --install curl-7.58.0

tput setaf 2; echo "Installing shellcheck "; tput sgr0
nix-env --install ShellCheck-0.4.7
