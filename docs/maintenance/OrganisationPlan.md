# Zonemaster - Organization plan

## Internal organization 

A number of roles have been identified during the maintenance period : 
* Test specification document owner
* Developers
* Code reviewer
* Tester for Quality Assurance
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
* Test Specification Manager
* Service manager
* Technical manager
* Steering Committee

### Test specification document owner
Test requirement for the Zonemaster project are discussed, evaluated and then finalised. Once a test requirement is finalised to be part of the validation process of the tool, test specifications are written. The test specifications are classified into different categories (such as DNSSEC test, Consistency test etc..). For each category of the test, there is a test specification document owner. 

His/Her's responsibilites essentially includes:
* Write the test specifications
* Make sure that the test specification written (if any of the test case is being written by any other team member) is as per the required criteria
* If there is a modification requirement arises, after the test specifiation is written, review and modify the test specification if the comment is appropriate
* Participate in the TRTF proceedings and contribute

### Developers
Responsibilities essentially include:
* Implement the code that follows the specification
* Do unit tests to ensure that the functionality is complete and major use cases pass
* Respond to the comments provided by the code reviewer and make necessary corrections if needed	
* Make comments for modifying the test specification, if a need arises

All comments by the developer should be recorded in the Github issue tracker.

### Code reviewer
The code should be reviewed by a developer other than the one who has developed the code

Responsibilities essentially include:
* Should have a knowledge of the test specification
* Review the code to check 
  * for bugs 
  * style issues
  * Architectural issues - such as recommendation for a better way to accomplish the goal
All comments by the reviewer should be recorded in the Github issue tracker.

### Tester for Quality Assurance (QA)
The changes in each release are tested against the specification. This role should be done ideally by a developer other than the one who has developed the code or a tester.

Responsibilities essentially include:
* Manual testing of the features to include success and failure cases and corner cases
* Check whether the code corresponds to the specifications
* Conduct regression tests should then also be put in place to cover the functionality

Any issues found are recorded on the Github issue tracker for the development for the original developer to fix before re-testing. For major developments a separate testing issue may be created.

### Translators
The initial translations of the software, FAQs, web interfaces and so on, are for the English, French and Swedish languages. Any user can contribute new languages for addition to the project, but any language added should be a complete translation of the current set of strings.

Any new language added to the software requires a person to be responsible for that translation. Since strings may change between releases, it is important that the new strings will be translated for all the languages.

There might be a need to have somebody to be responsible for translations, and that this responsibility includes having personal contacts with the translators. This role also has the responsibility for the translation documentation and processes.

### Release Manager
The release managers are responsible for going through the Github issue tracker for any new issues and delegate the issue to a responsible developer for fixing the problem. The issue should also be prioritized and planned for a release. When possible, the full dialogue with the reporter of the issue should go into this Github issue.

The Release Manager is responsible for the Release Process and the Release Management Process, and can veto the decision to execute the release.

The release manager could also sometimes play the role of code reviewer.

### Package Maintainer 
Package maintainers test the package before the release of any final version.

The RC versions are often tested by the package maintainers, and it is also a good way to see that the release are working on the platforms that the software is distributed with.

### Roadmap Owner
The roadmap is a public document in the Github source code tree or wiki.

The Roadmap owner has the responsibility for the roadmap, and decides on the content and timing of each release in coordination with project management and the developer team.

### Github manager
The Github manager is responsible for handling issues related to the github.

Responsibilities essentially includes:
* Managing github accounts such as creating/removing accounts, access right for account holders to each repositories etc..
* Managing github repositories such as creating/removing repositories	

Decision taken by github manager should be in consensus with release and technical manager.

### Mailinglist moderator
The moderator of the mailinglists have the responsibility to moderate the lists if needed (remove spam and so on).

### Mailinglist owner
The owner of the mailinglists have the responsibility to add and remove users and provide appropriate access rights for users on the lists (although the two public lists are open for subscription). 

### Support for questions on Github and mailinglists
This role is oriented to end-user support. There could be multiple team members playing the support role. For each repository in the project there should be a team member mandated. 

His/her responsibilities essentially includes responding to the question posed in a timely manner (or) orienting the question posed to a specific member of the team.

### Operator of GUI and ASN lookup service

The operator of the GUI is intended to do the following
* Make sure that the service is up 
* Monitor the service as well as the different modules required to run the service
* Collect user statistics and able to furnish them when necessary

The operator of the ASN look up service is intended to do the following:
* Make sure that the service is up
* Monitor the service as well as the different modules required to run the 
  service
* Collect user statistics and able to furnish them when necessary

### Content editor, web site 
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

### Test Specification Manager
The Test specification Manager responsibilities essentially include: 
* Being responsible for the Zonemaster’s Test Specification document and keep a dialog with the Internet community on its development. Specifically shall the Test specification Manager lead the work within Centr’s TRTF (Tests Requirements Task Force).
* Ongoing Status reporting to the Service Manager.

### Service manager
Responsibilities essentially include:
* Responsible for Zonemaster’s day to day business with the Internet community and ensure that it is run and developed optimally in accordance with the approved Service Plan
* Owner of Zonemaster’s Service Plan
* Prioritize the work of the development team and provide the Technical Manager with a road map for the development of Zonemaster software and approve the delivery of the results
* Ongoing Status reporting to the steering committee including progress and financial monitoring of the service
* Participate in the steering committee’s meetings
* Communicate the Steering Committee’s decisions and to the technical team and other concerned parties
* Accountable of and delegate the technical issues concerning the Zonemaster’s software to the Technical Manager and keep a close cooperation with him/her
* Involve both Afnic’s and .SE’s internal marketing and communication teams. 

### Technical manager

Responsibilities essentially include: 
* Responsible for the Zonemaster’s software published as open source in accordance with the requirements of Zonemaster’s Service Plan
* Leading the development teams work
* Keep the Service Manager updated on the work of the development teams the status of the Zonemaster software, by notably reporting on achieved milestones and resources consumed (e.g. the monthly time report)
* Assist the Service Manager in hers/his work to produce Zonemaster’s Service Plan
* Organise fortnightly meetings with the team and the service manager

### Steering Committee

Responsibilities essentially include: 
* Evaluate the effectiveness and adherence to the MoU.
* Appoint the roles within Zonemaster’s organization, including the Service manager, Technical Manager and Test specification document owner 
* Responsible for the strategic direction of Zonemaster
* Approve Zonemaster’s Service Plan including budget, goals, product roadmap, and a promotion and communication plan
* Meet on a monthly bases, evaluate status reports, and if needed handle escalated issues and make decisions

## Responsibility assignment matrix (RACI)

|Tasks|Steering Committee|Service Manager|Technical Manager|Test Specification Manager|
|-----|:----------------:|:-------------:|:---------------:|-------------------------:|
|Adherence to the MoU| AR | I | I | I |
|Organization for ZM | AR | I | I | I |
|ZM's Service Plan   | A  | R | C | C |
|ZM's Software       | I  | A | R | I |
|ZM's Test Specification| I | A | I | R |

* R : Responsible
* A : Accountable
* C : Consulted
* I : Informed

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
