# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz zcalc zmv

# custom
for f in $ZDOTDIR/snippets/*.zsh; do
    source $f
done

# zinit
typeset -A ZINIT=(
    BIN_DIR         $ZDOTDIR/zinit/bin
    HOME_DIR        $ZDOTDIR/zinit
    COMPINIT_OPTS   -C
)

source $ZDOTDIR/zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# annex
zinit light-mode for \
    zinit-zsh/z-a-bin-gem-node

# OMZ
zinit for \
    OMZ::lib/theme-and-appearance.zsh \
    OMZ::lib/completion.zsh \
    OMZ::lib/compfix.zsh \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::lib/directories.zsh \
    OMZ::plugins/git/git.plugin.zsh \
    OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/sudo/sudo.plugin.zsh \

# executable
zinit wait"2" lucid as"null" from"gh-r" for \
    mv"exa* -> exa" sbin  ogham/exa \
    mv"fd* -> fd" sbin"fd/fd"  @sharkdp/fd \
    sbin junegunn/fzf-bin

# plugins
zinit light-mode lucid for \
    zdharma/fast-syntax-highlighting \
    atload'source $ZDOTDIR/plug.conf/zsh-autosuggestions.zsh' zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
    skywind3000/z.lua \
    load'' atload'!source $ZDOTDIR/plug.conf/fzf-tab.zsh' Aloxaf/fzf-tab

# cheat.sh and its completions
zinit lucid as"null" for \
    mv":cht.sh -> cht.sh" sbin"cht.sh" https://cht.sh/:cht.sh
zinit ice mv=":zsh -> _cht" as="completion"
zinit snippet https://cheat.sh/:zsh

# fzf utils
# FIXME: fzf-tmux
zinit lucid for \
    https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh \
    https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

zinit as="completion" for \
    https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fd/_fd \
    https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# theme
zinit ice depth=1 atload'!source $ZDOTDIR/plug.conf/p10k.zsh' lucid nocd
zinit light romkatv/powerlevel10k

