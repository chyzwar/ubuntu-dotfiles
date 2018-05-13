#!/bin/bash


#Update Ubuntu to newest version
tput setaf 2; echo "Upgrade Ubuntu"; tput sgr0
sudo apt-get update -qq
sudo apt-get upgrade dist


#install basic utilities
tput setaf 2; echo "Install git, curl, zips ..."; tput sgr0
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y tree
sudo apt-get install -y ppa-purge
sudo apt-get install -y git
sudo apt-get install -y git-flow
sudo apt-get install -y alacarte
sudo apt-get install -y mercurial
sudo apt-get install -y openssh-client
sudo apt-get install -y openssh-server
sudo apt-get install -y dirnenv
sudo apt-get install -y shellcheck
sudo apt-get install -y gnome-tweak-tool
sudo apt-get install -y gnome-shell-extensions
sudo apt-get install -y snapd
sudo apt-get install -y snapcraft
sudo apt-get install -y libssl-dev
sudo apt-get install -y fonts-firacode

tput setaf 2; echo "Install chrome, vlc"; tput sgr0
sudo snap install chromium
sudo snap install vlc


tput setaf 1; echo "Do you want to install vanilla Gnome"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt install -y gnome-session
            sudo apt install -y ubuntu-gnome-default-settings
            sudo apt install -y vanilla-gnome-default-settings
            sudo apt install -y vanilla-gnome-desktop
            break;;
        No ) break;;
    esac
done

tput setaf 1; echo "Do you want to install Zeal - Documentation"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository -y ppa:zeal-developers/ppa
            sudo apt-get update -qq
            sudo apt-get install -y zeal
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

tput setaf 1; echo "Do you want to install Arc theme"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y arc-theme
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
            sudo apt-get upgrade -qq
            sudo apt-get install -q gimp
            break;;
        No ) break;;
    esac
done



tput setaf 1; echo "Do you want to install Docky"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository -y ppa:docky-core/stable
            sudo apt-get update -qq
            sudo apt-get install -y docky
            break;;
        No ) break;;
    esac
done


tput setaf 1; echo "Do you want to install PPA Manager"; tput sgr0
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





tput setaf 1; echo "Do you want to install Plank"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository ppa:ricotz/docky
            sudo apt-get update -qq
            sudo apt-get install -y plank
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
            sudo apt-get install google-chrome-beta
            break;;
        No ) break;;
    esac
done





tput setaf 1; echo "Do you want to install Spotify"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
            echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
            sudo apt-get update -qq
            sudo apt-get install -y spotify-client
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

