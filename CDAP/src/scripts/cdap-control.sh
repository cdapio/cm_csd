#!/usr/bin/env bash

# Expects argument: [CDAP service]
SERVICE=$1

# Reads a line from a generated properties file in the format "$host:$key=$value", setting those variables.
function readconf {
  local conf
  IFS=':' read host conf <<< "${1}"
  IFS='=' read key value <<< "${conf}"
}

# Reads the 'peerConfig' generated kafka properties file and formulates the kafka quorum
function generate_kafka_quorum {
  local __seed_brokers=()
  for line in `cat ${KAFKA_PROPERTIES}`; do
    readconf "${line}"
    if [ "${key}" == "kafka.bind.port" ]; then
      __seed_brokers+=("${host}:${value}")
    fi
  done
  # Join array
  KAFKA_SEED_BROKERS=${__seed_brokers[@]}
  KAFKA_SEED_BROKERS=${KAFKA_SEED_BROKERS/ /,}
}

# Determine relevant CDAP component paths from sourced parcel variables
case ${SERVICE} in
  (auth-server)
    COMPONENT_HOME=${CDAP_AUTH_SERVER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_AUTH_SERVER_CONF_SCRIPT}
    ;;
  (kafka-server)
    COMPONENT_HOME=${CDAP_KAFKA_SERVER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_KAFKA_SERVER_CONF_SCRIPT}
    ;;
  (master)
    COMPONENT_HOME=${CDAP_MASTER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_MASTER_CONF_SCRIPT}
    ;;
  (router)
    COMPONENT_HOME=${CDAP_ROUTER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_ROUTER_CONF_SCRIPT}
    ;;
  (web-app)
    COMPONENT_HOME=${CDAP_WEB_APP_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_WEB_APP_CONF_SCRIPT}
    ;;
  (*)
    echo "Unknown service specified: ${SERVICE}"
    exit 1
    ;;
esac

# Source the CDAP common init functions
source ${COMPONENT_HOME}/bin/common.sh
source ${COMPONENT_HOME}/bin/common-env.sh

# Token replacement in CM-generated cdap-site.xml
# Hostname
HOSTNAME=`hostname`
sed -i -e "s#{{HOSTNAME}}#${HOSTNAME}#" ${CONF_DIR}/cdap-site.xml
# Zookeeper (ZK_QUORUM provided by CM)
sed -i -e "s#{{ZK_QUORUM}}#${ZK_QUORUM}#" ${CONF_DIR}/cdap-site.xml
# Kafka
generate_kafka_quorum
sed -i -e "s#{{KAFKA_SEED_BROKERS}}#${KAFKA_SEED_BROKERS}#" ${CONF_DIR}/cdap-site.xml
sed -i -e "s#{{LOCAL_DIR}}#${LOCAL_DIR}#" ${CONF_DIR}/cdap-site.xml

# Source CDAP Component config
source ${COMPONENT_CONF_SCRIPT}

# CDAP_CONF is used by Web-App to find cdap-site.xml
export CDAP_CONF=${CONF_DIR}

# Debug info
echo "CDAP_HOME: ${CDAP_HOME}"
echo "COMPONENT_HOME: ${COMPONENT_HOME}"
echo "COMPONENT_CONF_SCRIPT: ${COMPONENT_CONF_SCRIPT}"
echo "CONF_DIR: ${CONF_DIR}"
echo "ENV: `env`"

source $COMMON_SCRIPT
if [ "$cdap_principal" != "" ]; then
  export SCM_KERBEROS_PRINCIPAL=$cdap_principal
  acquire_kerberos_tgt cdap.keytab
fi

# Launch a cmd or a java app
if [ ${MAIN_CLASS} ]; then
  # Launch a java app

  # Set java
  JAVA=${JAVA_HOME}/bin/java

  # Set base classpath to include component and conf directory (CM provided)
  set_classpath ${COMPONENT_HOME} ${CONF_DIR}

  # Setup hive classpath if hive is installed, this has to be run after HBASE_CP is setup by set_classpath.
  set_hive_classpath

  # Include appropriate hbase_compat module in classpath
  set_hbase

  echo "`date` Starting Java service ${SERVICE} on `hostname`"
  "${JAVA}" -version
  echo "`ulimit -a`"
  echo "Using classpath: ${CLASSPATH}"

  exec "${JAVA}" -Dcdap.service=${SERVICE} "${JAVA_HEAPMAX}" \
    -Dexplore.conf.files=${EXPLORE_CONF_FILES} \
    -Dexplore.classpath=${EXPLORE_CLASSPATH} "${OPTS}" \
    -Duser.dir=${LOCAL_DIR} \
    -cp ${CLASSPATH} ${MAIN_CLASS} ${MAIN_CLASS_ARGS}

elif [ ${MAIN_CMD} ]; then
  # Launch a non-java app

  echo "`date` Starting service ${SERVICE} on ${HOSTNAME}"
  echo "`ulimit -a`"

  exec ${MAIN_CMD} ${MAIN_CMD_ARGS}
fi
