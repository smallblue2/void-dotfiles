#!/usr/bin/bash

# Improve bug discoverability
set -euo pipefail

LOCK=/tmp/volume-yuck.lock

# Verify arg count
if [ $# -ne 1 ]; then
  echo "Usage: $0 [+|-]<value>"
  exit 2
fi

floating_res='^[+-]([0-9]+([.][0-9]*)?|[.][0-9]+)$'

if [[ ! $1 =~ $floating_res ]]; then
  echo "Bad argument: $1"
  exit 2
fi

# Extract values
modifier=${1:0:1}
number=${1:1}

# Set new volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ $number%$modifier

# Get new volume value
vol_frac="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')"

# Avoid going over 100%
if (( $(echo "scale=2; $vol_frac >= 1.0" | bc ) )); then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 1
  vol_frac=1
fi

# Normalise the volume between 0 - 100
vol_norm=$(echo "scale=2; $vol_frac * 100" | bc)

# Update yuck
eww update current-volume=$vol_norm last-changed=$(date +%s)

# ONE (likely first) waiter handles open and close
(
  # Lock the open file descriptor, otherwise exit gracefully
  flock -n 9 || exit 0
  eww open volume
  alive_for=$(eww get seconds-alive-for)
  while (( $(date +%s) - $(eww get last-changed) < $alive_for )); do
    sleep 0.2
  done
  eww close volume
) 9> "$LOCK"
