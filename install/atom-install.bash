#!/usr/bin/env bash

tput setaf 2; echo "Install Atom Editor"; tput sgr0
sudo snap install atom --classic

apm install sync-settings
