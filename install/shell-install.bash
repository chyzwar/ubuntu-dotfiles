#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"

echo "Install guake, ultimate terminal"
pip install --user guake


echo "Install liquidprompt"
git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt


echo "Symlinks for git/bashrc"
ln -sfv "$DIR/../.bashrc" ~
ln -sfv "$DIR/../.inputrc" ~
ln -sfv "$DIR/../git/.gitconfig" ~
ln -sfv "$DIR/../git/.gitignore_global" ~
