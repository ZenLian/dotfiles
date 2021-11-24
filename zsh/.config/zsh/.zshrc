# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# general
export PATH=$HOME/.local/bin:$PATH
# export TERM=xterm-256color
export TERM_ITALICS=true
export EDITOR='nvim'

# History command configuration
HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

bindkey -e

autoload -U compinit

export SHELDON_CONFIG_DIR=$XDG_CONFIG_HOME/sheldon
export SHELDON_DATA_DIR=$XDG_DATA_HOME/sheldon
export SHELDON_CLONE_DIR=$SHELDON_DATA_DIR/repos
export SHELDON_DOWNLOAD_DIR=$SHELDON_DATA_DIR/downloads
eval "$(sheldon source)"
