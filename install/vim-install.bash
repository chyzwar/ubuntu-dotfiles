#!/bin/bash

tput setaf 2; echo "Install Vim"; tput sgr0
sudo apt-get install -y vim

echo "Install vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Install .vimrc configs"
ln -sfv "$(pwd)/etc/vim/vimrc" "/home/$USER/.vimrc"

echo "Install bundles"
vim +PlugInstall +qall
