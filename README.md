# CDAP Cloudera Manager Integration CSD

## CDAP Custom Service Descriptor (CSD)

The CDAP Custom Service Descriptor (CSD) is an extension for Cloudera Manager allowing it to install
and manage CDAP services.  It consists of a service descriptor SDL and a control script, which together
are responsible for configuring and launching CDAP services.

Cloudera's documentation for CSDs can be found [here](https://github.com/cloudera/cm_ext/wiki/CSD-Overview)

Full documentation for installing the CDAP services via Cloudera Manager can be found [here](http://docs.cdap.io/cdap/current/en/integrations/index.html)

### Building the CSD
```
  git clone git@github.com:caskdata/cm_csd.git
  cd cm_csd
  mvn clean package
```

### Installing the CSD

Copy the generated jar file to the CSD directory of a Cloudera Manager instance, by default `/opt/cloudera/csd`.
Then restart Cloudera Manager.

### Installing CDAP via Cloudera Manager

Please refer to the [documentation](http://docs.cdap.io/cdap/current/en/integrations/partners/cloudera/configuring.html) for further CDAP installation instructions.
