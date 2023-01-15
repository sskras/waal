#!/bin/bash

round ()
{
    awk '{ printf("%.0f", $1) }'
}

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

PART_OF_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/ | grep -Ezo 'port_weather_header_title.*port_weather_wind_speed_chart_title'| sed '1,14d;25,60d')
#| sed -r 's/\s+//g'
WIND_DIR_LYKLP=$(echo "$PART_OF_HTML" | awk '{ printf("%.0f", $1); exit }')
WIND_SPEED_LYKLP=$(echo "$PART_OF_HTML" | awk 'END { printf("%.2f", $1) }')
#echo "$WSKLP_NUM"
WSKLP_KT=$(echo "scale=2; $WIND_SPEED_LYKLP * $MS_CONVERSION_KT" | bc | round)
#echo "$WIND_DIR_LYKLP/$WIND_SPEED_LYKLP=${WSKLP_KT}kt"
echo "$WIND_DIR_LYKLP/${WSKLP_KT}kt"
#echo "$PART_OF_HTML"
