#!/bin/bash
# shellcheck disable=SC1090

tput setaf 2; echo "Do you want to install Python Tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
            git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
            git clone https://github.com/pyenv/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash

            export PATH="$HOME/.pyenv/bin:$PATH"
            eval "$(pyenv init -)"

            pyenv install 3.6.3
            pyenv global 3.6.3

            sudo apt-get install -y python-pip

            pip install virtualenvwrapper
            pip install jedi
            pip install pipenv
            break;;
        No ) break;;
    esac
done





tput setaf 2; echo "Do you want to install node.js annd tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/nodenv/nodenv.git ~/.nodenv
            cd ~/.nodenv && src/configure && make -C src
            git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
            git clone https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs
            git clone https://github.com/nodenv/nodenv-default-packages.git ~/.nodenv/plugins/nodenv-default-packages

            export PATH="$HOME/.nodenv/bin:$PATH"
            eval "$(nodenv init -)"


            node_versions=(8.9.3 9.4.0)
            for version in "${node_versions[@]}"
            do
                echo "Installing node version" "$version"
                nodenv install "$version"
                nodenv global "$version"

                npm install -g --depth 0 npm
                npm install -g --depth 0 yarn
                npm install -g --depth 0 eslint
                npm install -g --depth 0 eslint-plugin-react
                npm install -g --depth 0 eslint-plugin-import
                npm install -g --depth 0 npm-check
                npm install -g --depth 0 htmlhint
                npm install -g --depth 0 csslint
                npm install -g --depth 0 elm
                npm install -g --depth 0 verdaccio
            done
            break;;
        No ) break;;
    esac
done

tput setaf 2; echo "Do you want to kerl and erlang"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            # Install version manager
            git clone https://github.com/kerl/kerl ~/.kerl
            export PATH="$HOME/.kerl:$PATH"

            # For erlang deps
            sudo apt-get install -y autoconf
            sudo apt-get install -y automake
            sudo apt-get install -y libncurses5-dev
            sudo apt-get install -y xsltproc
            sudo apt-get install -y libssl-dev
            sudo apt-get install -y fop
            sudo apt-get install -y libxml2-utils
            sudo apt-get install -y unixodbc-dev
            sudo apt-get install -y systemtap
            sudo apt-get install -y systemtap-sdt-dev

            # For wx deps
            sudo apt-get install -y libwxbase3.0-dev
            sudo apt-get install -y libwxgtk3.0-dev
            sudo apt-get install -y libgtk3.0
            sudo apt-get install -y libqt4-opengl-dev

            # Kerl options (.kerl)
            export KERL_BUILD_DOCS=yes
            export KERL_USE_AUTOCONF=yes
            export KERL_CONFIGURE_OPTIONS="\
                --disable-native-libs \
                --with-dynamic-trace=systemtap \
                --with-wx-config=/usr/bin/wx-config  \
                --with-ssl=/usr/local \
                --with-javac \
                --enable-vm-probes \
                --enable-hipe \
                --enable-kernel-poll \
                --enable-threads \
                --enable-sctp \
                --enable-smp-support"

            erlang_versions=(19.3 20.2)
            for version in "${erlang_versions[@]}"
            do
                echo "Building Erlang version" "$version"
                kerl build "$version" "$version"

                echo "Installing Erlang version" "$version"
                kerl install "$version" ~/.kerl/versions/"$version"
            done

            echo "Activate 20.2"
            source ~/.kerl/versions/20.2/activate
            break;;
        No ) break;;
    esac
done

tput setaf 2; echo "Do you want to install Elixir"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s

            elixir_versions=(1.5 1.6)
            for version in "${elixir_versions[@]}"
            do
                echo "Installing Elixir version" "$version"
                kiex install "$version"
            done

            echo "Set 1.6 as default version"
            kiex default 1.6
            break;;
        No ) break;;
    esac
done







tput setaf 2; echo "Do you want to install ocaml"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
          sudo apt-get install -y ocaml-nox
          sudo apt-get install -y ocaml
          sudo apt-get install -y opam

          opam init
          opam install merlin
          opam user-setup install
            break;;
        No ) break;;
    esac
done




tput setaf 2; echo "Do you want to install VirtualBox"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
            wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

            sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian artful contrib" >> /etc/apt/sources.list.d/virtualbox.org.list'
            sudo apt-get update -qq
            sudo apt-get install -y virtualbox
            break;;
        No ) break;;
    esac
done




tput setaf 2; echo "Do you want to install rust and rustup.rs"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
            rustup completions bash > /etc/bash_completion.d/rustup

            rustup install nightly
            rustup default nightly

            cargo install clippy
            cargo install racer
            break;;
        No ) break;;
    esac
done





tput setaf 2; echo "Do you want to install PHP and composer"; tput sgr0
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






tput setaf 2; echo "Do you want to install Apache"; tput sgr0
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






tput setaf 2; echo "Do you want install MariaDB"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y mariadb-server
            sudo apt-get install -y mariadb-client
            break;;
        No ) break;;
    esac
done







tput setaf 2; echo "Do you want install Java 8,9 and tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install openjdk-8-jdk
            sudo apt-get install openjdk-9-jdk
            sudo update-java-alternatives -s java-1.8.0-openjdk-amd64

            sudo apt-get install -y maven
            sudo apt-get install -y gradle
            sudo apt-get install -y ant
            break;;
        No ) break;;
    esac
done






tput setaf 2; echo "Do you want install Scala and sbt"; tput sgr0
tput setaf 2; echo "Assume that Java is installed"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get -y install scala
            echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
            sudo apt-get update -qq
            sudo apt-get install -y sbt
            break;;
        No ) break;;
    esac
done





tput setaf 2; echo "Do you want install Clojuire and lein"; tput sgr0
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





tput setaf 2; echo "Do you want install Julia?"; tput sgr0
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







tput setaf 2; echo "Do you want to install Haskell Platform"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y haskell-platform
            sudo apt-get install -y haskell-platform-doc
            sudo apt-get install -y haskell-platform-prof

            sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
            echo 'deb http://download.fpcomplete.com/ubuntu wily main'| sudo tee /etc/apt/sources.list.d/fpco.list
            sudo apt-get update -qq
            sudo apt-get install -y stack
            break;;
        No ) break;;
    esac
done






tput setaf 2; echo "Do you want install go-lang??"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y golang
            break;;
        No ) break;;
    esac
done






tput setaf 2; echo "Do you want install Ruby and rbenv"; tput sgr0
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

tput setaf 2; echo "Do you want install Crystal and crenv"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/pine/crenv.git ~/.crenv
            git clone https://github.com/pine/crystal-build.git ~/.crenv/plugins/crystal-build
            git clone https://github.com/pine/crenv-update.git ~/.crenv/plugins/crenv-update

            export PATH="$HOME/.crenv/bin:$PATH"
            eval "$(crenv init -)"

            crenv install 0.20.3
            crenv global 0.20.3
            crenv rehash
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install nix"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            curl https://nixos.org/nix/install | sh
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install docker"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo addgroup --system docker
            sudo adduser "$USER" docker
            newgrp docker

            sudo snap install docker
            sudo docker run hello-world
            break;;
        No ) break;;
    esac
done

