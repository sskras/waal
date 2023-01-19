#!/bin/bash

MS_CONVERSION_KT=1.94

PART_OF_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/ | grep -zo 'port_weather_header_title.*port_weather_wind_speed_chart_title')

while read LINE
do
    (( LINE_NUM++ ))
    [ $LINE_NUM = 15 ] && read WIND_DIR_LYKLP   UNITS <<< "$LINE"
    [ $LINE_NUM = 24 ] && read WIND_SPEED_LYKLP UNITS <<< "$LINE"
done <<< $PART_OF_HTML

WSKLP_KT=$(bc <<< "scale=2; $WIND_SPEED_LYKLP * $MS_CONVERSION_KT")

echo "$WIND_DIR_LYKLP/${WSKLP_KT}kt"
