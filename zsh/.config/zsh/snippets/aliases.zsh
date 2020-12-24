command -v nvim > /dev/null && alias vim='nvim'
command -v ranger > /dev/null && alias ra='ranger'
command -v z > /dev/null && alias j='z'

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

command -v exa > /dev/null && alias ls='exa'
command -v exa > /dev/null
if [ $? -eq 0 ]; then
    alias ls='exa'
    alias l='exa -alh'
    unalias lsa
    alias ll='exa -lh'
    alias la='exa -a'
fi

command -v trash > /dev/null && alias rm='trash'

command -v cht.sh > /dev/null && alias cht='cht.sh'
