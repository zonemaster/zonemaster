# Prerequisites

Zonemaster comes with documentation for and has been tested on the operating systems
and processor architecture listed below.

## Supported processor architectures

* x86_64 / amd64

## Supported operating system versions

* [Debian] 12
* [Docker]
* [FreeBSD] 14.0
* [Rocky Linux] 8.9
* [Rocky Linux] 9.3
* [Ubuntu] 20.04
* [Ubuntu] 22.04

Only the latest long-term supported version of Debian and FreeBSD, respectively,
is supported. All long-term supported versions of Rocky Linux and Ubuntu are
supported, unless such a version has end of support before the expected next
release of Zonemaster.

Only the Docker images provided by the Zonemaster project on [Docker Hub] are
supported. Currently only Zonemaster-CLI is supported on Docker. Docker itself
can run on any of the [Docker] supported OSs (Linux, MacOS and Windows).

[Rocky Linux] has replaced CentOS in Zonemaster version v2021.2 since CentOS 8
is not supported anymore and CentOS 7 is old and does not support modern OpenSSL
required by Zonemaster. Rocky Linux is also a Red Hat derivative and is available
at large cloud providers.

## Supported database engine versions

Operating System | MariaDB | PostgreSQL
---------------- | --------| ---------------
Debian 12        | 10.11   | 15.5
Docker           | n/a     | n/a
FreeBSD 14.0     | 8.0 (*) | 15
Rocky Linux 8.9  | ?       | ?
Rocky Linux 9.3  | 10.5    | 13.11
Ubuntu 20.04     | 10.3    | 12.17
Ubuntu 22.04     | 10.6    | 14.10

* (*) FreeBSD uses MySQL, not MariaDB.
* SQLite is bundled in Perl DBD::SQLite and loaded as a dependency to
  Zonemaster-Backend.
* Zonemaster Backend has been tested with the combination of OS and database
  engine version listed in the table above.
* Zonemaster depends on functionality introduced in PostgreSQL version 10, and
  earlier versions of PostgreSQL are as such not supported.
* Zonemaster Backend has not been published on [Docker Hub].

## Supported Perl versions

Operating System | Perl
---------------- | ----
Debian 12        | 5.36
Docker           | (*)
FreeBSD 14.0     | 5.38
Rocky Linux 8.9  | 5.32
Rocky Linux 9.3  | 5.32
Ubuntu 20.04     | 5.30
Ubuntu 22.04     | 5.34

* Zonemaster requires Perl version 5.16 or higher.
* Zonemaster has been tested with the default version of Perl in the OSs as
  listed in the table above.
* (*) Perl is included in the Docker image published on [Docker Hub].

## Supported Client Browser versions

Zonemaster GUI is tested against the combination and browser in the table below.
The latest version of the browser at the time of testing is used.

Operating System | Browser
---------------- | -------
Debian 12        | Firefox
MacOS 13         | Firefox
MacOS 13         | Chrome
Windows 10       | Firefox
Windows 10       | Chrome
Ubuntu 22.04     | Firefox
Ubuntu 22.04     | Chrome

Zonemaster GUI is tested manually and with testing tools. See the
[Zonemaster-gui repository][Zonemaster-GUI] for more details.

[Debian]:                              https://www.debian.org/
[Docker Hub]:                          https://hub.docker.com/u/zonemaster
[Docker]:                              https://www.docker.com/get-started/
[FreeBSD]:                             https://www.freebsd.org/
[Rocky Linux]:                         https://rockylinux.org/
[Ubuntu]:                              https://ubuntu.com/
[Zonemaster-GUI]:                      https://github.com/zonemaster/zonemaster-gui
