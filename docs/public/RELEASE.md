# Release v2025.2 (2025-12-17)

### \[Release information\]
- The GUI in this release has been completely rewritten. Customization has been simplified. See [Zonemaster-GUI].
- Translations have not been fully updated in this release. They will be updated in an upcoming extra release.
- A zone (domain name) without DNSSEC will from this release create a WARNING message, not just a message on NOTICE level ([#1425])

### \[Breaking changes\]
- Removes deprecated API method get_batch_job_result. See [#1433] and [Zonemaster-Backend].
- Customization in GUI of previous version requires migration for this version. See [Zonemaster-GUI].
- The Zonemaster URL API has changed. See "using GUI" documentation.

### \[Deprecations\]
- Ignores and deprecates some profile properties. To be removed in release v2026.1. See [Zonemaster-Engine].
- Deprecate yes/no boolean values ([#1438])

### \[Features\]
- Adds Dockerfile and Docker image for Backend. See [Zonemaster-Backend] and "using Backend" documentation ([#1441])
- Updates several test case specifications: Address01, DNSSEC01, DNSSEC05, DNSSEC07 and Zone11 ([#1284], [#1409], [#1412], [#1415], [#1425], [#1448], [#1449]) and also updates test case implementations in [Zonemaster-Engine].
- MethodsV2: adds Get-Parent-NS-Names-and-IPs method ([#1418])

### \[Fixes\]
- Updates GUI installation and configuration documents to match updated GUI ([#1442])
- Moved and updated translation instructions ([#1445])
- Updates installation instructions ([#1446])
- Adds instructions for enabling IPv6 on Docker on Linux ([#1397])

### \[Zonemaster product\]
This version of Zonemaster also consists of the following components. For each component, see its Changes file or Github release notes for complete release information.

Component            | Github release notes   | Changes file               | Updated in this release
---------------------|:----------------------:|----------------------------|:----------------------:
[Zonemaster-LDNS]    | [v5.0.1][ldns-tag]     | [Changes][ldns-Changes]    | Yes
[Zonemaster-Engine]  | [v8.1.0][engine-tag]   | [Changes][engine-Changes]  | Yes
[Zonemaster-CLI]     | [v8.0.1][cli-tag]      | [Changes][cli-Changes]     | Yes
[Zonemaster-Backend] | [v12.0.0][backend-tag] | [Changes][backend-Changes] | Yes
[Zonemaster-GUI]     | [v5.0.0][gui-tag]      | [Changes][gui-Changes]     | Yes

For more information on previous versions of the Zonemaster product see the [Changes][zonemaster-Changes] file or the [releases] page on Github. For general information see the [README] file.

The public documentation is also found in a nicer format on the [documentation site]. Zonemaster can be used and tested on the [reference installation].

[README]:                 https://github.com/zonemaster/zonemaster/blob/master/README.md
[releases]:               https://github.com/zonemaster/zonemaster/releases
[documentation site]:     https://doc.zonemaster.net/
[reference installation]: https://zonemaster.net/

[ldns-tag]:    https://github.com/zonemaster/zonemaster-ldns/releases/tag/v5.0.1
[engine-tag]:  https://github.com/zonemaster/zonemaster-engine/releases/tag/v8.1.0
[cli-tag]:     https://github.com/zonemaster/zonemaster-cli/releases/tag/v8.0.1
[backend-tag]: https://github.com/zonemaster/zonemaster-backend/releases/tag/v12.0.0
[gui-tag]:     https://github.com/zonemaster/zonemaster-gui/releases/tag/v5.0.0

[zonemaster-Changes]: https://github.com/zonemaster/zonemaster/blob/master/Changes
[ldns-Changes]:       https://github.com/zonemaster/zonemaster-ldns/blob/master/Changes
[engine-Changes]:     https://github.com/zonemaster/zonemaster-engine/blob/master/Changes
[cli-Changes]:        https://github.com/zonemaster/zonemaster-cli/blob/master/Changes
[backend-Changes]:    https://github.com/zonemaster/zonemaster-backend/blob/master/Changes
[gui-Changes]:        https://github.com/zonemaster/zonemaster-gui/blob/master/Changes

[Zonemaster-LDNS]: https://github.com/zonemaster/zonemaster-ldns
[Zonemaster-Engine]: https://github.com/zonemaster/zonemaster-engine
[Zonemaster-CLI]: https://github.com/zonemaster/zonemaster-cli
[Zonemaster-Backend]: https://github.com/zonemaster/zonemaster-backend
[Zonemaster-GUI]: https://github.com/zonemaster/zonemaster-gui

[#1284]:      https://github.com/zonemaster/zonemaster/pull/1284
[#1397]:      https://github.com/zonemaster/zonemaster/pull/1397
[#1409]:      https://github.com/zonemaster/zonemaster/pull/1409
[#1412]:      https://github.com/zonemaster/zonemaster/pull/1412
[#1415]:      https://github.com/zonemaster/zonemaster/pull/1415
[#1418]:      https://github.com/zonemaster/zonemaster/pull/1418
[#1425]:      https://github.com/zonemaster/zonemaster/pull/1425
[#1425]:      https://github.com/zonemaster/zonemaster/pull/1425
[#1433]:      https://github.com/zonemaster/zonemaster/pull/1433
[#1438]:      https://github.com/zonemaster/zonemaster/pull/1438
[#1441]:      https://github.com/zonemaster/zonemaster/pull/1441
[#1442]:      https://github.com/zonemaster/zonemaster/pull/1442
[#1445]:      https://github.com/zonemaster/zonemaster/pull/1445
[#1446]:      https://github.com/zonemaster/zonemaster/pull/1446
[#1448]:      https://github.com/zonemaster/zonemaster/pull/1448
[#1449]:      https://github.com/zonemaster/zonemaster/pull/1449



