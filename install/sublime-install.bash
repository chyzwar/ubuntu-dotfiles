#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"

tput setaf 2; echo "Install Sublime Text"; tput sgr0
sudo snap install --edge --classic sublime-text


echo "Install Package Manager"
PACKAGE_MANAGER_URL="https://packagecontrol.io/Package%20Control.sublime-package"
PACKAGE_MANAGER_DIR="/home/$USER/.config/sublime-text-3/Installed\ Packages/"
wget "${PACKAGE_MANAGER_URL}" -P "${PACKAGE_MANAGER_DIR}"

echo "Links List of Plugins and Settings"
ln -sfv $DIR/Default.sublime-theme ~/.config/sublime-text-3/Packages/User/Default.sublime-theme
ln -sfv $DIR/Package\ Control.sublime-settings ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
ln -sfv $DIR/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
ln -sfv $DIR/Python.sublime-settings ~/.config/sublime-text-3/Packages/User/Python.sublime-settings
ln -sfv $DIR/CustomPATH.sublime-settings ~/.config/sublime-text-3/Packages/User/CustomPATH.sublime-settings




