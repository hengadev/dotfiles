#!/usr/bin/env bash
# Global theme picker: lists all base46 themes in a wofi dmenu, then runs
# the chosen one through set-theme.sh - the single entry point (alongside
# nvim's own Telescope picker) for changing the theme everywhere.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$HOME/.local/share/nvim/lazy/base46/lua/base46/themes"

selected="$(
    find "$THEMES_DIR" -maxdepth 1 -name '*.lua' -printf '%f\n' \
        | sed 's/\.lua$//' \
        | sort \
        | (cd "$HOME/.config/wofi" && wofi --dmenu --prompt "Theme")
)"

if [ -n "$selected" ]; then
    "$SCRIPT_DIR/set-theme.sh" "$selected"
fi
