# Labels for Issues and Pull Requests

## Label categories

The table below defines the labels to be used when classifying issues and pull requests. There
are three categories of labels defined:

* Area that the issue covers
* Priority of issue
* Issue type

# Usage

A label from *Area* and *Type* should be attached to an issue or pull request,
when applicable.

One label from *Priority* could be attached to an issue, or else the issue is considered
to have normal priority. A priority label could also be set on a pull request, if applicable.

## Labels

Category | Label            | Color  | Used in repository | Description
---------|------------------|--------|--------------------|------------------------------------
Area     | A-Documentation  | green  | all                | Area: Documentation only.
Area     | A-TestCase       | green  | "main" or Engine   | Area: Test case specification or implementation of test case.
Area     | A-Translation    | green  | all                | Area: Documentation of, implementation of or actual translation of text.
Area     | FA-Backend-conf  | green  | Backend            | Focus Area: Improving backend configuration handling.
Area     | FA-Basic04       | green  | "main" or Engine   | Focus Area: Implementing Basic04 and adjusting other test cases to it.
Area     | FA-CDS-CDNSKEY   | green  | "main" or Engine   | Focus Area: Adding test cases for CDS and CDNSKEY.
Area     | FA-IDN-ASCII     | green  | Backend or GUI     | Focus Area: Moving U-label-to-A-label conversion to GUI and zmtest and away from RPCAPI.
Area     | FA-MethodNT      | green  | "main" or Engine   | Focus Area: Implementing and migrating to MethodNT for test cases.
Priority | P-High           | red    | all                | Priority: Issue to be solved before other.
Status   | S-ReleaseTested  | yellow | all                | Status: The PR has been successfully tested in release testing
Type     | T-Bug            | red    | all                | Type: Bug in software or error in test case description.
Type     | T-Feature        | blue   | all                | Type: New feature in software or test case description.
Type     | T-Question       | blue   | all                | Type: Incoming question.
Type     | T-TrackingIssue  | blue   | all                | Type: Tracks other issues, PRs or other changes.

## Terms

Term     | Definition or meaning
---------|---------------------------------------------
main     | In the table above, "main" stands for the [Zonemaster/Zonemaster] repository
Backend  | In the table above, "Backend" stands for the [Zonemaster-Backend] repository
Engine   | In the table above, "Engine" stands for the [Zonemaster-Engine] repository
GUI      | In the table above, "GUI" stands for the [Zonemaster-GUI] repository
red      | Label with color code #EE0701
blue     | Label with color code #0CCFF2
green    | Label with color code #55D700
yellow   | Label with color code #FFCE2E


[Zonemaster/Zonemaster]:    https://github.com/zonemaster/zonemaster
[Zonemaster-Backend]:       https://github.com/zonemaster/zonemaster-backend
[Zonemaster-Engine]:        https://github.com/zonemaster/zonemaster-engine
[Zonemaster-GUI]:           https://github.com/zonemaster/zonemaster-gui
