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
export FZF_DEFAULT_COLOR="\
bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,\
fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6,\
marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
# mocha
# local FZF_DEFAULT_COLOR="\
    # bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,\
    # fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,\
    # marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

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
  --bind=${FZF_DEFAULT_KEYBINDINGS:-\'\'}\
  --preview-window=sharp\
  --prompt=' '\
  --pointer=\
  --marker=+\
  --color=${FZF_DEFAULT_COLOR}\
  --height=${FZF_DEFAULT_HEIGHT:-40%}"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER='\'
export FZF_ALT_C_OPTS="--preview='$FZF_PREVIEW_DIR_CMD'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git/"
export FZF_TMUX=0
# export FZF_TMUX_OPTS='-p' # float window
#export FZF_TMUX_HEIGHT='80%'


# ------------------------------------------
# builtin widgets
# `C-t`: file
# `C-r`: history
# `A-c`: cd directory
# ------------------------------------------
# #[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/completion.zsh

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
        trash "$*"
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
    [[ -n $selected ]] && trash ${=selected}
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
compdef rm=trash

# ------------------------------------------
# History
# CTRL-R - Paste the selected command from history into the command line
# ------------------------------------------
fzf-history-widget() {
    local selected num key
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    # awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    selected=($( \
                fc -rl 1 | \
            FZF_DEFAULT_OPTS=" \
            ${FZF_DEFAULT_OPTS-} \
            -n2..,.. \
            --scheme=history \
            --expect=ctrl-o \
            --preview='echo {2..-1}' \
            --preview-window=down,hidden,3,wrap \
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
# Git
# ------------------------------------------



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

# ------------------------------------------
# pacman widget
# https://github.com/junegunn/fzf/wiki/Examples#pacman
# - fpi: install
# - fpu: remove
# ------------------------------------------
# Install packages using yay (change to pacman/AUR helper of your choice)
fpi() {
yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
fpu() {
yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}
# Helper function to integrate yay and fzf
yzf() {
pos=$1
shift
sed "s/ /\t/g" |
fzf --nth=$pos --multi --history="${FZF_HISTDIR:-$XDG_CACHE_HOME/fzf}/history-yzf$pos" \
    --preview-window=60%,border-left \
    --ansi \
    --bind="double-click:execute(xdg-open 'https://archlinux.org/packages/{$pos}'),alt-enter:execute(xdg-open 'https://aur.archlinux.org/packages?K={$pos}&SB=p&SO=d&PP=100')" \
    "$@" | cut -f$pos | xargs
}

# Dev note: print -s adds a shell history entry

# List installable packages into fzf and install selection
yas() {
cache_dir="/tmp/yas-$USER"
test "$1" = "-y" && rm -rf "$cache_dir" && shift
mkdir -p "$cache_dir"
preview_cache="$cache_dir/preview_{2}"
list_cache="$cache_dir/list"
{ test "$(cat "$list_cache$@" | wc -l)" -lt 50000 && rm "$list_cache$@"; } 2>/dev/null
pkg=$( (cat "$list_cache$@" 2>/dev/null || { pacman --color=always -Sl "$@"; yay --color=always -Sl aur "$@" } | sed 's/ [^ ]*unknown-version[^ ]*//' | tee "$list_cache$@") |
yzf 2 --tiebreak=index --preview="cat $preview_cache 2>/dev/null | grep -v 'Querying' | grep . || yay --color always -Si {2} | tee $preview_cache")
if test -n "$pkg"
then echo "Installing $pkg..."
    cmd="yay -S $pkg"
    print -s "$cmd"
    eval "$cmd"
    rehash
fi
}
# List installed packages into fzf and remove selection
# Tip: use -e to list only explicitly installed packages
yar() {
pkg=$(yay --color=always -Q "$@" | yzf 1 --tiebreak=length --preview="yay --color always -Qli {1}")
if test -n "$pkg"; then
    echo "Removing $pkg..."
    cmd="yay -R --cascade --recursive $pkg"
    print -s "$cmd"
    eval "$cmd"
    rehash
fi
}


# ------------------------------------------
# asdf
# https://github.com/junegunn/fzf/wiki/Examples#asdf
# ------------------------------------------
# Install one or more versions of specified language
# e.g. `fai rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `fai<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
fai() {
local lang=${1}

if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
fi

if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
        for version in $(echo $versions);
        do; asdf install $lang $version; done;
    fi
fi
}

# Remove one or more versions of specified language
# e.g. `fau rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `fau<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
fau() {
local lang=${1}

if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
fi

if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
        for version in $(echo $versions);
        do; asdf uninstall $lang $version; done;
    fi
fi
}

# ------------------------------------------
# flatpak widget
# https://github.com/junegunn/fzf/wiki/Examples#flatpak-widget-for-zsh
#
# <A-f><A-i>: Install
# <A-f><A-u>: Uninstall
# ------------------------------------------
# CLR=$(for i in {0..7}; do echo "tput setaf $i"; done)
BLK=\$(tput setaf 0); RED=\$(tput setaf 1); GRN=\$(tput setaf 2); YLW=\$(tput setaf 3); BLU=\$(tput setaf 4);
MGN=\$(tput setaf 5); CYN=\$(tput setaf 6); WHT=\$(tput setaf 7); BLD=\$(tput bold); RST=\$(tput sgr0);

AWK_VAR="awk -v BLK=${BLK} -v RED=${RED} -v GRN=${GRN} -v YLW=${YLW} -v BLU=${BLU} -v MGN=${MGN} -v CYN=${CYN} -v WHT=${WHT} -v BLD=${BLD} -v RST=${RST}"

# Searches only from flathub repository
fzf-flatpak-install-widget() {
flatpak remote-ls flathub --cached --columns=app,name,description \
    | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0) \
    '{
        app_info="";
        for(i=2;i<=NF;i++){
            app_info=cyn app_info" "$i
        };
        print blu bld $2" -" res app_info "|" $1
}' \
    | column -t -s "|" -R 3 \
    | fzf \
    --ansi \
    --with-nth=1.. \
    --prompt="Install > " \
    --preview-window "nohidden,40%,<50(down,50%,border-rounded)" \
    --preview "flatpak --system remote-info flathub {-1} | $AWK_VAR -F\":\" '{print YLW BLD \$1 RST WHT \$2}'" \
    --bind "enter:execute(flatpak install flathub {-1})" # when pressed enter it doesn't showing the key pressed but it is reading the input
zle reset-prompt
}
bindkey '^[f^[i' fzf-flatpak-install-widget #alt-f + alt-i
zle -N fzf-flatpak-install-widget

fzf-flatpak-uninstall-widget() {
touch /tmp/uns
flatpak list --columns=application,name \
    | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0)  \
    '{
    app_id="";
    for(i=2;i<=NF;i++){
      app_id" "$i
    };
    print bld cyn $2 " - " res blu $1
}' \
    | column -t \
    | fzf \
    --ansi \
    --with-nth=1.. \
    --prompt="  Uninstall > " \
    --header="M-u: Uninstall | M-r: Run" \
    --header-first \
    --preview-window "nohidden,50%,<50(up,50%,border-rounded)" \
    --preview  "flatpak info {3} | $AWK_VAR -F\":\" '{print RED BLD  \$1 RST \$2}'" \
    --bind "alt-r:change-prompt(Run > )+execute-silent(touch /tmp/run && rm -r /tmp/uns)" \
    --bind "alt-u:change-prompt(Uninstall > )+execute-silent(touch /tmp/uns && rm -r /tmp/run)" \
    --bind "enter:execute(
    if [ -f /tmp/uns ]; then
      flatpak uninstall {3};
    elif [ -f /tmp/run ]; then
      flatpak run {3};
    fi
)" # same as the install one but when pressed  entered the message is something like this
# "Proceed with these changes to the system installation? [Y/n]:" but it will uninstall the selected app weird but idk y
rm -f /tmp/{uns,run} &> /dev/null
zle reset-prompt
}
bindkey '^[f^[u' fzf-flatpak-uninstall-widget #alt-f + alt-u
zle -N fzf-flatpak-uninstall-widget
