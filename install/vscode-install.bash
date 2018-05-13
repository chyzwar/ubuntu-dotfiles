#!/bin/bash

tput setaf 2; echo "Install VSCode Editor"; tput sgr0
sudo snap install --classic vscode

code --install-extension Shan.code-settings-sync
