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
Area     | A-Backend-conf-FA| green  | Backend            | Focus Area Improving backend configuration handling.
Area     | A-Basic04-FA     | green  | "main" or Engine   | Focus Area Implementing Basic04 and adjusting other test cases to it.
Area     | A-CDS-CDNSKEY-FA | green  | "main" or Engine   | Focus Area Adding test cases for CDS and CDNSKEY.
Area     | A-Documentation  | green  | all                | Documentation only.
Area     | A-IDN-ASCII-FA   | green  | Backend or GUI     | Focus Area Moving U-label-to-A-label conversion to GUI and zmtest and away from RPCAPI.
Area     | A-MethodNT-FA    | green  | "main" or Engine   | Focus Area Implementing and migrating to MethodNT for test cases.
Area     | A-TestCase       | green  | "main" or Engine   | Test case specification or implementation of test case.
Area     | A-Translation    | green  | all                | Documentation of, implementation of or actual translation of text.
Priority | P-High           | red    | all                | Issue to be solved before other.
Type     | T-Bug            | red    | all                | Bug in software or error in test case description.
Type     | T-Feature        | blue   | all                | New feature in software or test case description.
Type     | T-Question       | blue   | all                | Incoming question.

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


[Zonemaster/Zonemaster]:    https://github.com/zonemaster/zonemaster
[Zonemaster-Backend]:       https://github.com/zonemaster/zonemaster-backend
[Zonemaster-Engine]:        https://github.com/zonemaster/zonemaster-engine
[Zonemaster-GUI]:           https://github.com/zonemaster/zonemaster-gui
