#!/bin/sh
# simple script to query the version of Redis, if installed.
#
# @return: Redis vesion; "0" if not available. 
#


line=$(redis-cli -v)
#echo $line


if [[ $line =~ ([0-9]+\.[0-9]+\.[0-9]+)$ ]]; then
  version=${BASH_REMATCH[1]}
  echo $version

else
  echo "0"

fi
