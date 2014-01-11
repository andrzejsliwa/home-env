# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="eastwood"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx rake rebar rails3 capistrano)

source $ZSH/oh-my-zsh.sh

alias epull='for dir in ~/erlang/local-copy/*; do (cd "$dir" && echo "in $dir.." && git stash && git pull && rebar get-deps && rebar compile); done'
alias e='open -a /Applications/Emacs.app "$@"'
alias ew='exec emacsclient -a "" "$@"'
alias dns='ec /etc/hosts; dscacheutil -flushcache'
alias fixp="rm /usr/local/var/postgres/postmaster.pid"

function c {
  message=""
  for word in "$@"
  do
     message+="$word "
  done
  echo "git commit -u -m \"$message\""
  git commit -u -m "$message"
  git push
}

function gsb {
  git log | grep '^Author' | sort | uniq -ci | sort -r
}

function gsu {
  git remote add upstream git://github.com/$@.git
}

export EDITOR=ew

# Customize to your needs...
export PATH=/usr/local/bin:$PATH
