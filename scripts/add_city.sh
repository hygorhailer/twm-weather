#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Read cities from file into a variable
CITIES=""

CITIES=$(awk -F'|' '{print $2}' $SCRIPT_DIR/../dataset/brazil_cities | paste -sd '|' -)

# Remove the trailing '|'
CITIES=${CITIES%|}

MENU="$(rofi -sep "|" -dmenu -i -color-window "#232729, #232729, #b1b4b3" -color-normal "#232729, #ececec, #232729, #bf4848, #ececec" -p 'Add a city' -location 0 -columns 1 -width 30 -line-padding 4 -padding 20 -lines 20 <<< "$CITIES")"

if [ -n "$MENU" ]; then
    awk -F'|' -v menu="$MENU" '{if ($2 == menu) print $2}' $SCRIPT_DIR/../dataset/brazil_cities >> $SCRIPT_DIR/../dataset/registered_cities && notify-send "$MENU has been added"
fi
