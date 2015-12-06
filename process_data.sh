#!/bin/bash
lock /tmp/weather.lock
read data < /tmp/weather.log
temp=`cat /tmp/weather.log | cut -d ':' -f18`
hum=`cat /tmp/weather.log | cut -d ':' -f19`
echo "Temperatur: ${temp}°C, Luftfeuchtigkeit: ${hum}%" > /mnt/weather/temp.txt
lock -u /tmp/weather.lock
logger weather $data
rrdtool update /mnt/flashdrive/weather/weather.rrd $data
rrdtool update /mnt/flashdrive/weather/weather-new.rrd $data
