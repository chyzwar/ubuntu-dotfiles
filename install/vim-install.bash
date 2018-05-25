#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

tput setaf 2; echo "Install Vim"; tput sgr0
sudo apt-get install -y vim

echo "Install vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Install .vimrc configs"
ln -sfv "$DIR/.vimrc" "/home/$USER/.vimrc"

echo "Install bundles"
vim +PlugInstall +qall
