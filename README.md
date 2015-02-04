# CDAP Cloudera Manager Integration CSD and Parcel Build

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

## Parcel Build

The Parcel packaging format is the preferred format for Cloudera Manager.  This build script works in
conjunction with the CDAP repo to package CDAP as a parcel.

This is used by the CDAP Parcel build [here](https://builds.cask.co/browse/CDAP-RPA)

### Arguments
The following environment variables can be set
  * `CDAP_HOME`: set this to the root of the CDAP repo.
  * `PARCEL_ITERAION`: append this iteration number to the resultant version.  Default 1.
  * `PARCEL_DELIVERY_OPTIONS_FILE`: optional location of a file containing additional configuration

### Building

Build CDAP archives
```
  git clone https://github.com/caskdata/cdap.git
  cd cdap
  mvn clean package -DskipTests -P dist,tgz
  cd ..
```

Run the `build_parcel.sh` script
```
  git clone git@github.com:caskdata/cm_csd.git
  cd cm_csd
  export CDAP_HOME=../cdap
  ./parcel_build/bin/build_parcel.sh
```

### Deploying
The build_parcel.sh script will optionally SCP the resultant parcel to a configured destination.  Set
`PARCEL_DELIVERY_OPTIONS_FILE` and the options within appropriately.  The build agents use this mechanism to 
deploy the resultant parcel into the parcel repo pipeline.

### Installing
After the Parcel is in a CDAP Parcel Repo, it can be installed vi Cloudera Manager's UI.  The CSD above
configures a parcel repo url for CDAP, which can be further modified by the user.
