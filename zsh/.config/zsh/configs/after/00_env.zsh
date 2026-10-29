# batch rename utilities
autoload -U zmv

################################################################################
# mise
################################################################################
if exists mise; then
    eval "$(mise activate zsh)"
fi

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
# rust
####################
[[ -d $HOME/.cargo ]] && path+=($HOME/.cargo/bin)

####################
# luarocks
####################
[[ -d $HOME/.luarocks ]] && path+=($HOME/.luarocks/bin)

