#!/bin/bash

#unstested install script (WIP)
if [ "$1" != "" ]; then
    echo copy files to $1
    scp ~/.vimrc $1:~/.vimrc
    echo installing vundle
    ssh $1 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
    ssh $1 'vim +PluginInstall +qall'
else
    echo "add name@host as arguments"
fi

