# Configuration: Global cache in Zonemaster-Engine

## Table of contents

* [Experimental feature](#experimental-feature)
* [Prerequisites](#prerequisites)
* [Installation for global cache](#installation-for-global-cache)
* [Create directory for custom profile](#create-directory-for-custom-profile)
* [Enable global cache](#enable-global-cache)
* [Using global cache](#using-global-cache)


## Experimental feature
Global cache is an *experimental feature* that can increase performance when many
tests are run within a short time frame, especially when they share some data
such as using the same name server names.

The global cache improves the caching function by  making the DNS lookups from
one test to be available for further tests. The cache is stored in `Redis`, a
cache service running in a separate daemon.

To enable global caching, additional software has to be installed and custom
profile has to be created, where global caching is enabled.

Since it is an experimental featuer, its interface might change in upcoming
release.


## Prerequisites

Before installing or enabling global cache you must follow the
[Zonemaster::Engine installation] first. The feature is available from version
`v5.0.0` of Zonemaster-Engine.


## Installation for global cache

Install the `Redis` daemon and needed Perl library. And then start the `Redis`
daemon. It will listen to localhost and default port.

### Rocky Linux

To be added.

### Debian and Ubuntu
```
sudo apt install redis libredis-perl libdata-messagepack-perl
sudo systemctl start redis
```

### FreeBSD
```
pkg install redis p5-Redis p5-Data-MessagePack
service redis start
```

## Create directory for custom profile

Create a directory to be used for a custom profile, which is here the same
directory as used by Zonemaster-Backend. And then copy the default profile
to this directory.

### Rocky Linux

To be added.

### Debian and Ubuntu
```
test -d /etc/zonemaster  || sudo mkdir -v /etc/zonemaster
cp -v $(perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Engine")')/profile.json /etc/zonemaster
```

### FreeBSD
```
test -d /usr/local/etc/zonemaster  || mkdir -v /usr/local/etc/zonemaster
cp -v $(perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Engine")')/profile.json /usr/local//etc/zonemaster
```

## Enable global cache

Update `profile.json` in `/etc/zonemaster` (or `/usr/local//etc/zonemaster`) by
addin the following section,
```
    "cache": {
        "redis": {
            "server": "127.0.0.1:6379",
            "expire": 300
        }
    },
```
You can also copy the section from the file listed by the following command,
```
ls $(perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Engine")')/profile_additional_properties.json
```

The `expire` value can be increased or decreased to increase or decrease the time
in seconds that `Redis` will cache the data. Caching of specific DNS data is
never longer than the normal DNS TTL value.


## Using global cache

If [Zonemaster-CLI][Zonemaster::CLI installation] has been installed, then
run `zonemaster-cli` with `--profile /etc/zonemaster/profile.json`
(or `--profile /usr/local/etc/zonemaster/profile.json` if on FreeBSD) to use the
global cache. Caching will persist between test unless it has expired.

See `man zonemaster-cli` and look for `cli.args` for how to make it the custom
profile being the default profile for `zonemaster-cli`.

See [Zonemaster::Backend configuration] for how to make the custom profile being
used for Zonemaster-Backend and Zonemaster-GUI.

For more documentation on profiles, see [profile documentation].


[EPEL]:                                              https://docs.fedoraproject.org/en-US/epel/
[profile documentation]:                             profiles.md
[Zonemaster::Backend configuration]:                 backend.md
[Zonemaster::CLI installation]:                      ../installation/zonemaster-cli.md
[Zonemaster::Engine installation]:                   ../installation/zonemaster-engine.md




