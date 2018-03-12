#!/bin/bash

tput setaf 2; echo "Install emacs 25"; tput sgr0
sudo apt-get install -y emacs25

tput setaf 2; echo "Install spacemac"; tput sgr0
git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d

tput setaf 2; echo "Do you want to install preconfigured .spacemac file"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
        	DIR="$( cd "$( dirname "$0" )" && pwd )"
			ln -sfv "$DIR"/../emacs/.spacemacs /home/"$USER"/.spacemacs
			break;;
        No ) break;;
    esac
done
