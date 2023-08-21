if [[ $ZSHRC_KEYMAPS == true ]]; then
    bindkey -v # -v for vi, -e for emacs

    # emacs like
    bindkey -M viins '^B' backward-char
    bindkey -M viins '^F' forward-char
    bindkey -M viins '^A' beginning-of-line
    bindkey -M viins '^E' end-of-line
    bindkey -M viins '^P' up-history
    bindkey -M viins '^N' down-history
    #bindkey -M viins '^W' backward-delete-word
    bindkey -M viins '^H' backward-delete-char
    bindkey -M viins '^?' backward-delete-char
    bindkey -M viins '^D' delete-char
    bindkey -M viins '^K' kill-line
    bindkey -M viins '^U' backward-kill-line
fi
