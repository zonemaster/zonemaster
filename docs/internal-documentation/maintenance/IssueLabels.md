# Labels for Issues and Pull Requests

## Label categories

The table below defines the labels to be used when classifying issues and pull requests. There
are four categories of labels defined:

* Area
* Priority
* Status
* Issue

# Usage

A label from *Area* and *Type* should be attached to an issue or pull request,
when applicable.

One label from *Priority* could be attached to an issue, or else the issue is considered
to have normal priority. Similarly, the same could be done for a pull request.

A label from *Status* can be used if applicable.

## Labels

Category | Label            | Color  | Used in repository | Scope |Description
---------|------------------|--------|--------------------|-------|---------------------------------------------------------
Area     | A-Documentation  | green  | all                | Both  | Area: Documentation only.
Area     | A-TestCase       | green  | "main" or Engine   | Both  | Area: Test case specification or implementation of test case.
Area     | A-Translation    | green  | all                | Both  | Area: Documentation of, implementation of or actual translation of text.
Area     | FA-MethodsV2     | green  | "main" or Engine   | Both  | Focus Area: Implementing and migrating to MethodsV2 for test cases.
Priority | P-High           | red    | all                | Both  | Priority: Issue to be solved before other.
Status   | S-ReleaseTested  | yellow | all                | PR    | Status: The PR has been successfully tested in release testing
Status   | S-PRforIssue     | yellow | all                | Issue | Status: There is a PR that is meant to resolve the issue
Type     | T-Bug            | red    | all                | Both  | Type: Bug in software or error in test case description.
Type     | T-Feature        | blue   | all                | Issue | Type: New feature in software or test case description.
Type     | T-Question       | blue   | all                | Issue | Type: Incoming question.
Type     | T-TrackingIssue  | blue   | all                | Issue | Type: Tracks other issues, PRs or other changes.

## Color

Term     | Definition or meaning
---------|---------------------------------------------
red      | Label with color code #EE0701
blue     | Label with color code #0CCFF2
green    | Label with color code #55D700
yellow   | Label with color code #FFCE2E

## Used in repository

Term     | Definition or meaning
---------|---------------------------------------------
main     | In the table above, "main" stands for the [Zonemaster/Zonemaster] repository
Backend  | In the table above, "Backend" stands for the [Zonemaster-Backend] repository
Engine   | In the table above, "Engine" stands for the [Zonemaster-Engine] repository
GUI      | In the table above, "GUI" stands for the [Zonemaster-GUI] repository

## Scope

Term  | Definition or meaning
------|---------------------------------------------------
PR    | The label is meant for Pull Request only
Issue | The label is meant for Issue only
Both  | The label is meant for both Pull Request and Issue

[Zonemaster/Zonemaster]:    https://github.com/zonemaster/zonemaster
[Zonemaster-Backend]:       https://github.com/zonemaster/zonemaster-backend
[Zonemaster-Engine]:        https://github.com/zonemaster/zonemaster-engine
[Zonemaster-GUI]:           https://github.com/zonemaster/zonemaster-gui
