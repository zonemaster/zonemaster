# Labels for Issues and Pull Requests

## Label categories

The table below defines the labels to be used when classifying issues and pull requests.
Each label is assigned to one of these categories:

* Area
* Priority
* Status
* Type
* Versioning
* Release category

# Usage

A label from *Area* and *Type* should be attached to an issue or pull request,
when applicable.

One label from *Priority* could be attached to an issue, or else the issue is
considered to have normal priority. Similarly, the same could be done for a pull
request.

A label from *Status* can be used if applicable.

A PR should always have exactly one label from *Versioning* and one or more
labels from *Release category*. `RC-None` must not be combined with any other
*Release category* label.

## Labels

Category         | Label              | Color   | Used in repository | Scope |Description
-----------------|--------------------|---------|--------------------|-------|---------------------------------------------------------
Area             | A-Documentation    | green   | all                | Both  | Area: Documentation only.
Area             | A-TestCase         | green   | "main" or Engine   | Both  | Area: Test case specification or implementation of test case.
Area             | A-Translation      | green   | all                | Both  | Area: Documentation of, implementation of or actual translation of text.
Priority         | P-High             | red     | all                | Both  | Priority: Issue to be solved before others.
Release category | RC-BreakingChanges | magenta | all                | PR    | Release category: Breaking changes.
Release category | RC-Deprecations    | magenta | all                | PR    | Release category: Deprecations.
Release category | RC-Features        | magenta | all                | PR    | Release category: Features.
Release category | RC-Fixes           | magenta | all                | PR    | Release category: Fixes.
Release category | RC-None            | magenta | all                | PR    | Release category: Not to be included in Changes file.
Status           | S-ReleaseTested    | yellow  | all                | PR    | Status: The PR has been successfully tested in release testing.
Status           | S-PRforIssue       | yellow  | all                | Issue | Status: There is a PR that is meant to resolve the issue.
Type             | T-Bug              | red     | all                | Both  | Type: Bug in software or error in test case specification.
Type             | T-Feature          | blue    | all                | Issue | Type: New feature in software or test case specification.
Type             | T-Question         | blue    | all                | Issue | Type: External question.
Type             | T-TrackingIssue    | blue    | all                | Issue | Type: Tracks other issues, PRs or other changes.
Versioning       | V-Major            | pink    | all                | Both  | Versioning: The change gives an update of major in version.
Versioning       | V-Minor            | pink    | all                | Both  | Versioning: The change gives an update of minor in version.
Versioning       | V-Patch            | pink    | all                | Both  | Versioning: The change gives an update of patch in version.

## Color

Term     | Color code
---------|---------------------------------------------
blue     | #0CCFF2
green    | #55D700
pink     | #FFC0CB
red      | #EE0701
yellow   | #FFCE2E
magenta  | #D4C5F9

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
