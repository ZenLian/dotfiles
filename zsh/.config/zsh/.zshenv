export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8

# export TERM=xterm-256color
export TERM_ITALICS=true
export EDITOR='nvim'
export LANG=en_US.UTF-8

# typeset -U path
path=($HOME/.local/bin $path)

####################
# go/gvm
####################
export GOPATH=$XDG_DATA_HOME/gopath
export GOBIN=$GOPATH/bin
export GOPROXY=https://goproxy.cn
path=($GOBIN $path)
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
path=($HOME/.cargo/bin $path)

####################
# luarocks
####################
path=($HOME/.luarocks/bin $path)

####################
# mongodb
####################
export MONGODB_ROOT=$HOME/.local/mongodb-5.0.5
path=($MONGODB_ROOT/bin $path)

