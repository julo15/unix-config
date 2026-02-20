# Mozi-specific aliases, functions, and env (tracked).

alias use_dev="bundle exec fastlane use_dev_config"
alias use_stg="bundle exec fastlane use_staging_config"
alias use_prod="bundle exec fastlane use_prod_config"
alias beb="./install.sh"
alias ber="docker-compose up -d"
alias use_newmozi="cp ~/Documents/mozi/docs/ios-build-server/buildServer.json.NewMozi buildServer.json"
alias use_wanderfusion="cp ~/Documents/mozi/docs/ios-build-server/buildServer.json.WanderFusion buildServer.json"
alias use_vortexorchestra="cp ~/Documents/mozi/docs/ios-build-server/buildServer.json.VortexOrchestra buildServer.json"

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

alias pw_user_profile_dev="awsd secretsmanager get-secret-value --secret-id 'rds!cluster-e013a4c5-4377-41db-a87a-8df8d52257b7' | jq -r '.SecretString' | jq -r '.password'"
alias pw_location_dev="awsd secretsmanager get-secret-value --secret-id 'rds!cluster-b882f5e0-b809-4a4c-8dfe-73b1a3804e47' | jq -r '.SecretString' | jq -r '.password'"
alias pw_user_profile_prod="awsp secretsmanager get-secret-value --secret-id 'rds!cluster-8e1ea540-b14e-4963-a238-6859819dc9dd' | jq -r '.SecretString' | jq -r '.password'"
alias pw_location_prod="awsp secretsmanager get-secret-value --secret-id 'rds!cluster-f02f58e5-392e-4386-aab5-043ac0e34807' | jq -r '.SecretString' | jq -r '.password'"

psql_user_profile_dev() {
    k8ud
    k8 run -i -t --rm --image postgres:latest julian --env="PGPASSWORD=$(pw_user_profile_dev)" --command -- /bin/bash -c "psql -h user-profile-dev.cluster-ro-c9muycya8ras.us-west-2.rds.amazonaws.com -U user_profile_dev user_profile_dev"
}

psql_location_dev() {
    k8ud
    k8 run -i -t --rm --image postgres:latest julian --env="PGPASSWORD=$(pw_location_dev)" --command -- /bin/bash -c "psql -h location-dev.cluster-ro-c9muycya8ras.us-west-2.rds.amazonaws.com -U location_dev location_dev"
}

psql_user_profile_prod() {
    k8up
    k8 run -i -t --rm --image postgres:latest julian --env="PGPASSWORD=$(pw_user_profile_prod)" --command -- /bin/bash -c "psql -h user-profile-prod.cluster-ro-c1sauaokwp94.us-west-2.rds.amazonaws.com -U user_profile_prod user_profile_prod"
}

psql_location_prod() {
    k8up
    k8 run -i -t --rm --image postgres:latest julian --env="PGPASSWORD=$(pw_location_prod)" --command -- /bin/bash -c "psql -h location-prod.cluster-ro-c1sauaokwp94.us-west-2.rds.amazonaws.com -U location_prod location_prod"
}

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
