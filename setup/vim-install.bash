#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

# echo "Installing Vim"
sudo apt-get install -y vim
sudo apt-get install -y cmake
sudo apt-get install -y python-dev
sudo apt-get install -y build-essential

#  Install/update Vundle
echo "Installaling Vundle"
BUNDLE_DIR=~/.vim/bundle
mkdir -p "$BUNDLE_DIR" && (git clone https://github.com/gmarik/vundle.git "$BUNDLE_DIR/vundle" || (cd "$BUNDLE_DIR/vundle" && git pull origin master))

#Install Plugins and creates links
echo "Installing Plugins"
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
sudo git clone https://github.com/rkitover/vimpager.git /opt/vimpager
sudo apt-get install pandoc
sudo apt-get install sharutils
cd /opt/vimpager
sudo make install-deb