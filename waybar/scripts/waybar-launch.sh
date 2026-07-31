#!/usr/bin/env bash
# Restarts waybar with the layout matching the current widest active
# output: top bar normally, moved to the left edge past WIDE_THRESHOLD so a
# wide/ultrawide monitor uses its abundant horizontal space instead of
# eating into it with a horizontal strip. Called by sway on every
# startup/reload, and by output-watch.sh whenever a monitor is
# connected/disconnected.
set -uo pipefail

WAYBAR_DIR="$HOME/.config/waybar"
WIDE_THRESHOLD=2560

width="$(swaymsg -t get_outputs 2>/dev/null | jq '[.[] | select(.active) | .current_mode.width] | max // 0')"

pkill -x waybar 2>/dev/null

# waybar resolves the "include" directive in config/config-vertical against
# the process's cwd, not the config file's own directory - cd first so the
# relative "modules.json" reference in both keeps working.
cd "$WAYBAR_DIR" || exit 1

if [ "${width:-0}" -ge "$WIDE_THRESHOLD" ]; then
    setsid waybar -c config-vertical -s style-vertical.css >/dev/null 2>&1 &
else
    setsid waybar -c config -s style.css >/dev/null 2>&1 &
fi
disown
