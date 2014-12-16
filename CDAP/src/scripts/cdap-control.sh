#!/usr/bin/env bash

# expects arguments [package] [service] [action]
PACKAGE=$1
SERVICE=$2
CMD=$3

# Reads a line in the format "$host:$key=$value", setting those variables.
function readconf {
  local conf
  IFS=':' read host conf <<< "$1"
  IFS='=' read key value <<< "$conf"
}

function generate_kafka_quorum {
  local __seed_brokers=()
  for line in `cat $KAFKA_PROPERTIES` ; do
    readconf "$line"
    if [ $key == "kafka.bind.port" ]; then
      __seed_brokers+=("$host:$value")
    fi
  done
  # join array
  KAFKA_SEED_BROKERS=$(printf ",%s" "${__seed_brokers[@]}")
  KAFKA_SEED_BROKERS=${KAFKA_SEED_BROKERS:1}
}

echo "PWD: `pwd`"

# source common functions from CDAP init framework to reuse here
source $CDAP_HOME/$PACKAGE/bin/common.sh
source $CDAP_HOME/$PACKAGE/bin/common-env.sh

# cdap-site.xml token variable substutions
perl -pi -e "s#{{ZK_QUORUM}}#${ZK_QUORUM}#" ${CONF_DIR}/cdap-site.xml

generate_kafka_quorum
perl -pi -e "s#{{KAFKA_SEED_BROKERS}}#${KAFKA_SEED_BROKERS}#" ${CONF_DIR}/cdap-site.xml

HOSTNAME=`hostname`
perl -pi -e "s#{{HOSTNAME}}#${HOSTNAME}#" ${CONF_DIR}/cdap-site.xml


# set the conf dir to cloudera managers agent directory for this process
export CDAP_CONF=$CONF_DIR

export CDAP_COMPONENT_HOME=${CDAP_HOME}/${PACKAGE}

# pull in CDH environment vars
export HADOOP_HOME=$CDH_HADOOP_HOME
export HBASE_HOME=$CDH_HBASE_HOME
export YARN_HOME=$CDH_YARN_HOME


echo "*** attempting to source ${CDAP_HOME}/${PACKAGE}/conf/${SERVICE}-env.sh"
# source the service-specific conf to get $MAIN_CLASS or $MAIN_CMD
if [ -f ${CDAP_HOME}/${PACKAGE}/conf/${SERVICE}-env.sh ]; then
  . ${CDAP_HOME}/${PACKAGE}/conf/${SERVICE}-env.sh
fi

echo "MAIN_CLASS: $MAIN_CLASS"
echo "MAIN_CMD: $MAIN_CMD"


if [ $MAIN_CLASS ]; then
  # launch a java app

  # set java
  JAVA=$JAVA_HOME/bin/java

  set_classpath $CDAP_COMPONENT_HOME $CDAP_CONF

  # Setup hive classpath if hive is installed, this has to be run after HBASE_CP is setup by set_classpath.
  set_hive_classpath

  set_hbase

  echo "`date` Starting Java service $SERVICE on `hostname`"
  "$JAVA" -version
  echo "`ulimit -a`"

  exec "$JAVA" -Dcdap.service=$SERVICE "$JAVA_HEAPMAX" \
    -Dexplore.conf.files=$EXPLORE_CONF_FILES \
    -Dexplore.classpath=$EXPLORE_CLASSPATH "$OPTS" \
    -Duser.dir=$LOCAL_DIR \
    -cp $CLASSPATH $MAIN_CLASS $MAIN_CLASS_ARGS 

elif [ $MAIN_CMD ]; then
  # launch a non-java app

  echo "`date` Starting service $SERVICE on `hostname`"
  echo "`ulimit -a`"

  exec $MAIN_CMD $MAIN_CMD_ARGS

fi



#case $CMD in
#  (start)
#    echo "Starting the CDAP ${SERVICE} service"
#    echo "CDAP_HOME: ${CDAP_HOME}"
#    exec $CDAP_HOME/$PACKAGE/bin/service $CMD $SERVICE
#    ;;
#  (*)
#    echo "Don't understand [$CMD]"
#    ;;
#esac
