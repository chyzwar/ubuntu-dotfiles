#!/usr/bin/env bash

tput setaf 2; echo "Install guake Terminal"; tput sgr0
sudo apt-get install -y guake

tput setaf 2; echo "Install foot Terminal"; tput sgr0
sudo apt-get -y install foot

tput setaf 2; echo "Install liquidprompt"; tput sgr0
sudo apt-get install -y liquidprompt

tput setaf 2; echo "Create symlinks"; tput sgr0
ln -sfv "$(pwd)/etc/bash/.bashrc" ~
ln -sfv "$(pwd)/etc/readline/.inputrc" ~
ln -sfv "$(pwd)/etc/git/.gitconfig" ~
ln -sfv "$(pwd)/etc/git/.gitignore_global" ~

tput setaf 2; echo "Install hishtory"; tput sgr0
curl https://hishtory.dev/install.py | python3 -
