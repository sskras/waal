#!/bin/bash

FULL_HTML=""
PART_OF_HTML=""
WIND_DIR_LYKLP=""
WIND_SPEED_LYKLP=""
MS_CONVERSION_KT=1.94
WSKLP_NUM=""
WSKLP_KT=""
#FULL_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/)
#FULL_HTML=$(wget -q --output-document - https://portofklaipeda.lt/uostas/oro-salygos/ | tr -d '\000')
#TMP=$(echo "$FULL_HTML" )

PART_OF_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/ | grep -Ezo 'port_weather_header_title.*port_weather_wind_speed_chart_title'| sed -n '15p; 24p')
#| sed -r 's/\s+//g'

{
    read WIND_DIR_LYKLP UNITS
    read WIND_SPEED_LYKLP UNITS
} <<< $PART_OF_HTML

WSKLP_KT=$(bc <<< "scale=2; $WIND_SPEED_LYKLP * $MS_CONVERSION_KT")
#echo "$WIND_DIR_LYKLP/$WIND_SPEED_LYKLP=${WSKLP_KT}kt"
echo "$WIND_DIR_LYKLP/${WSKLP_KT}kt"
#echo "$PART_OF_HTML"
