#!/bin/bash

install_personal_bin () {
if [ ! -d ~/bin ]; then
    cd
    echo "git clone https://github.com/skywinder/bin.git"
    git clone https://github.com/skywinder/bin.git

else
    echo "~/bin already exists -> to pull from master."
    cd ~/bin
    git pull origin master
fi
}

install_personal_bin
