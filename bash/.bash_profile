# ------------------------------------------
# Environment
# ------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export PATH="${HOME}/.local/bin:${PATH}"

# ------------------------------------------
# fzf
# ------------------------------------------
export FZF_DIR="${HOME}/.vim/plugged/junegunn/fzf"
export PATH="${FZF_DIR}/bin:${PATH}"

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
