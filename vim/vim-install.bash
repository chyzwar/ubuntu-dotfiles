#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "Install Vim and dependencies"
sudo apt-get install -y vim
sudo apt-get install -y cmake
sudo apt-get install -y python-dev
sudo apt-get install -y python3-dev
sudo apt-get install -y build-essential

echo "Install Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle

echo "Install configuration"
ln -sfv "$DIR/.vimrc" "/home/$USER/.vimrc"
ln -sfv "$DIR/vundle.vim" "/home/$USER/.vim/vundle.vim"

echo "Install bundles"
vim +PluginInstall +qall
