#!/usr/bin/env bash

usage() {
    printf "\
        usage:
    $0 [name]
    $0 all
    "
}

if [[ -n "$1" ]]; then
    if [[ "$1" == "all" ]]; then
        all="awesome zsh alacritty tmux nvim git bat lf npm conda lazygit luarocks asdf pip"
    else
        all=$*
    fi
else
    usage
    exit 1
fi

for i in $all; do
    echo "installing: $i"
    stow -t $HOME $i || exit -1
done

echo "Installation success!"
