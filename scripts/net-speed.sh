#!/usr/bin/env bash
# net-speed.sh
# Detect default interface and measure rx/tx bytes over 1 second to show speeds.
# Lightweight, no persistent state. Output example: "↓ 1.2MiB/s ↑ 350KiB/s"

set -euo pipefail

# detect interface used for default route
iface=$(ip route get 1.1.1.1 2>/dev/null | awk '/dev/ {for(i=1;i<=NF;i++) if($i=="dev") print $(i+1)}' || true)
if [[ -z "$iface" ]]; then
  # fallback: pick first non-loopback up interface
  iface=$(ls /sys/class/net | grep -v lo | head -n1 || true)
fi
if [[ -z "$iface" ]]; then
  echo "—"
  exit 0
fi

rx1=$(cat /sys/class/net/$iface/statistics/rx_bytes 2>/dev/null || echo 0)
tx1=$(cat /sys/class/net/$iface/statistics/tx_bytes 2>/dev/null || echo 0)
# wait a second for sample
sleep 1
rx2=$(cat /sys/class/net/$iface/statistics/rx_bytes 2>/dev/null || echo 0)
tx2=$(cat /sys/class/net/$iface/statistics/tx_bytes 2>/dev/null || echo 0)

rx=$((rx2 - rx1))
tx=$((tx2 - tx1))

hr() {
  local bytes=$1
  if (( bytes > 1048576 )); then
    # use awk for float division if bc is not available
    printf "%.1fMiB/s" "$(awk -v b=$bytes 'BEGIN{printf b/1048576}')"
  elif (( bytes > 1024 )); then
    printf "%.1fKiB/s" "$(awk -v b=$bytes 'BEGIN{printf b/1024}')"
  else
    printf "%dB/s" "$bytes"
  fi
}

printf "⇣%s ⇡%s" "$(hr $tx)" "$(hr $rx)"
