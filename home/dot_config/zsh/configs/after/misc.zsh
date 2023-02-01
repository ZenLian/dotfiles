exists "thefuck" && eval $(thefuck --alias)
exists "zoxide" && eval "$(zoxide init zsh)"

# batch rename utilities
autoload -U zmv
