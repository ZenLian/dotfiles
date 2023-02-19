#!/usr/bin/env bash

images=($HOME/.config/awesome/zl/theme/wallpapers/LockScreen/*)
count=${#images[@]}
i=$((RANDOM % count))
IMAGE=${images[i]}
# IMAGE=$HOME/.config/awesome/zl/theme/wallpapers/LockScreen/arch-rainbow-1920x1080.png
SIZE=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
# convert $IMAGE -resize $SIZE RGB:- | \
    # i3lock --raw $SIZE:rgb --image /dev/stdin
i3lock -i $IMAGE -F \
    -n -k \
    -B 0.5 \
    --inside-color=1e1e2e88 \
    --ring-color=1e1e2ecc \
    --insidever-color=1e1e2e88 \
    --ringver-color=89b4facc \
    --verif-color=cdd6f4 \
    --insidewrong-color=1e1e2e88 \
    --ringwrong-color=f38ba8cc \
    --wrong-color=cdd6f4 \
    --line-color=1e1e1e88 \
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
