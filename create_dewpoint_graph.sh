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
# Example: create_dewpoint_graph.sh dewpointday.png "Taupunktverlauf der letzten 24h" day temps1 hums1 0000ff Keller
case $3 in
        hour|day|week )
	cmt="\"            Wert\\n\""
	minmax="LINE1:dew_point_${7}#000000:Aktuell GPRINT:dew_point_${7}:LAST:\"%5.2lf Grad C\\n\" AREA:dew_point_${7}#$6 HRULE:${7}_absmin#0000ff:Minimum GPRINT:dew_point_${7}:MIN:\"%5.2lf Grad C\\n\" HRULE:${7}_absmax#ff0000:Maximum GPRINT:dew_point_${7}:MAX:\"%5.2lf Grad C\""
	;;
        month|year )
	cmt="\"            Spitzenwert\\n\""
	minmax="LINE1:dew_point_${7}_min#0000ff:Minimum GPRINT:dew_point_${7}_min:MIN:\"%5.2lf Grad C\\n\" LINE1:dew_point_${7}_max#ff0000:Maximum GPRINT:dew_point_${7}_max:MAX:\"%5.2lf Grad C\""
	;;
esac

bash -c "rrdtool graph ${1} \
  --title \"$2\" \
  -w 800 -h 200 -s \"now - 1 $3\" -e 'now' \
  -v \"Grad C\" \
  COMMENT:$cmt \
  DEF:temp_avg_${7}=weather-new.rrd:$4:AVERAGE \
  DEF:hum_avg_${7}=weather-new.rrd:$5:AVERAGE \
  CDEF:sdd_${7}=10,LOG,7.5,temp_avg_${7},*,temp_avg_${7},237.3,+,/,*,EXP,6.1078,* \
  CDEF:dd_${7}=hum_avg_${7},100,/,sdd_${7},* \
  CDEF:v_${7}=dd_${7},6.1078,/,LOG,10,LOG,/ \
  CDEF:dew_point_${7}=237.3,v_${7},*,7.5,v_${7},-,/ \
  VDEF:${7}_absmin=dew_point_${7},MINIMUM VDEF:${7}_absmax=dew_point_${7},MAXIMUM \
  DEF:temp_avg_${7}_min=weather-new.rrd:$4:MIN \
  DEF:hum_avg_${7}_min=weather-new.rrd:$5:MIN \
  CDEF:sdd_${7}_min=10,LOG,7.5,temp_avg_${7}_min,*,temp_avg_${7}_min,237.3,+,/,*,EXP,6.1078,* \
  CDEF:dd_${7}_min=hum_avg_${7}_min,100,/,sdd_${7}_min,* \
  CDEF:v_${7}_min=dd_${7}_min,6.1078,/,LOG,10,LOG,/ \
  CDEF:dew_point_${7}_min=237.3,v_${7}_min,*,7.5,v_${7}_min,-,/ \
  DEF:temp_avg_${7}_max=weather-new.rrd:$4:MAX \
  DEF:hum_avg_${7}_max=weather-new.rrd:$5:MAX \
  CDEF:sdd_${7}_max=10,LOG,7.5,temp_avg_${7}_max,*,temp_avg_${7}_max,237.3,+,/,*,EXP,6.1078,* \
  CDEF:dd_${7}_max=hum_avg_${7}_max,100,/,sdd_${7}_max,* \
  CDEF:v_${7}_max=dd_${7}_max,6.1078,/,LOG,10,LOG,/ \
  CDEF:dew_point_${7}_max=237.3,v_${7}_max,*,7.5,v_${7}_max,-,/ \
  $minmax"
#  LINE1:dew_point_${7}#000000 AREA:dew_point_${7}#$6:$7  GPRINT:dew_point_${7}:LAST:"%5.2lf Grad C" GPRINT:dew_point_${7}:MIN:"%5.2lf Grad C" GPRINT:dew_point_${7}:MAX:"%5.2lf Grad C\n""


