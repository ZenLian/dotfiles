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
# use zsh-defer
typeset -g ZSHRC_DEFER=false

##########################################
# prepare
##########################################
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p $ZSH_CACHE_DIR

# type 'zprof' cmd to list startup profile
[[ $ZSHRC_ZPROF == true ]] && zmodload zsh/zprof

path=($HOME/.local/bin $ZDOTDIR/bin $path)
fpath=($ZDOTDIR/functions $ZDOTDIR/completions $fpath)
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
[[ $ZSHRC_DEFER == true ]] && plug "romkatv/zsh-defer"

[[ $ZSHRC_PROMPT != true ]] && plug "romkatv/powerlevel10k"
[[ $ZSHRC_KEYMAPS != true ]] && plug "jeffreytse/zsh-vi-mode"

if [[ $ZSHRC_DEFER == true ]]; then
    zsh-defer -t 0.1 plug "Aloxaf/fzf-tab"
    zsh-defer -t 0.5 plug "zsh-users/zsh-autosuggestions"
    zsh-defer plug "zdharma-continuum/fast-syntax-highlighting"
    #zsh-defer plug "zsh-users/zsh-history-substring-search"
    zsh-defer -t 0.2 plug "zsh-users/zsh-completions"
else
    plug "Aloxaf/fzf-tab"
    plug "zsh-users/zsh-autosuggestions"
    plug "zdharma-continuum/fast-syntax-highlighting"
    #plug "zsh-users/zsh-history-substring-search"
    plug "zsh-users/zsh-completions"
fi

##########################################
# after
##########################################
_zshrc-source-after() {
    for cfg in $ZDOTDIR/configs/after/*.zsh; do
        source $cfg
    done
}

if [[ $ZSHRC_DEFER == true ]]; then
    zsh-defer _zshrc-source-after
else
    _zshrc-source-after
fi

##########################################
# local
##########################################
if [[ -f $ZDOTDIR/local.zsh ]]; then
    source $ZDOTDIR/local.zsh
fi
