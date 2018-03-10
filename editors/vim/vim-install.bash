#!/usr/bin/env bash
# shellcheck disable=SC1090

DIR="$(dirname "$(readlink -f "$0")")"
source "$DIR/../install/nix-install.bash"

tput setaf 2; echo "Installing vim"; tput sgr0
nix-env --install vim-8.0.1257

echo "Install vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Install .vimrc configs"
ln -sfv "$DIR/.vimrc" "/home/$USER/.vimrc"

echo "Install bundles"
vim +PlugInstall +qall
