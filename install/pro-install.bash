#!/bin/bash
# shellcheck disable=SC1090

tput setaf 2; echo "Do you want to install Python Tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev
            sudo apt-get install -y libreadline-dev libsqlite3-dev wget curl llvm
            sudo apt-get install -y libncurses5-dev libncursesw5-dev xz-utils tk-dev
            sudo apt-get install -y libffi-dev liblzma-dev python-openssl

            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
            git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
            git clone https://github.com/pyenv/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash

            export PATH="$HOME/.pyenv/bin:$PATH"
            eval "$(pyenv init -)"

            pyenv install 2.7.14
            sudo apt-get install -y python-pip

            pyenv install 3.7.2
            sudo apt-get install -y python3-pip

            pip3 install virtualenvwrapper
	          pip3 install virtualenv
            pip3 install jedi
            pip3 install pipenv
            pip3 install yamllint
            break;;
        No ) break;;
    esac
done





tput setaf 2; echo "Do you want to install node.js and tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/nodenv/nodenv.git ~/.nodenv
            cd ~/.nodenv && src/configure && make -C src && cd - || return
            git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
            git clone https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs

            export PATH="$HOME/.nodenv/bin:$PATH"
            eval "$(nodenv init -)"


            node_versions=(10.16.3 12.10.0)
            for version in "${node_versions[@]}"
            do
                echo "Installing node version" "$version"
                nodenv install "$version"
                nodenv global "$version"

                npm install -g --depth 0 npm
                npm install -g --depth 0 yarn
                npm install -g --depth 0 lerna
                npm install -g --depth 0 eslint
                npm install -g --depth 0 eslint-plugin-react
                npm install -g --depth 0 eslint-plugin-import
                npm install -g --depth 0 npm-check
                npm install -g --depth 0 htmlhint
                npm install -g --depth 0 csslint
                npm install -g --depth 0 stylelint
                npm install -g --depth 0 elm
                npm install -g --depth 0 typescript
                npm install -g --depth 0 tslint
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
	          sudo apt-get install -y openjdk-8-jdk

            # Kerl options (.kerl)
            export KERL_BUILD_DOCS=yes
            export KERL_USE_AUTOCONF=yes
            export KERL_INSTALL_MANPAGES=yes
            export KERL_BUILD_BACKEND=tarbal

            export KERL_CONFIGURE_OPTIONS="\
                --disable-native-libs \
                --with-dynamic-trace=systemtap \
                --with-ssl=/usr/local \
                --with-javac \
                --enable-vm-probes \
                --enable-hipe \
                --enable-kernel-poll \
                --enable-threads \
                --enable-sctp \
                --enable-smp-support"

            erlang_versions=(21.3)
            for version in "${erlang_versions[@]}"
            do
                echo "Building Erlang version" "$version"
                kerl build "$version" "$version"

                echo "Installing Erlang version" "$version"
                kerl install "$version" ~/.kerl/versions/"$version"
            done

            echo "Activate 21.3"
            source ~/.kerl/versions/21.3/activate
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install Elixir"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s
	        source "$HOME/.kiex/scripts/kiex"

            elixir_versions=(1.7 1.8)
            for version in "${elixir_versions[@]}"
            do
                echo "Installing Elixir version" "$version"
                kiex install "$version"
            done

            echo "Set 1.8 as default version"
            kiex default 1.8
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

            sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian bionic contrib" >> /etc/apt/sources.list.d/virtualbox.org.list'
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
            curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
            export PATH="$HOME/.cargo/bin:$PATH"
            sudo rustup completions bash | sudo tee -a /etc/bash_completion.d/rustup.bash-completion

            rustup install nightly
            rustup default nightly

            cargo install racer
            cargo install exa
            cargo install fd-find
            cargo install skim
            break;;
        No ) break;;
    esac
done





tput setaf 2; echo "Do you want to install PHP7 and composer"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y php7.0
            sudo apt-get install -y php7.0-fpm
            sudo apt-get install -y php7.0-mysql
            sudo apt-get install -y composer
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install nginx"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y nginx
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
            sudo apt-get install -y openjdk-8-jdk
            sudo apt-get install -y openjdk-9-jdk
            sudo apt-get install -y openjdk-11-jdk
            sudo update-java-alternatives -s java-1.11.0-openjdk-amd64

            sudo apt-get install -y maven
            sudo apt-get install -y gradle
            sudo apt-get install -y ant
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want install Scala and sbt"; tput sgr0
tput setaf 3; echo "Assume that Java is installed"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y scala
            echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
            sudo apt-get update -qq
            sudo apt-get install -y sbt
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want install Clojure and lein"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y leiningen
            sudo apt-get install -y clojure
            break;;
        No ) break;;
    esac
done




tput setaf 2; echo "Do you want to install Haskell Platform"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y haskell-stack
            sudo apt-get install -y haskell-platform
            sudo apt-get install -y haskell-platform-doc
            sudo apt-get install -y haskell-platform-prof
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
            cd ~/.rbenv && src/configure && make -C src && cd - || return
            git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

            export PATH="$HOME/.rbenv/bin:$PATH"
            eval "$(rbenv init -)"

            rbenv install 2.5.1
            rbenv global 2.5.1
            break;;
        No ) break;;
    esac
done



tput setaf 2; echo "Do you want install Terraform and tfenv"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/tfutils/tfenv.git ~/.tfenv

            export PATH="$HOME/.tfenv/bin:$PATH"

            tfenv install latest
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

            crenv install 0.27.1
            crenv global 0.27.1
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
            sudo snap install docker
            sudo snap connect docker:home

            sudo addgroup --system docker
            sudo adduser "$USER" docker
            newgrp docker

            sudo docker run hello-world
            break;;
        No ) break;;
    esac
done

tput setaf 2; echo "Do you want to Android Studio"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y qemu-kvm
            sudo apt-get install -y libvirt-bin
            sudo apt-get install -y ubuntu-vm-builder
            sudo apt-get install -y bridge-utils

            sudo adduser $USER kvm

            sudo snap install android-studio --classic
            break;;
        No ) break;;
    esac
done

