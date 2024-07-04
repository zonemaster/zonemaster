# Document generation

## Background

The utility scripts described below are used to update or generate some documents
in the public document tree.

* The scripts should be run at each Zonemaster release and the resulting update
  should be submitted to correct git branch of this git repository.

## Pre-requisite

The scripts should be run on a computer where the updated git branch of
`zonemaster/zonemaster` has been cloned, and the equivalent version of
`zonemaster/engine` has been **installed**. Usually the git branches will
be the `develop` branches of each repository.

## Scripts

* [generateTestCaseList.pl]
  * This tool extracts all Test Case specifications and creates a Markdown table
    to be inserted in [Test Case README].
* [updateTestPlanReadme.pl]
  * This tool extracts all Test Case specifications per Test Plan and creates
    Markdown tables. The tables are automatically added to the Test Plan
    README.md file which is located in the directory named after the Test Plan.
* [generateTestMessages.pl]
  * This tools creates a map between the Zonemaster message tags from the
    [Zonemaster-Engine] implementation of the Test Cases and the Test Case
    specifications. This is used to create the complete [TestMessages.md] file.
* [generateImplementedTestCases.pl]
  * This tool creates a list of implemented test cases from the
    [Zonemaster-Engine] implementation. This is used to create the complete
    [ImplementedTestCases.md] file.
    
## Steps to be run

1. You are assumed to start from the root of the zonemaster/zonemaster tree.
   Go to directory to execute the commands from.
```sh
cd docs/public/specifications/tests
```
2. All commands below must be run from the directory you are in now.
3. Remove Test Case table from [README.md][Test Case README] in that directory
   and save the file.
4. Run:
```sh
../../../../utils/generateTestCaseList.pl >> README.md
```
5. Run:
```sh
../../../../utils/updateTestPlanReadme.pl
```
6. Run:
```sh
../../../../utils/generateTestMessages.pl > TestMessages.md
```
7. Run:
```sh
../../../../utils/generateImplementedTestCases.pl > ImplementedTestCases.md
```
8. Verify any updated documents.
9. Submit to git.


[generateImplementedTestCases.pl]: generateImplementedTestCases.pl
[generateTestCaseList.pl]:         generateTestCaseList.pl
[generateTestMessages.pl]:         generateTestMessages.pl
[ImplementedTestCases.md]:         ../docs/public/specifications/tests/ImplementedTestCases.md
[Test Case README]:                ../docs/public/specifications/tests/README.md
[TestMessages.md]:                 ../docs/public/specifications/tests/TestMessages.md
[updateTestPlanReadme.pl]:         generateTestMessages.pl
[Zonemaster-Engine]:               https://github.com/zonemaster/zonemaster-engine
