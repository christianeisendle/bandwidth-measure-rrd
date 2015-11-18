#!/bin/sh
BW_DATABASE_NAME=bandwidth.rrd
. ./bandwidth.cfg
us=`iperf3 -c ${BW_IPERF_SERVER} -t 5 -J | jq '.end.sum_received.bytes' | awk '{ printf("%d", ($1 * 8) / 5)}'`
ds=`iperf3 -c ${BW_IPERF_SERVER} -t 5 -J -R | jq '.end.sum_received.bytes' | awk '{ printf("%d", ($1 * 8) / 5)}'`
if [ $us -eq 0 ]; then us="U"; fi
if [ $ds -eq 0 ]; then ds="U"; fi
/usr/bin/rrdtool update $BW_DATABASE_NAME "N:$us:$ds"
