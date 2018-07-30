CDAP CSD CHANGELOG
==================

v5.0.0 (Jul 30, 2018)
---------------------
- Update default configurations for better usability ( Issues: #187 [CDAP-12767](https://issues.cask.co/browse/CDAP-12767) )
- Update default JVM options for JDK 8 ( Issues: #191 )
- Update default twill JVM options for JDK 8 ( Issues: #192 [CDAP-13416](https://issues.cask.co/browse/CDAP-13416) )
- Add configurations for CDAP 5.0 release ( Issues: #193 #194 #195 [CDAP-13708](https://issues.cask.co/browse/CDAP-13708) )

v4.3.1 (Dec 5, 2017)
--------------------
- Add optional dependency on Sentry ( Issues: #178 )
- Add configurable graceful shutdown timeout ( Issues: #181 #183 [CDAP-12721](https://issues.cask.co/browse/CDAP-12721) )

v4.3.0 (Aug 25, 2017)
---------------------
- Adds compatibility check for CDAP Parcel ( Issues: #172 #173 [CDAP-4874](https://issues.cask.co/browse/CDAP-4874) )
- Adds configurations for CDAP 4.3 release ( Issues: #175 [CDAP-12235](https://issues.cask.co/browse/CDAP-12235) )
- Removes configurations which are designated final ( Issues: #176 [CDAP-11944](https://issues.cask.co/browse/CDAP-11944) )

v4.2.2 (June 13, 2017)
----------------------
- Add cdap-env.sh to gateway role ( Issues: #168 [CDAP-11900](https://issues.cask.co/browse/CDAP-11900) )

v4.2.1 (June 7, 2017)
---------------------
- Update parcel repo ( Issues: #165 )

v4.2.0 (June 6, 2017)
---------------------
- Update start script to handle spark2 ( Issues: #156 [CDAP-11586](https://issues.cask.co/browse/CDAP-11586) )
- Adds configurations for CDAP 4.2 release ( Issues: #157 #159 #160 #162 [CDAP-11531](https://issues.cask.co/browse/CDAP-11531) )
- Adds optional tag & service dependencies on spark 2 ( Issues: #158 [CDAP-11606](https://issues.cask.co/browse/CDAP-11606) )
- Adds JobQueue debug tool ( Issues: #161 [CDAP-11515](https://issues.cask.co/browse/CDAP-11515) )

v4.1.2 (Mar 14, 2017)
---------------------
- Fixes an issue with the log.process.pipeline.lib.dir delimiter ( Issues: #152 [CDAP-8897](https://issues.cask.co/browse/CDAP-8897) )
- Adds optional authentication parameters ( Issues: #153 [CDAP-8891](https://issues.cask.co/browse/CDAP-8891) )

v4.1.1 (Feb 28, 2017)
---------------------
- Update to v2 market url ( Issues: #151 )

v4.1.0 (Feb 27, 2017)
---------------------
- Adds CDAP coprocessor check to Master startup ( Issues: #135, 138, 139 )
- Adds basic rolling restart capability ( Issues #136 [CDAP-5453](https://issues.cask.co/browse/CDAP-5453) )
- Adds configurations for CDAP 4.1 release ( Issues #137 #141 #142 #143 #144 #145 #146 [CDAP-8393](https://issues.cask.co/browse/CDAP-8393) )
- Relaxes required fields ( Issues #138 [CDAP-8435](https://issues.cask.co/browse/CDAP-8435) )

v4.0.1 (Feb 1, 2017)
--------------------
- Exposes configuration for scheduler.misfire.threshold.ms ( Issue: #129 )
- SSL support ( Issues: #130, #131 )

v4.0.0 (Dec 16, 2016)
---------------------
- Adds support for CDAP 4.0 init framework ( Issues: #105 #107 #112 #126 )
- Sync logback-container.xml updates from CDAP ( Issues: #113 #114 #115 )
- Updates UI default port to 11011 ( Issues: #118 [CDAP-5897](https://issues.cask.co/browse/CDAP-5897) )
- Supports improved CDAP mechanism to use Hive Classpath ( Issues #119 [CDAP-7054](https://issues.cask.co/browse/CDAP-7354) )
- Adds capability to run a CDAP debugger utility from the Actions menu ( Issues: #122 [CDAP-5632](https://issues.cask.co/browse/CDAP-5632) )
- Adds CM enhanced JVM support for CDAP services, **Requires CM 5.7 or above** ( Issues: #123 [CDAP-7555](https://issues.cask.co/browse/CDAP-7555) )
- Fixes an issue where CDAP would not pickup latest configuration changes ( Issues: #124 [CDAP-7556](https://issues.cask.co/browse/CDAP-7556) )
- Adds configurations for CDAP 4.0 release ( Issues: #125 #127 [CDAP-7796](https://issues.cask.co/browse/CDAP-7556) )

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
