# Release v2026.1 (2026-06-29)

### \[Release information\]
 - Please note that some of the links to documents at doc.zonemaster.net might not work the first days after the release.
 - Migration of the database is required by this release to add correct schema version. See [Zonemaster-Backend] upgrade guide, <https://doc.zonemaster.net/v2026.1/upgrading/backend.html>

### \[Breaking changes\]
 - Removes deprecated profile properties. See [Zonemaster-Engine]
 - Changes saved packets’ serialization format. Data files saved with previous versions will not load. See [Zonemaster-Engine]

### \[Deprecations\]
- None for this release

### \[Features\]
 - Adds All-In-One Docker image including CLI, Backend and GUI components. Documentation added by [#1487]. Also see <https://doc.zonemaster.net/v2026.1/using/gui/all-in-one.html>
 - Adds migration guide for [Zonemaster-Backend] 12.1.0 ([#1491], [#1509])
 - Specifies URL to TLD feature for GUI in RPCAPI ([#1429])
 - Update specification of DNSSEC10 to handle nonstandard NSEC responses ([#1478])

### \[Fixes\]
 - Updates installation instructions to match FreeBSD 15 and changes from external LDNS to internal LDNS for FreeBSD ([#1504])
 - Drops unused log directory on Rocky Linux ([#1489], [#1502])
 - Updates installation instruction with Capture::Tiny as dependency ([#1497])
 - Documents dependency on CBOR::XS ([#1494])
 - Corrects spelling in several documents ([#1496])
 - Fixes a link error in README file ([#1492])
 - Fixes link in the public [documentation site] ([#1475])
 - Resolves issue in Ubuntu 26.04 by having Debian/Ubuntu users install libcrypt-dev explicitly ([#1479])
 - Other fixes are found in the [Zonemaster-LDNS], [Zonemaster-Engine], [Zonemaster-CLI], [Zonemaster-Backend] and [Zonemaster-GUI] release notes.

### \[Zonemaster product\]
This version of Zonemaster also consists of the following components. For each component, see its Changes file or Github release notes for complete release information.

Component            | Github release notes   | Changes file               | Updated in this release
---------------------|:----------------------:|----------------------------|:----------------------:
[Zonemaster-LDNS]    | [v5.1.0][ldns-tag]     | [Changes][ldns-Changes]    | Yes
[Zonemaster-Engine]  | [v9.0.0][engine-tag]   | [Changes][engine-Changes]  | Yes
[Zonemaster-CLI]     | [v8.0.2][cli-tag]      | [Changes][cli-Changes]     | Yes
[Zonemaster-Backend] | [v12.1.0][backend-tag] | [Changes][backend-Changes] | Yes
[Zonemaster-GUI]     | [v5.1.0][gui-tag]      | [Changes][gui-Changes]     | Yes

For more information on previous versions of the Zonemaster product see the [Changes][zonemaster-Changes] file or the [releases] page on Github. For general information see the [README] file.

The public documentation is also found in a nicer format on the [documentation site]. Zonemaster can be used and tested on the [reference installation].

[README]:                 https://github.com/zonemaster/zonemaster/blob/master/README.md
[releases]:               https://github.com/zonemaster/zonemaster/releases
[documentation site]:     https://doc.zonemaster.net/
[reference installation]: https://zonemaster.net/

[ldns-tag]:    https://github.com/zonemaster/zonemaster-ldns/releases/tag/v5.1.0
[engine-tag]:  https://github.com/zonemaster/zonemaster-engine/releases/tag/v9.0.0
[cli-tag]:     https://github.com/zonemaster/zonemaster-cli/releases/tag/v8.0.2
[backend-tag]: https://github.com/zonemaster/zonemaster-backend/releases/tag/v12.1.0
[gui-tag]:     https://github.com/zonemaster/zonemaster-gui/releases/tag/v5.1.0

[zonemaster-Changes]: https://github.com/zonemaster/zonemaster/blob/master/Changes
[ldns-Changes]:       https://github.com/zonemaster/zonemaster-ldns/blob/master/Changes
[engine-Changes]:     https://github.com/zonemaster/zonemaster-engine/blob/master/Changes
[cli-Changes]:        https://github.com/zonemaster/zonemaster-cli/blob/master/Changes
[backend-Changes]:    https://github.com/zonemaster/zonemaster-backend/blob/master/Changes
[gui-Changes]:        https://github.com/zonemaster/zonemaster-gui/blob/master/Changes

[Zonemaster-LDNS]:    https://github.com/zonemaster/zonemaster-ldns
[Zonemaster-Engine]:  https://github.com/zonemaster/zonemaster-engine
[Zonemaster-CLI]:     https://github.com/zonemaster/zonemaster-cli
[Zonemaster-Backend]: https://github.com/zonemaster/zonemaster-backend
[Zonemaster-GUI]:     https://github.com/zonemaster/zonemaster-gui

[NOTICE]:     https://github.com/zonemaster/zonemaster/blob/master/docs/public/specifications/tests/SeverityLevelDefinitions.md#notice
[WARNING]:    https://github.com/zonemaster/zonemaster/blob/master/docs/public/specifications/tests/SeverityLevelDefinitions.md#warning

[#1429]:     https://github.com/zonemaster/zonemaster/pull/1429
[#1475]:     https://github.com/zonemaster/zonemaster/pull/1475
[#1478]:     https://github.com/zonemaster/zonemaster/pull/1478
[#1479]:     https://github.com/zonemaster/zonemaster/pull/1479
[#1487]:     https://github.com/zonemaster/zonemaster/pull/1487
[#1489]:     https://github.com/zonemaster/zonemaster/pull/1489
[#1491]:     https://github.com/zonemaster/zonemaster/pull/1491
[#1492]:     https://github.com/zonemaster/zonemaster/pull/1492
[#1494]:     https://github.com/zonemaster/zonemaster/pull/1494
[#1496]:     https://github.com/zonemaster/zonemaster/pull/1496
[#1497]:     https://github.com/zonemaster/zonemaster/pull/1497
[#1502]:     https://github.com/zonemaster/zonemaster/pull/1502
[#1504]:     https://github.com/zonemaster/zonemaster/pull/1504
[#1509]:     https://github.com/zonemaster/zonemaster/pull/1509
