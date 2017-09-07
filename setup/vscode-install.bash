#!/bin/bash

tput setaf 1; echo "Install VSCode Editor"; tput sgr0
sudo snap install --classic vscode

code --install-extension Shan.code-settings-sync
