#!/bin/bash

MS_CONVERSION_KT=1.94

FULL_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/)
PART_OF_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/ | grep -zo 'port_weather_header_title.*port_weather_wind_speed_chart_title')

[[ $FULL_HTML =~ (port_weather_header_title.*port_weather_wind_speed_chart_title) ]] || exit

while read LINE
do
    (( LINE_NUM++ ))
    [ $LINE_NUM = 15 ] && read WIND_DIR_LYKLP   UNITS <<< "$LINE"
    [ $LINE_NUM = 24 ] && read WIND_SPEED_LYKLP UNITS <<< "$LINE"
done <<< ${BASH_REMATCH[1]}

WSKLP_KT=$(bc <<< "scale=2; $WIND_SPEED_LYKLP * $MS_CONVERSION_KT")

printf "%.0f/%.2fkt\n" $WIND_DIR_LYKLP $WIND_SPEED_LYKLP
