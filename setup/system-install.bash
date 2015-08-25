#!/bin/bash

#Update Ubuntu to newest version
echo "Upgrade Ubuntu"
sudo apt-get update
sudo apt-get upgrade dist


#install basic utilities
echo "Install git, curl, shutter, workbench and zips"
sudo apt-get install git
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=36000'

sudo apt-get install curl
sudo apt-get install shutter
sudo apt-get install tree
sudo apt-get install mysql-workbench
sudo apt-get install p7zip{,-full}
sudo apt-get install alien libaio1 unixodbc
sudo apt-get install ppa-purge


echo "Install Docker"
wget -qO- https://get.docker.com/ | sh
# Add the docker group if it doesn't already exist.
$ sudo groupadd docker

# Add the connected user "${USER}" to the docker group.
# Change the user name to match your preferred user.
# You may have to logout and log back in again for
# this to take effect.
$ sudo gpasswd -a ${USER} docker

# Restart the Docker daemon.
# If you are in Ubuntu 14.04, use docker.io instead of docker
$ sudo service docker restart



#Python tools
echo "Install Python tooling"
sudo apt-get install python-pip
pip install --upgrade pip
pip install virtualenvwrapper
pip install "ipython[notebook]"
pip install jedi


#Install Gnome Shell
echo "Install Gnome Shell"
sudo add-apt-repository ppa:gnome3-team/gnome3-staging
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo apt-get update
sudo apt-get install gdm
sudo apt-get install gnome-shell
sudo apt-get install gnome-session
sudo apt-get install ubuntu-gnome-desktop
sudo apt-get dist-upgrade
sudo apt-get install gnome-tweak-tool

#Removal
# sudo ppa-purge ppa:gnome3-team/gnome3
# sudo ppa-purge ppa:gnome3-team/gnome3-staging

#Node JS install
echo "Install node version manager"
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
source ~/.nvm/nvm.sh

node_versions=(stable unstable iojs) 
for version in "${node_versions[@]}"
do
	echo "Intsalling node version" $version
	nvm install $version
	nvm use $version

 	npm install grunt -g
 	npm install gulp  -g
 	npm install yo -g
 	npm install karma -g
 	npm install nodemon -g
 	npm install http-server -g
 	npm install bower -g
 	npm install karma -g
 	npm install browserify -g
 	npm install jshint -g
 	npm install jsxhint -g
    npm install -g jscs
    npm install -g htmlhint
    npm install -g csslint
done 
nvm alias default stable #select def version of node to stable release


#PHP
echo "Install LAMP and Composer, HHVM"
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
echo "Install Java 7 and 8, 9 set def to 8"
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java9-installer
sudo update-java-alternatives -s java-8-oracle


#Clojure
echo "Install lein"
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /usr/local/bin
chmod a+x /usr/local/bin/lein
lein


#Julia
echo "Install Julia"
sudo apt-add-repository ppa:staticfloat/julianightlies
sudo apt-add-repository ppa:staticfloat/julia-deps
sudo apt-get update
sudo apt-get install julia


#Haskell
echo "Install Haskell "
sudo apt-get install haskell-platform
sudo apt-get install haskell-platform-doc
sudo apt-get install haskell-platform-prof

#Go Lang
echo "Go lang install"
sudo apt-get install golang

#Ruby Stuff
echo "Ruby and rvm"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo curl -sSL https://get.rvm.io | bash -s stable --with-default-gems="rails haml"
rmv install 2.2
rvm use 2.2 --default

echo "Install MongoDB"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org=3.0.3 mongodb-org-server=3.0.3 mongodb-org-shell=3.0.3 mongodb-org-mongos=3.0.3 mongodb-org-tools=3.0.3
sudo apt-get install -y mongodb-org

echo "Install btsync"
apt-get -y install python-software-properties
add-apt-repository ppa:tuxpoldo/btsync
apt-get update
apt-get -y install btsync

echo "Install DropBox"
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd