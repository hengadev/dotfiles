#!/usr/bin/env bash
# Started once at sway startup (via `exec`, not `exec_always` - so sway
# reloads don't stack up duplicate watchers). Re-runs waybar-launch.sh
# whenever a monitor is connected or disconnected, so waybar's top/left
# position stays correct without needing a manual sway reload.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

swaymsg -t subscribe -m '["output"]' | while read -r _; do
    "$SCRIPT_DIR/waybar-launch.sh"
done
