#!/bin/bash

TEST=echo
#OUTPUT=`./capture_and_update_db_iperf3.sh`
OUTPUT="foooo"
UPLOAD=`echo $OUTPUT | awk -F: '{print $2}'`
DOWNLOAD=`echo $OUTPUT | awk -F: '{print $3}'`
if [ -z "$UPLOAD" ]; then
  echo "Can't get upload value, execution failed"
  exit 1
fi
if [ -z "$DOWNLOAD" ]; then
  echo "Can't get download value, execution failed"
  exit 2
fi
if [ "$UPLOAD" == "U" ]; then
  echo "Failed at upload check"
  exit 3
fi
if [ "$DOWNLOAD" == "U" ]; then
  echo "Failed at download check"
  exit 4
fi
