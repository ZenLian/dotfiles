local fzf_preview_cmd='[[ -d {} ]] && (exa -hl --git --color=always {} || ls -l --color=always {}) ||
    ( [[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
      ( bat --color=always --style=numbers --line-range=:500 {} || ccat --color=always {} || highlight -O ansi -l {} || cat {} ) 2> /dev/null
    )'
export FZF_DEFAULT_OPTS="--bind=tab:down,btab:up,change:top,space:toggle"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview="'$fzf_preview_cmd'"'
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
