export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always --theme=\"Monokai Extended\"'"
export MANROFFOPT="-c"

batail() {
    tail -f "$1" | bat --paging=never -l log
}

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

