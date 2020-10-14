Support criteria
================
This document hosts a set of guiding principles for selecting configuration
parameter items to support.


## General

It is legitimate to avoid supporting items that are otherwise perfectly eligible
for support, just for the sake of limiting the total number of configuration
tuples.


## Architectures

Zonemaster is actively tested on the amd64/x86_64 processor architecture.


## Operating systems

Zonesmaster is actively tested on these operating systems:

* CentOS
* Debian
* FreeBSD
* Ubuntu


## Operating system versions

### List of versions is set

The criteria below are used at the time of release of Zonemaster to determine what versions
that are supported for the version of Zonemaster to be released. That list of versions is
fixed for the lifetime of the Zonemaster version.

### Criteria

Minor version/point release/patch level should not be specified.

Operating system versions without long term support form their vendor should not be supported.

Operating system versions that have reached their end-of-life should not be supported.

Operating system versions that do not provide the prerequisites for Zonemaster should not be supported.

Operating system specific guidelines:

* CentOS:
  * Base Distributions are listed here:
    <https://en.wikipedia.org/wiki/CentOS#End-of-support_schedule>

* Debian:
  * Current versions of "stable" and "oldstable" are listed here:
    <https://wiki.debian.org/DebianReleases#Current_Releases.2FRepositories>

* FreeBSD:
  * Supported releases are listed here:
    <https://www.freebsd.org/security/>
  * FreeBSD 10: Releases that are supported by FreeBSD and being "extended" are supported by Zonemaster.
  * FreeBSD 11: Latest release version is supported.

* Ubuntu:
  * LTS releases are listed here:
    <https://wiki.ubuntu.com/Releases>


## Database engines

Zonemaster provides database integrations for these database engines:

* MySQL
* PostgreSQL
* SQLite


## Database engine versions

The database engine versions that are provided by the respective supported
operating system version should be supported.

Database engine versions that lack required features cannot be supported.

* Database engine versions provided by CentOS 7 are listed here:
  * http://mirror.centos.org/centos/7/os/x86_64/Packages/

* Database engine versions provided by each version of Debian are listed here:
  * <https://packages.debian.org/search?searchon=names&keywords=mariadb-server>
  * <https://packages.debian.org/search?searchon=names&keywords=mysql-server>
  * <https://packages.debian.org/search?searchon=names&keywords=postgresql>
  * <https://packages.debian.org/search?searchon=names&keywords=sqlite3>

* Database engine versions provided FreeBSD are listed here:
  * <https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=mysql>
  * <https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=postgresql>
  * <https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=sqlite3>

* Database engine versions provided by each version of Ubuntu are listed here:
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=mysql-server>
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=postgresql>
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=sqlite3>


## Translation locales

Can we say something about how the current triple of locales was chosen? How
about including new languages?


## System locales

A base line locale should be included.

Locales that expose classes of bugs should be included.


## Perl versions

The Perl versions that are provided by the respective supported operating system
version should be supported.

The point release should not be specified.

* Perl versions provided by CentOS 7 are listed here:
  * <http://mirror.centos.org/centos/7/os/x86_64/Packages/>

* Perl versions provided by each version of Debian are listed here:
  * <https://packages.debian.org/search?searchon=names&keywords=perl>

* Perl versions provided FreeBSD are listed here:
  * <https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=lang&query=perl>

* Perl versions provided by each version of Ubuntu are listed here:
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=perl>


## Nice-to-have resources

* [CentOS minor releases](https://wiki.centos.org/Download)
* [Debian point releases](https://wiki.debian.org/DebianReleases/PointReleases)
* [Ubuntu patch levels](https://wiki.ubuntu.com/Releases)
