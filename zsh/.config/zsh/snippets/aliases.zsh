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

command -v trash > /dev/null && alias rm='trash'
