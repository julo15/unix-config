cdl() {
    if [ $# -eq 1 ]; then
        cd $@
    fi
    if [ $? -eq 0 ]; then
        ls -l
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

findstr() {
    if [ "$#" -ne 2 ]; then
        echo Usage: fs [search-term] [file-scope]
        echo Example: fs foo *.json
        echo Example: fs foo *.*
        echo Example: fs foo *.{php,html}
    else
        egrep -ir --include=$2 "$1" .
    fi
}

gitdifftool() {
    if [ -z "$1" ]; then
        git difftool
    else
        git difftool $1^ $1
    fi
}

alias l="ls -l"
alias md="mkdir"
alias c=goup
alias d=cdl
alias esource="vi ~/.bash_profile"
alias resource="source ~/.bash_profile"
alias fs=findstr
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log"
alias gd="git diff"
alias gda="git-diffall"
alias gr="./gradlew"
alias gdt=gitdifftool

export PS1="\[\033[32m\]\u\[\033[32m\]@\[\033[37m\]\h:\[\033[36m\]\w\[\033[32m\]\$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxegedabagacad

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

if [ -f .aws_config.sh ]; then
    echo Loading .aws_config.sh
    ./.aws_config.sh
fi
