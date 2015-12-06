#!/bin/bash
# Receive remote weather data from USB-WDE1 and store it into database

# Loop forever to read data from USB-WDE1
#stty -F /dev/ttyUSB0 speed 9600 cs8 -cstopb -parenb > /dev/null
oldrain=0
maxdiff=20
currtime=`date +%s`
intervall=300
timetoupdate=0
windpeak=0
while true
do
	stty < /dev/ttyUSB0 9600 -brkint -opost -onlcr -echo
	read line < /dev/ttyUSB0
	if [[ "${line%%;*}" == '$1' ]] ; then
        	# format data
		logger weather-serial $line
        	tmp=`echo "${line#?1;1;}" | tr ';,' ':.'`
	        data=`echo "N${tmp%%0}" | sed 's/::/:U:/g' | sed 's/::/:U:/g'`
        	data=${data%%:}
		currain=`echo $data | cut -d ':' -f21`
		if [[ "$currain" == 'U' ]] ; then
			currain=$oldrain
		fi
		if [ $oldrain -eq 0 ]; then
			oldrain=$currain
		fi
		logger weather-serial-rain "Old: $oldrain Current: $currain"
		diff=`expr $currain - $oldrain`
		if [ $diff -lt $maxdiff ]; then
			oldrain=$currain
			datatowrite=$data
		else
			logger weather-serial-rain "Filtered wrong data! Diff: $diff"
		fi
	fi
	currwind=`echo $datatowrite | cut -d ':' -f20`
	if [ `echo "$currwind > $windpeak" | bc` -eq 1 ] ; then
		logger weather-serial-wind "New wind-peak: $currwind"
		windpeak=$currwind
	fi
	currtime=`date +%s`
	if [ $currtime -gt $timetoupdate ] ; then
		timetoupdate=`expr $intervall + $currtime`
		temp=`echo $datatowrite | cut -d ':' -f18`
		hum=`echo $datatowrite | cut -d ':' -f19`
		substring="${temp}:${hum}:${currwind}"
		replacement="${temp}:${hum}:${windpeak}"
		datatowrite=${datatowrite/$substring/$replacement}
		logger weather $datatowrite
		echo "Temperatur: ${temp}°C, Luftfeuchtigkeit: ${hum}%, Wind: ${windpeak}km/h" > /mnt/weather/temp.txt
		rrdtool update /mnt/flashdrive/weather/weather.rrd $datatowrite
		rrdtool update /mnt/flashdrive/weather/weather-new.rrd $datatowrite
		rrdtool update /mnt/flashdrive/weather/weather-test.rrd $datatowrite
		windpeak=0
	fi
done
