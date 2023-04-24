#!/usr/bin/env bash

# random image
images=($HOME/.config/awesome/theme/wallpapers/LockScreen/*)
count=${#images[@]}
i=$((RANDOM % count))
image=${images[i]}

# SIZE=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
# convert $image -resize $SIZE RGB:- | \
    # i3lock --raw $SIZE:rgb --image /dev/stdin

i3lock_cmd=(i3lock -F -n -k -B 1)
i3lock_params=("--inside-color=1e1e2e" "--ring-color=1e1e2e" \
        "--insidever-color=1e1e2e" "--ringver-color=89b4fa" "--verif-color=89d4fa" \
        "--insidewrong-color=1e1e2e" "--ringwrong-color=f38ba8" "--wrong-color=f38ba8"\
        "--line-color=1e1e2e" "--keyhl-color=a6e3a1" "--bshl-color=f38ba8"\
        "--layout-color=cdd6f4" "--time-color=cdd6f4" "--date-color=cdd6f4"\
        "--greeter-color=cdd6f4"\
        "--date-str=%Y-%m-%d" \
        "--verif-text=Verifying..." \
        "--wrong-text=Wrong!" \
        "--noinput-text=Clear" \
        "--greeter-text=Why So Serious?" \
        "--pass-media-keys" "--pass-screen-keys" "--pass-power-keys" "--pass-volume-keys"
)

if ! "${i3lock_cmd[@]}" "${i3lock_params[@]}" > /dev/null; then
    "${i3lock_cmd[@]}"
fi
