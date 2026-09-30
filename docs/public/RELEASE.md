# Release v2026.1.2 (2026-09-30)

### \[Release information\]
- This release mainly contains bug fixes in the test cases.
- Updates th implementation of test cases Consistency05, Zone09 and DNSSEC02 and the shared methods in MethodsV2 in [Zonemaster-Engine].

### \[Breaking changes\]
- None for this release

### \[Deprecations\]
- None for this release

### \[Features\]
- Updates test case Consistency05 specification to resolve a bug, but the message tags have also been updated and some of the logic has changed (#1523)

### \[Fixes\]
- Updates test case Zone09 specification to resolved a bug ([#1516])

### \[Zonemaster product\]
This version of Zonemaster also consists of the following components. For each component, see its Changes file or Github release notes for complete release information.

Component            | Github release notes   | Changes file               | Updated in this release
---------------------|:----------------------:|----------------------------|:----------------------:
[Zonemaster-LDNS]    | [v5.1.0][ldns-tag]     | [Changes][ldns-Changes]    | No
[Zonemaster-Engine]  | [v9.0.1][engine-tag]   | [Changes][engine-Changes]  | Yes
[Zonemaster-CLI]     | [v8.0.3][cli-tag]      | [Changes][cli-Changes]     | Yes
[Zonemaster-Backend] | [v12.1.1][backend-tag] | [Changes][backend-Changes] | No
[Zonemaster-GUI]     | [v5.1.0][gui-tag]      | [Changes][gui-Changes]     | No

For more information on previous versions of the Zonemaster product see the [Changes][zonemaster-Changes] file or the [releases] page on Github. For general information see the [README] file.

The public documentation is also found in a nicer format on the [documentation site]. Zonemaster can be used and tested on the [reference installation].

[README]:                 https://github.com/zonemaster/zonemaster/blob/master/README.md
[releases]:               https://github.com/zonemaster/zonemaster/releases
[documentation site]:     https://doc.zonemaster.net/
[reference installation]: https://zonemaster.net/

[ldns-tag]:    https://github.com/zonemaster/zonemaster-ldns/releases/tag/v5.1.0
[engine-tag]:  https://github.com/zonemaster/zonemaster-engine/releases/tag/v9.0.1
[cli-tag]:     https://github.com/zonemaster/zonemaster-cli/releases/tag/v8.0.3
[backend-tag]: https://github.com/zonemaster/zonemaster-backend/releases/tag/v12.1.1
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

[#1523]:              https://github.com/zonemaster/zonemaster/pull/1523
[#1516]:              https://github.com/zonemaster/zonemaster/pull/1516


