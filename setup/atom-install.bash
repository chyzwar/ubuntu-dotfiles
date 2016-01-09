#!/bin/bash


tput setaf 1; echo "Install Atom Editor"; tput sgr0
sudo add-apt-repository -y ppa:webupd8team/atom
sudo apt-get update -qq
sudo apt-get install -y atom