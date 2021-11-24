# conda_zsh_completion
# zstyle ':completion::complete:*' use-cache 1
# zstyle ":conda_zsh_completion:*" use-groups true

# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# ref: https://github.com/Aloxaf/fzf-tab/wiki/Preview

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# systemctl
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# show file contents
local fzf_preview_cmd='[[ -d ${(Q)realpath} ]] && ls -l --color=always ${(Q)realpath} ||
    ( [[ $(file --mime ${(Q)realpath}) =~ binary ]] && echo ${(Q)realpath} is a binary file ||
      (bat ${(Q)realpath} || ccat --color=always ${(Q)realpath} || highlight -O ansi -l ${(Q)realpath} || cat ${(Q)realpath}) 2> /dev/null
    )'
zstyle ':fzf-tab:complete:*:*' fzf-preview $fzf_preview_cmd
# export LESSOPEN='|'$ZDOTDIR'/plugins/.lessfilter %s'

# environment variable
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'