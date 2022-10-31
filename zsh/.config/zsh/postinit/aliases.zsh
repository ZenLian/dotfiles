do_alias ()
{
    for v in $*; do
        if [[ $1 != $v ]] && command -v $v &> /dev/null; then
            alias $1="$v"
            break
        fi
    done
}

do_alias cat bat batcat
do_alias rm trash
do_alias vim nvim
do_alias vi nvim vim
do_alias ra ranger lf

if command -v exa &> /dev/null; then
    alias ls='exa'
    alias la='exa -a'
    alias l='exa -al'
    alias lsa='exa -al'
    alias ll='exa -l'
    alias lt='exa -T'
    alias lta='exa -Ta'
    alias llta='exa -lTa'
fi

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias cht='cht.sh'
alias lg='lazygit'

