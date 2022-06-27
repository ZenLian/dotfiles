#!/usr/bin/env bash

if [[ -n "$1" ]]; then
    all=$*
else
    # list=(zsh git tmux nvim ranger npm conda lazygit luarocks asdf pip)
    # all=${list[*]}
    all="zsh git tmux nvim ranger npm conda lazygit luarocks asdf pip alacritty awesome rofi"
fi

for i in $all; do
    # echo $i
    echo "installing: $i"
    stow -t $HOME $i || exit -1
done

echo "Installation success!"

