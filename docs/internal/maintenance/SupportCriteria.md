Support criteria
================
This document hosts a set of guiding principles for selecting configuration
parameter items to support.


## General

It is legitimate to avoid supporting items that are otherwise perfectly eligible
for support, just for the sake of limiting the total number of configuration
tuples.


## Architectures

Zonemaster is actively tested on the amd64/x86_64 processor architecture. No
testing is currently done on ARM architecture.


## Operating systems

Zonemaster is actively tested on the following operating systems:

* Debian
* FreeBSD
* Rocky Linux
* Ubuntu

CentOS is no longer supported and has been replaced by Rocky Linux.

## Operating system versions

### List of versions is set

The criteria below are used at the time of release of Zonemaster to determine what versions
that are supported for the version of Zonemaster to be released. That list of versions is
fixed for the lifetime of the Zonemaster version.

### Criteria

The following criteria are used to determine which version of the operating
system that is supported:
  * Minor version/point release/patch level should not be specified.
  * Operating system versions without long term support form their
    vendor should not be supported.
  * Operating system versions that have reached their end-of-life (or end of
    general support) should not be supported.
  * Operating system versions that are expected to reach their end-of-life (or
    end of general support) within the lifetime of the Zonemaster version should
    not be supported.
  * Operating system versions that do not provide the prerequisites for
    Zonemaster should not be supported.

### Operating system specific guidelines

* Debian:
  * Only the current "stable" release is supported.
  * Current "stable" is listed on
    <https://wiki.debian.org/DebianReleases#Current_Releases.2FRepositories>.

* FreeBSD:
  * One major branch is supported. The selected major branch is supported for
    its lifetime, and then replaced by the newest major branch. The replacement
    is done when EOL will be reached within the expected lifetime of the
    Zonemaster release.
  * For the selected major release, only the newest point release is tested.
  * The active major branches are found on <https://www.freebsd.org/security/>
    (scroll down to "Supported FreeBSD releases").

* Rocky Linux:
  * All major versions that have not reached EOL are supported.
    * If the the EOL of a major version is within the expected lifetime of the
      Zonemaster release then that major version is not supported.
  * Only the newest point release is tested.
  * Active releases are listed on <https://rockylinux.org/download> and
    <https://en.wikipedia.org/wiki/Rocky_Linux#Releases>.

* Ubuntu:
  * All LTS versions that have not reached the "End of Standard Support" are
    supported.
    * If the "End of Standard Support" for an LTS version is within the expected
      lifetime of the Zonemaster release then that LTS version is not supported.
  * For each LTS version, only the newest point release is tested.
  * LTS releases are listed on <https://wiki.ubuntu.com/Releases>.


## Database engines

Zonemaster provides database integrations for these database engines:

* MariaDB (MySQL)
* PostgreSQL
* SQLite (included in Zonemaster-Backend dependency)


## Database engine versions

The database engine versions that are provided by the respective supported
operating system version should be supported.

Database engine versions that lack required features cannot be supported.

* Database engine versions provided by each version of Debian are listed here:
  * <https://packages.debian.org/search?searchon=names&keywords=mariadb-server>
  * <https://packages.debian.org/search?searchon=names&keywords=postgresql>

* Database engine versions provided FreeBSD are listed here:
  * <https://www.freebsd.org/cgi/ports.cgi?query=mysql&stype=name&sektion=databases>
    and look for "mysql??-server-*" (FreeBSD does not support MariaDB in a
    default Backend installation).
  * <https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=databases&query=postgresql>

* Database engine versions provided by each version of Rocky Linux are listed here: TBP

* Database engine versions provided by each version of Ubuntu are listed here:
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=mariadb-server>
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=postgresql>


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

* Perl versions provided by each version of Debian are listed here:
  * <https://packages.debian.org/search?searchon=names&keywords=perl>

* Perl versions provided FreeBSD are listed here:
  * <https://www.freebsd.org/cgi/ports.cgi?stype=name&sektion=lang&query=perl>

* Perl versions provided by each version of Rocky Linux are listed here: TBP

* Perl versions provided by each version of Ubuntu are listed here:
  * <https://packages.ubuntu.com/search?suite=default&section=all&arch=any&searchon=names&keywords=perl>


## Nice-to-have resources

* [Debian point releases](https://wiki.debian.org/DebianReleases/PointReleases)
* [Ubuntu patch levels](https://wiki.ubuntu.com/Releases)
