# Do the initialization when the script is sourced (i.e. Initialize instantly)
zvm_config() {
    # ZVM_INIT_MODE=sourcing
    ZVM_VI_HIGHLIGHT_FOREGROUND=black
    ZVM_VI_HIGHLIGHT_BACKGROUND=blue
    # ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
}

zvm_after_lazy_keybindings() {
    bindkey -M viins '^F' forward-word
}
