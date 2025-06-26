# Release v2025.1 (2025-06-26)

### \[Release information\]
- Translations have not been fully updated in this release. They will be updated in an upcoming extra release.

### \[Breaking changes\]
- Raises minimum Perl version to v5.26.0. See [Zonemaster-LDNS], but indirectly affects all components except [Zonemaster-GUI].
- Changes the string representation of IPv6 addresses. See [Zonemaster-Engine].
- Separates functions to trim whitespace and to normalize domain name. See [Zonemaster-Engine].
- Changes the CLI "--test" option. See [Zonemaster-CLI].

### \[Deprecations\]
- API method "get\_batch\_job\_result" is deprecated to be removed in v2025.2. Use method "batch\_status" instead. See [#1304] and [Zonemaster-Backend].


### \[Features\]
- Lowers all WARNING to NOTICE in test case Zone01. Lowers ERROR to WARNING in test case DNSSEC03. See [#1384], [#1352] and [Zonemaster-Engine].
- Updates "Requirements and normalization of domain names in input" to make removal of leading and trailing space optional ([#1260]).
- Defines Backend API "batch\_status" to replace "get\_batch\_job\_result" ([#1304]). For implementation see [Zonemaster-Backend].


### \[Fixes\]
- Updates language translations. See [Zonemaster-Engine], [Zonemaster-CLI] and [Zonemaster-Backend].
- Fixes issue in test case DNSSEC10 when name servers share IP addresses. See [Zonemaster-Engine].
- Updates installation instructions ([#1391]).
- Updates global cache instructions ([#1392]).
- Updates Backend batch instructions ([#1386]).
- Removes 'Randomized capitalization' documentation ([#1390]).
- Adds test scenarios for test cases DNSSEC10, Basic02 and Address03, respectively ([#1383]), ([#1380]), ([#1354]).


### \[Zonemaster product\]
This version of Zonemaster also consists of the following components. For each component, see its Changes file or Github release notes for complete release information.

Component            | Github release notes   | Changes file               | Updated in this release
---------------------|:----------------------:|----------------------------|:----------------------:
[Zonemaster-LDNS]    | [v5.0.0][ldns-tag]     | [Changes][ldns-Changes]    | Yes
[Zonemaster-Engine]  | [v8.0.0][engine-tag]   | [Changes][engine-Changes]  | Yes
[Zonemaster-CLI]     | [v8.0.0][cli-tag]      | [Changes][cli-Changes]     | Yes
[Zonemaster-Backend] | [v11.5.0][backend-tag] | [Changes][backend-Changes] | Yes
[Zonemaster-GUI]     | [v4.4.0][gui-tag]      | [Changes][gui-Changes]     | No

For more information on previous versions of the Zonemaster product see the [Changes][zonemaster-Changes] file or the [releases] page on Github. For general information ses the [README] file. The public documentation is found in nice format on the [documentation site]. Zonemaster can be used and tested on the [reference installation].

[README]:                 https://github.com/zonemaster/zonemaster/blob/master/README.md
[releases]:               https://github.com/zonemaster/zonemaster/releases
[documentation site]:     https://doc.zonemaster.net/
[reference installation]: https://zonemaster.net/

[ldns-tag]:    https://github.com/zonemaster/zonemaster-ldns/releases/tag/v5.0.0
[engine-tag]:  https://github.com/zonemaster/zonemaster-engine/releases/tag/v8.0.0
[cli-tag]:     https://github.com/zonemaster/zonemaster-cli/releases/tag/v8.0.0
[backend-tag]: https://github.com/zonemaster/zonemaster-backend/releases/tag/v11.5.0
[gui-tag]:     https://github.com/zonemaster/zonemaster-gui/releases/tag/v4.4.0

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

[#1260]:      https://github.com/zonemaster/zonemaster/pull/1260
[#1304]:      https://github.com/zonemaster/zonemaster/pull/1304
[#1304]:      https://github.com/zonemaster/zonemaster/pull/1304
[#1352]:      https://github.com/zonemaster/zonemaster/pull/1352
[#1354]:      https://github.com/zonemaster/zonemaster/pull/1354
[#1380]:      https://github.com/zonemaster/zonemaster/pull/1380
[#1383]:      https://github.com/zonemaster/zonemaster/pull/1383
[#1384]:      https://github.com/zonemaster/zonemaster/pull/1384
[#1386]:      https://github.com/zonemaster/zonemaster/pull/1386
[#1390]:      https://github.com/zonemaster/zonemaster/pull/1390
[#1391]:      https://github.com/zonemaster/zonemaster/pull/1391
[#1392]:      https://github.com/zonemaster/zonemaster/pull/1392
