#!/usr/bin/env bash
# Propagates a light/dark mode across waybar, tmux, herdr, and the sway
# wallpaper. Source of truth is ~/.theme_state ("dark" or "light"), written
# either by this script's --toggle or by nvim's NvThemeReload autocmd.
#
# Called directly at every trigger point (sway keybind, sway startup, nvim
# autocmd) - no polling.

set -euo pipefail

STATE_FILE="$HOME/.theme_state"
WAYBAR_DIR="$HOME/.config/waybar"
WALLPAPER_DARK="$HOME/Pictures/Wallpapers/mountain.jpg"
WALLPAPER_LIGHT="$HOME/Pictures/Wallpapers/lofi_forest.jpg"
CATPPUCCIN_TMUX="$HOME/.config/tmux/plugins/catppuccin-tmux/catppuccin.tmux"
HERDR_CONFIG="$HOME/.config/herdr/config.toml"

read_mode() {
    if [ -f "$STATE_FILE" ]; then
        tr -d '[:space:]' <"$STATE_FILE"
    else
        echo "dark"
    fi
}

if [ "${1:-}" = "--toggle" ]; then
    current="$(read_mode)"
    if [ "$current" = "light" ]; then
        mode="dark"
    else
        mode="light"
    fi
    printf '%s' "$mode" >"$STATE_FILE"
else
    mode="$(read_mode)"
    if [ "$mode" != "light" ] && [ "$mode" != "dark" ]; then
        mode="dark"
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

# --- tmux ---
if [ "$mode" = "light" ]; then
    flavour="latte"
else
    flavour="mocha"
fi
if command -v tmux >/dev/null 2>&1 && tmux info >/dev/null 2>&1; then
    tmux set-option -g @catppuccin_flavour "$flavour"
    bash "$CATPPUCCIN_TMUX"
fi

# --- herdr ---
if [ "$mode" = "light" ]; then
    herdr_theme="catppuccin-latte"
else
    herdr_theme="catppuccin"
fi
if [ -f "$HERDR_CONFIG" ] && pgrep -f "$HOME/.local/bin/herdr" >/dev/null 2>&1; then
    sed -i -E "s/^name = \"catppuccin(-latte)?\"/name = \"$herdr_theme\"/" "$HERDR_CONFIG"
    herdr server reload-config >/dev/null 2>&1 || true
fi
