#!/usr/bin/bash

# Improve bug discoverability
set -euo pipefail

LOCK=/tmp/bright-yuck.lock

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

# Set new brightness
brightnessctl set $number%$modifier

# Get new brightness
new_brightness=$(printf '%.0f' "$(bc -l <<< "scale=2; ($(brightnessctl get) / $(brightnessctl max)) * 100 ")")

# Update yuck
eww update bright-last-changed=$(date +%s) current-brightness=$new_brightness

(
  flock -n 9 || exit 0
  eww open brightness
  alive_for=$(eww get bright-seconds-alive-for)
  while (( $(date +%s) - $(eww get bright-last-changed) < $alive_for )) ; do
    sleep 0.2
  done
  eww close brightness
) 9> "$LOCK"
