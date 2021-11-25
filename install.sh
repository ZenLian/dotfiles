#!/bin/bash

list=(zsh git tmux nvim ranger npm conda lazygit)

for i in ${list[*]}; do
    #echo $i
    stow -t $HOME $i || exit -1
done
