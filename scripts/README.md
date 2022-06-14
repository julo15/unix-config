# git smart switch

## Install

1. Add the following to your `~/.zshrc`: `alias gss="git_smart_switch $*"`
1. Add this scripts folder to your path: e.g. `export PATH=$PATH:~/Documents/unix-config/scripts`
1. Reload your terminal

## Usage

```
# Switch branches
# This will
# 1) stash any changes on your current branch
# 2) switch branches
# 3) apply stash to resultant branch
gss fuzzy-branch-name

```
