##########################################
# misc
##########################################
alias _='sudo'
alias diff='diff --color'

# ls/exa
if exists exa; then
    # if command -v exa &> /dev/null; then
    alias ls='exa'
    alias la='exa -a'
    alias l='exa -al'
    alias lsa='exa -al'
    alias ll='exa -l'
    alias lt='exa -T'
    alias lta='exa -Ta'
    alias llta='exa -lTa'
else
    alias ls='ls --color=auto'
    alias lsa='ls -lah --color=auto'
    alias l='ls -lah --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -lAh --color=auto'
fi

if exists nvim; then
    alias vim=nvim
    alias vi=nvim
    alias v=nvim
else
    alias vi=vim
    alias v=vim
fi

exists "bat" && alias cat=bat
#exists "trash" && alias rm=trash
alias ra=ranger
alias cht='cht.sh'
alias lg='lazygit'

##########################################
# directories
##########################################
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

# function d () {
#   if [[ -n $1 ]]; then
#     dirs "$@"
#   else
#     dirs -v | head -n 10
#   fi
# }
# compdef _dirs d

##########################################
# git
##########################################
g() {
    if [[ $# -eq 0 ]]; then
        cd "$(git rev-parse --show-toplevel || echo .)"
        return 0
    fi
    git "$@"
    return $?
}
compdef g=git

alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbr='git branch --remote'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -va'
alias gca!='git commit -va --amend'
alias gcA='git commit -va --no-edit --amend'
alias gcm='git commit -m'
alias gcam='git commit -am'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gcl='git clone --recursive'

alias gd='git diff'
alias gdc='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias gdd='git diff | delta'

# alias glg=
alias glp='git log --stat'
alias glg="git log --color --graph --pretty='%C(auto)%h%d%Creset %s %Cgreen(%cr)'"
alias gll="git log --color --graph --pretty='%C(auto)%h%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset'"
alias gl1='git log --oneline --decorate --graph'

alias gm='git merge'
alias gmtl='git mergetool --no-prompt'
alias gma='git merge --abort'

alias gp='git push'
alias gp!='git push --force'
alias gpv='git push -v'

alias gpl='git pull'
alias gplr='git pull --rebase'

alias gr='git remote'
alias gra='git remote add'
alias grr='git remote rename'
alias grR='git remote remove'
alias gru='git remote update'
alias grv='git remote -v'
alias grset='git remote set-url'

alias gR='git reset'
alias gRh='git reset --hard'
alias gRo='git reset origin/$(git branch --show-current) --hard'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'

alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'

alias gst='git status'
alias gsb='git status -b'
alias gss='git status -s'
alias gsu='git status -s -uno'

alias gsta='git stash push'
alias gstA='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstall='git stash --all'

alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch main'
alias gswd='git switch develop'

##########################################
# tmux
##########################################
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
