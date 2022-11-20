# ------------------------------------------
# Colors
# https://github.com/catppuccin/fzf
# ------------------------------------------
# latte
local fzf_colors_latte="\
bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39,\
fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78,\
marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
# frappe
local fzf_colors_frappe="\
bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284,\
fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf,\
marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
# macchiato
local fzf_colors_macchiato="\
bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,\
fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6,\
marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
# mocha
local fzf_colors_mocha="\
bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,\
fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,\
marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# ------------------------------------------
# FZF_* environment variables
# ------------------------------------------
local fzf_keybindings='tab:down,btab:up,change:top,space:toggle'

# local fzf_preview_cmd='[[ -d {} ]] && (exa -ahl --git --color=always {} || ls -Al --color=always {}) ||
#     ( [[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
#     ( bat --color=always --style=numbers --line-range=:$FZF_PREVIEW_LINES {} || ccat --color=always {} || highlight -O ansi -l {} || cat {} ) 2> /dev/null
#     )'
local fzf_preview_cmd='preview {} $FZF_PREVIEW_LINES $FZF_PREVIEW_COLUMNS'

export FZF_DEFAULT_OPTS="\
  --bind=${fzf_keybindings}\
  --preview-window=sharp\
  --prompt=' '\
  --pointer=\
  --marker=+\
  --color=${fzf_colors_mocha}"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude=.git/"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="\
  --preview='$fzf_preview_cmd'\
  --select-1 --exit-0\
  --bind='ctrl-o:execute-silent(xdg-open {1})'"
export FZF_COMPLETION_TRIGGER='\'
export FZF_CTRL_R_OPTS="--preview='echo {}' --preview-window=down,3,wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview='exa -aT -L2 --icons {} | head -200'"
export FZF_ALT_C_COMMAND="fd --hidden --exclude=.git/ --type=d"
export FZF_TMUX=1
# export FZF_TMUX_OPTS='-p' # float window
export FZF_TMUX_HEIGHT='80%'


# ------------------------------------------
# Source Bounded scripts
# ------------------------------------------
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ------------------------------------------
# Man widget
# https://github.com/junegunn/fzf/wiki/Examples#fzf-man-pages-widget-for-zsh
#
# * `C-h`: launch widget
# Change Source:
#   * `A-c`: cht.sh
#   * `A-m`: manpage
#   * `A-t`: tldr
# ------------------------------------------
fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget

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

# ------------------------------------------
# pacman widget
# https://github.com/junegunn/fzf/wiki/Examples#pacman
# - yi: install
# - yr: remove
# ------------------------------------------
# Install packages using yay (change to pacman/AUR helper of your choice)
yi() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
yr() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}
# Helper function to integrate yay and fzf
yzf() {
  pos=$1
  shift
  sed "s/ /\t/g" |
    fzf --nth=$pos --multi --history="${FZF_HISTDIR:-$XDG_CACHE_HOME/fzf}/history-yzf$pos" \
      --preview-window=60%,border-left \
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
  if test -n "$pkg"
    then echo "Removing $pkg..."
      cmd="yay -R --cascade --recursive $pkg"
      print -s "$cmd"
      eval "$cmd"
  fi
}


