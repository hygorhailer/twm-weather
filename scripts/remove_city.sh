#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Read cities from file into a variable
CITIES=""
CITIES=$(awk '{print $0 "|"}' $SCRIPT_DIR/../dataset/registered_cities | paste -sd '\0' -)

# Remove the trailing '|'
CITIES=${CITIES%|}

# Create a count variable
COUNT=$(cat $SCRIPT_DIR/../dataset/registered_cities | wc -l)
if [[ $COUNT -ge 10 ]];then COUNT=10;fi

MENU="$(rofi -sep "|" -dmenu -i -color-window "#232729, #232729, #b1b4b3" -color-normal "#232729, #ececec, #232729, #bf4848, #ececec" -p 'Remove a city' -location 0 -columns 1 -width 30 -line-padding 4 -padding 20 -lines $COUNT <<< "$CITIES")"

while IFS= read -r city; do
    case "$MENU" in
	$city) sed -i "/^$city$/d" $SCRIPT_DIR/../dataset/registered_cities && notify-send "$city has been removed" && exit  0 ;;
    esac
done < $SCRIPT_DIR/../dataset/registered_cities
