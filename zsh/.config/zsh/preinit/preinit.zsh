autoload -U compinit && compinit

####################
# thefuck
####################
command -v thefuck &> /dev/null && eval $(thefuck --alias)

####################
# zoxide
####################
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
