
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
  PLUG_NAME=$(echo $1 | cut -d "/" -f 2)
  # source config if any
  plug_source "$PLUG_CFG_DIR/$PLUG_NAME.zsh"
  # source plugin
  if [ -d "$PLUG_DIR/$PLUG_NAME" ]; then
    plug_source "$PLUG_DIR/$PLUG_NAME/$PLUG_NAME.plugin.zsh" || \
    plug_source "$PLUG_DIR/$PLUG_NAME/$PLUG_NAME.zsh" || \
    plug_source "$PLUG_DIR/$PLUG_NAME/$PLUG_NAME.zsh-theme" || \
    plug_source "$PLUG_DIR/$PLUG_NAME/$2.zsh"
  else
    cd $ZDOTDIR
    git submodule add "https://github.com/$1.git" "plugins/$PLUG_NAME"
    cd -
  fi
}

zsh_sync() {
    cd $ZDOTDIR
    git submodule update --remote --merge
    cd -
}

