#!/usr/bin/env sh

# -c 1e1e2e
i3lock -n -k --indicator \
    -i $HOME/.config/awesome/zl/theme/wallpapers/LockScreen/arch-rainbow-1920x1080.png -F\
    -B 0.5 \
    --inside-color=1e1e2e88 \
    --ring-color=1e1e2e88 \
    --insidever-color=1e1e2e \
    --ringver-color=1e1e2e \
    --verif-color=89b4fa \
    --insidewrong-color=1e1e2e \
    --ringwrong-color=1e1e2e \
    --wrong-color=f38ba8 \
    --line-color=6c7086 \
    --keyhl-color=a6e3a1 \
    --bshl-color=f38ba8 \
    --layout-color=cdd6f4 \
    --time-color=cdd6f4 \
    --date-color=cdd6f4 \
    --greeter-color=cdd6f4 \
    --date-str="%Y-%m-%d" \
    --verif-text="..." \
    --wrong-text="OOPS" \
    --noinput-text="CLEAR" \
    --greeter-text="Hello, Cuty" \
    --time-font=sans \
    --date-font=sans \
    --layout-font=sans \
    --verif-font=sans \
    --wrong-font=sans \
    --greeter-font=sans \
    --pass-media-keys \
    --pass-screen-keys \
    --pass-power-keys \
    --pass-volume-keys
