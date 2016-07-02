#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"


echo "Install guake, ultimate terminal"
sudo add-apt-repository -y ppa:webupd8team/unstable
sudo apt-get update -qq
sudo apt-get -y build-dep guake
sudo apt-get install -y guake


echo "Install zhs shell"
sudo apt-get update --qq
sudo apt-get install -y zsh


echo "Install liquidprompt"
git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt

echo "Install oh-my-zhs"
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh

echo "Symlinks for git/bashrc"
ln -sfv "$DIR/../.bashrc" ~
ln -sfv "$DIR/../.zshrc" ~
cp -f   "$DIR/../.zsh_history" ~
cp -f   "$DIR/../.zsh-update" ~
ln -sfv "$DIR/../.inputrc" ~
ln -sfv "$DIR/../git/.gitconfig" ~
ln -sfv "$DIR/../git/.gitignore_global" ~
