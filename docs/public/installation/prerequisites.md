# Prerequisites

Zonemaster comes with documentation for and has been tested on the operating systems
and processor architecture listed below.

## Supported processor architectures

* x86_64 / amd64

## Supported operating system versions

* [Debian] 13
* [Docker]
* [FreeBSD] 14
* [Rocky Linux] 8
* [Rocky Linux] 9
* [Rocky Linux] 10
* [Ubuntu] 22.04
* [Ubuntu] 24.04

Only the latest long-term supported version of Debian and FreeBSD, respectively,
is supported. All long-term supported versions of Rocky Linux and Ubuntu are
supported, unless such a version has end of support before the expected next
release of Zonemaster.

Only the Docker images provided by the Zonemaster project on [Docker Hub] are
supported. Currently only Zonemaster-CLI is supported on Docker. Docker itself
can run on any of the [Docker] supported OSs (Linux, macOS and Windows).

## Supported database engine versions

| Operating System | MariaDB | PostgreSQL |
|------------------|---------|------------|
| Debian 13        | 11.8    | 17         |
| Docker           | n/a     | n/a        |
| FreeBSD 14       | 8.0 (*) | 17         |
| Rocky Linux 8    | 10.3    | 10        |
| Rocky Linux 9    | 10.5    | 13         |
| Rocky Linux 10   | 10.11   | 16         |
| Ubuntu 22.04     | 10.6?   | 14?        |
| Ubuntu 24.04     | 10.11   | 16         |

* (*) FreeBSD uses MySQL, not MariaDB.
* SQLite is bundled in Perl DBD::SQLite and loaded as a dependency to
  Zonemaster-Backend.
* Zonemaster Backend has been tested with the combination of OS and database
  engine version listed in the table above.
* Zonemaster depends on functionality introduced in PostgreSQL version 10, and
  earlier versions of PostgreSQL are as such not supported.
* Zonemaster Backend has not been published on [Docker Hub].

## Supported Perl versions

| Operating System | Perl  |
|------------------|-------|
| Debian 13        | 5.40  |
| Docker           | (*)   |
| FreeBSD 14       | 5.42  |
| Rocky Linux 8    | 5.26  |
| Rocky Linux 9    | 5.32  |
| Rocky Linux 10   | 5.40  |
| Ubuntu 22.04     | 5.34? |
| Ubuntu 24.04     | 5.38  |


* Zonemaster technically requires Perl version 5.26 or higher, but has only been tested with the versions in the table above.
* Zonemaster has been tested with the default version of Perl in the OSs as
  listed in the table above.
* (*) Perl is included in the Docker images published on [Docker Hub].

## Supported Client Browser versions

Zonemaster GUI is tested on the browsers in the table below.
The latest version of the browser at the time of testing is used.

Browser |
------- |
Firefox |
Chrome  |


Zonemaster GUI is tested manually and with testing tools. See the
[Zonemaster-gui repository][Zonemaster-GUI] for more details.

[Debian]:                              https://www.debian.org/
[Docker Hub]:                          https://hub.docker.com/u/zonemaster
[Docker]:                              https://www.docker.com/get-started/
[FreeBSD]:                             https://www.freebsd.org/
[Rocky Linux]:                         https://rockylinux.org/
[Ubuntu]:                              https://ubuntu.com/
[Zonemaster-GUI]:                      https://github.com/zonemaster/zonemaster-gui
