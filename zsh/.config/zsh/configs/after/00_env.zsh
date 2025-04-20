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
#export ASDF_CONFIG_FILE=$HOME/.config/asdf/config
export ASDF_DATA_DIR=$HOME/.local/share/asdf
# asdf-python(python-build)
export PYTHON_BUILD_MIRROR_URL="https://mirrors.huaweicloud.com/python"
export PYTHON_BUILD_MIRROR_URL_SKIP_CHECKSUM=1

################################################################################
# tmux
################################################################################

if [[ $ZSHRC_ICONS == true ]]; then
    export DOTFILES_TMUX_ICON=" "
fi


################################################################################
# fzf
################################################################################
local fzf_dirs=($HOME/.local/opt/fzf)
for fzf_dir in $fzf_dirs; do
    if [[ -f ${fzf_dir}/bin/fzf ]]; then
        export FZF_DIR="${fzf_dir}"
        path=($FZF_DIR/bin $path)
        . $FZF_DIR/shell/completion.zsh
    fi
done

################################################################################
# ripgrep
################################################################################
local ripgrep_dir=$HOME/.local/opt/ripgrep
if [[ -d ${ripgrep_dir} ]]; then
    path=(${ripgrep_dir} $path)
    fpath+=(${ripgrep_dir}/complete)
fi

################################################################################
# fd
################################################################################
local fd_dir=$HOME/.local/opt/fd
if [[ -d ${fd_dir} ]]; then
    path=(${fd_dir} $path)
    fpath+=(${fd_dir}/autocomplete)
fi

################################################################################
# bat
################################################################################
local bat_dir=$HOME/.local/opt/bat
if [[ -d ${bat_dir} ]]; then
    path+=(${bat_dir})
    fpath+=(${bat_dir}/autocomplete)
fi

if exists 'bat'; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'"
    export MANROFFOPT="-c"

    batail() {
        tail -f "$1" | bat --paging=never -l log
    }

    batdiff() {
        git diff --name-only --relative --diff-filter=d | xargs bat --diff
    }
fi

################################################################################
# eza
################################################################################
local eza_dir=$HOME/.local/opt/eza
if [[ -d ${eza_dir} ]]; then
    path=(${eza_dir} $path)
    fpath+=(${eza_dir}/completions)
fi

################################################################################
# zoxide
################################################################################
local zoxide_dir=$HOME/.local/opt/zoxide
if [[ -d ${zoxide_dir} ]]; then
    path=(${zoxide_dir} $path)
    fpath+=(${zoxide_dir}/completions)
fi
exists "zoxide" && eval "$(zoxide init zsh)"

################################################################################
# yazi
################################################################################
local yazi_dir=$HOME/.local/opt/yazi
if [[ -d ${yazi_dir} ]]; then
    path=(${yazi_dir} $path)
    fpath+=(${yazi_dir}/completions)
fi

################################################################################
# delta
################################################################################
local delta_dir=$HOME/.local/opt/delta
if [[ -d ${delta_dir} ]]; then
    path=(${delta_dir} $path)
    fpath+=(${delta_dir}/completions)
fi

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

################################################################################
# Development
################################################################################
toolchains=(/opt/linux/x86-arm/aarch64-mix210-linux /opt/linux/x86-arm/aarch64-himix100-linux)
for toolchain in $toolchains; do
    if [[ -d ${toolchain} && $PATH != *${toolchain}* ]]; then
        export PATH=${toolchain}/bin:$PATH
    fi
done
