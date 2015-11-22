alias l="ls -l"
alias md="mkdir"
alias c="cd .."

#export PS1="\[\033[32m\]\u\[\033[m\]@\[\033[33m\]\h:\[\033[36m\]\w\[\033[m\]\$ "
export PS1="\[\033[32m\]\u\[\033[32m\]@\[\033[32m\]\h:\[\033[36m\]\w\[\033[32m\]\$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxegedabagacad

if [ -f .aws_config.sh ]; then
    ./.aws_config.sh
else
    echo warn: no aws config found
fi
