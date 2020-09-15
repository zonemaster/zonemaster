Release process - Preparation
=============================


The steps in this document should be processed early in the release
process, definitely before acceptance testing starts, but also before
development has been completed.


## 1. Update prerequisites

Make sure the [declaration of prerequisites] in main README.md is up to date
with regard to [SupportCriteria].


## 2. Update [CI] configuration

Make sure the Travis configuration for each repo, in the `develop` branch
is up to date with the [supported Perl versions] in main README.md.

 * zonemaster-ldns - [.travis.yml][ldns.travis]
 * zonemaster-engine - [.travis.yml][engine.travis]
 * zonemaster-cli - [.travis.yml][cli.travis]
 * zonemaster-backend - [.travis.yml][backend.travis]

(zonemaster-gui uses no Perl and (zonemaster/zonemaster uses no Travis.)


## 3. Verify that META.yml will have all the correct data

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster.

META.yml is created by Makefile.PL so if META.yml is not correct, then
Makefile.PL must be updated.

  1. Make a clean clone for each repo.
  2. Check out the `develop` branch.
  3. Run
```
     perl Makefile.PL --no-ed25519 # zonemaster-ldns only
     perl Makefile.PL              # other repositories
```
  4. Verify that META.yml contains all the paths in the table in [Appendix META]
     below and that the value at each path matches the listed requirement.


## 6. Verify that MANIFEST and MANIFEST.SKIP are up to date

> This section is *NOT* relevant for Zonemaster-GUI or Zonemeaster/Zonemaster.

MANIFEST must, directly or indirectly, list all files that should be installed.
MANIFEST.SKIP must list all file that should not be installed, and what is
counted are all files available when `make dist` is run.


## Appendix META

Requirements for generated META.yml file.

Property             | Requirement
---------------------|----------------------------------------------------------------------
abstract             | component tag line
author               | current maintainer and original author
license              | [license string]
name                 | name of the component
recommends           | all modules that aren't strictly required but still used if available
requires             | all required modules
requires.perl        | minimum perl version
resources.bugtracker | link to the bug tracker
resources.license    | link to the license text
resources.repository | link to the repository
version              | version number of the new release


<!-- Zonemaster links point on purpose on the develop branch. -->
[CI]:                                      https://github.com/travis-ci/travis-ci
[declaration of prerequisites]:            https://github.com/zonemaster/zonemaster/blob/develop/README.md#prerequisites
[license string]:                          https://metacpan.org/pod/CPAN::Meta::Spec#license
[SupportCriteria]:                         https://github.com/zonemaster/zonemaster/blob/develop/docs/internal-documentation/maintenance/SupportCriteria.md
[ldns.travis]:                             https://github.com/zonemaster/zonemaster-ldns/blob/develop/.travis.yml
[engine.travis]:                           https://github.com/zonemaster/zonemaster-engine/blob/develop/.travis.yml
[cli.travis]:                              https://github.com/zonemaster/zonemaster-cli/blob/develop/.travis.yml
[backend.travis]:                          https://github.com/zonemaster/zonemaster-backend/blob/develop/.travis.yml
[supported Perl versions]:                 https://github.com/zonemaster/zonemaster/blob/develop/README.md#supported-perl-versions
[Appendix META]:                           #appendix-meta
