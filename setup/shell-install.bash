#!/bin/bash


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

#Install qfc, config in autocomplete folder
git clone https://github.com/pindexis/qfc "$HOME/.qfc"

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master


# # Bunch of symlinks
echo "Symlinks for git/bashrc"
ln -sfv "$DOTFILES_DIR/../.bashrc" ~
ln -sfv "$DOTFILES_DIR/../.inputrc" ~
ln -sfv "$DOTFILES_DIR/../git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/../git/.gitignore_global" ~
