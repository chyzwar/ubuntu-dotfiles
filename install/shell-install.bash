#!/bin/bash
# shellcheck disable=SC1090

DIR="$(dirname "$(readlink -f "$0")")"
source "$DIR/nix-install.bash"

tput setaf 2; echo "Installing git "; tput sgr0
nix-env --install git-2.16.2

tput setaf 2; echo "Installing Python2 "; tput sgr0
nix-env --install guake-0.8.3

tput setaf 2; echo "Installing liquidprompt "; tput sgr0
git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt

tput setaf 2; echo "Symlinks for bashrc and git"; tput sgr0
ln -sfv "$DIR/../.bashrc" ~
ln -sfv "$DIR/../.inputrc" ~
ln -sfv "$DIR/../git/.gitconfig" ~
ln -sfv "$DIR/../git/.gitignore" ~
ln -sfv "$DIR/../git/.gitattributes" ~
