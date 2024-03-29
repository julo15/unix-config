# Functions

cdl() {
    if [ $# -eq 1 ]; then
        cd $@
    fi
    if [ $? -eq 0 ]; then
        ls -l --color
    fi
}

findstr() {
    if [ "$#" -ne 2 ]; then
        echo Usage: fs [search-term] [file-scope]
        echo Example: fs foo *.json
        echo Example: fs foo *.*
        echo Example: fs foo *.{php,html}
    else
        egrep -inr --include=$2 "$1" .
    fi
}

goup() {
    if [[ $# -eq 0 ]]; then
        cd ..
    else
        startDirectory=$PWD
        currentDirectory=${PWD##*/}
        while [[ $currentDirectory != *"$1"* ]]; do
            cd ..

            if [ "$PWD" == "/" ]; then
                cd $startDirectory
                echo No parent directory found containing "$1"
                break;
            fi

            currentDirectory=${PWD##*/}
        done
    fi
}

jump_dir() {
    output=`ruby jump_dir.rb $*`
    if [ $? -eq 0 ]; then
        cd $output
    fi
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

parse_git_status() {
    local git_status=`git status -s 2> /dev/null`
    if [ -n "$git_status" ]; then
        echo "(*)"
    fi
}

# Aliases

alias l="ls -l --color"
alias md="mkdir"
alias c=goup
alias d=cdl
alias esource="vi ~/.zshrc"
alias fs=findstr
alias gs="git status"
alias gb="git branch --sort=committerdate"
alias gc="git-ss $*"
alias gd="git diff"
alias gr="./gradlew"
alias j=jump_dir

# History
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=1000
alias hist="history -50"

# Auto complete
setopt menucomplete

# Delete word style
autoload -U select-word-style
select-word-style bash

# Git
ZSH_DISABLE_COMPFIX=true
autoload -Uz compinit && compinit

# Prompt
setopt prompt_subst
PROMPT='%F{2}%n@%F{254}%m:%F{51}%~%F{5}$(parse_git_branch)%F{7}$(parse_git_status)%F{2}$%f '

# Exports

export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:~/Documents/unix-config/scripts

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This lo

