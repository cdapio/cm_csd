#!/bin/bash

# expects arguments [package] [service] [action]
PACKAGE=$1
SERVICE=$2
CMD=$3

MY_ENV=`env`

echo "**************** ENVIRONMENT **************"
echo $MY_ENV
echo "*******************************************"
echo "ZOOKEEPER? $ZK_QUORUM"
case $CMD in
  (start)
    echo "Starting the CDAP ${SERVICE} service"
    echo "CDAP_HOME: ${CDAP_HOME}"
    exec $CDAP_HOME/$PACKAGE/bin/service $CMD $SERVICE
    ;;
  (*)
    echo "Don't understand [$CMD]"
    ;;
esac
