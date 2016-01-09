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
			sudo apt-get upgrade -q
			sudo apt-get dist-upgrade
			sudo apt-get install -y ubuntu-gnome-desktop^
			sudo apt-get install -y gnome-tweak-tool
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






tput setaf 1; echo "Do you want to install btsync"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get -y install python-software-properties
			sudo add-apt-repository ppa:tuxpoldo/btsync
			sudo apt-get update -qq
			sudo apt-get -y install btsynqc
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
			sudo apt-get install steam
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

