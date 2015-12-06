#!/bin/bash
#$1 .... image name
#$2 .... diagram title
#$3 .... [day/week/month/year]
#$4 .... color
#$5 .... label
case $3 in
	"hour" )
	sc=300 
	unit="5min"
	totalunit="h" ;;
	"day" )
	sc=300
	totalunit="24h"
	unit="5min" ;;
	"week" )
	sc=3600 
	totalunit="Woche"
	unit="h" ;;
	"month" )
	sc=86400 
	totalunit="Monat"
	unit="tag" ;;
	"year" )
	sc=86400 
	totalunit="Jahr"
	unit="tag" ;;
esac
#
# Example: create_rain_graph.sh rainday.png "Regen in den letzten 24h" day 0000ff Kombi
rrdtool graph ${1} \
  --title "$2" \
  -s "now - 1 $3" -e 'now' \
  -w 800 -h 200 -X 0 -v "mm" \
  COMMENT:"            Wert\n" \
  DEF:rains9=weather-new.rrd:rains9:AVERAGE \
  CDEF:rain=rains9,0.295,* \
  CDEF:rainpd=rain,$sc,* \
  VDEF:raintotal=rain,TOTAL \
  VDEF:rain_max=rainpd,MAXIMUM \
  LINE1:rainpd#000000:Aktuell GPRINT:rainpd:LAST:"%5.2lf mm/$unit\n" AREA:rainpd#$4 HRULE:rain_max#ff0000:Maximum GPRINT:rain_max:"%5.2lf mm/$unit\n" GPRINT:raintotal:"  Summe    %5.2lf mm/$totalunit"

