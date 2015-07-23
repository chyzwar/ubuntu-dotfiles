#!/bin/bash

#Install quake
echo "Install guake, ultimate terminal"
sudo add-apt-repository ppa:webupd8team/unstable
sudo apt-get update
sudo apt-get install guake
	
echo "Install zhs shell"
sudo apt-get update
sudo apt-get install zsh

#Install liquid promt
echo "Install liquidprompt"
sudo git clone https://github.com/nojhan/liquidprompt.git /opt/liquidprompt

#Set Monokai Pallete for Guake Terminal
echo "Set Monokai Pallete"
palette="#1B1B1D1D1E1E:#F9F926267272:#8282B4B41414:#FDFD97971F1F:#5656C2C2D6D6:#8C8C5454FEFE:#464654545757:#CCCCCCCCC6C6:#505053535454:#FFFF59599595:#B6B6E3E35454:#FEFEEDED6C6C:#8C8CEDEDFFFF:#9E9E6F6FFEFE:#89899C9CA1A1:#F8F8F8F8F2F2"
bd_color="#000000000000"
fg_color="#EAEAEAEAEAEA"
bg_color="#1C1C1C1C1C1C"
gconftool-2 -s -t string /apps/guake/style/font/palette $palette
gconftool-2 -s -t string /apps/guake/style/font/bold $bd_color
gconftool-2 -s -t string /apps/guake/style/font/color $fg_color
gconftool-2 -s -t string /apps/guake/style/background/color $bg_color


# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master


# # Bunch of symlinks
echo "Symlinks for git/bashrc"
ln -sfv "$DOTFILES_DIR/../runcom/.bashrc" ~
ln -sfv "$DOTFILES_DIR/../runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/../git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/../git/.gitignore_global" ~
