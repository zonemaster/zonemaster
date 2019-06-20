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
   component.

2. For each configuration:

   1. Prepare a machine
      1. Allocate a machine with the architecture specified by the configuration.
      2. Follow the preparation document for the operating system specified by the configuration.
         * CentOS-Preparation.md (unavailable at this time)
         * [Debian-Preparation.md](https://github.com/zonemaster/zonemaster/blob/master/docs/internal-documentation/distrib-testing/Debian-Preparation.md)
         * [FreeBSD-Preparation.md](https://github.com/zonemaster/zonemaster/blob/master/docs/internal-documentation/distrib-testing/FreeBSD-Preparation.md)
         * Ubuntu-Preparation.md (unavailable at this time)

   2. Install Zonemaster LDNS
      1. Make sure the requirements for IDN support in [the IDN section](https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md#idn) section are satisfied.
      2. Make sure that OpenSSL is installed.
      3. Install the preliminary distribution tarball for zonemaster-ldns.

         ```sh
         sudo cpanm Zonemaster-LDNS-${LDNS_VERSION}.tar.gz
         ```

      3. Make sure Zonemaster LDNS was properly installed.

         ```sh
         perl -MZonemaster::LDNS -le 'print Zonemaster::LDNS::has_idn()'
         ```

         The output from command should be "1".

   3. Install Zonemaster Engine
      1. Install dependencies according to the [installation instruction](https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Installation.md).
      2. Install the preliminary distribution tarball for zonemaster-engine.

         ```sh
         sudo cpanm Zonemaster-Engine-${ENGINE_VERSION}.tar.gz
         ```

      3. Follow the [post-installation sanity check](https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Installation.md#post-installation-sanity-check) section of the installation guide to the letter.

   4. Install Zonemaster Backend
      1. Install dependencies according to the [installation instruction](https://github.com/zonemaster/zonemaster-backend/blob/master/docs/Installation.md).
      2. Install the preliminary distribution tarball for zonemaster-backend.

         ```sh
         sudo cpanm Zonemaster-Backend-${BACKEND_VERSION}.tar.gz
         ```

      3. Follow the [configuration](https://github.com/zonemaster/zonemaster-backend/blob/master/docs/Installation.md#configuration) section of the installation guide to the letter.
      4. Follow the [startup](https://github.com/zonemaster/zonemaster-backend/blob/master/docs/Installation.md#startup) section of the installation guide to the letter.
      5. Follow the [smoke test] section of the installation guide to the letter.

   5. Install Zonemaster GUI
      1. Follow the prerequisites section of [installation.md](https://github.com/zonemaster/zonemaster-gui/blob/master/docs/Installation.md)
         to the letter.
      2. Install the preliminary distribution tarball for zonemaster-backend.

         ```sh
         sudo cpanm Zonemaster-GUI-${GUI_VERSION}.tar.gz
         ```

      3. Follow the configuration, startup and sanity check sections of [installation.md](https://github.com/zonemaster/zonemaster-gui/blob/master/docs/Installation.md)
         to the letter.

         *The following should be put into a sanity check section of [installation.md](https://github.com/zonemaster/zonemaster-gui/blob/master/docs/Installation.md).*

         > ```
         > http://localhost/
         > ```
         >
         > You should be presented with a page showing, among other things the
         > Zonemaster logotype.

   6. Install Zonemaster CLI
      1. Follow the prerequisites section of [installation.md](https://github.com/zonemaster/zonemaster-cli/blob/master/docs/Installation.md)
         to the letter.
      2. Install the preliminary distribution tarball for zonemaster-backend.

         ```sh
         sudo cpanm Zonemaster-CLI-${CLI_VERSION}.tar.gz
         ```

      3. Follow the configuration and sanity check sections of [installation.md](https://github.com/zonemaster/zonemaster-cli/blob/master/docs/Installation.md)
         to the letter.

         *The following should be put into a sanity check section of [installation.md](https://github.com/zonemaster/zonemaster-cli/blob/master/docs/Installation.md).*

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



[smoke test]: https://github.com/zonemaster/zonemaster-backend/blob/master/docs/Installation.md#71-smoke-test
