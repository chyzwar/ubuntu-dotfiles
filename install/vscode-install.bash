#!/bin/bash

tput setaf 2; echo "Install VSCode Editor"; tput sgr0
sudo snap install --classic code

code --install-extension Shan.code-settings-sync
