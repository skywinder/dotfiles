# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# See https://github.com/ohmyzshwiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME=powerlevel10k/powerlevel10k
#ZSH_THEME="spaceship"
#ZSH_THEME="agnoster"


# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
github
gh
ruby
gem
brew
pod
macos
npm
node
z
tmux
rsync
history
docker
docker-compose
docker-machine
yarn
poetry
# add from idealatom setup on vps:
gitfast
python
pyenv
#dotenv
safe-paste
zsh-interactive-cd
zsh-navigation-tools
F-Sy-H # (fast-syntax-highlighting)
zsh-autosuggestions
history-substring-search    # history-substring-search should be loaded after zsh-syntax-highlighting and zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# My actual PATH = /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin
# So, next string probably not needed..
export PATH=$PATH:$HOME/bin
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin"
# https://docs.python-guide.org/starting/install3/osx/#install3-osx

# Poetry installation path
export PATH="$PATH:$HOME/.local/bin"


export PATH="~/Library/Python/3.7:$PATH"
alias python=python3

#add pip alias as well
alias pip=pip3

#https://www.jetbrains.com/help/pycharm/pipenv.html#
export PATH="$PATH:/Users/jetbrains/.local/bin"

# For macports:
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#for brew:
export PATH=/usr/local/sbin:$PATH

#for installation z:
#. /usr/local/etc/profile.d/z.sh

#for npm:
export PATH="$HOME/.node/bin:$HOME/.npm-packages/bin:$PATH"

#for Go lang:
export GOPATH="$HOME/Projects/go"
export PATH=$GOPATH/bin:$PATH

# added by recomendation after `brew install ruby`
export PATH="/usr/local/opt/ruby/bin:$PATH"

# support chruby
#source /usr/local/share/chruby/chruby.sh
#source /usr/local/share/chruby/auto.sh

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

#Ruby + gem
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem

export PATH=$GEM_HOME/bin:$PATH

export RUBYPATH="/usr/local/lib/ruby/gems/2.7.0"
export PATH=$RUBYPATH/bin:$PATH

# add MEGA cli support
export PATH=/Applications/MEGAcmd.app/Contents/MacOS:$PATH

#-----------

# Hello, vim!
export EDITOR=vim
#Git vim editor with insert mode at start:
export GIT_EDITOR='vim +startinsert!'

#to correct working pods:
#see: https://github.com/CocoaPods/guides.cocoapods.org/issues/26
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
# and others locale vars:
export LANGUAGE="en_US.UTF-8"

# To make sed works: http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
#export LC_CTYPE=C
#export LANG=C

# load local env variables
source ~/.env

#  The next lines is from  https://github.com/michaeljsmalley/dotfiles.git repo.

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

function mcg ()
{
    echo "Creating folder named: $1"
    mkdir "$1" && cd "$1" && git init
    echo "Folder $1 created and git initialized."
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

# mac specific:
# Fast clear Derived Data folder for Xcode
function cleandd(){
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "Removed all derived data."
}

#simple werapper for speedtest to store output
function speedlog()
{
    echo "\n----\n" >> ~/tmp/speed.log
    date >> ~/tmp/speed.log
    fast -u | tee -a  ~/tmp/speed.log
    echo "\n----" >> ~/tmp/speed.log
    echo "data stored in ~/tmp/speed.log"
}

#for linux clipboards:
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# Exports:
#http://stackoverflow.com/a/31250347/1698467

# export RBENV_ROOT=/usr/local/var/rbenv

# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## safe rm: brew install safe-rm
alias rm='safe-rm'
#alias rm="rm_i"

#function rm_i(){
#RM_BIN=safe-rm # you can replace it with regular rm if you like

#args=""
#files=""
#argsDone=0 # to make sure arguments are before the files

#for var in "$@"
#do
    #if [[ $var == \-* ]] ; then
        #if [ $argsDone -eq 1 ] ; then
            #$RM_BIN # just to show the usage of rm
            #return
        #fi
        #args+=" $var"
    #else
        #argsDone=1
        #files+=" $var"
    #fi
#done

#args+=" -i" # Put -i at the end (so rm -rf will not ignore it)

#$RM_BIN $args $files
#}




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

# Thanks, @KrauseFx, for inspiration!
# https://github.com/KrauseFx/dotfiles/blob/master/.zshrc
alias zshrc="vim ~/.zshrc"
#alias bundle!="bundle install && rake install"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias ri="rake install"
alias c='code "$(git rev-parse --show-toplevel)"'
alias i='idea "$(git rev-parse --show-toplevel)"'
alias o='open "$(git rev-parse --show-toplevel)"'
alias a='atom "$(git rev-parse --show-toplevel)"'

# Now you can 'git kraken'!
alias kraken='open -na "GitKraken" --args -p "$(git rev-parse --show-toplevel)"'


# Docker aliases:
alias dm-ssh='docker-machine ssh `docker-machine active`'
alias dm-ip='docker-machine ip `docker-machine active`'
alias dm-env='docker-machine env `docker-machine active`'
alias dm-inspect='docker-machine inspect `docker-machine active`'
alias dm-config='docker-machine config `docker-machine active`'

# env files when start sudo:
alias sudo='sudo -E'

#alias tailscale="/System/Volumes/Data/Applications/_dev_VPN/Tailscale.app"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pk/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pk/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pk/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pk/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# pyenv installations script:

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#


export NARGO_HOME="/Users/pk/.nargo"

export PATH="$PATH:$NARGO_HOME/bin"

export BB_HOME="/Users/pk/.bb"

export PATH="$PATH:$BB_HOME"
