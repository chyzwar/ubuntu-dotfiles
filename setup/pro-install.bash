#!/bin/bash


tput setaf 1; echo "Do you want to install Python Tooluing"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get install -y python-pip
			sudo pip install virtualenvwrapper jedi
			break;;
		No ) break;;
	esac
done





tput setaf 1; echo "Do you want to install node.js annd tools"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
			source ~/.nvm/nvm.sh

			node_versions=(v4.2.3 stable)
			for version in "${node_versions[@]}"
			do
				echo "Installing node version" "$version"
				nvm install "$version"
				nvm use "$version"

				npm install -g --depth 0 npm
				npm install -g --depth 0 grunt
				npm install -g --depth 0 grunt-cli
				npm install -g --depth 0 gulp
				npm install -g --depth 0 yo
				npm install -g --depth 0 karma
				npm install -g --depth 0 nodemon
				npm install -g --depth 0 http-server
				npm install -g --depth 0 bower
				npm install -g --depth 0 karma
				npm install -g --depth 0 browserify
				npm install -g --depth 0 eslint
				npm install -g --depth 0 jshint
				npm install -g --depth 0 jscs
				npm install -g --depth 0 htmlhint
				npm install -g --depth 0 csslint
				npm install -g --depth 0 elm
				npm install -g --depth 0 purescript
			done
			nvm alias default stable

			break;;
		No ) break;;
	esac
done





tput setaf 1; echo "Do you want to install rust and rsvm"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			wget -qO- https://raw.github.com/sdepold/rsvm/master/install.sh | sh
			source ~/.rsvm/rsvm.sh
			rsvm install 1.5.0
			break;;
		No ) break;;
	esac
done





tput setaf 1; echo "Do you want to install PHP and composer"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo add-apt-repository -y ppa:ondrej/php5
			sudo apt-get update -qq
			sudo apt-get install -y php5 php5-mcrypt php5-gd

			curl -sS https://getcomposer.org/installer | php
			sudo mv composer.phar /usr/local/bin/composer
			sudo chmod +x /usr/local/bin/composer
			break;;
		No ) break;;
	esac
done






tput setaf 1; echo "Do you want to install Apache"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get install -y apache2 libapache2-mod-php5
			sudo apt-get install -y mcrypt php5-mcrypt
			sudo php5enmod mcrypt
			break;;
		No ) break;;
	esac
done






tput setaf 1; echo "Do you want install MariaDB"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo add-apt-repository -y ppa:ondrej/mariadb-10.0
			sudo apt-get update -qq
			sudo apt-get install -y mariadb-server
			break;;
		No ) break;;
	esac
done







tput setaf 1; echo "Do you want install Java 7,8,9 and tools"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo add-apt-repository -y ppa:webupd8team/java
			sudo apt-get update -qq
			sudo apt-get install -y oracle-java7-installer
			sudo apt-get install -y oracle-java8-installer
			sudo apt-get install -y oracle-java9-installer
			sudo update-java-alternatives -s java-8-oracle

			sudo apt-get install -y maven
			sudo apt-get install -y gradle
			sudo apt-get install -y ant
			break;;
		No ) break;;
	esac
done






tput setaf 1; echo "Do you want install Scala and sbt"; tput sgr0
tput setaf 1; echo "Assume that Java is installed"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get -y install scala
			sudo apt-get -y install sbt
			break;;
		No ) break;;
	esac
done





tput setaf 1; echo "Do you want install Clojuire and lein"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
			sudo mv lein /usr/local/bin
			chmod a+x /usr/local/bin/lein
			break;;
		No ) break;;
	esac
done





tput setaf 1; echo "Do you want install Julia??"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-add-repository -y ppa:staticfloat/julianightlies
			sudo apt-add-repository -y ppa:staticfloat/julia-deps
			sudo apt-get update -qq
			sudo apt-get install -y julia
			break;;
		No ) break;;
	esac
done







tput setaf 1; echo "Do you want to install Haskell Platform"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get install -y haskell-platform
			sudo apt-get install -y haskell-platform-doc
			sudo apt-get install -y haskell-platform-prof

			# Install Stack
			echo 'deb http://download.fpcomplete.com/ubuntu wily main'| sudo tee /etc/apt/sources.list.d/fpco.list
			sudo apt-get update
			sudo apt-get install -y stack
			break;;
		No ) break;;
	esac
done







tput setaf 1; echo "Do you want install go-lang??"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			sudo apt-get install -y golang
			break;;
		No ) break;;
	esac
done






tput setaf 1; echo "Do you want install Ruby and rvm"; tput sgr0
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			tput setaf 2; echo "Ruby and rvm"; tput sgr0
			gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
			sudo curl -sSL https://get.rvm.io | bash -s stable --with-default-gems="rails haml"
			rvm install 2.3
			rvm use 2.3 --default
			break;;
		No ) break;;
	esac
done






