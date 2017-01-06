#!/bin/bash


#Update Ubuntu to newest version
tput setaf 2; echo "Upgrade Ubuntu"; tput sgr0
sudo apt-get update -qq
sudo apt-get upgrade dist


#install basic utilities
tput setaf 2; echo "Install git, curl, shutter, zips"; tput sgr0
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y shutter
sudo apt-get install -y bzip2 libbz2-dev
sudo apt-get install -y tree
sudo apt-get install -y ppa-purge
sudo apt-get install -y git
sudo apt-get install -y git-flow
sudo apt-get install -y unity-tweak-tool
sudo apt-get install -y alacarte
sudo apt-get install -y mercurial
sudo apt-get install -y openssh-client
sudo apt-get install -y openssh-server
sudo apt-get install -y dirnenv




tput setaf 1; echo "Do you want to install LibreOffice prerealse"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get purge -y libreoffice-core
            sudo add-apt-repository -y ppa:libreoffice/libreoffice-prereleases
            sudo apt-get update -qq
            sudo apt-get install -y libreoffice
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





tput setaf 1; echo "Do you want to install Gnome Shell"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo add-apt-repository -y ppa:gnome3-team/gnome3-staging
            sudo add-apt-repository -y ppa:gnome3-team/gnome3
            sudo apt-get update -qq
            sudo apt-get dist-upgrade
            sudo apt-get install -y gnome gnome-shell
            sudo apt-get install -y gnome-tweak-tool
            sudo apt-get install -y gdm
            sudo dpkg-reconfigure gdm
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

