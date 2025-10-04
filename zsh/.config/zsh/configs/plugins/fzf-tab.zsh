# References:
# * https://github.com/Aloxaf/fzf-tab/wiki/Preview
# * https://github.com/Freed-Wu/fzf-tab-source
#
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# set descriptions format to enable group support
# zstyle ':completion:*:descriptions' format '[%d]'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' show-group brief

# ------------------------------------------
# common preview
# ------------------------------------------
# https://github.com/Freed-Wu/fzf-tab-source/blob/main/sources/_complete.zsh
zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview ${realpath#--*=}'

# options
zstyle ':fzf-tab:complete:*:options' fzf-preview 'echo $desc'
zstyle ':fzf-tab:complete:*:options' fzf-flags --preview-window=down:3:hidden:wrap

# environment variable
zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' \
    fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' \
    fzf-flags --preview-window=wrap

# =<TAB>
zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains):argument-1)' \
    fzf-preview '[[ $group == "[external command]" ]] && preview =$word'

# users
# ~<TAB>
zstyle ':fzf-tab:complete:-tilde-:' \
    fzf-preview 'groups $word && id $word && w $word'

# bindkey -M <TAB>
zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
    '[[ $group == "keymap" ]] && {bindkey -M$word | bat --color=always -p -ltsv}'

# ------------------------------------------
# kill/ps
# ------------------------------------------
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# ------------------------------------------
# systemctl
# ------------------------------------------
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# ------------------------------------------
# git
# TODO: custom git preview
# ------------------------------------------
zstyle ':fzf-tab:complete:git-*:*' fzf-preview
# zstyle ':fzf-tab:complete:git*:*' fzf-flags --preview-window=hidden
zstyle ':fzf-tab:complete:git:argument-1' fzf-preview 'echo $desc'

# ------------------------------------------
# zlua/zoxide
# ------------------------------------------
# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input
# zstyle ':fzf-tab:complete:_zoxide:*' query-string input

# ------------------------------------------
# flatpak
# ------------------------------------------
zstyle ':fzf-tab:complete:(\\|*/|)flatpak:' fzf-preview \
    '[[ $group == "argument" ]] && flatpak $word --help'
# 'flatpak $word --help | bat --color=always -plhelp'

# ------------------------------------------
# docker
# ------------------------------------------
zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview \
    'docker help $word | bat --color=always -plhelp'

# ------------------------------------------
# gcc
# ------------------------------------------
zstyle ':fzf-tab:complete:(\\|*/|):gcc:argument-rest' fzf-preview \
    'gcc -o- -S $realpath | bat --color=always -plasm'
