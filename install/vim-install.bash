#!/bin/bash

tput setaf 2; echo "Install vim"; tput sgr0
sudo apt-get install -y vim

tput setaf 2; echo "Install .vimrc"; tput sgr0
ln -sfv "$(pwd)/etc/vim/.vimrc" "/home/$USER/.vimrc"
