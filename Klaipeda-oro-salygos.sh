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

PART_OF_HTML=$(curl -s https://portofklaipeda.lt/uostas/oro-salygos/ | grep -Ezo 'port_weather_header_title.*port_weather_wind_speed_chart_title'| sed '1,14d;25,60d')
#| sed -r 's/\s+//g'
#echo "$WSKLP_NUM"
#echo "$WIND_DIR_LYKLP/$WIND_SPEED_LYKLP=${WSKLP_KT}kt"
echo "$PART_OF_HTML" | awk '
    NR == 1 { WIND_DIR_LYKLP = $1 }
    END { WIND_SPEED_LYKLP = $1 * '$MS_CONVERSION_KT' }
    END { printf("%.0f/%.0fkt\n", WIND_DIR_LYKLP, WIND_SPEED_LYKLP) }
'
#echo "$PART_OF_HTML"
