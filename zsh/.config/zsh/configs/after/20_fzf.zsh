# ------------------------------------------
# custom environment variables
# ------------------------------------------
export FZF_DEFAULT_HEIGHT='80%'

export FZF_COPY_CMD='clipcopy'
export FZF_PREVIEW_CMD='preview {} $FZF_PREVIEW_LINES $FZF_PREVIEW_COLUMNS'
export FZF_PREVIEW_DIR_CMD='exa -aT -L2 --icons {} | head -n $FZF_PREVIEW_LINES'

# Default colors
# https://github.com/catppuccin/fzf
# macchiato
local fzf_color_maccchiato="\
bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,\
fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6,\
marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# mocha
local fzf_color_mocha="\
bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,\
fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,\
marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_DEFAULT_COLOR="$fzf_color_maccchiato"

# Default key-bindings
export FZF_DEFAULT_KEYBINDINGS="\
tab:down,\
btab:up,\
change:top,\
space:toggle,\
?:toggle-preview,\
ctrl-y:'execute-silent(echo -n {} | $FZF_COPY_CMD)',\
alt-k:preview-page-up,\
alt-j:preview-page-down,\
ctrl-a:select-all,\
ctrl-s:toggle-sort,\
ctrl-/:toggle-all,\
ctrl-z:ignore" # don't hung up
# ctrl-x:toggle-sort"
# ctrl-s:jump
# ctrl-qsrty


# list directories
local fzf_dir_cmd="fd --type d --hidden --exclude .git/"
# list files
local fzf_file_cmd="fd --type f --strip-cwd-prefix --hidden --exclude=.git/"

# ------------------------------------------
# FZF_* environment variables
# ------------------------------------------
export FZF_DEFAULT_OPTS="\
  --bind=${FZF_DEFAULT_KEYBINDINGS}\
  --preview-window=sharp \
  --color=${FZF_DEFAULT_COLOR} \
  --height=${FZF_DEFAULT_HEIGHT:-80%} \
  --marker='+'"
  # --prompt='> ' \
  # --pointer='>' "
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER='\'
export FZF_ALT_C_OPTS="--preview='$FZF_PREVIEW_DIR_CMD'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git/"
export FZF_TMUX=0
# export FZF_TMUX_OPTS='-p' # float window
#export FZF_TMUX_HEIGHT='80%'

# ------------------------------------------
# fix fzf-tab opts
# ------------------------------------------
zstyle ':fzf-tab:*' fzf-flags "--color=${FZF_DEFAULT_COLOR}"

# ------------------------------------------
# builtin widgets
# `C-t`: file
# `C-r`: history
# `A-c`: cd directory
# ------------------------------------------
# #[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NOTE:
# steal from key-bindings.zsh, for writing custom scripts
# source /usr/share/fzf/key-bindings.zsh
fzfcmd() {
    [ -n "${TMUX_PANE-}" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "${FZF_TMUX_OPTS-}" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

# ------------------------------------------
# Directories
# https://github.com/atweiden/fzf-extras/blob/master/fzf-extras.sh
# ------------------------------------------

export FZF_ZD_OPTS="\
    --preview='$FZF_PREVIEW_DIR_CMD' \
    --reverse"

__zd() {
    local cmd='fd "${1:-.}" --type d --hidden --exclude .git/'
    local dir="$(eval "$cmd" \
        | FZF_DEFAULT_OPTS=" \
        ${FZF_DEFAULT_OPTS-} \
        ${FZF_ZD_OPTS-}" \
        $(fzfcmd) +m \
    )"
    echo -n "${dir}"
}

# zd - cd into selected directory, including hidden
# --preview='exa {} -alT --icons | head -n $FZF_PREVIEW_LINES'
zd() {
    local dir="$(__zd)"
    local ret=$?
    if [[ -z "$dir" ]]; then
        return 0
    fi
    builtin cd -- "$dir"
    return $ret
}

# ALT-C - act as zd() with no arg
fzf-cd-widget() {
    local dir="$(__zd)"
    if [[ -z "$dir" ]]; then
        zle redisplay
        return 0
    fi
    zle push-line
    BUFFER="builtin cd -- ${(q)dir} "
    zle accept-line
    local ret=$?
    unset dir
    zle reset-prompt
}
zle     -N             fzf-cd-widget
bindkey -M emacs '^[c' fzf-cd-widget
bindkey -M vicmd '^[c' fzf-cd-widget
bindkey -M viins '^[c' fzf-cd-widget

# zf - cd into the directory of the selected file
zf() {
    local cmd="fd --type=f --min-depth=2 --strip-cwd-prefix --hidden --exclude=.git/"
    local file="$(eval "$cmd" \
            | FZF_DEFAULT_OPTS=" \
            --reverse \
            --preview='$FZF_PREVIEW_CMD' \
            ${FZF_DEFAULT_OPTS-}" \
            $(fzfcmd) +m -q "$*" \
        )"
    cd "$(dirname "$file")" || return
}

# zi - selectable cd to frecency directory
# NOTE: zoxide already has builtin support
# zi() {
#     local dir
#
#     dir="$(
#         zoxide query -sl \
    #             | fzf \
    #             --reverse \
    #             --select-1 \
    #             --no-multi \
    #             --tiebreak=index \
    #             --query "$*" \
    #             --preview='exa {} -aT -L2 --icons | head -n $FZF_PREVIEW_LINES' \
    #         )" || return
#
#     cd "$dir" || return
# }

# ------------------------------------------
# Files
# ------------------------------------------
export FZF_FILE_OPTS=" \
    --reverse \
    --preview='$FZF_PREVIEW_CMD' \
    --select-1 --exit-0"

# helper function to select files
__fsel() {
    local cmd="fd --type f --hidden --exclude=.git/"
    local item
    eval "$cmd" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} ${FZF_FILE_OPTS-}" $(fzfcmd) -m "$@" \
        | while read item; do
        echo -n "${item} "
    done
    local ret=$?
    echo
    return $ret
}

# CTRL-T - Paste the selected file path(s) into the command line
fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fsel)"
    local ret=$?
    zle reset-prompt
    return $ret
}
zle     -N            fzf-file-widget
bindkey -M emacs '^T' fzf-file-widget
bindkey -M vicmd '^T' fzf-file-widget
bindkey -M viins '^T' fzf-file-widget

# fv - open selected file(s) with $EDITOR
#    - ctrl-o open with $OPENER (xdg-open)
fv() {
    local files
    files="$(__fsel \
        -q "$*" \
        --bind='ctrl-o:abort+execute-silent(for f in {+}; do $OPENER $f; done)')"
    [[ -n "$files" ]] && "$EDITOR" ${=files} # `=` force word splitting
}

# ff [directory] - interactive searching file contents
# -> https://github.com/junegunn/fzf/wiki/Examples#searching-file-contents
# TODO: open editor at first matched line
ff() {
    [[ -n $1 ]] && cd $1 # go to provided folder
    local RG_DEFAULT_COMMAND="rg -l --hidden --glob='!.git/*' " # --no-ignore-vcs"
    local RG_MATCH_CMD="rg --context=0 --line-number -- {q} {}"
    # https://github.com/eth-p/bat-extras#batgrep
    local batgrep='{ \
            LR=(); LH=(); FOUND=0; \
            for text (${(f)"$(eval '"${RG_MATCH_CMD}"')"}) { \
                (( FOUND++ )); \
                line=${text%%:*}; \
                line_start=$((line - 2)); \
                line_end=$((line + 2)); \
                (( line_start <= 0 )) && line_start=; \
                LR+=("--line-range=${line_start}:${line_end}"); \
                LH+=("--highlight-line=${line}"); \
            }; \
            ((FOUND > 0)) && bat --color=always --style=numbers "${LR[@]}" "${LH[@]}" --paging=never {}; \
        }'

    local selected=$(
        FZF_DEFAULT_COMMAND="rg --files --hidden -i" \
            FZF_DEFAULT_OPTS=" \
            --reverse \
            ${FZF_DEFAULT_OPTS-}" \
            $(fzfcmd) \
            -m \
            --exact \
            --ansi \
            --disabled \
            --bind "change:+reload($RG_DEFAULT_COMMAND {q} || true)+change-preview:($batgrep)" \
            --preview 'bat --color=always --style=numbers --line-range=:$FZF_PREVIEW_LINES {}' \
        )

    [[ -n $selected ]] && $EDITOR ${=selected}
}

# rm: interactive delete files when used without argument
rm() {
    if [[ $# -ne 0 ]]; then
        command rm "$@"
        return
    fi
    local selected=$(
        FZF_DEFAULT_COMMAND="fd --hidden --max-depth=1 --exclude=.git" \
            FZF_DEFAULT_OPTS=" \
            --reverse \
            ${FZF_DEFAULT_OPTS} \
            -m \
            --ansi \
            --preview='$FZF_PREVIEW_CMD' " \
            $(fzfcmd)
    )
    [[ -n $selected ]] && rm -rf ${=selected}
}

# frm: like above, but recursive search in subdirectories
frm() {
    if [[ $# -ne 0 ]]; then
        trash "$*"
        return
    fi
    local selected=$(
        FZF_DEFAULT_COMMAND="fd --hidden --exclude=.git" \
            FZF_DEFAULT_OPTS=" \
            --reverse \
            ${FZF_DEFAULT_OPTS} \
            -m \
            --ansi \
            --preview='$FZF_PREVIEW_CMD' " \
            $(fzfcmd)
    )
    [[ -n $selected ]] && trash ${=selected}
}
#compdef rm=trash

# ------------------------------------------
# History
# CTRL-R - Paste the selected command from history into the command line
# ------------------------------------------
fzf-history-widget() {
    local selected num key
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    # --scheme=history # not supported v0.30
    selected=($( \
                fc -rl 1 | \
            FZF_DEFAULT_OPTS=" \
            ${FZF_DEFAULT_OPTS-} \
            -n2..,.. \
            --tiebreak=index \
            --expect=ctrl-o \
            --preview='echo {2..-1}' \
            --preview-window='down,hidden,3,wrap' \
            --query=${(qqq)LBUFFER} \
            +m" \
            $(fzfcmd)
    ))
    ret=$?
    key=$selected[1]
    num=$selected[2]
    # <ENTER>
    if [[ "$key" != ctrl-o ]]; then
        num="$key"
    fi
    if [[ -n "$num" ]]; then
        zle vi-fetch-history -n $num
        if [[ "$key" == ctrl-o ]]; then
            zle accept-line
        fi
    fi

    zle reset-prompt
    return $ret
}
zle     -N            fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget

# ------------------------------------------
# Process
# ------------------------------------------
# fkill - kill processes, list only the ones you can kill.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# ------------------------------------------
# Man widget
# https://github.com/junegunn/fzf/wiki/Examples#fzf-man-pages-widget-for-zsh
#
# * `C-h`: launch widget
# Change Source:
#   * `A-c`: cht.sh
#   * `A-m`: manpage
#   * `A-t`: tldr
# FIXME: press <Enter> always show manpages
# ------------------------------------------
fzf-man-widget() {
    batman='SEC={2} && man ${SEC[-2,2]} {1} | col -bx | bat --language=man --plain --color=always --theme="Monokai Extended"'
    man -k . | sort \
        | awk \
        -v cyan=$(tput setaf 6) \
        -v yellow=$(tput setaf 4) \
        -v blue=$(tput setaf 7) \
        -v res=$(tput sgr0) \
        -v bld=$(tput bold) \
        '{ $1=cyan bld $1; $2=yellow $2; $3=res blue $3;} 1' \
        | fzf  \
        -q "$BUFFER" \
        --ansi \
        --tiebreak=begin \
        --prompt=' Man > '  \
        --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
        --preview "${batman}" \
        --bind "enter:execute(${batman})" \
        --bind "alt-c:reload(cht.sh :list)+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
        --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
        --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
    zle reset-prompt
}
bindkey '^[h' fzf-man-widget
zle -N fzf-man-widget
