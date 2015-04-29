#!/bin/bash

#Update Ubuntu to newest version
echo "Upgrade Ubuntu"
sudo apt-get update
sudo apt-get upgrade dist

#install basic utilities
echo "Install git, curl, shutter"
sudo apt-get install git
sudo apt-get install curl
sudo apt-get install shutter
sudo apt-get install mysql-workbench

#Python tools
echo "Install Python tooling"
sudo apt-get install pip
pip install --upgrade pip
pip install virtualenvwrapper
pip install "ipython[notebook]"

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
done 
nvm alias default stable #select def version of node to stable release

#PHP
echo "Install LAMP and Composer, HHVM"
sudo apt-get install apache2
sudo apt-get install mysql-server
sudo apt-get install php5 libapache2-mod-php5
sudo apt-get install php5-cli
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
