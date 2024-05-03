#!/usr/bin/env bash

DATE=$(date +"%Y-%m-%d")

FILE_DIR=$(dirname "$0")

## Update infos
$FILE_DIR/../scripts/api.sh

## Get new values
CURRENT_CITY=$(cat $FILE_DIR/../current_values/current_city)
CURRENT_TEMP=$(cat $FILE_DIR/../current_values/current_temp)
CURRENT_DESCRIPTION=$(cat $FILE_DIR/../current_values/current_description)
CURRENT_ICON=$(cat $FILE_DIR/../current_values/current_icon)

echo "$CURRENT_ICON $CURRENT_TEMPºC"
