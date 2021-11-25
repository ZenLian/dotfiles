command -v nvim > /dev/null && alias vim='nvim'
command -v ranger > /dev/null && alias ra='ranger'

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

command -v exa > /dev/null &&\
    alias ls='exa' && \
    alias la='exa -a' &&\
    alias l='exa -al' &&\
    alias lsa='exa -al' &&\
    alias ll='exa -l' &&\
    alias lt='exa -T' &&\
    alias lta='exa -Ta' &&\
    alias llta='exa -lTa'

command -v trash > /dev/null && alias rm='trash'

command -v cht.sh > /dev/null && alias cht='cht.sh'

alias lg='lazygit'

