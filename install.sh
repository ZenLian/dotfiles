#!/usr/bin/env bash

usage() {
    printf 'usage:\n'
    printf '  %s [name]\n' "$0"
    printf '  %s -a\n' "$0"
}

basic="zsh tmux nvim git"
head="wezterm awesome alacritty"


if [[ -n "$1" ]]; then
case "$1" in
    "-t"|"--terminal") all="tmux zsh nvim yazi bat"
    ;;
    "-g"|"--graphic") all="hyprland kitty fontconfig"
    ;;
    *) all=$*
    ;;
esac
else
    usage
    exit 1
fi

for i in $all; do
    echo "installing: $i"
    stow -t "$HOME" "$i"
done

echo "Installation success!"
