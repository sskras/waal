#!/bin/bash

URL="https://portofklaipeda.lt/uostas/oro-salygos/"
MS_CONVERSION_KT=1.94

FULL_HTML=$(curl -s $URL) 2>/dev/null

[[ $FULL_HTML =~ port_weather_header_title.*port_weather_wind_speed_chart_title ]] ||
{
    echo "$0: Pattern not found in the HTML"
    exit 1
}

while read LINE
do
    (( LINE_NUM++ ))
    [ $LINE_NUM = 15 ] && read WIND_DIR_LYKLP   UNITS <<< "$LINE"
    [ $LINE_NUM = 24 ] && read WIND_SPEED_LYKLP UNITS <<< "$LINE"
done <<< ${BASH_REMATCH[@]}

WSKLP_KT=$(bc <<< "scale=2; $WIND_SPEED_LYKLP * $MS_CONVERSION_KT")

printf "%.0f/%.2fkt\n" $WIND_DIR_LYKLP $WIND_SPEED_LYKLP
