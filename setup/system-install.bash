#!/bin/bash


#Update Ubuntu to newest version
tput setaf 2; echo "Upgrade Ubuntu"; tput sgr0
sudo apt-get update
sudo apt-get upgrade dist


#install basic utilities
tput setaf 2; echo "Install git, curl, shutter, zips"; tput sgr0
sudo apt-get install git
sudo apt-get install git-flow
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=36000'


sudo apt-get install curl
sudo apt-get install wget
sudo apt-get install shutter
sudo apt-get install tree
sudo apt-get install p7zip{,-full}
sudo apt-get install alien libaio1 unixodbc
sudo apt-get install ppa-purge


tput setaf 2; echo "Install Docker"; tput sgr0
wget -qO- https://get.docker.com/ | sh
# Add the docker group if it doesn't already exist.
$ sudo groupadd docker

# Add the connected user "${USER}" to the docker group.
# Change the user name to match your preferred user.
# You may have to logout and log back in again for
# this to take effect.
$ sudo gpasswd -a "${USER}" docker

# Restart the Docker daemon.
# If you are in Ubuntu 14.04, use docker.io instead of docker
$ sudo service docker restart

#Python tools
tput setaf 2; echo "Install Python tooling"; tput sgr0
sudo apt-get install python-pip
pip install --upgrade pip
pip install virtualenvwrapper
pip install "ipython[notebook]"
pip install jedi


#Optional Installation of LibreOffice prerelase
tput setaf 1; echo "Do you want to install LibreOffice prerealse"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get purge libreoffice-core
			sudo add-apt-repository ppa:libreoffice/libreoffice-prereleases
			sudo apt-get update
			sudo apt-get install libreoffice
			break;;
		No ) break;;
	esac
done

#Install Gimp Edge
tput setaf 2; echo "Install Gimp"; tput sgr0
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install gimp

#Install Gnome Shell
tput setaf 1; echo "Do you want to install Gnome Shell"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo add-apt-repository ppa:gnome3-team/gnome3-staging
			sudo add-apt-repository ppa:gnome3-team/gnome3
			sudo apt-get update
			sudo apt-get install gdm
			sudo apt-get install gnome-shell
			sudo apt-get install gnome-session
			sudo apt-get install ubuntu-gnome-desktop
			sudo apt-get dist-upgrade
			sudo apt-get install gnome-tweak-tool
			break;;
		No ) break;;
	esac
done

#Removal of gnome
# sudo ppa-purge ppa:gnome3-team/gnome3
# sudo ppa-purge ppa:gnome3-team/gnome3-staging

#Node JS install
tput setaf 2; echo "Install node and nvm"; tput sgr0
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
source ~/.nvm/nvm.sh

node_versions=(v4.2.1 v5.0.0)
for version in "${node_versions[@]}"
do
	echo "Installing node version" "$version"
	nvm install "$version"
	nvm use "$version"

	npm install -g npm
	npm install -g grunt
	npm install -g grunt-cli
	npm install -g gulp
	npm install -g yo
	npm install -g karma
	npm install -g nodemon
	npm install -g http-server
	npm install -g bower
	npm install -g karma
	npm install -g browserify
	npm install -g eslint
	npm install -g jshint
	npm install -g jscs
	npm install -g htmlhint
	npm install -g csslint
done

#select def version of node to stable lts release
nvm alias default v4.2.1


#PHP
tput setaf 2; echo "Install LAMP and Composer"; tput sgr0
sudo apt-get install apache2
sudo apt-get install mysql-server
sudo apt-get install php5 libapache2-mod-php5
sudo apt-get install php5-cli
sudo apt-get install php5-sqlite
# Install and enable mcrypt
sudo apt-get install mcrypt php5-mcrypt
sudo php5enmod mcrypt
#Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer


#Java
tput setaf 2; echo "Install Java 7 and 8, 9 set def to 8"; tput sgr0
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java9-installer
sudo update-java-alternatives -s java-8-oracle
sudo apt-get install maven
sudo apt-get install ant


#Clojure
tput setaf 2; echo "Install lein and clojure"; tput sgr0
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /usr/local/bin
chmod a+x /usr/local/bin/lein
lein


#Julia
tput setaf 2; echo "Install Julia"; tput sgr0
sudo apt-add-repository ppa:staticfloat/julianightlies
sudo apt-add-repository ppa:staticfloat/julia-deps
sudo apt-get update
sudo apt-get install julia


#Haskell
tput setaf 1; echo "Do you want to install Haskell Platform"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get install haskell-platform
			sudo apt-get install haskell-platform-doc
			sudo apt-get install haskell-platform-prof

			#Needed for SublimeHaskell
			cabal install cabal-install-1.20.0.6
			cabal install ghc-mod-4.1.6 --constraint=haskell-src-exts==1.15.0.1
			cabal install haddock-2.14.3 --constraint=haskell-src-exts==1.15.0.1
			cabal install aeson
			cabal install stylish-haskell --constraint=haskell-src-exts==1.15.0.1
			cabal install haskell-docs-4.2.2
			cabal install hdevtools
			sudo cabal install happy --global
			break;;
		No ) break;;
	esac
done


#Go Lang
tput setaf 2; echo "Go lang install"; tput sgr0
sudo apt-get install golang

#Ruby Stuff
tput setaf 2; echo "Ruby and rvm"; tput sgr0
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo curl -sSL https://get.rvm.io | bash -s stable --with-default-gems="rails haml"
rvm install 2.2
rvm use 2.2 --default
gem install scss_lint

tput setaf 2; echo "Install btsync"; tput sgr0
apt-get -y install python-software-properties
add-apt-repository ppa:tuxpoldo/btsync
apt-get update
apt-get -y install btsynqc

tput setaf 2; echo "Install Dropbox"; tput sgr0
sudo apt-get -y install nautilus-dropbox
