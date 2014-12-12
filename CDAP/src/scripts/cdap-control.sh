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

# set the conf dir to cloudera managers agent directory for this process
export CDAP_CONF=$CONF_DIR

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
