# Upgrade Backend

## 1. Overview

This document contains pointer to instructions on how to upgrade the
Zonemaster::Backend component. An upgrade usually consist of an upgrade script
to upgrade the database, and instructions to install new dependencies.

> When upgrading from a version < v6.2.0 to a version ≥ v8.0.0, it is
> recommended to install the desired version following the [Installation
> instructions] skipping the part about the database if you want to keep it. To
> upgrade the database, apply each upgrade instructions one after another (see
> table below).

## 2. Prerequisites

Upgrade Zonemaster::LDNS and Zonemaster::Engine first following instructions
within the [Zonemaster::Engine installation] document.

## 3. Upgrading Zonemaster::Backend

To upgrade Zonemaster::Backend perform the following tasks:

  1. stop the `zm-rpcapi` and `zm-testagent` daemons (`zm_rpcapi` and
     `zm_testagent` on FreeBSD)
  2. remove old files with `cpanm --uninstall Zonemaster::Backend`
  3. install any new dependencies (see corresponding upgrade document below)
  4. install the latest version from CPAN with `cpanm Zonemaster::Backend`
  5. apply any remaining instructions specific to this new release
  6. start the `zm-rpcapi` and `zm-testagent` daemons (`zm_rpcapi` and
     `zm_testagent` on FreeBSD)


### Specific upgrade instructions

> Always make a backup of the database before upgrading it.

When upgrading Zonemaster::Backend, it might be needed to upgrade the database
and/or install new dependencies. Such instructions are available in the upgrade
document coming with the release. See table below to refer to the right
document.

*When upgrading from an older version than the previous release, apply each
upgrade instructions one after another.*

Current Zonemaster::Backend version | Link to instructions | Comments
------------------------------------|----------------------|-----------------------
 version < 1.0.3                    | [Upgrade to 1.0.3]   |
 1.0.3 ≤ version < 1.1.0            | [Upgrade to 1.1.0]   |
 1.1.0 ≤ version < 5.0.0            | [Upgrade to 5.0.0]   |
 5.0.0 ≤ version < 5.0.2            | [Upgrade to 5.0.2]   | For MySQL/MariaDB only
 5.0.2 ≤ version < 8.0.0            | [Upgrade to 8.0.0]   |
 8.0.0 ≤ version < 9.0.0            | [Upgrade to 9.0.0]   |
 9.0.0 ≤ version                    | -                    | No special steps needed for upgrade

## 4. Find current version

The following command will report the version of Zonemaster-Backend currently
installed. If an error is report Zonemaster-Backend is not installed or not
available for the user. If so, consider tunning the command as root or with
`sudo`.

```sh
perl -E 'use Zonemaster::Backend; say $Zonemaster::Backend::VERSION;'
```

[Installation instructions]: ../installation/zonemaster-backend.md
[Upgrade to 1.0.3]:  https://github.com/zonemaster/zonemaster-backend/tree/master/docs/upgrade/upgrade_zonemaster_backend_ver_1.0.3.md
[Upgrade to 1.1.0]:  https://github.com/zonemaster/zonemaster-backend/tree/master/docs/upgrade/upgrade_zonemaster_backend_ver_1.1.0.md
[Upgrade to 5.0.0]:  https://github.com/zonemaster/zonemaster-backend/tree/master/docs/upgrade/upgrade_zonemaster_backend_ver_5.0.0.md
[Upgrade to 5.0.2]:  https://github.com/zonemaster/zonemaster-backend/tree/master/docs/upgrade/upgrade_zonemaster_backend_ver_5.0.2.md
[Upgrade to 8.0.0]:  https://github.com/zonemaster/zonemaster-backend/tree/master/docs/upgrade/upgrade_zonemaster_backend_ver_8.0.0.md
[Upgrade to 9.0.0]:  https://github.com/zonemaster/zonemaster-backend/tree/master/docs/upgrade/upgrade_zonemaster_backend_ver_9.0.0.md
[Zonemaster::Engine installation]: ../installation/zonemaster-engine.md
