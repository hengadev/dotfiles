#!/usr/bin/env bash
# Applies the light/dark bucket in ~/.theme_state to waybar and the sway
# wallpaper. This is a subroutine, not a user-facing entry point: called by
# set-theme.sh (after it writes a new state from a picked theme) and once at
# sway startup to reapply whatever was last saved.
#
# tmux, wezterm, and herdr are NOT handled here - they mirror the exact
# palette of the last picked nvim theme, via set-theme.sh, not this coarse
# bucket.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATE_FILE="$HOME/.theme_state"
WAYBAR_DIR="$HOME/.config/waybar"
source "$SCRIPT_DIR/wallpapers.sh"

mode="dark"
if [ -f "$STATE_FILE" ]; then
    read_mode="$(tr -d '[:space:]' <"$STATE_FILE")"
    if [ "$read_mode" = "light" ] || [ "$read_mode" = "dark" ]; then
        mode="$read_mode"
    fi
fi

# --- waybar ---
ln -sf "palette-$mode.css" "$WAYBAR_DIR/palette.css"
if pgrep -x waybar >/dev/null 2>&1; then
    killall waybar
    setsid waybar >/tmp/waybar.log 2>&1 &
    disown
fi

# --- wallpaper ---
if [ "$mode" = "light" ]; then
    wallpaper="$WALLPAPER_LIGHT"
else
    wallpaper="$WALLPAPER_DARK"
fi
if command -v swaymsg >/dev/null 2>&1 && swaymsg -t get_version >/dev/null 2>&1; then
    swaymsg output "*" bg "$wallpaper" fill >/dev/null
fi
