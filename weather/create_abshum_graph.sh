#!/bin/bash
cd /mnt/flashdrive/weather
#$1 .... image name
#$2 .... diagram title
#$3 .... [day/week/month/year]
#$4 .... ds temp
#$5 .... ds hum
#$6 .... color
#$7 .... label
#
# Example: createabshumgraph.sh abshumday.png "Absolute Luftfeuchtigkeitsverlauf der letzten 24h" day temps1 hums1 0000ff Keller

case $3 in
        hour|day|week )
	cmt="\"            Wert\\n\""
	minmax="LINE1:hum_abs_${7}#000000:Aktuell GPRINT:hum_abs_${7}:LAST:\"%5.2lf g/m^3\\n\" AREA:hum_abs_${7}#$6 HRULE:${7}_absmin#0000ff:Minimum GPRINT:hum_abs_${7}:MIN:\"%5.2lf g/m^3\\n\" HRULE:${7}_absmax#ff0000:Maximum GPRINT:hum_abs_${7}:MAX:\"%5.2lf g/m^3\""
	;;
        month|year )
	cmt="\"            Spitzenwert\\n\""
	minmax="LINE1:hum_abs_${7}_min#0000ff:Minimum GPRINT:hum_abs_${7}_min:MIN:\"%5.2lf g/m^3\\n\" LINE1:hum_abs_${7}_max#ff0000:Maximum GPRINT:hum_abs_${7}_max:MAX:\"%5.2lf g/m^3\""
	;;
esac

bash -c "rrdtool graph ${1} \
  -w 800 -h 200 --title \"$2\" \
  -s \"now - 1 $3\" -e 'now' \
  -v \"g/m^3\" \
  COMMENT:$cmt \
  DEF:temp_avg_${7}=weather-new.rrd:$4:AVERAGE \
  DEF:hum_avg_${7}=weather-new.rrd:$5:AVERAGE \
  CDEF:sdd_${7}=10,LOG,7.5,temp_avg_${7},*,temp_avg_${7},237.3,+,/,*,EXP,6.1078,* \
  CDEF:dd_${7}=hum_avg_${7},100,/,sdd_${7},* \
  CDEF:hum_abs_${7}=100000,18.016,8314.3,/,*,dd_${7},temp_avg_${7},273.15,+,/,* \
  VDEF:${7}_absmin=hum_abs_${7},MINIMUM VDEF:${7}_absmax=hum_abs_${7},MAXIMUM \
  DEF:temp_avg_${7}_min=weather-new.rrd:$4:MIN \
  DEF:hum_avg_${7}_min=weather-new.rrd:$5:MIN \
  CDEF:sdd_${7}_min=10,LOG,7.5,temp_avg_${7}_min,*,temp_avg_${7}_min,237.3,+,/,*,EXP,6.1078,* \
  CDEF:dd_${7}_min=hum_avg_${7}_min,100,/,sdd_${7}_min,* \
  CDEF:hum_abs_${7}_min=100000,18.016,8314.3,/,*,dd_${7}_min,temp_avg_${7}_min,273.15,+,/,* \
  DEF:temp_avg_${7}_max=weather-new.rrd:$4:MAX \
  DEF:hum_avg_${7}_max=weather-new.rrd:$5:MAX \
  CDEF:sdd_${7}_max=10,LOG,7.5,temp_avg_${7}_max,*,temp_avg_${7}_max,237.3,+,/,*,EXP,6.1078,* \
  CDEF:dd_${7}_max=hum_avg_${7}_max,100,/,sdd_${7}_max,* \
  CDEF:hum_abs_${7}_max=100000,18.016,8314.3,/,*,dd_${7}_max,temp_avg_${7}_max,273.15,+,/,* \
  $minmax"
 # LINE1:hum_abs_${7}#000000 AREA:hum_abs_${7}#$6:$7  GPRINT:hum_abs_${7}:LAST:"%5.2lf g/m^3" GPRINT:hum_abs_${7}:MIN:"%5.2lf g/m^3" GPRINT:hum_abs_${7}:MAX:"%5.2lf g/m^3\n"




