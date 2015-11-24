#!/bin/sh
. ./bandwidth.cfg
if [ -z $BW_DATABASE_NAME ]; then 
  BW_DATABASE_NAME=bandwidth.rrd
fi
if [ -z $BW_PERIOD_IN_SEC ]; then 
  BW_PERIOD_IN_SEC=5
fi
us=`iperf3 -c ${BW_IPERF_SERVER} -t ${BW_PERIOD_IN_SEC} -J -O2 | jq '.end.sum_received.bytes' | awk -v period=${BW_PERIOD_IN_SEC} '{ printf("%ld", ($0 * 8) / period)}'`
ds=`iperf3 -c ${BW_IPERF_SERVER} -t ${BW_PERIOD_IN_SEC} -J -R -O2 | jq '.end.sum_received.bytes' | awk -v period=${BW_PERIOD_IN_SEC} '{ printf("%ld", ($0 * 8) / period)}'`
if [ $us -eq 0 ]; then us="U"; fi
if [ $ds -eq 0 ]; then ds="U"; fi
${TEST} /usr/bin/rrdtool update $BW_DATABASE_NAME "N:$us:$ds"
