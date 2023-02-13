#!/usr/bin/env bash

log_info() {
    fmt="$1"
    shift
    printf "\x1b[32m==>\x1b[0m $fmt\n" "$@"
}

# ensure correct working directory
cd "$(dirname "$0")" || exit 1
CWD="$(pwd)"
log_info 'CWD: %s' "$CWD"

# ensure chezmoi is installed
CHEZMOI='chezmoi'
if ! version=$($CHEZMOI --version 2> /dev/null) ; then
    log_info 'installing chezmoi into %s' "$HOME/.local/bin"
    # printf '%s\n' "installing chezmoi into $HOME/.local/bin"
    BINDIR="$HOME/.local/bin" sh -c "$(curl -fsLS get.chezmoi.io)"
    CHEZMOI="$BINDIR/chezmoi"
else
    # printf '%s\n' "$version"
    log_info "$version"
fi

# chezmoi apply
