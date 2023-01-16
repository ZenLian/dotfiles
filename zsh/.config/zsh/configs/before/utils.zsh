
# https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh/
exists() { (( $+commands[$1] )); }

#
# Plugin management
# https://github.com/akinsho/dotfiles/blob/main/.config/zsh/plugins.zsh
#
# usage:
#   plug <NAME> [file-to-source]
#

PLUG_DIR="$ZDOTDIR/plugins"
PLUG_CFG_DIR="$ZDOTDIR/configs/plugins"

plug_source() {
    [ -f "$1" ] && source "$1"
}

plug() {
    # name=$(echo $1 | cut -d "/" -f 2)
    repo=$1
    name=${repo##*/}
    # source config if any
    plug_source "$PLUG_CFG_DIR/$name.zsh"
    # source plugin
    if [ -d "$PLUG_DIR/$name" ]; then
        plug_source "$PLUG_DIR/$name/$name.plugin.zsh" || \
            plug_source "$PLUG_DIR/$name/$name.zsh" || \
            plug_source "$PLUG_DIR/$name/$name.zsh-theme" || \
            plug_source "$PLUG_DIR/$name/$2.zsh"
    else
        cd $ZDOTDIR
        git submodule add "https://github.com/$1.git" "plugins/$name"
        cd -
    fi
}

zsh_sync() {
    cd $ZDOTDIR
    git submodule update --remote --merge
    cd -
}
