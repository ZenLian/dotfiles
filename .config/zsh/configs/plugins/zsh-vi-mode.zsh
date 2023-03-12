# Do the initialization when the script is sourced (i.e. Initialize instantly)
zvm_config() {
    ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
    # ZVM_INIT_MODE=sourcing
    ZVM_VI_HIGHLIGHT_FOREGROUND='#1e1e2e'
    ZVM_VI_HIGHLIGHT_BACKGROUND='#b4befe'
    # ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
}

zvm_after_lazy_keybindings() {
    bindkey -M viins '^F' forward-word
    #bindkey -M viins '^W' backward-delete-word
}
