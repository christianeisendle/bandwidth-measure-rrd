#!/bin/bash
cd /mnt/flashdrive/weather
#$1 .... image name
#$2 .... diagram title
#$3 .... [day/week/month/year]
#$4 .... y-axis
#$5 .... DS
#$6 .... color
#$7 .... label
#$8 .... legend
#$9 .... lowerLimit
#$10 ... upperLimit
#
# Example: creategraph.sh tempday.png "Luftfeuchtigkeitsverlauf der letzten 24h" day "Grad Celcius" temp1 000000 Keller "Grad Celcius"

case $3 in
        hour|day|week )
	cmt="\"            Wert\\n\""
	minmax="LINE1:$5#000000:Aktuell GPRINT:$5:LAST:\"%5.2lf ${8}\\n\" AREA:$5#$6 HRULE:${5}_absmin#0000ff:Minimum GPRINT:${5}:MIN:\"%5.2lf ${8}\\n\" HRULE:${5}_absmax#ff0000:Maximum GPRINT:${5}:MAX:\"%5.2lf ${8}\""
	;;
        month|year )
	cmt="\"            Spitzenwert\\n\""
	minmax="LINE1:${5}_min#0000ff:Minimum GPRINT:${5}_min:MIN:\"%5.2lf ${8}\\n\" LINE1:${5}_max#ff0000:Maximum GPRINT:${5}_max:MAX:\"%5.2lf ${8}\""
	;;
esac
timespec="1 $3"

bash -c "rrdtool graph ${1} \
  -l $9 -u ${10} \
  -w 800 -h 200  --title \"$2\" \
  -s \"now - $timespec\" -e 'now' \
  -v \"$4\" \
  COMMENT:$cmt \
  DEF:$5=weather-new.rrd:$5:AVERAGE \
  VDEF:${5}_absmin=$5,MINIMUM VDEF:${5}_absmax=$5,MAXIMUM \
  DEF:${5}_min=weather-new.rrd:$5:MIN DEF:${5}_max=weather-new.rrd:$5:MAX \
  $minmax"
  #GPRINT:$5:LAST:"%5.2lf ${8}" GPRINT:${5}_min:MIN:"%5.2lf ${8}" GPRINT:${5}_max:MAX:"%5.2lf ${8}\n"

