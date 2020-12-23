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
OMZ="https://gitee.com/mirrors/oh-my-zsh/raw/master"
zinit for \
    ${OMZ}/lib/theme-and-appearance.zsh \
    ${OMZ}/lib/completion.zsh \
    ${OMZ}/lib/compfix.zsh \
    ${OMZ}/lib/clipboard.zsh \
    ${OMZ}/lib/git.zsh \
    ${OMZ}/lib/directories.zsh \
    ${OMZ}/plugins/git/git.plugin.zsh \
    ${OMZ}/plugins/colored-man-pages/colored-man-pages.plugin.zsh \
    ${OMZ}/plugins/systemd/systemd.plugin.zsh \
    ${OMZ}/plugins/sudo/sudo.plugin.zsh \

# plugins
zinit light-mode lucid for \
    zdharma/fast-syntax-highlighting \
    atload'source $ZDOTDIR/plug.conf/zsh-autosuggestions.zsh' zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
    skywind3000/z.lua \
    load'' atload'!source $ZDOTDIR/plug.conf/fzf-tab.zsh' Aloxaf/fzf-tab

zinit as="completion" for \
    mv"completions.zsh -> _exa" https://gitee.com/mirrors/exa/raw/master/completions/completions.zsh \
    https://gitee.com/mirrors/fd/raw/master/contrib/completion/_fd \
    https://gitee.com/mirrors/ripgrep/raw/master/complete/_rg

# theme
zinit ice depth=1 atload'!source $ZDOTDIR/plug.conf/p10k.zsh' lucid nocd
zinit light romkatv/powerlevel10k

