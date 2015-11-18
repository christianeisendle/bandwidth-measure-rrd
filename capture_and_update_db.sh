#!/bin/sh
BW_DATABASE_NAME=bandwidth.rrd
. ./bandwidth.cfg
val=`iperf -c ${BW_IPERF_SERVER} -r -t 5 -y c | awk -F "," 'BEGIN {printf("N:"); cnt = 0;} {if (cnt++ == 1) printf(":"); printf("%d", $9)}'`
/usr/bin/rrdtool update $BW_DATABASE_NAME $val
