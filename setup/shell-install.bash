#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"


echo "Install guake, ultimate terminal"
sudo add-apt-repository -y ppa:webupd8team/unstable
sudo apt-get update -qq
sudo apt-get -y build-dep guake


echo "Install zhs shell"
sudo apt-get update --qq
sudo apt-get install -y zsh


echo "Install liquidprompt"
sudo git clone https://github.com/nojhan/liquidprompt.git /opt/liquidprompt


echo "Symlinks for git/bashrc"
ln -sfv "$DIR/../.bashrc" ~
ln -sfv "$DIR/../.inputrc" ~
ln -sfv "$DIR/../git/.gitconfig" ~
ln -sfv "$DIR/../git/.gitignore_global" ~
