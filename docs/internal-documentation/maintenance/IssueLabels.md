# Labels for Issues and Pull Requests

## Label categories

The table below defines the labels to be used when classifying issues and pull requests. There
are four categories of labels defined:

* Issue type
* Priority of issue
* Status of issue
* Area that the issue covers

# Usage

One, and only one, label from each of *Type* and *Area* should always be attached to every
issue, and could be attached to a pull request.

One label from *Priority* could be attached to an issue, or else the issue is considered
to have normal priority. A priority label could also be set on a pull request, if applicable.

One label from *Status* could be attached to an issue, or else the issue is considered to
be just opened and not worked on (or work has been withdrawn). If applicable, a status label
could also be set on a pull request. A status label has no meaning if the issue is closed
or pull request is closed or merged.

## Labels

Category | Label            | Color  | Used in repository | Description
---------|------------------|--------|--------------------|------------------------------------
Area     | A-BuildSystem    | green  | all but "main"     | Build system as "make" or similar
Area     | A-Code           | green  | all                | Software code not covered by other areas
Area     | A-Databases      | green  | Backend            | Configuration or integration of database engines into Zonemaster
Area     | A-Documentation  | green  | all                | Documentation not covered by other areas
Area     | A-Installation   | green  | all but "main"     | Installation instructions of Zonemaster for users
Area     | A-Logging        | green  | Backend            | Documentation or implementation of logging system in Zonemaster-Backend
Area     | A-OSintegration  | green  | Backend            | Code or documentation of integration of Zonemaster into the OS
Area     | A-RCPAPI         | green  | Backend            | Documentation or implementation of the RPCAPI in Zonemaster-Backend
Area     | A-TestAgent      | green  | Backend            | Documentation or implementation of the Test Agent in Zonemaster-Backend
Area     | A-TestCase       | green  | "main" or Engine   | Test case specification or implementation of test case
Area     | A-Translation    | green  | all                | Documentation of, implementation of or actual translation of text
Area     | A-Travis         | green  | all but "main"     | Travis test tool in Github
Area     | A-UnitTests      | green  | all but "main"     | Documentation or implementation of unit tests
Priority | P-High           | red    | all                | Issue to be solved before other
Status   | S-InProgress     | yellow | all                | Work in progress, but no proposal or pull request exists
Status   | S-ProposalExists | yellow | all                | Work in progress and a proposal (PR) exists
Status   | S-Stalled        | yellow | all                | Work has been stopped or stalled or is waiting for some other issue to resolved before continuing
Type     | T-Bug            | red    | all                | Bug in software or error in test case description
Type     | T-Feature        | blue   | all                | New feature in software or test case description
Type     | T-Performance    | blue   | all but "main"     | Performance in software
Type     | T-Project        | blue   | "main"             | Project related issue
Type     | T-Question       | blue   | all                | Incoming question
Type     | T-Stability      | blue   | all but "main"     | Stability in software
Type     | T-Usability      | blue   | all but "main"     | Usability of software

## Terms

Term     | Definition or meaning
---------|---------------------------------------------
main     | In the table above, "main" stands for the [Zonemaster/Zonemaster] repository
Backend  | In the table above, "Backend" stands for the [Zonemaster-Backend] repository
Engine   | In the table above, "Engine" stands for the [Zonemaster-Engine] repository
red      | Label with color code #EE0701
blue     | Label with color code #0CCFF2
yellow   | Label with color code #FFCE2E
green    | Label with color code #55D700


[Zonemaster/Zonemaster]: https://github.com/zonemaster/zonemaster
[Zonemaster-Backend]: https://github.com/zonemaster/zonemaster-backend
[Zonemaster-Engine]: https://github.com/zonemaster/zonemaster-backend

