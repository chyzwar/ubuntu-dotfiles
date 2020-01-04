#!/usr/bin/env bash

tput setaf 2; echo "Install guake Terminal"; tput sgr0
sudo snap install guake --edge --devmode

tput setaf 2; echo "Install liquidprompt"; tput sgr0
sudo apt-get install -y liquidprompt

tput setaf 2; echo "Create symlinks"; tput sgr0
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
ln -sfv "$(pwd)/etc/git/.gitconfig" ~
ln -sfv "$(pwd)/etc/git/.gitignore_global" ~
