Support criteria
================
This document hosts a set of guiding principles for selecting configuration
parameter items to support.


## General

It is legitimate to avoid supporting items that are otherwise perfectly eligible
for support, just for the sake of limiting the total number of configuration
tuples.


## Architectures

Can we say something about how we chose to support only amd64/x86_64 and nothing
else?


## Operating systems

Can we say something about how the current quartet of operating systems was
chosen?


## Operating system versions

Minor version/point releases should be specified. Patch levels should not be specified.

Operating system versions without long term support form their vendor should not be supported.

Operating system versions that have reached their end-of-life should not be supported.

Operating system versions that do not provide the prerequisites for Zonemaster should not be supported.

Operating system specific guidelines:

* CentOS:
  * Base Distributions are listed here:
    https://en.wikipedia.org/wiki/CentOS#End-of-support_schedule
  * The current minor releases are listed at:
    https://wiki.centos.org/Download

* Debian:
  * Current versions of "stable" and "oldstable" are listed here:
    https://wiki.debian.org/DebianReleases#Current_Releases.2FRepositories
  * The current point releases are listed here:
    https://wiki.debian.org/DebianReleases/PointReleases

* FreeBSD:
  * Extended releases are listed here:
    https://www.freebsd.org/security/
  * Patch level should not be specified.

* Ubuntu:
  * LTS releases are listed here:
    https://wiki.ubuntu.com/Releases
  * The supported patch level is the one specified at:
    https://wiki.ubuntu.com/Releases


## Database engines

Can we say something about how the current triple of database engines was
chosen?


## Database engine versions

The database engine versions that are provided by the respecive supported
operating system version should be supported.

Database engine versions that lack required features cannot be supported.

* Database engine versions provided by CentOS 7 are listed here:
  * http://mirror.centos.org/centos/7/os/x86_64/Packages/

* Database engine versions provided by each version of Debian are listed here:
  * https://packages.debian.org/search?searchon=names&keywords=mysql-server
  * https://packages.debian.org/search?searchon=names&keywords=postgresql
  * https://packages.debian.org/search?searchon=names&keywords=sqlite3

* Database engine versions provided FreeBSD are listed here:
  * https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=mysql
  * https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=postgresql
  * https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=sqlite3

* Database engine versions provided by each version of Ubuntu are listed here:
  * http://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=mysql-server
  * http://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=postgresql
  * http://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=sqlite3


## Translation locales

Can we say something about how the current triple of locales was chosen? How
about including new languages?


## System locale

Zonemaster promises to behave correctly when the system locale is set to one of
these locales.

... Do we support all possible locales in this sense? Since we cannot reasonably
perform testing for all possible locales, supported system locales are grouped
into a small set of "tier 1" system locales to be used in test configurations,
and the remaining "tier 2" system locales.
