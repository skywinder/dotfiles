#!/bin/bash

install_personal_bin () {
if [ ! -d ~/bin ]; then
    cd
    echo "git clone https://github.com/skywinder/bin.git"
    git clone https://github.com/skywinder/bin.git

else
	echo "~/bin folder already exists. Cancel."
fi
}

install_personal_bin
