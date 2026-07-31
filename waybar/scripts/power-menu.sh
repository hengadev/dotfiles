#!/usr/bin/env bash
# Power menu: a wofi dmenu list, replacing the old swaynag popups for both
# the waybar power button and sway's $mod+Shift+e exit binding, so both
# share the same themed confirm UI as the theme picker instead of a plain
# swaynag bar.
set -euo pipefail

options="󰌾  Lock\n󰗽  Logout\n󰜉  Reboot\n󰐥  Shutdown"

selected="$(printf '%b' "$options" | wofi --dmenu --prompt "Power" --width 280 --lines 4)"

case "$selected" in
    *Lock)     swaymsg exec i3lock ;;
    *Logout)   swaymsg exit ;;
    *Reboot)   systemctl reboot ;;
    *Shutdown) systemctl poweroff ;;
esac
