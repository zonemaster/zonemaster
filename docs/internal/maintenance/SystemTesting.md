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
* en_US.UTF-8


## 2. Installation testing

This test level validates that all components of Zonemaster can be installed
according to their respective installation instructions.


### Configurations

The set of configurations must include at least:
* One configuration for each supported architecture.
* One configuration for each supported operating system version.
* One configuration for each supported database engine version.


### Procedure

1. Make sure you have the correct preliminary distribution tarball for each
   component. See [Create Test Distribution].

2. For each configuration:

   1. Prepare a machine
      1. Allocate a machine with the architecture specified by the configuration.
      2. Follow the preparation document for the operating system specified by the configuration.
         * [CentOS-Preparation]
         * [Debian-Preparation]
         * [FreeBSD-Preparation]
         * [Ubuntu-Preparation]
         * Rocky-Linux-Preparation (TBD)

   2. Install Zonemaster LDNS
      1. Make sure the [requirements for IDN support] are satisfied.
      2. Make sure that OpenSSL is installed.
      3. Install the preliminary distribution tarball for zonemaster-ldns.

         ```sh
         sudo cpanm Zonemaster-LDNS-${LDNS_VERSION}.tar.gz
         ```

      4. Make sure Zonemaster LDNS was properly installed.

         ```sh
         perl -MZonemaster::LDNS -le 'print Zonemaster::LDNS::has_idn()'
         ```

         The output from command should be "1".
      5. Follow the [post-installation sanity check][LDNS sanity check] section of the installation guide to the letter.

   3. Install Zonemaster Engine
      1. Install dependencies according to the [Engine installation] instructions.
      2. Install the preliminary distribution tarball for zonemaster-engine.

         ```sh
         sudo cpanm Zonemaster-Engine-${ENGINE_VERSION}.tar.gz
         ```

      3. Follow the [post-installation sanity check][Engine sanity check] section of the installation guide to the letter.

   4. Install Zonemaster Backend
      1. Install dependencies according to the [Backend installation] instructions.
      2. Install the preliminary distribution tarball for zonemaster-backend.

         ```sh
         sudo cpanm Zonemaster-Backend-${BACKEND_VERSION}.tar.gz
         ```

      3. Follow the configuration section of the [Backend installation] instructions to the letter.
      4. Follow the startup section of the [Backend installation] instructions to the letter.
      5. Follow the [smoke test] section of the installation guide to the letter.

   5. Install Zonemaster GUI
      1. Follow the prerequisites section of the [GUI installation] instructions to the letter.
      2. Follow the installation section of the [GUI installation] instructions to the letter.
      3. Follow the configuration section of the [GUI installation] instructions to the letter.
      4. Follow the startup section of the [GUI installation] instructions to the letter.
      5. Follow the [post-installation sanity check][GUI sanity check] section of the installation guide to the letter.

   6. Install Zonemaster CLI
      1. Follow the prerequisites section of the [CLI installation] installation to the letter.
      2. Install the preliminary distribution tarball for zonemaster-backend.

         ```sh
         sudo cpanm Zonemaster-CLI-${CLI_VERSION}.tar.gz
         ```

      3. Follow the [post-installation sanity check][CLI sanity check] section of the installation guide to the letter.


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

   1. Test a working domain (e.g. `afnic.fr`)
   2. Test working IDN (e.g. `президент.рф`)
   3. Test a broken domain (e.g. `error.com`)
   4. Working domains not signed with DNSSEC (e.g. `google.com`)
   5. Working domains signed with DNSSEC (e.g. `iis.se`)
   6. Broken DNSSEC domains (e.g. `broken.dnssec.ee`)

3. Smoke test of Zonemaster GUI

   1. Test progress bar
   2. Test presentation of results
   3. Test export
   4. Test history


## 4. Acceptance testing

This test level validates that each change since last release:

* works independent of specific configurations
* weren't broken by other new changes


### Configurations

... To be specified.


### Procedure

1. Prepare an installation

2. Acceptance testing through Zonemaster CLI

   Test each new entry in the Changes files of *Zonemaster CLI* and *Zonemaster Engine*.

4. Acceptance testing through Zonemaster Backend

   Test each new entry in the Changes file of *Zonemaster Backend*.

4. Acceptance testing through Zonemaster GUI

   Test each new entry in the Changes file of *Zonemaster GUI*.



[Backend installation]:         ../../public/installation/zonemaster-backend.md
[CLI installation]:             ../../public/installation/zonemaster-cli.md
[CLI sanity check]:             ../../public/installation/zonemaster-cli.md#post-installation-sanity-check
[CentOS-Preparation]:           ../distrib-testing/CentOS-build-environment.md
[Create Test Distribution]:     ../maintenance/ReleaseProcess-create-test-distribution.md
[Debian-Preparation]:           ../distrib-testing/Debian-build-environment.md
[Engine installation]:          ../../public/installation/zonemaster-engine.md
[Engine sanity check]:          ../../public/installation/zonemaster-engine.md#post-installation-sanity-check
[FreeBSD-Preparation]:          ../distrib-testing/FreeBSD-build-environment.md
[GUI installation]:             ../../public/installation/zonemaster-gui.md
[GUI sanity check]:             ../../public/installation/zonemaster-gui.md#post-installation-sanity-check
[LDNS sanity check]:            ../../public/installation/zonemaster-ldns.md#post-installation-sanity-check
[Requirements for IDN support]: https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md#idn
[Smoke test]:                   ../../public/installation/zonemaster-backend.md#61-smoke-test
[Ubuntu-Preparation]:           ../distrib-testing/Ubuntu-build-environment.md
