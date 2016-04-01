#!/bin/bash


tput setaf 1; echo "Do you want to install Python Tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y make build-essential
            sudo apt-get install -y libssl-dev zlib1g-dev libbz2-dev
            sudo apt-get install -y libreadline-dev libsqlite3-dev  llvm libncurses5-dev

            git clone https://github.com/yyuu/pyenv.git ~/.pyenv
            git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
            source ~/.bashrc && source ~/.zshrc

            pyenv install 2.7.8
            pyenv install 3.4.2
            pyenv global 2.7.8
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
            git clone https://github.com/OiNutter/nodenv.git ~/.nodenv
            cd ~/.nodenv && src/configure && make -C src
            git clone https://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build

            export PATH="$HOME/.nodenv/bin:$PATH"
            eval "$(nodenv init -)"


            node_versions=(4.2.4 5.4.0)
            for version in "${node_versions[@]}"
            do
                echo "Installing node version" "$version"
                nodenv install "$version"
                nodenv global "$version"

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
                npm install -g --depth 0 eslint-plugin-react
                npm install -g --depth 0 npm-check-updates
                npm install -g --depth 0 htmlhint
                npm install -g --depth 0 csslint
                npm install -g --depth 0 elm
                npm install -g --depth 0 purescript
            done

            break;;
        No ) break;;
    esac
done






tput setaf 1; echo "Do you want to install docker"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get update -qq
            sudo apt-get install -y docker.io
            sudo service docker start

            sudo groupadd docker
            sudo gpasswd -a "${USER} docker"
            sudo service docker restart

            sudo docker run hello-world
            break;;
        No ) break;;
    esac
done

tput setaf 1; echo "Do you want to install VirtualBox"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
            sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian wily non-free contrib" >> /etc/apt/sources.list.d/virtualbox.org.list'
            sudo apt-get update -qq
            sudo apt-get install -y virtualbox
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
            rsvm install 1.7.0
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
            sudo apt-get install -y mariadb-server
            sudo apt-get install -y mariadb-client
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
            sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
            echo 'deb http://download.fpcomplete.com/ubuntu wily main'| sudo tee /etc/apt/sources.list.d/fpco.list
            sudo apt-get update -qq
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






tput setaf 1; echo "Do you want install Ruby and rbenv"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/rbenv/rbenv.git ~/.rbenv
            cd ~/.rbenv && src/configure && make -C src
            git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

            export PATH="$HOME/.rbenv/bin:$PATH"
            eval "$(rbenv init -)"

            rbenv install 2.3.0
            rbenv global 2.3.0
            break;;
        No ) break;;
    esac
done






