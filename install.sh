#!/usr/bin/env bash

usage() {
    printf 'usage:\n'
    printf '  %s [name]\n' "$0"
    printf '  %s -a\n' "$0"
}

basic="zsh tmux nvim git"
extra="bat lf npm"
head="wezterm awesome alacritty"


if [[ -n "$1" ]]; then
    if [[ "$1" == "-a" ]]; then
        all="zsh wezterm tmux nvim git bat lf npm conda lazygit luarocks asdf pip"
    else
        all=$*
    fi
else
    usage
    exit 1
fi

for i in $all; do
    echo "installing: $i"
    stow -t "$HOME" "$i" || exit 1
done

echo "Installation success!"
