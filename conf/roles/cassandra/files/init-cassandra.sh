#!/bin/bash
# init script for Cassandra.
# chkconfig: 2345 90 10
# description: Cassandra
# script slightly modified from:
#   http://blog.milford.io/2010/06/installing-apache-cassandra-on-centos/
#
# @source http://www.geilthings.com/wiki/Cassandra
#

 
. /etc/rc.d/init.d/functions
 
CASS_USER="cassandra"
CASS_BIN=/usr/sbin/cassandra
NODETOOL_BIN=/usr/bin/nodetool

#CASS_HOME=/usr/share/cassandra
CASS_LOG=/var/log/cassandra/output.log
CASS_PID=/var/run/cassandra/cassandra.pid
 
if [ ! -f $CASS_BIN ]; then
  echo "File not found: $CASS_BIN"
  exit 1
fi
 
RETVAL=0
 
start() {
  if [ -f $CASS_PID ] && checkpid `cat $CASS_PID`; then
    echo "Cassandra is already running."
    exit 0
  fi

  echo -n $"Starting Cassandra: "
  touch $CASS_LOG
  chown $CASS_USER:$CASS_USER  $CASS_LOG
  daemon --user $CASS_USER $CASS_BIN -p $CASS_PID >> $CASS_LOG 2>&1
  usleep 500000
  RETVAL=$?
  if [ "$RETVAL" = "0" ]; then
    echo_success
  else
    echo_failure
  fi
  echo
  return $RETVAL
}

 
stop() {
  # check if the process is already stopped by seeing if the pid file exists.
  if [ ! -f $CASS_PID ]; then
    echo "Cassandra is already stopped."
    exit 0
  fi
  echo -n $"Stopping Cassandra: "


  #
  # graceful shutdown
  # @see http://devblog.michalski.im/2012/11/25/safe-cassandra-shutdown-and-restart/
  #
  $NODETOOL_BIN  disablegossip
  $NODETOOL_BIN  disablethrift
  $NODETOOL_BIN  drain


  # pkill -9 cassandra
  if kill `cat $CASS_PID`; then
    rm $CASS_PID
    RETVAL=0
    echo_success
  else
    RETVAL=1
    echo_failure
  fi

  echo
  [ $RETVAL = 0 ]
}

 
status_fn() {
  if [ -f $CASS_PID ] && checkpid `cat $CASS_PID`; then
    echo "Cassandra is running."
    exit 0
  else
    echo "Cassandra is stopped."
    exit 1
  fi
}

 
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status_fn
    ;;
  restart)
    stop
	usleep 500000
    start
    ;;
  *)
    echo $"Usage: $prog {start|stop|restart|status}"
    RETVAL=3
esac
 
exit $RETVAL

