System testing
==============
Before a new version of Zonemaster can be released it must pass three levels of
system testing: Installation Testing, Smoke Testing and Acceptance Testing.
Each test level is described in a separate section below. A separate section is
reserved for the concept of Configurations, which is used by other sections.


## 1. Configurations

The purpose of configurations is to provide different contexts for the tests to
run in.

A configuration is a tuple of the following parameters:

* architecture (e.g. x86_64)
* operating system version (e.g. Ubuntu 14.04)
* database engine version (e.g. PostgreSQL 9.3)
* system locale (e.g. en_US.UTF-8)
* Perl version (e.g. 5.20)

The set of possible values for the following configuration parameters (except
for system locale) are declared in the README.md of the top-level zonemaster
repository.

The set of possible values for the system locale configuration parameter is:
* C
* sv_SE.UTF-8


## 2. Installation testing

This test level validates that all components of Zonemaster can be installed
according to their respective installation instructions.


### Configurations

The set of configurations must include at least:
* One configuration for each supported architecture.
* One configuration for each supported operating system version.
* One configuration for each supported database engine version.


### Procedure

1. Build a preliminary distribution tarball for each component

2. For each configuration:

   1. Prepare a machine
      1. Allocate a machine with the architecture specified by the configuration.
      2. Follow the preparation document for the operating system specified by the configuration.
         * CentOS-Preparation.md (unavailable at this time)
         * Debian-Preparation.md (unavailable at this time)
         * [FreeBSD-Preparation.md](https://github.com/dotse/zonemaster/blob/master/docs/internal-documentation/distrib-testing/FreeBSD-Preparation.md)
         * Ubuntu-Preparation.md (unavailable at this time)

   2. Install Zonemaster Engine
      1. Follow the [dependencies](https://github.com/dotse/zonemaster-engine/blob/master/docs/installation.md#dependencies) section of the installation guide to the letter.
      2. Install the preliminary distribution tarball for zonemaster-engine.
      3. Follow the [post-installation sanity check](https://github.com/dotse/zonemaster-engine/blob/master/docs/installation.md#post-installation-sanity-check) section of the installation guide to the letter.

   3. Install Zonemaster Backend
      1. Follow the [dependencies](https://github.com/dotse/zonemaster-backend/blob/master/docs/installation.md#dependencies)
         section of the installation guide to the letter.
      2. Install the preliminary distribution tarball for zonemaster-backend.
      3. Follow the [configuration](https://github.com/dotse/zonemaster-backend/blob/master/docs/installation.md#configuration) section of the installation guide to the letter.
      4. Follow the [startup](https://github.com/dotse/zonemaster-backend/blob/master/docs/installation.md#startup) section of the installation guide to the letter.
      5. Follow the [post-installation sanity check](https://github.com/dotse/zonemaster-backend/blob/master/docs/installation.md#post-installation-sanity-check) section of the installation guide to the letter.

   4. Install Zonemaster GUI
      1. Follow the prerequisites section of [installation.md](https://github.com/dotse/zonemaster-gui/blob/master/docs/installation.md)
         to the letter.
      2. Install the preliminary distribution tarball for zonemaster-backend.
      3. Follow the configuration, startup and sanity check sections of [installation.md](https://github.com/dotse/zonemaster-gui/blob/master/docs/installation.md)
         to the letter.

         *The following should be put into a sanity check section of [installation.md](https://github.com/dotse/zonemaster-gui/blob/master/docs/installation.md).*

         > ```
         > http://localhost/
         > ```
         >
         > You should be presented with a page showing, among other things the
         > Zonemaster logotype.

   5. Install Zonemaster CLI
      1. Follow the prerequisites section of [installation.md](https://github.com/dotse/zonemaster-cli/blob/master/docs/installation.md)
         to the letter.
      2. Install the preliminary distribution tarball for zonemaster-backend.
      3. Follow the configuration and sanity check sections of [installation.md](https://github.com/dotse/zonemaster-cli/blob/master/docs/installation.md)
         to the letter.

         *The following should be put into a sanity check section of [installation.md](https://github.com/dotse/zonemaster-cli/blob/master/docs/installation.md).*

         > ```
         > zonemaster-cli --version
         > ```
         >
         > The command is expected to list various version number information.

## 3. Smoke testing

This test level validates that fundamental use cases:

* work independent of specific configurations
* weren't broken by new changes


### Configurations

... To be specified.


### Procedure

For each configuration:

1. Prepare an installation

2. Smoke test of Zonemaster CLI

   * Test a working domain
     E.g. afnic.fr
   * Test working IDN
     E.g. президент.рф
   * Test a broken domain
     E.g. error.com
   * Working domains not signed with DNSSEC
     E.g. google.com
   * Working domains signed with DNSSEC
     E.g. iis.se
   * Broken DNSSEC domains
     E.g. broken.dnssec.ee

3. Smoke test of Zonemaster GUI

   * Test progress bar
   * Test presentation of results
   * Test export
   * Test history

## 4. Acceptance testing

This test level validates that new changes:

* work independent of specific configurations
* weren't broken by other new changes


### Configurations

...


### Procedure

1. Prepare an installation

2. Acceptance testing through Zonemaster CLI

   ... Test each new entry in the zonemaster-cli and zonemaster-engine components.

3. Acceptance testing through Zonemaster GUI

   ... Test each new entry in the zonemaster-gui, zonemaster-backend and zonemaster-engine components.
