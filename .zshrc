# Functions

cdl() {
    if [ $# -eq 1 ]; then
        cd $@
    fi
    if [ $? -eq 0 ]; then
        ls -l --color
    fi
}

cleanup_git_branches() {
    # Define an array of branches to exclude from deletion
    exclude_branches=("main")

    # Fetch all branch names except the current one
    branches=$(git branch | grep -v "\*" | awk '{print $1}')

    # Iterate over each branch name
    for branch in $branches; do
        # Check if the current branch is in the exclude list
        if [[ " ${exclude_branches[@]} " =~ " ${branch} " ]]; then
            echo "Skipping excluded branch: $branch"
            continue
        fi

        # Attempt to delete the branch
        git branch -d "$branch"
        if [ $? -eq 0 ]; then
            echo "Deleted branch: $branch"
        else
            echo "Failed to delete branch: $branch"
        fi
    done
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

jwt() {
    jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "$1"
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
alias gds="git diff --staged"
alias gr="./gradlew"
# alias git_cleanup="git branch | grep -v "\*" | grep -v "main" | awk '{system(\"git branch -d \"$1)}'"
alias j=jump_dir
alias jwt=jwt
alias pjq="pbpaste | jq"
alias sp="spatialite"

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
PROMPT='%F{51}%~%F{5}$(parse_git_branch)%F{7}$(parse_git_status)%F{2}$%f '

# Exports

export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:~/Documents/unix-config/scripts
export PATH=$PATH:/opt/homebrew/bin

export PATH=$PATH:$HOME/.mint/bin

export GOPATH=~/go
export PATH=$PATH:~/go/bin
export GOPROXY=https://proxy.golang.org
alias gocov="go test ./... -coverprofile=coverage.out && go tool cover -html=coverage.out"
export GONOPROXY=github.com/mozi-app
export GONOSUMDB=$GONOPROXY

export PATH=~/.asdf/shims:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This lo


# Ruby
# eval "$(rbenv init - zsh)"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# For swift protobuf
export PATH=$PATH:$HOME/Documents/open/swift-protobuf/.build/release

export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
alias cls='claude --dangerously-skip-permissions'
alias cdls='codex --dangerously-bypass-approvals-and-sandbox'

# Added as suggested by Claude Code
export PATH="$HOME/.local/bin:$PATH"

# Codex
export CODEX_HOME="$HOME/.agents"

# Claudimize
export PATH="/Users/julianlo/Documents/me/claudimize/scripts:$PATH"

# Tracked modular config
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME/.zshrc.d/"*.zsh(.N); do
    [ -f "$file" ] && source "$file"
  done
fi

# Local overrides and secrets (untracked)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME/.zshrc.d/"*.local.zsh(.N); do
    [ -f "$file" ] && source "$file"
  done
fi
