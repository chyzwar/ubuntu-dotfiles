#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")"


echo "Install Sublime Text"
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo apt-get update -qq
sudo apt-get install -y sublime-text-installer
sudo apt-get install -y wget


echo "Install Missing Linters"
sudo apt-get install -y libxml2-utils
sudo apt-get install -y shellcheck

echo "Links List of Plugins and Settings"
ln -sfv $DIR/../sublime/Default.sublime-theme /home/$USER/.config/sublime-text-3/Packages/User/Default.sublime-theme
ln -sfv $DIR/../sublime/Package\ Control.sublime-settings /home/$USER/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
ln -sfv $DIR/../sublime/Preferences.sublime-settings /home/$USER/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
ln -sfv $DIR/../sublime/Python.sublime-settings /home/$USER/.config/sublime-text-3/Packages/User/Python.sublime-settings
ln -sfv $DIR/../sublime/SublimeLinter.sublime-settings /home/$USER/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings
ln -sfv $DIR/../sublime/JsFormat.sublime-settings /home/$USER/.config/sublime-text-3/Packages/User/JsFormat.sublime-settings
ln -sfv $DIR/../sublime/phpfmt.sublime-settings /home/$USER/.config/sublime-text-3/Packages/User/phpfmt.sublime-settings



echo "Install Package Manager"
wget https://packagecontrol.io/Package%20Control.sublime-package
mv Package\ Control.sublime-package  /home/$USER/.config/sublime-text-3/Installed\ Packages/


