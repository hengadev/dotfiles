#!/usr/bin/env bash
# Prints {"text": <icon+temp+util>, "tooltip": ..., "class": ...} for waybar,
# summarizing NVIDIA GPU health (util/temp/VRAM/power/fan) - the stats that
# matter for spotting thermal throttling or a CUDA job about to OOM.
set -euo pipefail

# Thermal thresholds sit below the RTX 30-series ~90-93C throttle point,
# so "warning" gives a heads-up before "critical" means it's actually throttling.
temp_warn=75
temp_crit=85
mem_warn=75
mem_crit=90

raw="$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total,power.draw,power.limit,fan.speed,clocks.sm \
    --format=csv,noheader,nounits 2>/dev/null)" || raw=""

if [ -z "$raw" ]; then
    printf '{"text":"󰢮 --","tooltip":"nvidia-smi unavailable","class":"critical"}\n'
    exit 0
fi

IFS=$'\x1f' read -r temp util mem_used mem_total power_draw power_limit fan clock_sm <<< "$(
    awk -F',' 'BEGIN{OFS="\037"} {for(i=1;i<=NF;i++){gsub(/^ +| +$/,"",$i)} print}' <<< "$raw"
)"

mem_pct=$(( mem_used * 100 / mem_total ))
power_draw_r=$(printf '%.0f' "$power_draw" 2>/dev/null || echo "$power_draw")
power_limit_r=$(printf '%.0f' "$power_limit" 2>/dev/null || echo "$power_limit")

class=""
if [ "$temp" -ge "$temp_crit" ] || [ "$mem_pct" -ge "$mem_crit" ]; then
    class="critical"
elif [ "$temp" -ge "$temp_warn" ] || [ "$mem_pct" -ge "$mem_warn" ]; then
    class="warning"
fi

if [ "${1:-}" = "--compact" ]; then
    text="󰢮"
else
    text="󰢮 ${util}% ${temp}°C"
fi

tooltip="Utilization: ${util}%"
tooltip="${tooltip}\nTemperature: ${temp}°C"
tooltip="${tooltip}\nVRAM: ${mem_used}MiB / ${mem_total}MiB (${mem_pct}%)"
tooltip="${tooltip}\nPower: ${power_draw_r}W / ${power_limit_r}W"
tooltip="${tooltip}\nFan: ${fan}%"
tooltip="${tooltip}\nSM Clock: ${clock_sm} MHz"

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$text" "$tooltip" "$class"
