#!/bin/bash

MS_CONVERSION_KT=1.94

curl -s https://portofklaipeda.lt/uostas/oro-salygos/ | awk '
    /port_weather_header_title/ { BLOCK_START = NR }
    !BLOCK_START { next }
    NR == BLOCK_START + 14 { WIND_DIR_LYKLP = $1 }
    NR == BLOCK_START + 23 { WIND_SPEED_LYKLP = $1 * '$MS_CONVERSION_KT' }
    END { printf("%.0f/%.0fkt\n", WIND_DIR_LYKLP, WIND_SPEED_LYKLP) }
'
