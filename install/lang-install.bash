#!/usr/bin/env bash
# shellcheck disable=SC1090


DIR="$(dirname "$(readlink -f "$0")")"

source "$DIR/nix-install.bash"

tput setaf 2; echo "Installing Python2 "; tput sgr0
nix-env --install python-2.7.14

tput setaf 2; echo "Installing Python 3 "; tput sgr0
nix-env --install python3-3.6.4

tput setaf 2; echo "Installing nodejs "; tput sgr0
nix-env --install nodejs-8.9.4

tput setaf 2; echo "Installing erlang "; tput sgr0
nix-env --install erlang-20.2.2

tput setaf 2; echo "Installing Rebar3 "; tput sgr0
nix-env --install rebar3-3.4.3

tput setaf 2; echo "Installing elixir "; tput sgr0
nix-env --install elixir-1.6.2

tput setaf 2; echo "Installing ocaml "; tput sgr0
nix-env --install ocaml-4.04.2

tput setaf 2; echo "Installing opam "; tput sgr0
nix-env --install opam-1.2.2

tput setaf 2; echo "Installing php 7 "; tput sgr0
nix-env --install php-7.2.3

tput setaf 2; echo "Installing composer "; tput sgr0
nix-env --install composer-1.6.3

tput setaf 2; echo "Installing Java 8 "; tput sgr0
nix-env --install openjdk-8u172b02

tput setaf 2; echo "Installing Maven "; tput sgr0
nix-env --install apache-maven-3.5.2

tput setaf 2; echo "Installing Ant "; tput sgr0
nix-env --install ant-1.9.6

tput setaf 2; echo "Installing Gradle "; tput sgr0
nix-env --install gradle-4.6

tput setaf 2; echo "Installing Julia"; tput sgr0
nix-env --install julia-0.6.2

tput setaf 2; echo "Installing GHC"; tput sgr0
nix-env --install ghc-8.2.2

tput setaf 2; echo "Installing Cabal"; tput sgr0
nix-env --install cabal-install-2.0.0.1

tput setaf 2; echo "Installing stack"; tput sgr0
nix-env --install stack-1.6.5

tput setaf 2; echo "Installing stack"; tput sgr0
nix-env --install go-1.9.4

tput setaf 2; echo "Installing ruby"; tput sgr0
nix-env --install ruby-2.5.0

tput setaf 2; echo "Installing clojure"; tput sgr0
nix-env --install clojure-1.9.0.329

tput setaf 2; echo "Installing lein"; tput sgr0
nix-env --install leiningen-2.8.1

tput setaf 2; echo "Installing crystal"; tput sgr0
nix-env --install crystal-0.24.1

tput setaf 2; echo "Installing rustup"; tput sgr0
nix-env --install rustup-1.11.0
