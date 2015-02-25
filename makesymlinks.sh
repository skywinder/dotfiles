#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="zshrc private Xresources gitignore_global gitconfig profile vimrc shsh vim ideavimrc gvimrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    #check, that file is not sym-link to our file:
    sym_path=`eval "readlink ~/.$file"`
    subpath=`echo $dir`
    if [[ $sym_path == "$subpath"* ]]
    then
        echo "File $file is already linked -> skip"
        continue
    fi
    echo "Moving $file ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


echo -n "Clonning bin directory ..."
./install_bin.sh
echo "Done"
#check if ~/.vim/bundle/Vundle.vim is empty - run "git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
