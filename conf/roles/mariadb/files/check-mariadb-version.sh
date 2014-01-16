#!/bin/sh
# simple script to query the version of MariaDB, if installed.
#
# @return: MariaDB vesion; "0" if not available. 
#


line=$(mysql --version 2>&1)
#echo $line

if [[ $line =~ ([0-9]+\.[0-9]+\.[0-9]+)-MariaDB ]]; then
  version=${BASH_REMATCH[1]}
  echo $version

else
  echo "0"

fi
