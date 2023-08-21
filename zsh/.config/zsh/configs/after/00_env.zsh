# batch rename utilities
autoload -U zmv
################################################################################
# 00.asdf
################################################################################
local asdf_dirs=($HOME/.local/opt/asdf /opt/asdf-vm)
for asdf_dir in $asdf_dirs; do
    if [[ -f ${asdf_dir}/asdf.sh ]]; then
        . ${asdf_dir}/asdf.sh
        fpath+=(${ASDF_DIR}/completions)
        break
    fi
done
# asdf-python(python-build)
export PYTHON_BUILD_MIRROR_URL="https://mirrors.huaweicloud.com/python"
export PYTHON_BUILD_MIRROR_URL_SKIP_CHECKSUM=1

################################################################################
# fzf
################################################################################
local fzf_dirs=($HOME/.local/opt/fzf)
for fzf_dir in $fzf_dirs; do
    if [[ -f ${fzf_dir}/bin/fzf ]]; then
        export FZF_DIR="${fzf_dir}"
        path+=($FZF_DIR/bin)
    fi
done

################################################################################
# bat
################################################################################
if exists 'bat'; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always --theme=\"Monokai Extended\"'"
    export MANROFFOPT="-c"

    batail() {
        tail -f "$1" | bat --paging=never -l log
    }

    batdiff() {
        git diff --name-only --relative --diff-filter=d | xargs bat --diff
    }
fi

################################################################################
# zoxide
################################################################################
exists "zoxide" && eval "$(zoxide init zsh)"

####################
# go/gvm
####################
#export GOPATH=$XDG_DATA_HOME/gopath
#export GOBIN=$GOPATH/bin
#export GOPROXY=https://goproxy.cn
#path+=($GOBIN)
# command -v gvm &> /dev/null && eval "$(gvm 1.17.8)"

####################
# nodejs
####################
# 手动指定 nvm 默认环境, 加快 zsh 启动速度
#export NVM_DIR="$HOME/.nvm"
#export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
## [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  --no-use
## path=($HOME/.nvm/versions/node/v17.2.0/bin $path)

####################
# rust
####################
[[ -d $HOME/.cargo ]] && path+=($HOME/.cargo/bin)

####################
# luarocks
####################
[[ -d $HOME/.luarocks ]] && path+=($HOME/.luarocks/bin)

