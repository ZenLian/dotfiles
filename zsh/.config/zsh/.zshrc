# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
typeset -A ZINIT=(
    BIN_DIR         $ZDOTDIR/zinit/bin
    HOME_DIR        $ZDOTDIR/zinit
    COMPINIT_OPTS   -C
)

source $ZDOTDIR/zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zinit-zsh/z-a-bin-gem-node

# plugins
export _Z_DATA=$XDG_DATA_HOME/z
zinit for \
    OMZ::lib/theme-and-appearance.zsh \
    OMZ::lib/completion.zsh \
    OMZ::lib/compfix.zsh \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::lib/directories.zsh \
    OMZ::plugins/git/git.plugin.zsh \
    OMZ::plugins/z/z.sh \
    OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
    OMZ::plugins/systemd/systemd.plugin.zsh \
    OMZ::plugins/sudo/sudo.plugin.zsh
zinit ice as'completion'
zinit snippet OMZ::plugins/ripgrep/_ripgrep

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" atload'source $ZDOTDIR/plug.conf/zsh-autosuggestions.zsh' \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

#TODO: manage fzf
#zinit ice from"gh-r" fbin"fzf"
#zinit light junegunn/fzf-bin
#zplugin lucid as=null make \
#  atclone="cp shell/completion.zsh _fzf_completion" \
#  sbin="fzf;bin/fzf-tmux" \
#      junegunn/fzf
zinit ice lucid atload'!source $ZDOTDIR/plug.conf/fzf-tab.zsh'
zinit light Aloxaf/fzf-tab

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# theme
#zinit ice lucid wait="!0" pick="async.zsh" src="pure.zsh" atload="prompt_pure_precmd"
#zinit light sindresorhus/pure

zinit ice depth=1 atload'!source $ZDOTDIR/plug.conf/p10k.zsh' lucid nocd
zinit light romkatv/powerlevel10k

# custom
source $ZDOTDIR/env.zsh
source $ZDOTDIR/aliases.zsh

# 手动指定 nvm 默认环境, 加快 zsh 启动速度
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  --no-use
export PATH=$HOME/.nvm/versions/node/v13.12.0/bin/:$PATH

