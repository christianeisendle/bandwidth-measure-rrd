#!/bin/sh
. ./bandwidth.cfg
if [ -z $BW_DATABASE_NAME ]; then 
  BW_DATABASE_NAME=bandwidth.rrd
fi
us=`iperf3 -c ${BW_IPERF_SERVER} -t 5 -J -O2 | jq '.end.sum_received.bytes' | awk '{ printf("%ld", ($0 * 8) / 5)}'`
ds=`iperf3 -c ${BW_IPERF_SERVER} -t 5 -J -R -O2 | jq '.end.sum_received.bytes' | awk '{ printf("%ld", ($0 * 8) / 5)}'`
if [ $us -eq 0 ]; then us="U"; fi
if [ $ds -eq 0 ]; then ds="U"; fi
/usr/bin/rrdtool update $BW_DATABASE_NAME "N:$us:$ds"
