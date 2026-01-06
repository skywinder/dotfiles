# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#if [[ "$TERM_PROGRAM" != "vscode" ]] && [[ -z "$CURSOR_AGENT" ]] && [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

## --- Cursor/VSCode detection ---
#if [[ "$TERM_PROGRAM" == "vscode" ]] || [[ "$TERM_PROGRAM" == "cursor" ]] || [[ -n "$CURSOR_AGENT" ]]; then
  #export IS_CURSOR=1
#fi

# Uncomment the lines below for minimal Cursor configuration (fastest startup)
# if [[ -n "$IS_CURSOR" ]]; then
#   # Minimal configuration for Cursor - just basic PATH and aliases
#   export PATH="$HOME/bin:$PATH"
#   return
# fi

if [[ -n "$IS_CURSOR" ]]; then
  # Skip theme initialization for better compatibility
else
  [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# See https://github.com/ohmyzshwiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME=powerlevel10k/powerlevel10k
#ZSH_THEME="spaceship"
#ZSH_THEME="agnoster"

# Lighter theme in Cursor to avoid heavy prompt init
if [[ -n "$IS_CURSOR" ]]; then
  ZSH_THEME=""
fi


# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# ==========================================
# PLUGIN OPTIMIZATION
# ==========================================
# Which plugins would you like to load?
if [[ -n "$IS_CURSOR" ]]; then
  # Trim plugin set in Cursor to avoid slow/hanging startup
  plugins=(
  git
  gh
  macos
  history
  z
  )
else
  # Full plugin set
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
  yarn
  # add from idealatom setup on vps:
  gitfast
  python
  pyenv
  safe-paste
  zsh-interactive-cd
  zsh-navigation-tools
  F-Sy-H # (fast-syntax-highlighting)
  zsh-autosuggestions
  history-substring-search    # history-substring-search should be loaded after zsh-syntax-highlighting and zsh-autosuggestions
  )
fi

source $ZSH/oh-my-zsh.sh

# Simple prompt in Cursor
if [[ -n "$IS_CURSOR" ]]; then
  PROMPT='%F{blue}%~%f %# '
  RPROMPT=''
fi

# ==========================================
# PYTHON ENVIRONMENT SETUP
# ==========================================
# Set up pyenv first (highest priority)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Ensure pyenv shims have the highest priority
# This adds additional initialization for pyenv to handle all python commands
eval "$(pyenv init --path)"

# Poetry installation path (for Python package management)
export PATH="$HOME/.local/bin:$PATH"

# ==========================================
# NODE.JS ENVIRONMENT SETUP
# ==========================================
# NVM setup (skip in Cursor to avoid slow startup)
if [[ -z "$IS_CURSOR" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# NPM
export PATH="$HOME/.node/bin:$HOME/.npm-packages/bin:$PATH"

# ==========================================
# RUBY ENVIRONMENT SETUP
# ==========================================
# Ruby related paths
export PATH="/usr/local/opt/ruby/bin:$PATH"
export GEM_HOME=$HOME/.gem
export PATH=$HOME/.gem/bin:$PATH
export RUBYPATH="/usr/local/lib/ruby/gems/2.7.0"
export PATH=$RUBYPATH/bin:$PATH
if [[ -z "$IS_CURSOR" ]]; then
  eval "$(rbenv init - zsh)"
fi

# ==========================================
# GOLANG ENVIRONMENT SETUP
# ==========================================
# For Go lang:
export GOPATH="$HOME/Projects/go"
export PATH=$GOPATH/bin:$PATH

# ==========================================
# OTHER PATH ADDITIONS
# ==========================================
# Core PATH additions
export PATH=$PATH:$HOME/bin
export PATH="$PATH:/Users/jetbrains/.local/bin"

# For macports:
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# For brew:
export PATH=/usr/local/sbin:$PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Cargo (Rust)
export PATH="$HOME/.cargo/bin:$PATH"

# MEGA cli support
export PATH=/Applications/MEGAcmd.app/Contents/MacOS:$PATH

# Flutter
export PATH=$HOME/repo/flutter/bin:$PATH

# NARGO and BB
export NARGO_HOME="/Users/pk/.nargo"
export PATH="$PATH:$NARGO_HOME/bin"
export BB_HOME="/Users/pk/.bb"
export PATH="$PATH:$BB_HOME"

# FZF (skip in Cursor to avoid command interference)
if [[ -z "$IS_CURSOR" ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# ==========================================
# PATH DEDUPLICATION
# ==========================================
# Remove duplicate entries from PATH
typeset -U PATH

# ==========================================
# ENVIRONMENT VARIABLES
# ==========================================
# Hello, vim!
export EDITOR=vim
# Git vim editor with insert mode at start:
export GIT_EDITOR='vim +startinsert!'

# to correct working pods:
# see: https://github.com/CocoaPods/guides.cocoapods.org/issues/26
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
# and others locale vars:
export LANGUAGE="en_US.UTF-8"

# load local env variables
source ~/.env

# ==========================================
# ALIASES AND HELPER FUNCTIONS
# ==========================================

# ls after cd: (https://vas3k.club/question/3817/)
# Skip in Cursor to avoid interfering with command detection
if [[ -z "$IS_CURSOR" ]]; then
  cd() { builtin cd $@ && ls -lh }
fi

# Python aliases
# alias python=python3
# alias pip=pip3
if command -v uvx >/dev/null 2>&1; then
alias poetry='uvx poetry'
fi

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
   source $HOME/.private
fi

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
function gccd() {
  gh repo clone "$1"
  dir=$(basename "$1")
  cd "$dir"
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

## safe rm: brew install safe-rm
alias rm='safe-rm'

# Customize aliases to your needs:
alias psg="ps -A | grep"
alias lsa="ls -a"
alias lsa="lsa | grep"
alias cpath="pwd | pbcopy"
alias gmg="git merge --no-ff"
alias mg="merge --no-ff"
alias srctree='open -a SourceTree "$(git rev-parse --show-toplevel)"'
alias srct='open -a SourceTree "$(git rev-parse --show-toplevel)"'
alias hpr='hub pull-request -o'
alias ghistory='history | grep'
alias gcad='g add . && gca -m'
alias cmd='mkcddir'

# Thanks, @KrauseFx, for inspiration!
# https://github.com/KrauseFx/dotfiles/blob/master/.zshrc
alias zshrc="vim ~/.zshrc"

alias c='cursor "$(git rev-parse --show-toplevel)"'
alias i='idea "$(git rev-parse --show-toplevel)"'
alias o='open "$(git rev-parse --show-toplevel)"'
alias a='atom "$(git rev-parse --show-toplevel)"'

# Now you can 'git kraken'!
alias kraken='open -na "GitKraken" --args -p "$(git rev-parse --show-toplevel)"'

# env files when start sudo:
alias sudo='sudo -E'

# for color logs:
alias tail='grc tail'

# Colorful tail with grc
alias ctail='grc tail'

alias dc="docker compose"

### -----------------------------------------------------------
### 1-LINE PROGRESS  •  FULL-METADATA LOCAL CLONE  •  APFS/HFS+
### -----------------------------------------------------------

# Prefer Homebrew's modern rsync (≥3). Fallback to the macOS copy if missing.
if command -v /opt/homebrew/bin/rsync >/dev/null 2>&1; then
  export RSYNC_CMD="/opt/homebrew/bin/rsync"
else
  export RSYNC_CMD="/usr/bin/rsync"        # macOS 2.6.9
fi

# from https://github.com/TeamPyOgg/PyOgg/issues/113#issuecomment-2585724522
export DYLD_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_LIBRARY_PATH
export LIBRARY_PATH=/opt/homebrew/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH

. "$HOME/.local/bin/env"
if [[ -z "$IS_CURSOR" ]]; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

# bun completions
[ -s "/Users/pk/.bun/_bun" ] && source "/Users/pk/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude="/Users/pk/.claude/local/claude"
. "/Users/pk/.deno/env"
alias ai="aichat -e"

# Added by Antigravity
export PATH="/Users/pk/.antigravity/antigravity/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

eval "$(screenpipe completions zsh)"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/pk/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
