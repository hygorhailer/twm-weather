#!/usr/bin/env bash

# ----------------------------------
# Program Name: TWM Weather
# Description: Lightweight real-time weather information
# Author: Hygor Hailer
# Date: 18-04-2024
# Version: 1.0
# Usage: ./menu.sh
# ----------------------------------

FILE_DIR=$(dirname "$0")

# Read cities from file into a variable
CITIES=""
CITIES+="+ ADD CITY"
COUNT=1
if [[ -s  $FILE_DIR/./dataset/registered_cities  ]]; then
    CITIES+="|- REMOVE CITY"
    COUNT=$(($COUNT+1))
fi
CITIES="$CITIES|$(awk '{print $0 "|"}' $FILE_DIR/./dataset/registered_cities | paste -sd '\0' -)"

# Remove the trailing '|'
CITIES=${CITIES%|}

# Create a count variable
COUNT=$(($(cat $FILE_DIR/./dataset/registered_cities | wc -l)+$COUNT))
if [[ $COUNT -ge 10 ]];then COUNT=10;fi

MENU="$(rofi -sep "|" -dmenu -i -color-window "#232729, #232729, #b1b4b3" -color-normal "#232729, #ececec, #232729, #bf4848, #ececec" -p 'Select a city' -location 0 -columns 1 -width 20 -line-padding 4 -padding 20 -lines $COUNT <<< "$CITIES")"

case "$MENU" in
    '+ ADD CITY') $FILE_DIR/scripts/add_city.sh && exit  0 ;;
esac

while IFS= read -r city; do
    case "$MENU" in
        '- REMOVE CITY') $FILE_DIR/scripts/remove_city.sh && exit  0 ;;
	$city) echo "$city" > $FILE_DIR/./current_values/current_city && $FILE_DIR/./scripts/api.sh ;;
    esac
done < $FILE_DIR/./dataset/registered_cities
