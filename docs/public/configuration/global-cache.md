# Configuration: Global cache in Zonemaster-Engine

## Table of contents

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Installation for global cache](#installation-for-global-cache)
* [Create directory for custom profile](#create-directory-for-custom-profile)
* [Enable global cache](#enable-global-cache)
* [Using global cache](#using-global-cache)


## Introduction
Global cache is a feature that can increase performance when many tests are run
within a short time frame, especially when they share some data such as using the
same name server names. The global cache is meant for batch testing rather than
single tests through the GUI. In the latter case it is desirable that Zonemaster
checks again since the zone may have been corrected due to the report in a very
recent test.

The global cache improves the caching function by  making the DNS lookups from
one test to be available for further tests. The cache is stored in `Redis`, a
cache service running in a separate daemon.

To enable global caching, additional software has to be installed and custom
profile has to be created, where global caching is enabled.


## Prerequisites

Before installing or enabling global cache you must follow the
[Zonemaster::Engine installation] first. The feature is available from version
`v5.0.0` of Zonemaster-Engine.

For installation on FreeBSD being user root is assumed.


## Installation for global cache

Install the `Redis` daemon and needed Perl library. And then start the `Redis`
daemon. It will listen to localhost and default port.

### Rocky Linux
```
sudo dnf --assumeyes install redis perl-Redis perl-Data-MessagePack
sudo systemctl enable redis
sudo systemctl start redis
```

### Debian and Ubuntu
```
sudo apt install redis libredis-perl libdata-messagepack-perl
sudo systemctl enable redis
sudo systemctl start redis
```

### FreeBSD
```
pkg install -y redis p5-Redis p5-Data-MessagePack
sysrc redis_enable="YES"
service redis start
```

## Create directory for custom profile

Create a directory to be used for a custom profile, which is here the same
directory as used by Zonemaster-Backend. And then copy the default profile
to this directory.

### Rocky Linux, Debian and Ubuntu
```
test -d /etc/zonemaster || sudo mkdir -v /etc/zonemaster
perl -MZonemaster::Engine::Test -E 'say Zonemaster::Engine::Profile->default->to_json' | jq -S . | sudo tee /etc/zonemaster/profile.json > /dev/null
```

### FreeBSD
```
test -d /usr/local/etc/zonemaster || mkdir -v /usr/local/etc/zonemaster
perl -MZonemaster::Engine::Test -E 'say Zonemaster::Engine::Profile->default->to_json' | jq -S . > /usr/local/etc/zonemaster/profile.json
```

## Enable global cache
If there is no `profile.json` in `/etc/zonemaster/` (or `/usr/local/etc/zonemaster/`
for FreeBSD), create it by extracting the default profile using the command in the
[profile documentation].

Update `/etc/zonemaster/profile.json` (or `/usr/local/etc/zonemaster/profile.json`
for FreeBSD) by adding a cache section. If the profile already has an empty cache
section (i.e. `"cache": {}`) then it must be removed. Add the following section,
```
    "cache": {
        "redis": {
            "server": "127.0.0.1:6379",
            "expire": 7200
        }
    },
```

The `expire` value can be increased or decreased to increase or decrease the time
in seconds that `Redis` will cache the data. Caching of specific DNS data is
never longer than the normal DNS TTL value.


## Using global cache

If [Zonemaster-CLI][Zonemaster::CLI installation] has been installed, then
run `zonemaster-cli` with `--profile /etc/zonemaster/profile.json`
(or `--profile /usr/local/etc/zonemaster/profile.json` for FreeBSD) to use the
global cache. Caching will persist between test unless it has expired.

See `man zonemaster-cli` and look for `cli.args` for how to make it the custom
profile being the default profile for `zonemaster-cli`.

See [Zonemaster::Backend configuration] for how to make the custom profile being
used for Zonemaster-Backend and Zonemaster-GUI.

For more documentation on profiles, see [profile documentation].


[profile documentation]:                             profiles.md
[Zonemaster::Backend configuration]:                 backend.md
[Zonemaster::CLI installation]:                      ../installation/zonemaster-cli.md
[Zonemaster::Engine installation]:                   ../installation/zonemaster-engine.md
