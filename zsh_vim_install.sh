#!/bin/bash

#unstested install script (WIP)
if [ "$1" != "" ]; then
    echo copy files to $1
    scp ~/.vimrc $1:~/.vimrc
    echo installing vundle
else
    echo "add name@host as arguments"
fi

