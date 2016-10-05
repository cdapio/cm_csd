CDAP CSD CHANGELOG
==================

v3.6.0 (Oct 4, 2016)
--------------------
- Adds configurations for CDAP 3.6 release ( Issues: #108 )

v3.5.1 (Aug 24, 2016)
---------------------
- Fixes an issue where the Upgrade Tool commands could fail ( Issues: #104 )

v3.5.0 (Aug 19, 2016)
---------------------
- Exposes YARN scheduler configurations ( Issues: #96 [CDAP-6182](https://issues.cask.co/browse/CDAP-6182) )
- Fixes an issue where the Router and UI roles needed to be colocated ( Issues: #98 [CDAP-2501](https://issues.cask.co/browse/CDAP-2501) )
- Fixes an issue where the Gateway client was missing router.server.* configurations ( Issues: #98 [CDAP-6974](https://issues.cask.co/browse/CDAP-6974) )
- Adds configurations for CDAP 3.5 release ( Issues: #99 #100 #101 )

v3.4.2 (Aug 4, 2016)
--------------------
- Updates CDAP label and description ( Issues: #90 )
- Prevent unnecessary checks of Hive, HBase, and Spark environments ( Issues: #93 [CDAP-6923](https://issues.cask.co/browse/CDAP-6923) )

v3.4.1 (May 11, 2016)
---------------------
- Fixes an issue where java heap size for the Upgrade commands was not set properly ( Issues: #84 [CDAP-5891](https://issues.cask.co/browse/CDAP-5891) )
- Fixes an issue where the Additional Java Options property was not set properly ( Issues: #86 [CDAP-5956](https://issues.cask.co/browse/CDAP-5956) )

v3.4.0 (Apr 28, 2016)
---------------------
- Increase CDAP PermGen memory ( Issues: #69 #70 )
- Fixes an issue where logging directory was not modifiable ( Issues: #72 [CDAP-5620](https://issues.cask.co/browse/CDAP-5620) )
- Add configurations for CDAP 3.4 release ( Issues: #73 #74 [CDAP-5681](https://issues.cask.co/browse/CDAP-5681) )
- Dynamically enable Spark integration ( Issues: #76 [CDAP-5086](https://issues.cask.co/browse/CDAP-5086) )
- Adds security.auth.server.bind.address configuration ( Issues: #80 )

v3.3.2 (Apr 26, 2016)
---------------------
- Adds configuration for data.tx.timeout ( Issues: #66 [CDAP-5035](https://issues.cask.co/browse/CDAP-5035) )
- Fixes an issue where CDAP failed to start on Ubuntu due to a kinit issue ( Issues: #67 [CDAP-5058](https://issues.cask.co/browse/CDAP-5058) )

v3.3.1 (Feb 15, 2016)
---------------------
- Fixes issue where Hydrator plugins are not available ( Issues: #57 [CDAP-4746](https://issues.cask.co/browse/CDAP-4746) )
- Updates to configuration descriptions ( Issues: #58 #62 )
- Introduced Post-CDH Upgrade Tasks command to run after HBase upgrade ( Issues: #59 [CDAP-4852](https://issues.cask.co/browse/CDAP-4852) )
- Increased the default dashboard.router.check.timeout.secs ( Issues: #60 )
- Fixes backwards compatability issue to only run master startup checks on supported CDAP parcels ( Issues: #61 [CDAP-4922](https://issues.cask.co/browse/CDAP-4922) )
- Adds container sizing configurations, and exposes them in the Add Service wizard ( Issues: #63 )

v3.3.0 (Jan 19, 2016)
---------------------
- Namespace start script functions ( Issues: #45 #48 [CDAP-1174](https://issues.cask.co/browse/CDAP-1174) )
- Remove dependency on xmllint ( Issues: #47 [CDAP-4442](https://issues.cask.co/browse/CDAP-4442) )
- Explore functionality enabled by default ( Issues: #49 [CDAP-4355](https://issues.cask.co/browse/CDAP-4355) )
- Bugfix in /user/cdap ownership ( Issue: #50 )
- Ability to specify entire logback-container.xml in the safety valve ( Issues: #51 [CDAP-3360](https://issues.cask.co/browse/CDAP-3360) )
- Enable CDAP Master Startup checks ( Issues: #52 [CDAP-4585](https://issues.cask.co/browse/CDAP-4585) )
- Add dashboard.router.check.timeout.secs configuration to expose UI misconfiguration in CM UI ( Issues: #54 [CDAP-4699](https://issues.cask.co/browse/CDAP-4699) )
- Add configurations for streaming container logs back to master process log ( Issue: #55 )

v3.2.0 (Sep 22, 2015)
---------------------
- Use CM logback integration (requires CM 5.4)
- Embedded remote parcel repo updated to point to CDAP 3.2.x parcels
- app.artifact.dir and metadata.service.* configurations

v3.1.0 (Jul 31, 2015)
---------------------
- Embedded remote parcel repo updated to point to CDAP 3.1.x parcels
- Added app.template.dir configuration

v3.0.0 (May 5, 2015)
--------------------
- CDAP 3.0 compatability: new CDAP_UI role, removed CDAP_WEB_APP role, added upgrade command ( Issue: #31 )
- Embedded remote parcel repo updated to point to CDAP 3.0.x parcels
- New versioning scheme to reflect CDAP major/minor version compatibility: CSD 3.0.* compatible with CDAP 3.0.*

v1.0.2 (Mar 20, 2015)
---------------------
- Support for logback-container.xml ( Issue: #29 [CDAP-1885](https://issues.cask.co/browse/CDAP-1885) )

v1.0.1 (Feb 15, 2015)
---------------------
- Log rotation fix ( Issue: #27 )

v1.0.0 (Feb 5, 2015)
--------------------
- Initial version ( Issue: #26 )
