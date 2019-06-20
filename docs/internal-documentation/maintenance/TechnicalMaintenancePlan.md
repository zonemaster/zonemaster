# Zonemaster technical maintenance plan

## Background

The Zonemaster project has been developed by AFNIC and IIS. The first part of the project has been to finish the release of version 1.0. This is the technical maintenance plan put in place to ensure a long term support for the software, including all relevant parts for the development of the software.

This document outlines the continual development of the Zonemaster open source project, what is included and what the development entails.

## Change management

The process for Change management is described in the
[Change Management](ChangeManagement.md) document.

In short:

> A change is approved by the development team, and added to the
> roadmap and the current set of requirements.

Changes are assigned to minor or major releases depending on the extent
of the change.

## Development

Any new development for Zonemaster must follow the strict process where there are formal requirements, specifications for implementing the requirements and then any design and architecture fulfilling the specifications, and finally the implementation and quality assurance. When all this is performed successully the software package is relased using the release process.

The developers are responsible for the specifications that implements the requirements and that the code follows the specifications. All code should be reviewed by a developer other than the developer himself, this could either be the Release manager or another developer acting as a Code reviewer.

### Requirements

Formal requirements comes from "some kind of managament or governance of the project", the team and any users requesting new functionality. Requirements should be ranked in importance depending on a number of factors such as complexity, amount of work, risk, architectural changes, relevance to the product and so on.

New requirements that are acknowledged make it to the roadmap and planned for specification and implementation. They are also added to the current set of requirements.  

### Specification

A set of functional specifications can be derived from the requirements. It does not describe the inner workings of the system, but are focusing more on the interaction between the system and outside world. The specification is added to the current set of specifications.

All specified tests must have a requirement that matches the specification, and should also reference any valid standards documents that defines the protocol (DNS). All specified functionality should also match any functional requirements.

### Design and architecture

Any change and specifiation that requires architectural changes creates changes in the software architecture. These arhitectural changes must by documented and any decision to implement the specification is made by the development team with support from the steering committee.

A more detailed design can be created once the architecture has been set. This is done within the development team. The aim is to describe each component and its internal structures.

### Implementation

There are four different parts of the implementation phase:

 1. The backlog and roadmap contains all features that need to be implemented and bugs that need to be fixed. The work items are created based on the design of the system. Each item has an estimated workload. The sum of the workload is then output as estimation for the release plan.

 2. Not all features can be implemented in one release, but must be split up into smaller minor releases. The release backlog is a subset of the roadmap and contains only the features needed for this release.

 3. A normal iteration within an agile development process contains all parts of a software development cycle. But the iteration in our case is only the period between each telephone conference meeting where we have the chance to plan the release, give updates on our progress, and discuss current issues. We try to have a meeting every x weeks.

 4. The developer team can initiate the release process when they e.g. want to get feedback or have implemented all features. The software then goes on to the next step, QA.

### QA

The changes in this release are tested against the requirements and the specification.

 * The developer does sufficient developer testing to ensure that the functionality is complete and the major use cases pass.

 * Ideally a second developer or tester then does manual testing of the features to include success and failure cases and corner cases. Any issues found are recorded on the Github issue tracker for the development for the original developer to fix before re-testing. For major developments a separate testing issue may be created. 

 * Regression tests should then also be put in place to cover the functionality.

## Bug fixing

Any bug fixes the team or any user discovers should be published in the Github issue tracker.

Not all issues in the tracker are bugs, and not all reported bugs are software bugs, but can be protocol errors in DNS, or user or documentation errors.

Errors in the documentation, any language translation, requirements and specifications are also going into the Github issue tracker.

The release managers are responsible for going through the Github issue tracker for any new issues and delegate the issue to a responsible developer for fixing the problem. The issue should also be prioritized and planned for a release. When possible, the full dialogue with the reporter of the issue should go into this Github issue.

## Release management process

Release check list:

 * Decide to prepare a release
 * Update documentation
 * Check the database migration tool is up to date (web interface, batch tools)
 * Agree the release type and support period
 * Complete all testing
 * Code Reviews
 * Run code integrity tools
 * Agree to release

After that, se the Release Process.

The Release Manager is responsible for the Release Process and the Relase Management Process, and can veto the decision to execute the release.

## Version numbering policy

Our current [version numbering policy](../../design/Versions%20and%20Releases.md) is in the development documentation.

## Release process

In order to create a release after the decision to make a release has been made, there are a number of tasks that has to be done:

 * Update the documentation
 * Testing
 * Generate the release (tar.gz, check for completeness)
 * Announcements

The Release Process should be documented in a more exact routine document so that anybody in the team can create a release.
 
The Release Manager is responsible for the Release Process and the Relase Management Process.

Once the announcements are made, it is common practice to also give a friendly notice to any package maintainers that wants to package the new version.
 
## Queries on the users mailing list

All developers in the development team are responsible for answer any queries or comments on the users mailing list. When necessary to fix something in the documentation or software, a ticket should be created either by the user or the developer in the Github issue tracker so that the issue is not lost.

## Roadmap

The roadmap of things to be implemeted is regularly reviewed and updated by the team and by "the steering committee". All current issues in the issue tracker are also taken into account, and major issues are prioritized and added the a future release in the roadmap.

The roadmap is a public document in the Github source code tree or wiki.

The Roadmap owner has the responsibility for the roadmap, and decides on the content and timing of each release in coordination with project management and the developer team.

## User requests

Any user request of a new feature or change should go through the Issues function in the Github project. All requests should be promptly responded to, even if the decision to acknowledge the request is postponed.

## Translations

The initial translations of the software, FAQs, web interfaces and so on, are for the English, French and Swedish languages. Any user can contribute new languages for addition to the project, but any language added should be a complete translation of the current set of strings.

Any new language added to the software requires a person to be responsible for that translation. Since strings may change between releases, it is important that the new strings will be translated for all the languages.

There might be a need to have somebody to be responsible for translations, and that this responsibility includes having personal contacts with the translators. This role also has the responsibility for the translation documentation and processes.

## Packaging

Open source software is often shipped as software included in different operating system distributions. There are many people packaging software for these systems. Sometimes the open source projects takes its own responsibility to provide OS packages, especially if they have not yet been included in any distribution.

We should not package the software for any target OS, but we should have a friendly dialogue with the people that want to package Zonemaster in any distribution.

In the release process, there are often Release Candidate versions release before the actual release. These *RC* versions are often tested by the package maintainers, and it is also a good way to see that the release are working on the platforms that the software is distributed with. Therefore we want the package maintainers to test the package before we release any final version.

## Operational systems

A number of systems has to be maintained during the lifetime of the Zonemaster software.

### ASN Lookup

The ASN Lookup service asnlookup.zonemaster.net is (going to be) hosted by IIS, och is being managed alongside the current asnlookup.iis.se service. The operations department within IIS is running this service, and Zonemaster need an SLA for this service. Regular reports on the status of the operations is needed from the operations department.

This service might also be used as a collector for the statistics on the number of users of the software, since the default configuration for the software is to do ASN lookups from this service (the default can however be changed).

The software that runs the ASN Lookup service is rbldnsd, and the software itself is very robust and we don't expect the need to update the software.

### Github

The Github repository is a service run by the GitHub company. However, our repositories for the 
Zonemaster software belong to the Zonemaster organization within GitHub, and the Zonemaster 
organization is being managed by people from Afnic and IIS. 

The role of the repository manager is to add and remove members who have (write-)access the repository, the issues and the wiki.

### Mailinglists

There are a number of mailinglists set up for the project. The primary mailinglist for the management of the project is still named "new-dnscheck@lists.iis.se".

Two other mailinglists have been set up, that are more publically available:

 * zonemaster-users@lists.iis.se (the users list)
 * zonemaster-devel@lists.iis.se (the developers list, for dev talk and commit messages)
 
All lists are being maintained by the operations department within IIS.

The moderator and owner of the mailinglists have the responsibility to add and remove users on the lists (although the two public lists are open for subscription), and to moderate the lists if needed (remove spam and so on).

### Web site

There is no web site for the project yet, this text is TODO.

The web site needs content, and it has to be regularly updated to reflect changes in the project. Examples of content on the web site that has to be maintained:

 * About the project
 * Current versions of the software
 * Features of the software
 * Roadmap
 * How to get support
 * Documentation for users
 * Documentation for developers
 * License text
 * Download links

The Content editor has responsibility to update the content on the web site.

## Roles

A number of roles have been identified by the above processes and systems:

 * Developers
 * Code reviewer
 * Tester for QA
 * Translators
 * Release manager
 * Package maintainer
 * Roadmap owner
 * Github manager
 * Mailinglist moderator
 * Mailinglist owner
 * Support for questions on Github and mailinglists
 * Operator of website and ASN lookup service
 * Content editor, web site
