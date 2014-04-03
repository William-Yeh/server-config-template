#!/bin/sh
# simple script to query the version of Ant, if installed.
#
# @return: Ant vesion; "0" if not available. 
#


line=$(ant -version)
echo $line


if [[ $line =~ ([0-9]+\.[0-9]+\.[0-9]+) ]]; then
  version=${BASH_REMATCH[1]}
  echo $version

else
  echo "0"

fi
