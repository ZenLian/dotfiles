export PATH=$HOME/.local/bin:$PATH
export TERM=xterm-256color
export TERM_ITALICS=true
export EDITOR='nvim'

## History command configuration
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
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
local fzf_preview_cmd='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -200'
export FZF_DEFAULT_OPTS="--bind=tab:down,btab:up,change:top,space:toggle --border"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview="[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -200"'
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'

# pyenv
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export PATH=$PYENV_ROOT/bin:$PATH
[ -f $PYENV_ROOT/bin/pyenv ] && \
    eval "$(pyenv init -)" && \
    eval "$(pyenv virtualenv-init -)"

# 手动指定 nvm 默认环境, 加快 zsh 启动速度
export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  --no-use
export PATH=$HOME/.nvm/versions/node/v12.17.0/bin:$PATH

# golang
#export GOROOT=$HOME/.local/share/go1.14.3
export GOPATH=$HOME/.local/share/gopath
##export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/
#export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
# use gvm
export GOROOT="${HOME}/.g/go"
export PATH="${HOME}/.g/go/bin:$PATH"
export G_MIRROR=https://golang.google.cn/dl/

# rust
export PATH=$HOME/.cargo/bin:$PATH
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# haskell
export PATH=/opt/ghc/bin:$PATH
