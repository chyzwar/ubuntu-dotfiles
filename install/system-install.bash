#!/bin/bash

tput setaf 2; echo "Upgrade Ubuntu"; tput sgr0
sudo apt-get update -qq
sudo apt-get upgrade dist

tput setaf 2; echo "Install git, curl, zips ..."; tput sgr0
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y tree
sudo apt-get install -y build-essential
sudo apt-get install -y ppa-purge
sudo apt-get install -y git
sudo apt-get install -y git-flow
sudo apt-get install -y mercurial
sudo apt-get install -y fossil
sudo apt-get install -y subversion
sudo apt-get install -y openssh-client
sudo apt-get install -y openssh-server
sudo apt-get install -y shellcheck
sudo apt-get install -y alacarte
sudo apt-get install -y gnome-tweak-tool
sudo apt-get install -y gnome-shell-extensions
sudo apt-get install -y chrome-gnome-shell
sudo apt-get install -y snapd
sudo apt-get install -y snapcraft
sudo apt-get install -y libssl-dev
sudo apt-get install -y fonts-firacode
sudo apt-get install -y nnn

tput setaf 2; echo "Install chrome, vlc"; tput sgr0
sudo snap install chromium
sudo snap install vlc

# Change swappiness, default 60
sudo sysctl -w vm.swappiness=10

# Change nuber of inotify max watcher, default 8192
sudo sysctl -w fs.inotify.max_user_watches=524288

tput setaf 1; echo "Do you want to install vanilla Gnome"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y gnome-session
	          sudo update-alternatives --config gdm3.css

            gsettings set org.gnome.shell enable-hot-corners false
            gsettings set org.gnome.shell.overrides workspaces-only-on-primary false
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Zeal - Documentation"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install zeal
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Firefox Nightly"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
            sudo apt-get update -qq
            sudo apt-get install -y firefox-trunk
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Gimp edge"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
            sudo apt-get update -qq
            sudo apt-get install -q gimp
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install PPA Manager"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository ppa:webupd8team/y-ppa-manager
            sudo apt-get update -qq
            sudo apt-get install -y  y-ppa-manager
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Dropbox"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get -y install nautilus-dropbox
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Steam"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get -y install steam
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Chrome Beta"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            sudo apt-get update -qq
            sudo apt-get install -y google-chrome-beta
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Spotify"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            snap install spotify
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Discord"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo snap install discord
            sudo snap connect discord:camera core:camera
            sudo snap connect discord:mount-observe core:mount-observe
            sudo snap connect discord:network-observe core:network-observe
            sudo snap connect discord:process-control core:process-control
            sudo snap connect discord:system-observe core:system-observe
            break;;
        No ) break;;
    esac
done




tput setaf 1; echo "Do you want to install Picard"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository ppa:musicbrainz-developers/daily
            sudo apt-get update -qq
            sudo apt-get install -y picard
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install Skype"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo snap install skype --classic
            break;;
        No ) break;;
    esac
done

