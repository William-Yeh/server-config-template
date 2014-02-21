#!/bin/bash

### BEGIN INIT INFO
# Provides:          SAMPLE
# Short-Description: node.js service
#
# Long-Description:
#   wrapper SYSV init script to facilitate Monit <--> Node.js app.
#
# @see       http://markhildreth.me/article/monit-without-pidfiles
# @see-also  https://github.com/nicokaiser/node-monit
#
### END INIT INFO

CHDIR="/home/{{APP_DEPLOYER}}/SAMPLE/" 

DAEMON=/usr/bin/node
DAEMON_ARGS="app-SAMPLE.js" 

PIDFILE=/var/run/SAMPLE/SAMPLE.pid

#USER="{{APP_DEPLOYER}}"


case $1 in
   start)
      echo $$ > ${PIDFILE};
      cd $CHDIR
      exec ${DAEMON} ${DAEMON_ARGS}  2>/dev/null
      #exec sudo -u ${USER} ${DAEMON} ${DAEMON_ARGS}  2>/dev/null
      ;;
    stop)
      #kill `cat ${PIDFILE}` ;;
      pkill -f app-one
      rm    -f ${PIDFILE}
      ;;
    *)
      echo "usage: app-one {start|stop}" ;;
esac
exit 0
