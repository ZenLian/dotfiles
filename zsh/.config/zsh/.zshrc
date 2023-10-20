##########################################
# Global Configs
##########################################

# use custom keymaps
typeset -g ZSHRC_KEYMAPS=true
# use custom prompt
typeset -g ZSHRC_PROMPT=false
# use icons
typeset -g ZSHRC_ICONS=false
# load zprof for startup time parsing
typeset -g ZSHRC_ZPROF=true

##########################################
# prepare
##########################################
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p $ZSH_CACHE_DIR

# type 'zprof' cmd to list startup profile
[[ $ZSHRC_ZPROF == true ]] && zmodload zsh/zprof

path+=($HOME/.local/bin $ZDOTDIR/bin)
fpath+=($ZDOTDIR/functions $ZDOTDIR/completions)
autoload -U $ZDOTDIR/functions/*(:t)

##########################################
# before
##########################################
for cfg in $ZDOTDIR/configs/before/*.zsh; do
    source $cfg
done

##########################################
# plugins
##########################################
plug "romkatv/zsh-defer"

[[ $ZSHRC_PROMPT != true ]] && plug "romkatv/powerlevel10k"
[[ $ZSHRC_KEYMAPS != true ]] && plug "jeffreytse/zsh-vi-mode"
zsh-defer -t 0.1 plug "Aloxaf/fzf-tab"
zsh-defer -t 0.5 plug "zsh-users/zsh-autosuggestions"
zsh-defer plug "zdharma-continuum/fast-syntax-highlighting"
#zsh-defer plug "zsh-users/zsh-history-substring-search"
zsh-defer -t 0.2 plug "zsh-users/zsh-completions"

##########################################
# after
##########################################
_zshrc-source-after() {
    for cfg in $ZDOTDIR/configs/after/*.zsh; do
        source $cfg
    done
}
zsh-defer _zshrc-source-after

