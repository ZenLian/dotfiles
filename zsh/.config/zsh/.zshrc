fpath=($ZDOTDIR/functions $fpath)
autoload -U $ZDOTDIR/functions/*(:t)

for cfg in $ZDOTDIR/configs/before/*.zsh; do
    source $cfg
done

# TODO: plug "zsh-defer" or "zsh-async"
plug "romkatv/powerlevel10k"
plug "jeffreytse/zsh-vi-mode"
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-completions"

for cfg in $ZDOTDIR/configs/after/*.zsh; do
    source $cfg
done

