# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git git-flow git-hubflow github ruby rvm rails gem heroku brew pod osx sublime npm)

source $ZSH/oh-my-zsh.sh

# My actual PATH = /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin
# So, next string probably not needed..
export PATH=$PATH:$HOME/bin

# For macports:
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#for brew:
export PATH=/usr/local/sbin:$PATH

#for npm:
export PATH="$HOME/.node/bin:$PATH"

#for Go lang:
export GOPATH="$HOME/Projects/go"
export PATH=$GOPATH/bin:$PATH

# The variable for Theos.
export THEOS=/opt/theos

# Sublime as default text editor
#export EDITOR="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl -w"
#Hello, vim!
export EDITOR=vim
#Git vim editor with insert mode at start:
export GIT_EDITOR='vim +startinsert'

#to coorect working pods:
#see: https://github.com/CocoaPods/guides.cocoapods.org/issues/26
export LC_ALL="en_US.UTF-8"
#and others locale vars:
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

export CHANGELOG_GITHUB_TOKEN="8587bb22f6bf125454768a4a19dbcc774ea68d48"
export CODECLIMATE_REPO_TOKEN="ee3d2bb731918eed89b9c2a5a3ee11db0c6a17231d43b6a14e70f1eb6c811f9a"

export LOLCOMMITS_DELAY=1

# To make sed works: http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
export LC_CTYPE=C 
export LANG=C

# For Android development (adb): http://stackoverflow.com/questions/10303639/adb-command-not-found
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

# For build Crosswalk (depot_tools):
export PATH=$PATH:~/bin/depot_tools
#####  The next lines is from  https://github.com/michaeljsmalley/dotfiles.git repo. I'll try merge it latter :)
#####  skywinder

 export XWALK_OS_ANDROID=1
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

# # Custom exports
# ## Set EDITOR to /usr/bin/vim if Vim is installed
# if [ -f /usr/bin/vim ]; then
#     export EDITOR=/usr/bin/vim
# fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#for linux clipboards:
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/skywinder/.sdkman"
[[ -s "/Users/skywinder/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/skywinder/.sdkman/bin/sdkman-init.sh"

export XWALK_OS_ANDROID=1
