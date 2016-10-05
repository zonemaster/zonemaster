Support criteria
================
As we increase the number of items in each category below the total number of
combinations we support grows geometrically. It is imperative that the number of
items in each category is limited.


### Architecture
The only architecture we support is amd64/x86_64.


### Operating systems
The following operating systems are supported:

* Centos
* Debian
* FreeBSD
* Ubuntu


### Operating system versions
For each supported operating system, the supported versions are determined using
the following criteria.

* CentOS:
  * The supported versions are the Base Distributions (excluding 5 and 6) as
    specified at: 
    https://en.wikipedia.org/wiki/CentOS#End-of-support_schedule
  * The supported minor release is the one specified at:
    https://wiki.centos.org/Download

* Debian:
  * The supported versions are "stable" and "oldstable" as specified at: 
    https://wiki.debian.org/DebianReleases#Current_Releases.2FRepositories
  * The supported point release is the current one as specified at:
    https://wiki.debian.org/DebianReleases/PointReleases

* FreeBSD:
  * The supported versions are the Extended releases (excluding 9.3) as
    specified at: https://www.freebsd.org/security/
  * Patch level should not be specified.

* Ubuntu:
  * The supported versions are the LTS releases (excluding 12.04) as specified
    at: https://wiki.ubuntu.com/Releases
  * The supported patch level is the one specified at:
    https://wiki.ubuntu.com/Releases


Database engines
----------------
The following database engines are supported:

* MySQL
* PostgreSQL
* SQLite


Database engine versions
------------------------
The set of supported DB engine versions depends on which ones are provided by
the respective supported OS versions. This selection is limited by a few general
criteria.

* General criteria

  * PostgreSQL versions < 9.3 are excluded from support.
  * If an OS version supports multiple versions of a given DB engine, all
    versions that aren't already mandated by another by another OS version are
    excluded from support. (In the unlikely case that this results in no
    versions being supported, an exception is made and a previously supported
    version or the highest version is supported anyway.)

    *Note: This is an incredibly complicated formulation. I will happily replace
    it with something better.*

* CentOS

  The supported DB engine versions are *all versions* provided by the respective
  OS version as specified here:

  * http://mirror.centos.org/centos/7/os/x86_64/Packages/

  *How do we determine what MySQL version(s) to support for CentOS?*

* Debian

  The supported DB engine versions are *all versions* provided by the respective
  OS version as specified here:

  * https://packages.debian.org/search?searchon=names&keywords=mysql-server
  * https://packages.debian.org/search?searchon=names&keywords=postgresql
  * https://packages.debian.org/search?searchon=names&keywords=sqlite3

* FreeBSD

  The supported DB engine versions is *a subset of the versions* provided by the respective OS
  version as specified here:

  * https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=mysql
  * https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=postgresql
  * https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=sqlite3

* Ubuntu

  The supported DB engine versions are *all versions* provided by the respective
  OS version as specified here:

  * http://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=mysql-server
  * http://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=postgresql
  * http://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=sqlite3


Translation locales
-------------------
The set of supported language locales is decided by the Zonemaster steering
committee.


System locales
--------------
Zonemaster promises to behave correctly when the system locale is set to one of
these locales. Do we support all possible locales in this sense?

Since we cannot reasonably perform testing for all possible locales, supported
system locales are grouped into a small set of "tier 1" system locales to be
used in test configurations, and the remaining "tier 2" system locales.

*How do we pick the "tier 1" set of locales? See [SystemTesting.md#2.%20Configurations].*
