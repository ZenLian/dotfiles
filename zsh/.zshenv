export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8

# export TERM=xterm-256color
# export COLORTERM='truecolor'
# export TERM_ITALICS=true

export EDITOR='nvim'
export OPENER='xdg-open'

####################
# go/gvm
####################
export GOPATH=$XDG_DATA_HOME/gopath
export GOBIN=$GOPATH/bin
export GOPROXY=https://goproxy.cn
path+=($GOBIN)
# command -v gvm &> /dev/null && eval "$(gvm 1.17.8)"

####################
# nodejs
####################
# 手动指定 nvm 默认环境, 加快 zsh 启动速度
export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  --no-use
# path=($HOME/.nvm/versions/node/v17.2.0/bin $path)

####################
# rust
####################
[[ -d $HOME/.cargo ]] && path+=($HOME/.cargo/bin)

####################
# luarocks
####################
[[ -d $HOME/.luarocks ]] && path+=($HOME/.luarocks/bin)

# source zshrc
export ZDOTDIR=$HOME/.config/zsh
