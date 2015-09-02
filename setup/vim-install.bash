#!/bin/bash

# echo "Installing Vim"
sudo apt-get install vim
sudo apt-get install cmake
sudo apt-get install python-dev
sudo apt-get install build-essential

#  Install/update Vundle
echo "Installaling Vundle"
BUNDLE_DIR=~/.vim/bundle
mkdir -p "$BUNDLE_DIR" && (git clone https://github.com/gmarik/vundle.git "$BUNDLE_DIR/vundle" || (cd "$BUNDLE_DIR/vundle" && git pull origin master))

#Install Plugins and creates links
echo "Installing Plugins"
DIR="$( cd "$( dirname "$0" )" && pwd )"
ln -sfv $DIR/../vim/vimrc /home/$USER/.vimrc
ln -sfv $DIR/../vim/vundle.vim /home/$USER/.vim/vundle.vim

# Install bundles
vim +PluginInstall +qall
TERM=screen-256color

#  Compile YouCompleteMe
cd $BUNDLE_DIR/YouCompleteMe 
./install.sh --clang-completer

#Intall vimpager (TODO test)
#https://github.com/rkitover/vimpager
sudo git clone git://github.com/rkitover/vimpager /opt/vimpager
sudo apt-get install pandoc
cd /opt/vimpager
sudo make install