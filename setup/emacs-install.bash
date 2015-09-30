#!/bin/bash

echo "Install emacs 24"
sudo apt-get install emacs-snapshot

echo "Install spacemac"
git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d

