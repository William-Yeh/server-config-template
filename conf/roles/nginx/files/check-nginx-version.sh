#!/bin/sh
# simple script to query the version of Nginx, if installed.
#
# @return: Nginx vesion; "0" if not available. 
#


line=$(nginx -v 2>&1)
#echo $line


if [[ $line =~ ([0-9]+\.[0-9]+\.[0-9]+)$ ]]; then
  version=${BASH_REMATCH[1]}
  echo $version

else
  echo "0"

fi
