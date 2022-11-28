
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ------------------------------------------
# Options {{{
# https://github.com/mrzool/bash-sensible
# ------------------------------------------
## GENERAL OPTIONS ##

# disable Ctrl-S freeze
stty -ixon

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null                                                                                   

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"
# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"
# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"
# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projec
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars
# }}}

# ------------------------------------------
# History {{{
# ------------------------------------------
# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Re-edit the command line for failing history expansions
shopt -s histreedit

# Re-edit the result of history expansions
shopt -s histverify

# save history with newlines instead of ; where possible
shopt -s lithist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000
HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/bash_history"

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT=$'\033[32m%F \033[36m%T\033[0m '

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"


# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

#}}}

# ------------------------------------------
# Colors {{{
# ------------------------------------------
# highlight the man manual
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#}}}

# ------------------------------------------
# Prompt {{{
# ------------------------------------------
black="\[\e[30m\]"
red="\[\e[31m\]"
green="\[\e[32m\]"
yellow="\[\e[33m\]"
blue="\[\e[34m\]"
magenta="\[\e[35m\]"
cyan="\[\e[36m\]"
white="\[\e[37m\]"
reset="\[\e[0m\]"
# `vim +digraphs` to see more prompt symbols
# enter with <C-k>
#   ›: >1
#   →: ->
#   ▶: PR
# Others: ❯
# TODO: git prompt
bashrc::exit_color() {
  if [[ $? == 0 ]]; then
    printf '\e[32m'
  else
    printf '\e[31m'
  fi
}
hint='\[$(([[ $? == 0 ]] && printf "\e[32m") || printf "\e[31m")\]'
# before command
export PS1="${cyan}\w${reset}\n${hint}> ${reset}"
# before input
export PS2="${yellow}› ${reset}"

unset black green yellow blue magenta cyan white reset hint
# }}}

# ------------------------------------------
# Functions {{{
# ------------------------------------------
# make directory and jump inside
mk () { mkdir -p -- "$*" ; cd -- "$*" || exit ; }

# Extract most know archives with one command
extract () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# }}}

# ------------------------------------------
# Aliases {{{
# ------------------------------------------
alias -- -='cd -'
alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- ....='cd ../../..'

alias md='mkdir -p'

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias l='ls -1F'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias ga.='git add .'
alias gcm='git commit -v'
alias gca='git commit -v -a'
# TODO log format
alias glg='git log'
alias gst='git status'
alias gss='git status -s'

alias v='vim'
alias vi='vim'

alias ts='tmux -s'
alias ta='tmux -a'
# }}}

# ------------------------------------------
# fzf {{{
# ------------------------------------------
[[ -d ${FZF_DIR} ]] && source "${FZF_DIR}/shell/completion.bash"
[[ -d ${FZF_DIR} ]] && source "${FZF_DIR}/shell/key-bindings.bash"
unset fzf_dir
# }}}

# vim:foldmarker={{{,}}}:foldmethod=marker:
