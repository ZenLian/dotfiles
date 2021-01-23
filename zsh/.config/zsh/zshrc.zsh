# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz zcalc zmv

# zinit
typeset -A ZINIT=(
    BIN_DIR         $ZDOTDIR/zinit/bin
    HOME_DIR        $ZDOTDIR/zinit
    COMPINIT_OPTS   -C
)

source $ZDOTDIR/zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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
    blockf esc/conda-zsh-completion \
    load'!command -v fzf >/dev/null' atload'!source $ZDOTDIR/plug.conf/fzf-tab.zsh' Aloxaf/fzf-tab

# completions
zinit as="completion" for \
    mv"completions.zsh -> _exa" https://gitee.com/mirrors/exa/raw/master/completions/completions.zsh \
    https://gitee.com/mirrors/fd/raw/master/contrib/completion/_fd \
    https://gitee.com/mirrors/ripgrep/raw/master/complete/_rg \
    mv"*zsh -> _cht" https://cht.sh/:zsh

zinit ice pick"cht.sh" as"program"
zinit snippet https://gitee.com/mirrorshub/cht.sh/raw/master/cht.sh

# theme
zinit ice depth=1 atload'!source $ZDOTDIR/plug.conf/p10k.zsh' lucid nocd
zinit light romkatv/powerlevel10k

# -- environments ----------------------------
# general
export PATH=$HOME/.local/bin:$PATH
export TERM=xterm-256color
export TERM_ITALICS=true
export EDITOR='nvim'

bindkey -e

# History command configuration
HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
local fzf_preview_cmd='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -200'
export FZF_DEFAULT_OPTS="--bind=tab:down,btab:up,change:top,space:toggle --border"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview="[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -200"'
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'

## pyenv OR miniconda
# pyenv: light, pip
#export PYENV_ROOT=$XDG_DATA_HOME/pyenv
#export PATH=$PYENV_ROOT/bin:$PATH
#[ -f $PYENV_ROOT/bin/pyenv ] && \
#    eval "$(pyenv init -)" && \
#    eval "$(pyenv virtualenv-init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
CONDA_PATH="$HOME/.miniconda3"
__conda_setup="$('${CONDA_PATH}/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${CONDA_PATH}/etc/profile.d/conda.sh" ]; then
        . "${CONDA_PATH}/etc/profile.d/conda.sh"
    else
        export PATH="${CONDA_PATH}/bin:$PATH"
    fi
fi
unset __conda_setup
unset CONDA_PATH
# <<< conda initialize <<<

# 手动指定 nvm 默认环境, 加快 zsh 启动速度
export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  --no-use
export PATH=$HOME/.nvm/versions/node/v15.4.0/bin:$PATH

## golang
export GOPATH=$HOME/.local/share/gopath
##export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/
export GOROOT=/usr/lib/go
#export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
## use gvm
#export GOROOT="${HOME}/.g/go"
#export PATH="${HOME}/.g/go/bin:$PATH"
#export G_MIRROR=https://golang.google.cn/dl/

# rust
export PATH=$HOME/.cargo/bin:$PATH
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# haskell
export PATH=/opt/ghc/bin:$PATH

# aliases
source $ZDOTDIR/snippets/aliases.zsh

# functions
source $ZDOTDIR/snippets/functions.zsh

compinit

