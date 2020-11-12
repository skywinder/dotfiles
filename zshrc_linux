# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow git-hubflow npm node tmux rsync history zsh-autosuggestions zsh-completions zsh-syntax-highlighting docker  docker-compose  docker-machine)

source $ZSH/oh-my-zsh.sh

# User configuration

# Hello, vim!
export EDITOR=vim

# Git vim editor with insert mode at start:
export GIT_EDITOR='vim +startinsert!'

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# and others locale vars:
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# load local env variables
source ~/.env

#  The next lines is from  https://github.com/michaeljsmalley/dotfiles.git repo

# ls after cd: (https://vas3k.club/question/3817/)
cd() { builtin cd $@ && ls -lh }

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
   source $HOME/.private
fi


## Helper functions

# qfind - used to quickly find files that contain a string in a directory
function qfind () {
    find . -exec grep -l -s $1 {} \;
    return 0
}

# git quick update
# thanks to https://github.com/nikitavoloboev/dotfiles
# if no commit message is necessary.
function gacp() {
    git add .
    git commit . -m 'update'
    git push
}

# A lot safer than to rm -rf files as you can always check out ~/.Trash in cases of emergency or mistakes.
function re(){
  mv "$1" ~/.Trash
}

# cd after clone: https://unix.stackexchange.com/questions/97920/how-to-cd-automatically-after-git-clone
funciton gccd() {
   git clone "$1" && cd "$(basename "$1" .git)"
}

# cd after mdkir:
function mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# bk - make a copy of file with bk extension
function bk()
{
    cp $1 $1.bk
    echo made a copy of file: $1.bk
}

# restore file after bk function
function restore()
{
    var=$1
    orig=${var%.bk}
    cp $1 $orig
}

# backup file and open in vim
function bkv()
{
    bk $1
    vim $1
}



# Simplified copy scrips: send filename and destination only.   echo "expercted 2 parameters: filename and path"
# usage: cpf file path
function cpf()
{
    if [ "$1" != "" ] && [ "$2" != "" ]; then
        echo "cp ./${1} ${2}/${1}"
        cp "./${1} ${2}/${1}"
    else
        echo "expercted 2 parameters: filename and path"
    fi
}


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Customize aliases to your needs:
alias psg="ps -A | grep"
alias lsa="ls -a"
alias lsa="lsa | grep"
alias cpath="pwd | pbcopy"
alias gmg="git merge --no-ff"
alias mg="merge --no-ff"
alias srctree='open -a SourceTree "$(git rev-parse --show-toplevel)"'
alias hpr='hub pull-request -o'
alias ghistory='history | grep'
alias gcad='g add . && gca -m'
alias cmd= 'mkcddir'

# Docker aliases:
alias dm-ssh='docker-machine ssh `docker-machine active`'
alias dm-ip='docker-machine ip `docker-machine active`'
alias dm-env='docker-machine env `docker-machine active`'
alias dm-inspect='docker-machine inspect `docker-machine active`'
alias dm-config='docker-machine config `docker-machine active`'

# env files when start sudo:
alias sudo='sudo -E'
