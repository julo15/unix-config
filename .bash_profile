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

alias l="ls -l"
alias md="mkdir"
alias c=goup
alias d=cdl
alias esource="vi ~/.bash_profile"
alias resource="source ~/.bash_profile"
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log"
alias gd="git diff"
alias gda="git-diffall"
alias gr="./gradlew"

gitdifftool() {
    if [ -z "$1" ]; then
        git difftool
    else
        git difftool $1^ $1
    fi
}

alias gdt=gitdifftool

#export PS1="\[\033[32m\]\u\[\033[m\]@\[\033[33m\]\h:\[\033[36m\]\w\[\033[m\]\$ "
export PS1="\[\033[32m\]\u\[\033[32m\]@\[\033[37m\]\h:\[\033[36m\]\w\[\033[32m\]\$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxegedabagacad

if [ -f .aws_config.sh ]; then
    echo Loading .aws_config.sh
    ./.aws_config.sh
fi
