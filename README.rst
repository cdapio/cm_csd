=====================================
CDAP Cloudera Manager Integration CSD
=====================================

CDAP Custom Service Descriptor (CSD)
====================================

The CDAP Custom Service Descriptor (CSD) is an extension for Cloudera Manager allowing it to install
and manage CDAP services.  It consists of a service descriptor SDL and a control script, which together
are responsible for configuring and launching CDAP services.

Cloudera's documentation for CSDs can be found `here <https://github.com/cloudera/cm_ext/wiki/CSD-Overview>`__.

Full documentation for installing the CDAP services via Cloudera Manager can be found `here <http://docs.cdap.io/cdap/current/en/integrations/index.html>`__.

Building the CSD
----------------

You can build the latest version of the CSD by cloning the repo and running maven as follows::

  git clone git@github.com:caskdata/cm_csd.git
  cd cm_csd
  mvn clean package

Installing the CSD
==================

Copy the generated jar file to the CSD directory of a Cloudera Manager instance, by default `/opt/cloudera/csd`.
Then restart Cloudera Manager.

Installing CDAP via Cloudera Manager
====================================

Please refer to the documentation `here <http://docs.cdap.io/cdap/current/en/integrations/partners/cloudera/configuring.html>`__ for further CDAP installation instructions.

License and Trademarks
======================

Copyright © 2014-2015 Cask Data, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the
License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific language governing permissions
and limitations under the License.

Cask is a trademark of Cask Data, Inc. All rights reserved.

Apache, Apache HBase, and HBase are trademarks of The Apache Software Foundation. Used with
permission. No endorsement by The Apache Software Foundation is implied by the use of these marks.

