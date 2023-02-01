
#
# prepare
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p $ZSH_CACHE_DIR

path+=($HOME/.local/bin $ZDOTDIR/bin)


fpath=($ZDOTDIR/functions $ZDOTDIR/completions $fpath)
autoload -U $ZDOTDIR/functions/*(:t)

for cfg in $ZDOTDIR/configs/before/*.zsh; do
    source $cfg
done

plug "romkatv/zsh-defer"
plug "romkatv/powerlevel10k"
plug "jeffreytse/zsh-vi-mode"
zsh-defer plug "Aloxaf/fzf-tab"
zsh-defer plug "zsh-users/zsh-autosuggestions"
zsh-defer plug "zdharma-continuum/fast-syntax-highlighting"
zsh-defer plug "zsh-users/zsh-history-substring-search"
zsh-defer plug "zsh-users/zsh-completions"

source-after() {
    for cfg in $ZDOTDIR/configs/after/*.zsh; do
        source $cfg
    done
}
zsh-defer -c 'source-after && unset -f source-after'
