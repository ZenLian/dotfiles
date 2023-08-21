[[ $ZSHRC_PROMPT != true ]] && exit

setopt PROMPT_SUBST
autoload -U colors && colors

local dir="%F{blue}%~%f"

# export PS1="${dir}"$'\n'"$(hint '\u276f') "
export PS1="${dir}"$'\n'"%f$ "
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

set-prompt() {
    case ${KEYMAP} in
        vicmd) VI_MODE="%F{yellow}<%f" ;;
        viins|main) VI_MODE="%f$" ;;
    esac
    PS1="${dir}"$'\n'"${VI_MODE} "
}

# update prompt when mode changes
zle-keymap-select() {
    set-prompt
    zle reset-prompt
}
zle -N zle-keymap-select

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git hg
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' stagedstr "%F{green}●%f" # default 'S'
# zstyle ':vcs_info:*' unstagedstr "%F{red}●%f" # default 'U'
# zstyle ':vcs_info:*' use-simple true
# zstyle ':vcs_info:git+set-message:*' hooks git-untracked
# zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
# zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
# zstyle ':vcs_info:hg*:*' formats '[%m%b] '
# zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m] '
# zstyle ':vcs_info:hg*:*' branchformat '%b'
# zstyle ':vcs_info:hg*:*' get-bookmarks true
# zstyle ':vcs_info:hg*:*' get-revision true
# zstyle ':vcs_info:hg*:*' get-mq false
# zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
# zstyle ':vcs_info:hg*+set-message:*' hooks hg-message
#
# function +vi-hg-bookmarks() {
#     emulate -L zsh
#     if [[ -n "${hook_com[hg-active-bookmark]}" ]]; then
#         hook_com[hg-bookmark-string]="${(Mj:,:)@}"
#         ret=1
#     fi
# }
#
# function +vi-hg-message() {
#     emulate -L zsh
#
#     # Suppress hg branch display if we can display a bookmark instead.
#     if [[ -n "${hook_com[misc]}" ]]; then
#         hook_com[branch]=''
#     fi
#     return 0
# }
#
# function +vi-git-untracked() {
#     emulate -L zsh
#     if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
#         hook_com[unstaged]+="%F{blue}●%f"
#     fi
# }
