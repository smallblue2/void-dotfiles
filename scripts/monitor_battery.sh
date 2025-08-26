#!/usr/bin/bash

# THIS SCRIPT ASSUMES:
#  - Only one battery
#  - ACPI installed
#  - A dbus session at unix:path=/run/user/$(id -u)/bus

# Env variabels required by notify-send.
# Required, as this script is typically ran by crond,
# which has a minimal env.
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
export DISPLAY=":0"

acpi_output=$( acpi -b )
batt=$( echo "$acpi_output" | awk '{ print $4 }' | sed 's/%,$//g' )
stat=$( echo "$acpi_output" | awk '{ print $3 }' | sed 's/,//g' )

echo "$(date) batt=$batt stat=$stat DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS DISPLAY=$DISPLAY"

if [ "$stat" != 'Charging' ]; then
  if [ $batt -le 10 ]; then
    echo "$(date) sending critical notification"
    notify-send -u critical "Critical Battery" "Battery is at $batt%"
  elif [ $batt -le 20 ]; then
    echo "$(date) sending normal notification"
    notify-send -u normal "Low Battery" "Battery is at $batt%"
  fi
fi
