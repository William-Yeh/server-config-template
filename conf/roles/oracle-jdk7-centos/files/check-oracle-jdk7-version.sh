#!/bin/sh
# simple script to query the version of Oracle(Sun) JDK 1.7, if installed.
#
# @return: JDK 1.7 vesion; "0" if not available. 
#


line=$(rpm -q jdk)
#line=$(rpm -q jdk-1.7.0_19)
#echo $line


if [[ $line =~ jdk-(1\.7\.[0-9]+_[0-9]+) ]]; then
  version=${BASH_REMATCH[1]}
  echo $version

else
  echo "0"

fi
