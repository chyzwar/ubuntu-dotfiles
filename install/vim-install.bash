#!/bin/bash

tput setaf 2; echo "Install Vim"; tput sgr0
sudo apt-get install -y vim

echo "Install .vimrc configs"
ln -sfv "$(pwd)/etc/vim/.vimrc" "/home/$USER/.vimrc"
