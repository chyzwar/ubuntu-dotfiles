#!/bin/bash

tput setaf 2; echo "Install VSCode Editor"; tput sgr0
sudo snap install --classic code
sudo snap install --classic code-insiders

code --install-extension Shan.code-settings-sync
code-insiders  --install-extension Shan.code-settings-sync
