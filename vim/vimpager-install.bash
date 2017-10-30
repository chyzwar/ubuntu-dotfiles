#!/bin/bash

echo "Install vimpager dependencies"
sudo apt-get install -y pandoc
sudo apt-get install -y sharutils

echo "Clone vimpager"
git clone git://github.com/rkitover/vimpager ~/.vimpager

echo "Install vimpager"
(cd ~/.vimpager && sudo make install-deb)

