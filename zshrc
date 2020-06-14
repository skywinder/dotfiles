# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#
#ZSH_THEME="robbyrussell"
ZSH_THEME=powerlevel10k/powerlevel10k
#ZSH_THEME="spaceship"
#ZSH_THEME="agnoster"

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

# Thanks, @KrauseFx, for inspiration!
# https://github.com/KrauseFx/dotfiles/blob/master/.zshrc
alias zshrc="vim ~/.zshrc"
#alias bundle!="bundle install && rake install"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias ri="rake install"
alias c="code $(git rev-parse --show-toplevel)"
alias i="idea $(git rev-parse --show-toplevel)"
alias o="open $(git rev-parse --show-toplevel)"
alias a="atom $(git rev-parse --show-toplevel)"

# Now you can 'git kraken'!
alias kraken='open -na "GitKraken" --args -p "$(git rev-parse --show-toplevel)"'


# Docker aliases:
alias dm-ssh='docker-machine ssh `docker-machine active`'
alias dm-ip='docker-machine ip `docker-machine active`'
alias dm-env='docker-machine env `docker-machine active`'
alias dm-inspect='docker-machine inspect `docker-machine active`'
alias dm-config='docker-machine config `docker-machine active`'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow git-hubflow github ruby rvm rails gem heroku brew pod osx npm node thefuck z tmux rsync history zsh-autosuggestions zsh-completions zsh-syntax-highlighting docker  docker-compose  docker-machine)

source $ZSH/oh-my-zsh.sh

# My actual PATH = /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin
# So, next string probably not needed..
export PATH=$PATH:$HOME/bin

# https://docs.python-guide.org/starting/install3/osx/#install3-osx
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

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


#-----------

#Hello, vim!
export EDITOR=vim
#Git vim editor with insert mode at start:
export GIT_EDITOR='vim +startinsert!'

#to coorect working pods:
#see: https://github.com/CocoaPods/guides.cocoapods.org/issues/26
export LC_ALL="en_US.UTF-8"
#and others locale vars:
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# To make sed works: http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
export LC_CTYPE=C
export LANG=C

# To make sed works: http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
export LC_CTYPE=C
export LANG=C

# For Android development (adb): http://stackoverflow.com/questions/10303639/adb-command-not-found
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

source ~/.env

#####  The next lines is from  https://github.com/michaeljsmalley/dotfiles.git repo. I'll try merge it latter :)
#####  skywinder

# Explicitly configured $PATH variable
# PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/local/bin:/opt/local/sbin:/usr/X11/bin

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
   source $HOME/.private
fi

# if [ -f $HOME/.profile ]; then
#     source $HOME/.profile  # Read Mac .profile, if present.
# fi

# # qfind - used to quickly find files that contain a string in a directory
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

# mdir and cd:
function mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# bk_script
function bk()
{
    cp $1 $1.bk
}

function restore()
{
    var=$1
    orig=${var%.bk}
    cp $1 $orig
}

function bkv()
{
    bk $1
    vim $1
}

# Fast clear Derived Data folder for Xcode
function cleandd(){
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "Removed all derived data."
}

function speedlog()
{
    echo "\n----\n" >> ~/tmp/speed.log
    date >> ~/tmp/speed.log
    speedtest | tee -a  ~/tmp/speed.log
    echo "\n----" >> ~/tmp/speed.log
}
#
# # Custom exports
# ## Set EDITOR to /usr/bin/vim if Vim is installed
# if [ -f /usr/bin/vim ]; then
#     export EDITOR=/usr/bin/vim
# fi

#for linux clipboards:
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

#eval "$(thefuck --alias)"

#http://stackoverflow.com/a/31250347/1698467
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(thefuck --alias)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/pk/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

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
