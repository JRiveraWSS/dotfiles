#!/usr/bin/env bash

# i3lock with blurred wallpaper
# Uses the current wallpaper from .fehbg and applies medium blur

WALLPAPER="/home/jrivera/Pictures/desktop-wallpaper-omega-squad-teemo.jpg"
BLUR_IMAGE="/tmp/lockscreen_blur.png"

# Create blurred version of wallpaper - resize to screen resolution then blur
convert "$WALLPAPER" -resize 2560x1600^ -gravity center -extent 2560x1600 -blur 0x8 "$BLUR_IMAGE"

# Lock screen with blurred wallpaper and clock
i3lock \
    -i "$BLUR_IMAGE" \
    --clock \
    --time-str="%I:%M:%S %p" \
    --date-str="%A, %B %d" \
    --time-color=7aa2f7ff \
    --date-color=c0caf5ff \
    --time-font="JetBrainsMono Nerd Font" \
    --date-font="JetBrainsMono Nerd Font" \
    --time-size=72 \
    --date-size=24 \
    --ring-color=1a1b26ff \
    --inside-color=1a1b2688 \
    --line-color=00000000 \
    --keyhl-color=7aa2f7ff \
    --bshl-color=f7768eff \
    --separator-color=00000000 \
    --verif-color=7aa2f7ff \
    --wrong-color=f7768eff \
    --ringver-color=7aa2f7ff \
    --ringwrong-color=f7768eff \
    --ind-pos="x+w/2:y+h/2" \
    --radius=120 \
    --ring-width=8

# Clean up temp file
rm -f "$BLUR_IMAGE"
