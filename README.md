![Zonemaster](docs/images/zonemaster_logo_black.png)
==========

### Background

DNSCheck from IIS and Zonecheck from AFNIC are two different software
packages that do DNS validation of the quality of a DNS
delegation. AFNIC and IIS decided to develop a new DNS validation tool from the
scratch under the name "Zonemaster". 

The Zonemaster implementation intends to be a major
rewrite of the existing DNS validation tools developed by AFNIC (Zonecheck) and
IIS (DNSCheck), and implement the best parts of both.

### Purpose

The components developed as part of the Zonemaster project will help different
types of [users](USING.md) to check domain servers for configuration errors and
generate a report that will enable to fix the errors.

The ambition of the Zonemaster project is to develop and maintain an open source
DNS validation tool, offering better performance than the existing tools and
provide extensive documentation which could be re-used by similar projects in
the future.

### Documentation

The repository you are looking at is the main project repository. In this
repository, documentation regarding the [design](docs/design),
[requirements](docs/requirements) and [specifications](docs/specifications)
for the zonemaster implementation are available.

Also, in this repository, you can find a brief [user guide](USING.md).

### Prerequisites

Zonemaster comes with documentation for and has been tested with these
technologies:

Supported processor architectures:

* x86_64 / amd64

Supported operating system versions:

* CentOS 7
* Debian 7.11
* Debian 8.6
* FreeBSD 10.1
* FreeBSD 10.3
* Ubuntu 14.04
* Ubuntu 16.04

Supported database engine versions:

* MySQL 5.5, 5.7
* PostgreSQL 9.3, 9.4, 9.5

Supported Perl versions:

* Perl 5.14, 5.16, 5.18, 5.20, 5.22

### Localization

Zonemaster comes with localization for these locales:

* en.UTF-8
* fr.UTF-8
* sv.UTF-8

### Repositories

The Zonemaster project has four different repositories. All the software for
the Zonemaster project lies in these four repositories. The software has not yet
been packaged for any operating systems, and you have to install most of it from
the source code.

In order to install and run the different components, have a look at the
installation documentation under each of the repositories below:

 * [zonemaster-engine](https://github.com/dotse/zonemaster-engine) - which
   contains the test framework.
 * [zonemaster-cli](https://github.com/dotse/zonemaster-cli) - a Command Line
   Interface for the engine.
 * [zonemaster-backend](https://github.com/dotse/zonemaster-backend) - which
   interfaces between the GUI and an API with the engine.
 * [zonemaster-gui](https://github.com/dotse/zonemaster-gui) - A graphical user
   interface for the engine.

### Participation

The core development team are people from IIS and Afnic. However, you
can submit code by forking this repository and create pull requests.

You can follow the project in these two mailinglists:

 * [zonemaster-users](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-users)
 * [zonemaster-devel](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-devel)

### Contact or Bug reporting 

For any contacts or bug reporting, please send a mail to
"contact@zonemaster.net".

