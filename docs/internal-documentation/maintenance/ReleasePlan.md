# Zonemaster - Release Plan

## Scope
This document outlines the release management process. The 
[Release Process document](
https://github.com/dotse/zonemaster/blob/master/docs/internal-documentation/maintenance/ReleaseProcess.md) outlines the
release process steps.

## Release features
* a. Classify the issues from the "issue tracker" based on "minor" and
"major" changes 
* b. Identify the level of importance/resource/time available for
completing the issue
* c. Prioritize the identified issues based on (b) and include them in
the respective "release schedule" 

The minor or major features that are part of each release are determined by the development team.

## Release schedule
The release schedule is to be created based on _minor releases_ or _major releases_ of the Zonemaster components, i.e.
releases that changes functionality, and not only fixes bugs or erros.

When needed, _patch releases_ of the components are published.

When one or more components have been updated (release has been published), the Zonemaster product is also
released. Such a release of the Zonemaster product, could include a mixture of major, minor and patch releases of 
the components.

### Version numbering policy
See [Versions and Releases](https://github.com/dotse/zonemaster/blob/master/docs/design/Versions%20and%20Releases.md) for how to number each release.

## Release process

In order to create a release, there are a number of tasks that has to be done in the chronological order:
* Agree the release type (major/minor/patch) release
* Agree under which schedule the release will be done
* Announce to the steering committee
* Implementation
* Updating the documenation
* Complete all testing
* Code reviews
* Run code integrity tools
* Quality assurance
* Generate the release  
* Announce to the public, the features in the release
* Translations
* Friendly notice to any package maintainers that wants to package the  new version.

#### Explanation of each process (ToDo)

-------

Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2017, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
