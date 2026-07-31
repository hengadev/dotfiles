#!/usr/bin/env bash
# Diagnostic check for theme-sync. Run this after cloning this dotfiles repo
# onto a new machine, before relying on pick-theme.sh or nvim's theme picker,
# to see what's missing.
#
# Reports three levels per item:
#   OK      - present, nothing to do
#   MISSING - required for the core flow (nvim palette -> everywhere); the
#             picker will fail without it
#   WARN    - an optional integration (tmux/wezterm/herdr) is unconfigured or
#             its tool isn't installed - switching themes will just silently
#             skip that integration, which is fine if you don't use it
#
# A few purely local, reversible fixes (chmod +x, an initial ~/.theme_state,
# the waybar palette symlink) are applied automatically rather than just
# reported, since there's nothing to decide about them.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

missing_count=0
warn_count=0

ok()      { printf "  [OK]      %s\n" "$1"; }
warn()    { printf "  [WARN]    %s\n" "$1"; warn_count=$((warn_count + 1)); }
missing() { printf "  [MISSING] %s\n" "$1"; missing_count=$((missing_count + 1)); }
section() { printf "\n%s\n" "$1"; }

section "Core flow (nvim palette -> waybar/wallpaper)"

if command -v nvim >/dev/null 2>&1; then
    ok "nvim found ($(command -v nvim))"
else
    missing "nvim not found - extract-palette.lua needs it to read a theme's palette headlessly. Install neovim."
fi

if command -v jq >/dev/null 2>&1; then
    ok "jq found"
else
    missing "jq not found - set-theme.sh needs it to parse the extracted palette. Install jq."
fi

BASE46_DIR="$HOME/.local/share/nvim/lazy/base46/lua/base46/themes"
if [ -d "$BASE46_DIR" ] && [ -n "$(find "$BASE46_DIR" -maxdepth 1 -name '*.lua' -print -quit 2>/dev/null)" ]; then
    theme_count=$(find "$BASE46_DIR" -maxdepth 1 -name '*.lua' | wc -l)
    ok "base46 themes found ($theme_count themes at $BASE46_DIR)"
else
    missing "base46 plugin not found at $BASE46_DIR - open nvim once so lazy.nvim installs NvChad's base46 theme engine, then re-run this check."
fi

NVCONFIG="$CONFIG_DIR/nvim/lua/nvconfig.lua"
if [ -f "$NVCONFIG" ] && grep -q -- '-- default theme' "$NVCONFIG"; then
    ok "nvconfig.lua has the default-theme anchor set-theme.sh writes to"
elif [ -f "$NVCONFIG" ]; then
    warn "nvconfig.lua exists but its 'theme = \"...\", -- default theme' line is missing - set-theme.sh won't be able to persist a picked theme. Check M.base46.theme in nvim/lua/nvconfig.lua."
else
    missing "nvconfig.lua not found at $NVCONFIG"
fi

section "Global theme picker"

if command -v wofi >/dev/null 2>&1; then
    ok "wofi found"
else
    missing "wofi not found - required for pick-theme.sh (the \$mod+Shift+t menu). Install wofi."
fi

section "Waybar"

if command -v waybar >/dev/null 2>&1; then
    ok "waybar found"
else
    warn "waybar not found - theme switches will just skip restarting it."
fi

WAYBAR_DIR="$CONFIG_DIR/waybar"
if [ -f "$WAYBAR_DIR/palette-dark.css" ] && [ -f "$WAYBAR_DIR/palette-light.css" ]; then
    ok "waybar palette tokens found"
else
    missing "waybar/palette-dark.css or palette-light.css missing in $WAYBAR_DIR"
fi

if [ -f "$WAYBAR_DIR/palette-dark.css" ] && [ ! -e "$WAYBAR_DIR/palette.css" ]; then
    ln -sf palette-dark.css "$WAYBAR_DIR/palette.css"
    ok "created missing waybar/palette.css symlink -> palette-dark.css"
fi

section "Wallpaper"

source "$SCRIPT_DIR/wallpapers.sh"
if [ -f "$WALLPAPER_DARK" ]; then
    ok "dark wallpaper found ($WALLPAPER_DARK)"
else
    missing "dark wallpaper missing at $WALLPAPER_DARK"
fi
if [ -f "$WALLPAPER_LIGHT" ]; then
    ok "light wallpaper found ($WALLPAPER_LIGHT)"
else
    missing "light wallpaper missing at $WALLPAPER_LIGHT"
fi

if command -v swaymsg >/dev/null 2>&1; then
    ok "swaymsg found"
else
    warn "swaymsg not found - not running sway? waybar-restart/wallpaper steps will be skipped silently, matching apply-theme.sh's own guard."
fi

section "Optional: tmux palette sync"

if command -v tmux >/dev/null 2>&1; then
    ok "tmux found"
else
    warn "tmux not found - tmux color sync will be skipped. Ignore if you don't use tmux."
fi

section "Optional: wezterm palette sync"

if command -v wezterm >/dev/null 2>&1; then
    ok "wezterm found"
else
    warn "wezterm not found - palette sync will be skipped. Ignore if you don't use wezterm."
fi

section "Optional: herdr palette sync"

HERDR_CONFIG="$HOME/.config/herdr/config.toml"
if [ -f "$HERDR_CONFIG" ]; then
    ok "herdr config.toml found"
    if command -v python3 >/dev/null 2>&1; then
        ok "python3 found (set-theme.sh needs it to patch herdr's [theme.custom] keys)"
    else
        missing "python3 not found - herdr/config.toml exists, so set-theme.sh's herdr step needs python3 to patch it."
    fi
else
    warn "herdr/config.toml not found - herdr sync will be skipped. Ignore if you don't use herdr."
fi

section "File permissions"

for f in set-theme.sh apply-theme.sh pick-theme.sh tmux-nvim-theme.sh; do
    if [ -x "$SCRIPT_DIR/$f" ]; then
        ok "$f is executable"
    elif [ -f "$SCRIPT_DIR/$f" ]; then
        chmod +x "$SCRIPT_DIR/$f"
        ok "$f was not executable - fixed with chmod +x"
    else
        missing "$SCRIPT_DIR/$f not found"
    fi
done

section "State"

STATE_FILE="$HOME/.theme_state"
if [ -f "$STATE_FILE" ]; then
    ok "~/.theme_state found ($(cat "$STATE_FILE"))"
else
    printf '%s' "dark" >"$STATE_FILE"
    ok "created ~/.theme_state, defaulted to dark"
fi

section "Summary"

echo "  $missing_count missing, $warn_count warnings (optional integrations)"
if [ "$missing_count" -gt 0 ]; then
    echo
    echo "Fix the [MISSING] items above, then re-run this script before using pick-theme.sh or nvim's theme picker."
    exit 1
fi

echo
echo "Core requirements satisfied. Any [WARN] above is just an optional integration you can ignore if unused."
