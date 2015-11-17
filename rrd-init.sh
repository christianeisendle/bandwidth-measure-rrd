#!/bin/sh

rrdtool create weather.rrd --step 600 \
DS:upstream:GAUGE:900:0:1000000000 \
DS:downstream:GAUGE:900:0:1000000000 \
RRA:AVERAGE:0.5:1:1440 \
RRA:MIN:0.5:144:3600 \
RRA:MAX:0.5:144:3600 \
RRA:AVERAGE:0.5:144:3600
