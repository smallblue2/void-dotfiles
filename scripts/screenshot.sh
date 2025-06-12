#!/usr/bin/bash

# screenshot.sh screen|region clipboard|file

AREA=$1
DEST=$2
FILENAME="shot-$(date +%d-%a-%b-%H:%M).png"

help() {
  echo "USAGE: screenshot.sh [screen|region] [clipboard|file]"
}

screenshot() {
  GRIM_DEFAULT_DIR=$HOME/Pictures grim $FILENAME
}

regionshot() {
  GRIM_DEFAULT_DIR=$HOME/Pictures grim -g "$(slurp)" $FILENAME
}

if [[ "$AREA" == "screen" ]]; then
  screenshot
elif [[ "$AREA" == "region" ]]; then
  regionshot
else
  help
  exit 1
fi

if [[ "$DEST" == "clipboard" ]]; then
  wl-copy -t "image/png" < "$FILENAME"
  rm $FILENAME
  notify-send "Screenshot" "Screenshot has been saved to clipboard."
elif [[ "$DEST" == "file" ]]; then
  notify-send "Screenshot" "Screenshot has been saved to \"$FILENAME\""
else
  help
  exit 1
fi
