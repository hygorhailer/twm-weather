#!/usr/bin/env bash

## Open Weather API
API_KEY=$OPEN_WEATHER_API # Set your API here or use an environment variable

## Get the file directory
FILE_DIR=$(dirname "$0")

## Get date
DATE=$(date +"%Y-%m-%d")

## Get the current city
CURRENT_CITY=$(cat $FILE_DIR/../current_values/current_city)
CURRENT_CITY_CODE=$(grep "$CURRENT_CITY" $FILE_DIR/../dataset/brazil_cities | cut -d"|" -f1)

## Set temperature
TEMP=$(curl -s "http://api.openweathermap.org/data/2.5/weather?id=$CURRENT_CITY_CODE&units=metric&appid=$API_KEY" | jq -r '.main.temp' | cut -d'.' -f1)

## Set description
DESCRIPTION=$(curl -s "http://api.openweathermap.org/data/2.5/weather?id=$CURRENT_CITY_CODE&units=metric&appid=$API_KEY" | jq -r '.weather[0].description') 

## Set icon
ICON_CODE=$(curl -s "http://api.openweathermap.org/data/2.5/weather?id=$CURRENT_CITY_CODE&units=metric&appid=$API_KEY" | jq -r '.weather[0].icon') 

## Filling the files with the current values
echo $TEMP > $FILE_DIR/../current_values/current_temp
echo $DESCRIPTION > $FILE_DIR/../current_values/current_description
grep "$ICON_CODE" $FILE_DIR/../dataset/icons | cut -d'|' -f1 > $FILE_DIR/../current_values/current_icon
