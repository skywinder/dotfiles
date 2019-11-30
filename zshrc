# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel9k/powerlevel9k"

# Customize aliases to your needs:
alias psg="ps -A | grep"
alias lsa="ls -a"
alias lsa="lsa | grep"
alias cpath="pwd | pbcopy"
alias gmg="git merge --no-ff"
alias mg="merge --no-ff"
alias srctree='open -a SourceTree .'
alias hpr='hub pull-request -o'
alias ghistory='history | grep'
alias gcad='g add . && gca -m' 
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
plugins=(git git-flow git-hubflow github ruby rvm rails gem heroku brew pod osx sublime npm node thefuck z tmux rsync history zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# added by recomendation after `brew install ruby`
export PATH="/usr/local/opt/ruby/bin:$PATH"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

#
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
qfind () {
    find . -exec grep -l -s $1 {} \;
    return 0
}

# cd after clone: https://unix.stackexchange.com/questions/97920/how-to-cd-automatically-after-git-clone
funciton gccd() {
   git clone "$1" && cd "$(basename "$1" .git)"
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

