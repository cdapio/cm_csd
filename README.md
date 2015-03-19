# CDAP Cloudera Manager Integration CSD

## CDAP Custom Service Descriptor (CSD)

The CDAP Custom Service Descriptor (CSD) is an extension for Cloudera Manager allowing it to install
and manage CDAP services.  It consists of a service descriptor SDL and a control script, which together
are responsible for configuring and launching CDAP services.

Cloudera's documentation for CSDs can be found [here](https://github.com/cloudera/cm_ext/wiki/CSD-Overview)

### Building
```
  git clone git@github.com:caskdata/cm_csd.git
  cd cm_csd/csd
  mvn clean package
```

### Deploying
The resultant CSD jar is currently manually added to the resource/downloads pipeline.

### Installing

Copy the generated jar file to the CSD directory of a Cloudera Manager instance, by default `/opt/cloudera/csd`.
Then restart Cloudera Manager.
