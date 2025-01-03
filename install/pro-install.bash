#!/bin/bash
# shellcheck disable=SC1090

tput setaf 2; echo "Do you want to install Python Tools"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y make build-essential lzma libssl-dev zlib1g-dev libbz2-dev
            sudo apt-get install -y libreadline-dev libsqlite3-dev wget curl llvm
            sudo apt-get install -y libncurses5-dev libncursesw5-dev xz-utils tk-dev
            sudo apt-get install -y libffi-dev liblzma-dev python-openssl python-dev software-properties-common

            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
            git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
            git clone https://github.com/pyenv/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash

            export PATH="$HOME/.pyenv/bin:$PATH"
            eval "$(pyenv init -)"

            pyenv install 2.7.17
            pyenv install 3.11.7

            pyenv global 3.11.7

            pip install --upgrade pip
            pip install --user pipenv

            curl -sSL https://install.python-poetry.org | python3 -
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

            node_versions=(20.16.0 22.5.1)
            for version in "${node_versions[@]}"
            do
                echo "Installing node version" "$version"
                nodenv install "$version"
                nodenv global "$version"

                npm install -g --depth 0 npm
                npm install -g --depth 0 yarn
                npm install -g --depth 0 pnpm
            done
            break;;
        No ) break;;
    esac
done

tput setaf 2; echo "Do you want to install elixir and erlanf"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch master
            source "$HOME"/.asdf/asdf.sh
            source "$HOME"/.asdf/completions/asdf.bash

            export KERL_CONFIGURE_OPTIONS="\
                --without-javac \
                --without-wx"

            asdf plugin add erlang
            asdf plugin add elixir
            asdf plugin add nodejs
            asdf plugin add terraform

            asdf install erlang latest
            asdf global erlang latest

            asdf install elixir latest
            asdf global elixir latest
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

            sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian noble contrib" >> /etc/apt/sources.list.d/virtualbox.org.list'
            sudo apt-get update -qq
            sudo apt-get install -y virtualbox-6.1
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

tput setaf 2; echo "Do you want to install deno"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            curl -fsSL https://deno.land/install.sh | sh
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
            sudo apt-get install apt-transport-https curl gnupg -yqq
            echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
            curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
            sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg

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

            sudo apt-get install -y libyaml-dev

            export PATH="$HOME/.rbenv/bin:$PATH"
            eval "$(rbenv init -)"

            rbenv install 3.2.5
            rbenv global 3.2.5
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

            crenv install 1.13.1
            crenv global 1.13.1
            crenv rehash
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install nix"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sh <(curl -L https://nixos.org/nix/install) --daemon
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install docker"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
            sudo add-apt-repository "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable"
            sudo apt-get update -qq
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo groupadd docker
            sudo usermod -aG docker "$USER"
            break;;
        No ) break;;
    esac
done


tput setaf 2; echo "Do you want to install docker-compose"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo curl \
              -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-Linux-x86_64" \
              -o /usr/local/bin/docker-compose

            sudo chmod +x /usr/local/bin/docker-compose
            break;;
        No ) break;;
    esac
done



tput setaf 2; echo "Do you want to Android Studio"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo apt-get install -y qemu-kvm
            sudo apt-get install -y libvirt-daemon-system libvirt-clients
            sudo apt-get install -y ubuntu-vm-builder
            sudo apt-get install -y bridge-utils

            sudo adduser "$USER" kvm

            sudo snap install android-studio --classic
            break;;
        No ) break;;
    esac
done

tput setaf 2; echo "Do you want to instal zig"; tput sgr0
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            sudo snap install zig --classic --beta
            break;;
        No ) break;;
    esac
done
