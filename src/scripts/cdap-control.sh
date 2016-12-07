#!/usr/bin/env bash

# Copyright © 2015-2016 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

# Expects argument: [CDAP service]
SERVICE=${1}

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
    if [ "${key}" == "kafka.server.port" ]; then
      __seed_brokers+=("${host}:${value}")
    fi
  done
  # Join array
  KAFKA_SEED_BROKERS=${__seed_brokers[@]}
  KAFKA_SEED_BROKERS=${KAFKA_SEED_BROKERS// /,}
}

function substitute_cdap_site_tokens {
  local __cdap_site=${1}
  generate_kafka_quorum
  sed -i -e "s#{{HOSTNAME}}#${HOSTNAME}#" -e "s#{{ZK_QUORUM}}#${ZK_QUORUM}#" \
    -e "s#{{KAFKA_SEED_BROKERS}}#${KAFKA_SEED_BROKERS}#" -e "s#{{LOCAL_DIR}}#${LOCAL_DIR}#" \
    -e "s#{{COMPONENT_HOME}}#${COMPONENT_HOME}#" ${__cdap_site}

  if [[ "${cdap_principal}" != "" ]]; then
    # Kerberos is enabled, update cdap-site.xml keytab and principal settings
    sed -i -e "s#{{CDAP_MASTER_KERBEROS_PRINCIPAL}}#${cdap_principal}#" \
      -e "s#{{CDAP_MASTER_KERBEROS_KEYTAB}}#${CONF_DIR}/cdap.keytab#" \
      ${__cdap_site}
  else
    # Remove cdap-site.xml keytab and principal settings
    sed -i -e "s#{{CDAP_MASTER_KERBEROS_PRINCIPAL}}##" -e "s#{{CDAP_MASTER_KERBEROS_KEYTAB}}##" ${__cdap_site}
  fi
}

# Determine relevant CDAP component paths from sourced parcel variables
case ${SERVICE} in
  (auth-server)
    COMPONENT_HOME=${CDAP_AUTH_SERVER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_AUTH_SERVER_CONF_SCRIPT}
    MAIN_CLASS=co.cask.cdap.security.runtime.AuthenticationServerMain
    MAIN_CLASS_ARGS=
    JAVA_HEAP_VAR=AUTH_JAVA_HEAPMAX
    AUTH_JAVA_HEAPMAX=${AUTH_JAVA_HEAPMAX:--Xmx1024m}
    EXTRA_CLASSPATH="${EXTRA_CLASSPATH}:/etc/hbase/conf/"
    ;;
  (kafka-server)
    COMPONENT_HOME=${CDAP_KAFKA_SERVER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_KAFKA_SERVER_CONF_SCRIPT}
    MAIN_CLASS=co.cask.cdap.kafka.run.KafkaServerMain
    MAIN_CLASS_ARGS=
    JAVA_HEAP_VAR=KAFKA_JAVA_HEAPMAX
    KAFKA_JAVA_HEAPMAX=${KAFKA_JAVA_HEAPMAX:--Xmx1024m}
    ;;
  (master)
    COMPONENT_HOME=${CDAP_MASTER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_MASTER_CONF_SCRIPT}
    MAIN_CLASS=co.cask.cdap.data.runtime.main.MasterServiceMain
    MAIN_CLASS_ARGS="start"
    JAVA_HEAP_VAR=MASTER_JAVA_HEAPMAX
    MASTER_JAVA_HEAPMAX=${MASTER_JAVA_HEAPMAX:--Xmx1024m}
    EXTRA_CLASSPATH="${EXTRA_CLASSPATH}:/etc/hbase/conf/"
    ;;
  (router)
    COMPONENT_HOME=${CDAP_ROUTER_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_ROUTER_CONF_SCRIPT}
    MAIN_CLASS=co.cask.cdap.gateway.router.RouterMain
    MAIN_CLASS_ARGS=
    JAVA_HEAP_VAR=ROUTER_JAVA_HEAPMAX
    ROUTER_JAVA_HEAPMAX=${ROUTER_JAVA_HEAPMAX:--Xmx1024m}
    ;;
  (ui)
    COMPONENT_HOME=${CDAP_UI_HOME}
    COMPONENT_CONF_SCRIPT=${CDAP_UI_CONF_SCRIPT}
    MAIN_CMD=node
    if test -x ${CDAP_HOME}/ui/bin/node ; then
      ${CDAP_HOME}/ui/bin/node --version >/dev/null 2>&1
      if [ $? -eq 0 ] ; then
        MAIN_CMD=${CDAP_HOME}/ui/bin/node
      elif [[ $(which node 2>/dev/null) ]]; then
        MAIN_CMD=node
      else
        echo "Unable to locate Node.js binary (node), is it installed and in the PATH?"
        exit 1
      fi
    fi
    export NODE_ENV=production
    MAIN_CMD_ARGS="${CDAP_HOME}/ui/server.js"
    ;;
  (client)
    CLIENT_CONF_DIR=${CONF_DIR}/cdap-conf
    HOSTNAME=`hostname -f`
    substitute_cdap_site_tokens ${CLIENT_CONF_DIR}/cdap-site.xml
    exit 0
    ;;
  (upgrade_hbase)
    # The upgrade tool is run as master, but with an overridden $MAIN_CLASS and $MAIN_CLASS_ARGS
    COMPONENT_HOME=${CDAP_MASTER_HOME}
    MAIN_CLASS=co.cask.cdap.data.tools.UpgradeTool
    MAIN_CLASS_ARGS="upgrade_hbase force"
    # Set heap max, normally set in COMPONENT_CONF_SCRIPT
    JAVA_HEAPMAX=${MASTER_JAVA_HEAPMAX:--Xmx1024m}
    ;;
  (upgrade)
    # The upgrade tool is run as master, but with an overridden $MAIN_CLASS and $MAIN_CLASS_ARGS
    COMPONENT_HOME=${CDAP_MASTER_HOME}
    MAIN_CLASS=co.cask.cdap.data.tools.UpgradeTool
    MAIN_CLASS_ARGS="upgrade force"
    # Set heap max, normally set in COMPONENT_CONF_SCRIPT
    JAVA_HEAPMAX=${MASTER_JAVA_HEAPMAX:--Xmx1024m}
    ;;
  (postupgrade)
    # A post-upgrade step to correct any pending flow metrics. Kafka server must be running
    COMPONENT_HOME=${CDAP_MASTER_HOME}
    MAIN_CLASS=co.cask.cdap.data.tools.flow.FlowQueuePendingCorrector
    MAIN_CLASS_ARGS=""
    # Set heap max, normally set in COMPONENT_CONF_SCRIPT
    JAVA_HEAPMAX=${MASTER_JAVA_HEAPMAX:--Xmx1024m}
    ;;
  (debugger_utility)
    # The debugger utility (ie HBase queue debugger) is run as master, but with an overridden $MAIN_CLASS
    COMPONENT_HOME=${CDAP_MASTER_HOME}
    # MAIN_CLASS set by CSD, configurable by user
    # MAIN_CLASS_ARGS set by CSD, configurable by user
    # Set heap max, normally set in COMPONENT_CONF_SCRIPT
    JAVA_HEAPMAX=${MASTER_JAVA_HEAPMAX:--Xmx1024m}
    ;;
  (*)
    echo "Unknown service specified: ${SERVICE}"
    exit 1
    ;;
esac

# Source Cloudera common functions (for Kerberos)
source ${COMMON_SCRIPT}

# Source the CDAP common init functions
if [[ -e ${COMPONENT_HOME}/bin/functions.sh ]]; then
  source ${COMPONENT_HOME}/bin/functions.sh
else
  source ${COMPONENT_HOME}/bin/common-env.sh
  source ${COMPONENT_HOME}/bin/common.sh
fi

# Remap CDAP common init functions, if necessary
fn_exists() { type -t ${1} | grep -q function; }

fn_exists cdap_set_classpath || cdap_set_classpath() { set_classpath ${*}; }
fn_exists cdap_set_hive_classpath || cdap_set_hive_classpath() { set_hive_classpath ${*}; }
fn_exists cdap_set_hbase || cdap_set_hbase() { set_hbase ${*}; }

# Redefine cdap_kinit to be a no-op. CM handles kinit for us
cdap_kinit() { return 0; }

# Parse CDAP version from CDAP_HOME (exported in CDAP parcel)
CDAP_VERSION=${VERSION:-$(basename ${CDAP_HOME} | cut -d- -f2)}

# Token replacement in CM-generated cdap-site.xml
# Hostname
HOSTNAME=`hostname -f`
substitute_cdap_site_tokens ${CONF_DIR}/cdap-site.xml

# Copy logback-container.xml into place unless user has populated safety valve
if [[ -s logback-container.xml ]]; then
  echo "Populating logback-container.xml from safety valve content. Ensure the contents of the safety valve represent the entire file!"
else
  # No safety valve content, copy the packaged default into place
  cp aux/logback-container.xml.default logback-container.xml
fi

# Source CDAP Component config if defined and readable
if [[ -r "${COMPONENT_CONF_SCRIPT}" ]]; then
  source ${COMPONENT_CONF_SCRIPT}
fi

# Set JAVA_HEAPMAX from variable defined in JAVA_HEAP_VAR, unless defined already
JAVA_HEAPMAX=${JAVA_HEAPMAX:-${!JAVA_HEAP_VAR}}
export JAVA_HEAPMAX

# CDAP_CONF is used by Web-App to find cdap-site.xml
export CDAP_CONF=${CONF_DIR}

if [ "${cdap_principal}" != "" ]; then
  # Runs kinit
  export SCM_KERBEROS_PRINCIPAL=${cdap_principal}
  acquire_kerberos_tgt cdap.keytab
fi

# Debug info
echo "CDAP_HOME: ${CDAP_HOME}"
echo "CDAP_VERSION: ${CDAP_VERSION}"
echo "COMPONENT_HOME: ${COMPONENT_HOME}"
echo "COMPONENT_CONF_SCRIPT: ${COMPONENT_CONF_SCRIPT}"
echo "CONF_DIR: ${CONF_DIR}"
echo "ENV: `env`"

# Launch a cmd or a java app
if [ ${MAIN_CLASS} ]; then
  # Launch a java app

  # Set java
  JAVA=${JAVA_HOME}/bin/java

  # Set HBASE_HOME to CM-provided active location
  export HBASE_HOME=${CDH_HBASE_HOME}
  # Set base classpath to include component and conf directory (CM provided)
  cdap_set_classpath ${COMPONENT_HOME} ${CONF_DIR}

  # Prepend CM-provided ${CSD_JAVA_OPTS} to our ${CDAP_JAVA_OPTS}
  if [[ -n ${CSD_JAVA_OPTS} ]]; then
    CDAP_JAVA_OPTS="${CSD_JAVA_OPTS} ${CDAP_JAVA_OPTS}"
  fi

  echo "`date` Starting Java service ${SERVICE} on `hostname`"
  "${JAVA}" -version
  echo "`ulimit -a`"
  echo "Using java_heapmax: ${JAVA_HEAPMAX}"
  echo "Using user.dir: ${LOCAL_DIR}"
  echo "Using classpath: ${CLASSPATH}"
  echo "Using main_class: ${MAIN_CLASS}"
  echo "Using args: ${MAIN_CLASS_ARGS}"

  # Run Master-specific logic (for master and upgrade* services)
  if [ ${COMPONENT_HOME} == ${CDAP_MASTER_HOME} ]; then

    # Set HIVE_HOME to CM-provided active location
    export HIVE_HOME=${CDH_HIVE_HOME}
    # Setup hive classpath if hive is installed, this has to be run after HBASE_CP is setup by set_classpath.
    cdap_set_hive_classpath

    # Include appropriate hbase_compat module in classpath
    cdap_set_hbase

    # If a user has selected a dependency on Spark, CM will generate spark-conf directory in CWD
    if [ -d "spark-conf" ]; then
      export SPARK_HOME=${CDH_SPARK_HOME}
    fi

    # CDAP < 4.0 uses explore.conf.files, CDAP >= 4.0 uses explore.conf.dirs
    if [[ -n ${EXPLORE_CONF_DIRS} ]]; then
      __EXPLORE_CONF_FLAG="-Dexplore.conf.dirs=${EXPLORE_CONF_DIRS}"
    else
      __EXPLORE_CONF_FLAG="-Dexplore.conf.files=${EXPLORE_CONF_FILES}"
    fi
    echo "Using ${__EXPLORE_CONF_FLAG}"
    echo "Using explore.classpath: ${EXPLORE_CLASSPATH}"

    echo "Using SPARK_HOME: ${SPARK_HOME}"

    if [[ "${STARTUP_CHECKS_ENABLED}" == "true" ]]; then
      # Run only if CDAP_VERSION >= 3.3
      __maj_version=$(echo ${CDAP_VERSION} | cut -d. -f1)
      __min_version=$(echo ${CDAP_VERSION} | cut -d. -f2)
      if [[ __maj_version -gt 3 ]] || [[ __maj_version -ge 3 && __min_version -ge 3 ]]; then
        echo "Running startup checks -- this may take a few minutes"
        echo "Checks can be disabled using the master.startup.checks.enabled configuration option"
        "${JAVA}" "${JAVA_HEAPMAX}" \
          ${__EXPLORE_CONF_FLAG} \
          -Dexplore.classpath=${EXPLORE_CLASSPATH} ${CDAP_JAVA_OPTS} \
          -Dcdap.home=${CDAP_HOME} \
          -cp ${CLASSPATH} \
          co.cask.cdap.master.startup.MasterStartupTool 2>&1
        if [ $? -ne 0 ]; then
          echo "Master startup checks failed. Please check the CDAP Master Role logs to address issues"
          exit 1
        fi
      else
        echo "Skipping Master startup checks as CDAP version ${CDAP_VERSION} does not support them"
      fi
    fi
  fi

  # Exec into Master Service
  exec "${JAVA}" -Dcdap.service=${SERVICE} "${JAVA_HEAPMAX}" \
    ${__EXPLORE_CONF_FLAG} \
    -Dexplore.classpath=${EXPLORE_CLASSPATH} ${CDAP_JAVA_OPTS} \
    -Duser.dir=${LOCAL_DIR} \
    -Dcdap.home=${CDAP_HOME} \
    -cp ${CLASSPATH} ${MAIN_CLASS} ${MAIN_CLASS_ARGS}

elif [ ${MAIN_CMD} ]; then
  # Launch a non-java app

  echo "`date` Starting service ${SERVICE} on ${HOSTNAME}"
  echo "`ulimit -a`"

  exec ${MAIN_CMD} ${MAIN_CMD_ARGS}
fi
