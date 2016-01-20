CDAP CSD CHANGELOG
==================

v3.3.0 (Jan 19, 2016)
---------------------
- Namespace start script functions ( Issues: #45 #48 [CDAP-1174](https://issues.cask.co/browse/CDAP-1174) )
- Remove dependency on xmllint ( Issues: #47 [CDAP-4442](https://issues.cask.co/browse/CDAP-4442) )
- Explore functionality enabled by default ( Issues: #49 [CDAP-4355](https://issues.cask.co/browse/CDAP-4355) )
- Bugfix in /user/cdap ownership ( Issue: #50 )
- Ability to specify entire logback-container.xml in the safety valve ( Issues: #51 [CDAP-3360](https://issues.cask.co/browse/CDAP-3360) )
- Enable CDAP Master Startup checks ( Issues: #52 [CDAP-4585](https://issues.cask.co/browse/CDAP-4585) )
- Add dashboard.router.check.timeout.secs configuration to expose UI misconfiguration in CM UI ( Issues: #54 [CDAP-4699](https://issues.cask.co/browse/CDAP-4699) )

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
