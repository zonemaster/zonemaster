# Description of help utilities

## [generateTestCaseList.pl]

This tool extracts all Test Case specifications and creates
an Markdown table to be inserted in [Test Case README]. This
table should be recreated at each Zonemaster release.

Use:

1. Remove Test Case table from [Test Case README] and save the file
2. Do:
```
cd ../docs/specifications/tests
../../../utils/generateTestCaseList.pl >> README.md
```
3. Submit to git.

## [generateTestMessages.pl]

This tools creates a map between the Zonemaster messages tags from
the [Zonemaster-Engine] implementation of the Test Cases and the
Test Case specifications. This is used to create the
complete [TestMessages.md] file. The matching version of
[Zonemaster-Engine] must be installed.

[TestMessages.md] should be recreated at each Zonemaster release.

Use:

1. Do:
```
cd ../docs/specifications/tests
../../../utils/generateTestMessages.pl > TestMessages.md
```
2. Submit to git.

## [generateImplementedTestCases.pl]

This tool creates a list of implemented test cases from
the [Zonemaster-Engine] implementation. This is used to create
the complete [ImplementedTestCases.md] file. The matching version of
[Zonemaster-Engine] must be installed.

[ImplementedTestCases.md] should be recreated at each Zonemaster release.

Use:

1. Do:
```
cd ../docs/specifications/tests
../../../utils/generateImplementedTestCases.pl > ImplementedTestCases.md
```
2. Submit to git.


[generateImplementedTestCases.pl]:		generateImplementedTestCases.pl
[generateTestCaseList.pl]:      		generateTestCaseList.pl
[generateTestMessages.pl]:      		generateTestMessages.pl
[ImplementedTestCases.md]:			../docs/specifications/tests/ImplementedTestCases.md
[TestMessages.md]:              		../docs/specifications/tests/TestMessages.md
[Test Case README]:             		../docs/specifications/tests/README.md
[Zonemaster-Engine]:            		https://github.com/zonemaster/zonemaster-engine

