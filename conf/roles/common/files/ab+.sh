#!/bin/bash
# ab+ - Incremental benchmarking utility
# @see http://blog.brandonc.me/2013/04/ab.html
#
#
# os and network tuning
# ulimit -n 100000
# sudo echo "2048 64512" > /proc/sys/net/ipv4/ip_local_port_range
# sudo echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle
# sudo echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse
# sudo echo "10" > /proc/sys/net/ipv4/tcp_fin_timeout
AB_PATH=`which ab`
SS_PATH=`which ss`
 
LOW_CONCURRENCY=100
HIGH_CONCURRENCY=10000
CONCURRENCY_STEP=100
NUM_CALL=100
 
HOST=`echo $@ | perl -ne '/http.*?:\/\/([^\/?:#]*)/; print $1'`
PREFIX=$HOST`date +"_%Y%m%d_%H%M"`
OUTPUT_FILE=$PREFIX.csv
MAX_OPEN_FILES=`ulimit -n`
 
trap "exit;" SIGINT SIGTERM
 
if [ $MAX_OPEN_FILES -le $HIGH_CONCURRENCY ]; then
	echo "Warning: open file limit < HIGH_CONCURRENCY"
	exit 1
fi
 
echo "Start benchmark"
 
mkdir -p temp/$PREFIX
 
echo "#$AB_PATH -c CONCURRENCY=($LOW_CONCURRENCY to $HIGH_CONCURRENCY step $CONCURRENCY_STEP) -n NUM=($NUM_CALL*CONCURRENCY) $@" | tee $OUTPUT_FILE

echo "#start time,concurrency,complete requests,failed requests,tps,min,mean,stddev,median,max,90%,95%,99%" | tee -a $OUTPUT_FILE

for (( concurrency=$LOW_CONCURRENCY; concurrency<=$HIGH_CONCURRENCY; concurrency+=$CONCURRENCY_STEP ))
do
	tempFile="temp/$PREFIX/c$concurrency-n$((NUM_CALL*concurrency)).log"
	echo "$AB_PATH -c $concurrency -n $((NUM_CALL*concurrency)) $@" >$tempFile
	startTime=`date`
	$AB_PATH -c $concurrency -n $((NUM_CALL*concurrency)) $@ >>$tempFile 2>&1

	if [ $? -ne 0 ]; then
		echo "Error: please check $tempFile"
		exit 1
	fi

	duration=$startTime,$concurrency
	stats=`egrep "Complete requests:|Failed requests:|Requests per second:|Total:" $tempFile | perl -pe 's/[^\d\.]+/ /g; s/^\s+//g;' | perl -pe 's/\s+$//g; s/\s+/,/g'`
	histogram=`egrep "90%|95%|99%" $tempFile | cut -c6- | perl -pe 's/[^\d\.]+/ /g; s/^\s+//g;' | perl -pe 's/\s+$//g; s/\s+/,/g'`

	echo "$duration,$stats,$histogram" | tee -a $OUTPUT_FILE

	tcpConnections=`ss -s | egrep 'TCP:' | perl -ne '/(\d+)/; print $1'`
	while [ $((tcpConnections+concurrency+CONCURRENCY_STEP)) -ge $MAX_OPEN_FILES ]
	do
		sleep 1
		tcpConnections=`ss -s | egrep 'TCP:' | perl -ne '/(\d+)/; print $1'`
	done
done
 
rm -rf temp
 
echo "Finshed benchmark, see $OUTPUT_FILE"

