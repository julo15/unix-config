# Mozi-specific aliases, functions, and env (tracked).

# ---- AWS
alias awsd="aws --profile=dev"
alias awsp="aws --profile=prod"
alias aws-creds='aws --profile=dev configure export-credentials'

# ---- K8s
alias k8ld="aws --profile=dev sso login && aws --profile dev eks update-kubeconfig --name dev-cluster --alias dev"
alias k8lp="aws --profile=prod sso login && aws --profile prod eks update-kubeconfig --name prod-cluster --alias prod"
alias k8ud="kubectl config use-context dev"
alias k8up="kubectl config use-context prod"
alias k8=kubectl

GOPRIVATE=github.com/mozi-app/*

function ctx() {
    echo "kubectl config use-context $1"
    kubectl config use-context $1
}

alias ctxp="ctx prod"
alias ctxd="ctx dev"

function sternc() {
    local awk_command='
        /error/ {print "\033[31m" $0 "\033[39m"}
        /warn/ {print "\033[33m" $0 "\033[39m"}
        /info/ {print "\033[34m" $0 "\033[39m"}
        !/error|info|warn/ {print $0}
    '

    if [ -z "$2" ]; then
        stern -A $1 | awk "$awk_command"
    else
        stern -A $1 --tail $2 | awk "$awk_command"
    fi
}

alias dstern='ctxd && sternc'
alias pstern='ctxp && sternc'

alias deploy='~/Documents/mozi/deploy'
