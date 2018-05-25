#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"

tput setaf 2; echo "Install guake Terminal"; tput sgr0
sudo apt-get install -y guake

tput setaf 2; echo "Install liquidprompt"; tput sgr0
sudo apt-get install -y liquidprompt


echo "Symlinks for git/bashrc"
ln -sfv "$DIR/../.bashrc" ~
ln -sfv "$DIR/../.inputrc" ~
ln -sfv "$DIR/../etc/git/.gitconfig" ~
ln -sfv "$DIR/../etc/git/.gitignore_global" ~
