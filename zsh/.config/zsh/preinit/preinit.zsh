autoload -U compinit && compinit
typeset -U path

## Language ##
export LANG=en_US.UTF-8

####################
######## go ########
####################
export GOPATH=$XDG_DATA_HOME/gopath
export GOBIN=$GOPATH/bin

path=($GOBIN $path)

