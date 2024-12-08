# Release v2024.2 (2024-12-09)

### \[Release information\]
 - Translations have not been fully updated in this release. They will be updated in an upcoming extra release.

### \[Breaking changes\]
 - Refactors ASNLookup code in [Zonemaster-Engine][engine-tag]

### \[Features\]
 - Updates global cache documentationand makes the feature being supported and not experimental ([#1327], [#1303]). Also see [Zonemaster-Engine release notes][engine-tag]
 - Updates or adds specification of test cases or test scenarios for test cases Connectivity04 ([#1311], [#1299], [#1298]). Also see [Zonemaster-Engine release notes][engine-tag] for updates implementation
 - Updates specification of test case Connectivity03 ([#1297]). Also see [Zonemaster-Engine release notes][engine-tag] for updated implementation
 - Updates or adds specification of test cases or test scenarios for test cases DNSSEC10 ([#1294], [#1179]). Also see [Zonemaster-Engine release notes][engine-tag] for updated implementation
 - Corrects display when running 'zonemaster-cli'. See [Zonemaster-CLI release notes][cli-tag]
 - Makes utilities zmb() and zmtest supported. See [Zonemaster-Backend release notes][backend-tag]
 - Rebuild [Zonemaster-GUI] distribution package to remove potential vulnerabilities. See [Zonemaster-GUI release notes][gui-tag]

### \[Fixes\]
 - Updates installation instructions ([#1334], [#1332], [#1330], [#1322], [#1321], [#1314], [#1307])
 - Updates translations instructions ([#1320])
 - Updates general documents ([#1319], [#1318], [#1317], [#1316])
 - Updates usage document for CLI ([#1309])
 - Adds specification of test scenarios for test cases Delegation01, Delegation02 and Delegation03 ([#1305])
 - Removes unimplemented test case Nameserver14 ([#1300])
 - Updates and adds usage document for Backend and batch testing ([#1310], [#1303])
 - Updates or adds specification of MethodsV2 (shared between test cases) or test scenarios for MethodsV2 ([#1290], [#1287], [#1254])
 - Corrects spelling i various documents (external controbution from @jsoref) ([#1278])
 - Adds specification of test scenarios for the CNAME function in Recursor.pm in Engine ([#1220])

### \[Zonemaster product\]
This version of Zonemaster also consists of the following components. For each component, see its Changes file or Github release notes for complete release information.

Component            | Github release notes   | Changes file               | Updated in this release
---------------------|:----------------------:|----------------------------|:----------------------:
[Zonemaster-LDNS]    | [v4.1.0][ldns-tag]     | [Changes][ldns-Changes]    | Yes
[Zonemaster-Engine]  | [v7.0.0][engine-tag]   | [Changes][engine-Changes]  | Yes
[Zonemaster-CLI]     | [v7.1.0][cli-tag]      | [Changes][cli-Changes]     | Yes
[Zonemaster-Backend] | [v11.3.0][backend-tag] | [Changes][backend-Changes] | Yes
[Zonemaster-GUI]     | [v4.3.1][gui-tag]      | [Changes][gui-Changes]     | Yes

For more information on previous versions of the Zonemaster product see the [Changes][zonemaster-Changes] file or the [releases] page on Github. For general information ses the [README] file.

[README]: https://github.com/zonemaster/zonemaster/blob/master/README.md
[releases]: https://github.com/zonemaster/zonemaster/releases

[ldns-tag]: https://github.com/zonemaster/zonemaster-ldns/releases/tag/v4.1.0
[engine-tag]: https://github.com/zonemaster/zonemaster-engine/releases/tag/v7.0.0
[cli-tag]: https://github.com/zonemaster/zonemaster-cli/releases/tag/v7.1.0
[backend-tag]: https://github.com/zonemaster/zonemaster-backend/releases/tag/v11.3.0
[gui-tag]: https://github.com/zonemaster/zonemaster-gui/releases/tag/v4.3.1

[zonemaster-Changes]: https://github.com/zonemaster/zonemaster/blob/master/Changes
[ldns-Changes]: https://github.com/zonemaster/zonemaster-ldns/blob/master/Changes
[engine-Changes]: https://github.com/zonemaster/zonemaster-engine/blob/master/Changes
[cli-Changes]: https://github.com/zonemaster/zonemaster-cli/blob/master/Changes
[backend-Changes]: https://github.com/zonemaster/zonemaster-backend/blob/master/Changes
[gui-Changes]: https://github.com/zonemaster/zonemaster-gui/blob/master/Changes

[Zonemaster-LDNS]: https://github.com/zonemaster/zonemaster-ldns
[Zonemaster-Engine]: https://github.com/zonemaster/zonemaster-engine
[Zonemaster-CLI]: https://github.com/zonemaster/zonemaster-cli
[Zonemaster-Backend]: https://github.com/zonemaster/zonemaster-backend
[Zonemaster-GUI]: https://github.com/zonemaster/zonemaster-gui

[#1179]:    https://github.com/zonemaster/zonemaster/pull/1179
[#1220]:    https://github.com/zonemaster/zonemaster/pull/1220
[#1254]:    https://github.com/zonemaster/zonemaster/pull/1254
[#1278]:    https://github.com/zonemaster/zonemaster/pull/1278
[#1287]:    https://github.com/zonemaster/zonemaster/pull/1287
[#1290]:    https://github.com/zonemaster/zonemaster/pull/1290
[#1294]:    https://github.com/zonemaster/zonemaster/pull/1294
[#1297]:    https://github.com/zonemaster/zonemaster/pull/1297
[#1298]:    https://github.com/zonemaster/zonemaster/pull/1298
[#1299]:    https://github.com/zonemaster/zonemaster/pull/1299
[#1300]:    https://github.com/zonemaster/zonemaster/pull/1300
[#1303]:    https://github.com/zonemaster/zonemaster/pull/1303
[#1303]:    https://github.com/zonemaster/zonemaster/pull/1303
[#1305]:    https://github.com/zonemaster/zonemaster/pull/1305
[#1307]:    https://github.com/zonemaster/zonemaster/pull/1307
[#1309]:    https://github.com/zonemaster/zonemaster/pull/1309
[#1310]:    https://github.com/zonemaster/zonemaster/pull/1310
[#1311]:    https://github.com/zonemaster/zonemaster/pull/1311
[#1314]:    https://github.com/zonemaster/zonemaster/pull/1314
[#1316]:    https://github.com/zonemaster/zonemaster/pull/1316
[#1317]:    https://github.com/zonemaster/zonemaster/pull/1317
[#1318]:    https://github.com/zonemaster/zonemaster/pull/1318
[#1319]:    https://github.com/zonemaster/zonemaster/pull/1319
[#1320]:    https://github.com/zonemaster/zonemaster/pull/1320
[#1321]:    https://github.com/zonemaster/zonemaster/pull/1321
[#1322]:    https://github.com/zonemaster/zonemaster/pull/1322
[#1327]:    https://github.com/zonemaster/zonemaster/pull/1327
[#1330]:    https://github.com/zonemaster/zonemaster/pull/1330
[#1332]:    https://github.com/zonemaster/zonemaster/pull/1332
[#1334]:    https://github.com/zonemaster/zonemaster/pull/1334
