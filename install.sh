#!/bin/bash

list=(zsh git tmux nvim)

for i in ${list[*]}; do
    #echo $i
    stow -t $HOME $i || exit -1
done

#ln -sf $PWD/gitconfig ~/.gitconfig
#ln -sf $PWD/tmux.conf ~/.tmux.conf
#ln -sf $PWD/condarc ~/.condarc
