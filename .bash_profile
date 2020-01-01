# Functions

cdl() {
    if [ $# -eq 1 ]; then
        cd $@
    fi
    if [ $? -eq 0 ]; then
        ls -l
    fi
}

epoch() {
    if [ "$#" -ne 1 ]; then
        echo Usage: epoch [time-in-millis]
    else
        date -r $(( $1 / 1000 ))
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

gitdifftool() {
    if [ -z "$1" ]; then
        git difftool
    else
        git difftool $1^ $1
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
    status=`git status -s 2> /dev/null`
    if [ -n "$status" ]; then
        echo "(*)"
    fi
}

pstoggle() {
    if [ "$PS1" == "$PS_LONG" ]; then
        export PS1=$PS_SHORT
    else
        export PS1=$PS_LONG
    fi
}

pushd_and_ls() {
    pushd $*
    if [ $? -eq 0 ] ; then
        ls -l
    fi
}

# Aliases

alias l="ls -l"
alias md="mkdir"
alias c=goup
alias d=cdl
alias esource="vi ~/.bash_profile"
alias resource="source ~/.bash_profile"
alias fs=findstr
alias gs="git status"
alias gb="git branch"
alias gc="git_checkout_helper $*"
alias gl="git log"
alias gd="git diff"
alias gda="git-diffall"
alias gr="./gradlew"
alias gdt=gitdifftool
alias j=jump_dir
alias p=pstoggle
alias pd=pushd_and_ls

# Binds
bind '\C-f:backward-kill-word'

# Exports

export PS_LONG="\[\033[32m\]\u\[\033[32m\]@\[\033[37m\]\h:\[\033[36m\]\w\[\033[35m\]\$(parse_git_branch)\[\033[37m\]\$(parse_git_status)\[\033[32m\]\$\[\033[m\] "
export PS_SHORT="\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;153m\]:\[$(tput sgr0)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"
export PS1=$PS_LONG
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxegedabagacad

export VISUAL=vim # use C-x C-e to edit command line in vim

export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

if [ "$HOSTNAME" == "julian-workmac.local" ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
    export SCRIPTS_DIR=~/Documents/placed/placed-avenger/julian/scripts
    export PATH=$PATH:$JAVA_HOME/bin
    export PATH=$PATH:$SCRIPTS_DIR
fi

