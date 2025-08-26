#!/usr/bin/bash

# THIS SCRIPT ASSUMES:
#  - Only one battery
#  - ACPI installed

acpi_output=$( acpi -b )
batt=$( echo "$acpi_output" | awk '{ print $4 }' | sed 's/%,$//g' )
stat=$( echo "$acpi_output" | awk '{ print $3 }' | sed 's/,//g' )

if [ "$stat" != 'Charging' ]; then
  if [ $batt -le 10 ]; then
    notify-send -u critical "Critical Battery" "Battery is at $batt%"
  elif [ $batt -le 20 ]; then
    notify-send -u normal "Low Battery" "Battery is at $batt%"
  fi
fi
