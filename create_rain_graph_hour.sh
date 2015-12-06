#!/bin/bash
#$1 .... image name
#$2 .... diagram title
#$3 .... [day/week/month/year]
#$4 .... color
#$5 .... label

#
# Example: create_rain_graph.sh rainday.png "Regen in den letzten 24h" day 0000ff Kombi
rrdtool graph ${1} \
  --title "$2" \
  -s "now - 1 $3" -e 'now' \
  -X 0 -v "mm" \
  COMMENT:"Ort       Aktuell         Summe\n" \
  DEF:rains9=weather-new.rrd:rains9:AVERAGE \
  CDEF:rain=rains9,0.295,* \
  CDEF:rainpd=rain,300,* \
  VDEF:raintotal=rain,TOTAL \
  LINE1:rainpd#000000 AREA:rainpd#$4:$5  GPRINT:rainpd:LAST:"%5.2lf mm/5min" GPRINT:raintotal:"%5.2lf mm/24h"
