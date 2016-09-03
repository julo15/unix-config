#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo
echo WARNING! This will overwrite the following in your ~ directory:
echo
echo "    .bash_profile"
echo "    .inputrc"
echo "    .tmux.conf"
echo "    .vimrc"
echo
read -p "Proceed? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm ~/.bash_profile
    rm ~/.inputrc
    rm ~/.tmux.conf
    rm ~/.vimrc
    ln -s $SCRIPT_DIR/.bash_profile ~/.bash_profile
    ln -s $SCRIPT_DIR/.inputrc      ~/.inputrc
    ln -s $SCRIPT_DIR/.tmux.conf    ~/.tmux.conf
    ln -s $SCRIPT_DIR/.vimrc        ~/.vimrc
    echo
    echo Done.
    ls -o ~/.bash_profile
    ls -o ~/.inputrc
    ls -o ~/.tmux.conf
    ls -o ~/.vimrc
    echo
else
    echo Denied!
fi

