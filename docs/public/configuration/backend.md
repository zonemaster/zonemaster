# Configuration

## Table of contents

* [Introduction](#introduction)
* [RPCAPI section](#rpcapi-section)
  * [enable_batch_create](#enable_batch_create)
  * [enable_user_create](#enable_user_create)
  * [enable_add_batch_job](#enable_add_batch_job)
  * [enable_add_api_user](#enable_add_api_user)
* [DB section](#db-section)
  * [engine](#engine)
  * [polling_interval](#polling_interval)
* [MYSQL section](#mysql-section)
  * [host](#host)
  * [port](#port)
  * [user](#user)
  * [password](#password)
  * [database](#database)
* [POSTGRESQL section](#postgresql-section)
  * [host](#host-1)
  * [port](#port-1)
  * [user](#user-1)
  * [password](#password-1)
  * [database](#database-1)
* [SQLITE section](#sqlite-section)
  * [database_file](#database_file)
* [LANGUAGE section](#language-section)
  * [locale](#locale)
* [METRICS section](#metrics-section)
  * [statsd_host](#statsd_host)
  * [statsd_port](#statsd_port)
* [PUBLIC PROFILES and PRIVATE PROFILES sections](#public-profiles-and-private-profiles-sections)
* [ZONEMASTER section](#zonemaster-section)
  * [max_zonemaster_execution_time](#max_zonemaster_execution_time)
  * [number_of_processes_for_frontend_testing](#number_of_processes_for_frontend_testing)
  * [number_of_processes_for_batch_testing](#number_of_processes_for_batch_testing)
  * [lock_on_queue](#lock_on_queue)
  * [age_reuse_previous_test](#age_reuse_previous_test)

## Introduction

Zonemaster *Backend* is configured in
`/etc/zonemaster/backend_config.ini` (Linux) or
`/usr/local/etc/zonemaster/backend_config.ini` (FreeBSD). Following
[Installation instructions] will create the file with factory settings.

Restart the `zm-rpcapi` and `zm-testagent` daemons to load the changes
made to the `backend_config.ini` file.

The `backend_config.ini` file uses a file format in the INI family that is
described in detail [here][File format].
Repeating a key name in one section is forbidden.

Each section in `backend_config.ini` is documented below.

In addition to the configuration file, some settings can configured using
[environement variables][Environement Variables].

## RPCAPI section

Available keys: `enable_batch_create`, `enable_user_create`,
`enable_add_batch_job`, `enable_add_api_user`.

### enable_add_batch_job

Boolean value to enable the `add_batch_job` and `batch_create` methods of the API.

Accepted values: `yes` (or `true`) or `no` (or `false`),
default to `yes` (enabled).

### enable_add_api_user

Boolean value to enable the `add_api_user` and `user_create` method of the API.

Accepted values: `yes` (or `true`) or `no` (or `false`),
default to `no` (disabled).

### enable_batch_create

An experimental alias for [enable_add_batch_job][RPCAPI.enable_add_batch_job].

### enable_user_create

An experimental alias for [enable_add_api_user][RPCAPI.enable_add_api_user].


## DB section

Available keys : `engine`, `user`, `password`, `database_name`,
`database_host`, `polling_interval`.

### engine

Specifies what database engine to use.

The value must be one of the following, case-insensitively: `MySQL`,
`PostgreSQL` and `SQLite`.

This table declares what value to use for each supported database engine.

Database Engine   | Value
------------------|------
MariaDB           | `MySQL`
MySQL             | `MySQL`
PostgreSQL        | `PostgreSQL`
SQLite            | `SQLite`

### polling_interval

A strictly positive decimal number. Max 5 and 3 digits in the integer and fraction
components respectively.

Time in seconds between database lookups by Test Agent.
Default value: `0.5`.


## MYSQL section

Available keys : `host`, `port`, `user`, `password`, `database`.

### host

An [LDH domain name] or IP address.

The host name of the machine on which the MySQL server is running.

### port

The port the MySQL server is listening on.
Default value: `3306`.

If [MYSQL.host] is set to `localhost` (but neither `127.0.0.1` nor `::1`),
then the value of the [MYSQL.port] property is discarded as the driver
connects using a UNIX socket (see the [DBD::mysql documentation]).

### user

An ASCII-only [MariaDB unquoted identifier].
Max length [80 characters][MariaDB identifier max lengths].

The name of the user with sufficient permission to access the database.

### password

A string of [US ASCII printable characters].
The first character must be neither space nor `<`.
Max length 100 characters.

The password of the configured user.

### database

A US ASCII-only [MariaDB unquoted identifier].
Max length [64 characters][MariaDB identifier max lengths].

The name of the database to use.


## POSTGRESQL section

Available keys : `host`, `port`, `user`, `password`, `database`.

### host

An [LDH domain name] or IP address.

The host name of the machine on which the PostgreSQL server is running.

### port

The port the PostgreSQL server is listening on.
Default value: `5432`.

### user

A US ASCII-only [PostgreSQL identifier]. Max length 63 characters.

The name of the user with sufficient permission to access the database.

### password

A string of [US ASCII printable characters].
The first character must be neither space nor `<`.
Max length 100 characters.

The password of the configured user.

### database

A US ASCII-only [PostgreSQL identifier]. Max length 63 characters.

The name of the database to use.


## SQLITE section

Available keys : `database_file`.

### database_file

An absolute path.

The full path to the SQLite main database file.


## LANGUAGE section

The LANGUAGE section has one key, `locale`.

### locale

A string representing a space-separated list of one or more `locale tags`.
Each tag consists of a two-lowercase-letter language code, an underscore
character, and a two-uppercase-letter country code (i.e. it matches the regular
expression `/^[a-z]{2}_[A-Z]{2}$/`).
Each `locale tag` must have a unique language code.

Default value: `en_US`.

#### Design

The language code of a `locale tag` is intended to be an [ISO 639-1] code.
The country code is intended to be an [ISO 3166-1 alpha-2] code.
A `locale tag` is a locale setting for the available translation
of messages without ".UTF-8", which is implied.

#### Usage

Removing a language from the configuration file just blocks that
language from being allowed.

English is the Zonemaster default language, but it can be blocked
from being allowed by RPC-API by including some `locale tag` in the
configuration, but none starting with language code for English ("en").

#### Out-of-the-box support

The default installation and configuration supports the
following languages.

Language | Locale tag value | Language code | Locale value used
---------|------------------|---------------|------------------
Danish   | da_DK            | da            | da_DK.UTF-8
English  | en_US            | en            | en_US.UTF-8
Spanish  | es_ES            | es            | es_ES.UTF-8
Finnish  | fi_FI            | fi            | fi_FI.UTF-8
French   | fr_FR            | fr            | fr_FR.UTF-8
Norwegian| nb_NO            | nb            | nb_NO.UTF-8
Swedish  | sv_SE            | sv            | sv_SE.UTF-8

Setting in the default configuration file:

```
locale = da_DK en_US es_ES fi_FI fr_FR nb_NO sv_SE
```

#### Installation considerations

If a new `locale tag` is added to the configuration then the equivalent
MO file should be added to Zonemaster-Engine at the correct place so
that gettext can retrieve it, or else the added `locale tag` will not
add any actual language support. The MO file should be created for the
`language code` of the `locale tag` (see the table above), not the entire
`locale tag`. E.g. if the `locale` configuration key includes "sv_SE" then
a MO file for "sv" should be included in the installation.

Use of MO files based on the entire `locale tag` is *deprecated*.

See the [Zonemaster-Engine share directory] for the existing PO files that are
converted to MO files during installation. (Here we should have a link
to documentation instead.)

Each locale set in the configuration file, including the implied
".UTF-8", must also be installed or activate on the system
running the RPCAPI daemon for the translation to work correctly.

## METRICS section

### statsd_host

An [LDH domain name] or IP address.

The host name of the machine on which the StatsD receiver is running.

Leave unspecified to disable the metrics.

Note that this feature requires the `Net::Statsd` module to be installed.

### statsd_port

The port the StatsD receiver is listening on.
Default value: `8125`.


## PUBLIC PROFILES and PRIVATE PROFILES sections

The PUBLIC PROFILES and PRIVATE PROFILES sections together define the available [profiles].

Keys in both sections are `profile names`, and values are absolute file system
paths to [profile JSON files]. The key must conform to the character limitation
specified for `profile name` as specified in the API document
[Profile name section]. Keys that only differ in case are considered to be equal.
Keys must not be duplicated between or within the sections, and the key
`default` must not be present in the PRIVATE PROFILES section.

There is a `default` profile that is special. It is always available even
if not specified. If it is not explicitly mapped to a profile JSON file, it is implicitly
mapped to the [Zonemaster Engine default profile].

Each profile JSON file contains a (possibly empty) set of overrides to
the *Zonemaster Engine default profile*. Specifying a profile JSON file
that contains a complete set of profile data is equivalent to specifying
a profile JSON file with only the parts that differ from the *Zonemaster
Engine default profile*.

Specifying a profile JSON file that contains no profile data is equivalent
to specifying a profile JSON file containing the entire
*Zonemaster Engine default profile*.

## ZONEMASTER section

The ZONEMASTER section has several keys :
* max_zonemaster_execution_time
* number_of_processes_for_frontend_testing
* number_of_processes_for_batch_testing
* lock_on_queue
* age_reuse_previous_test

### max_zonemaster_execution_time

A strictly positive integer. Max length 5 digits.

Time in seconds before reporting an unfinished test as failed.
Default value: `600`.

### number_of_processes_for_frontend_testing

A strictly positive integer. Max length 5 digits.

Number of processes allowed to run in parallel (added with
`number_of_processes_for_batch_testing`).
Default value: `20`.

Despite its name, this key does not limit the number of process used by the
frontend, but is used in combination of
`number_of_processes_for_batch_testing`.

### number_of_processes_for_batch_testing

A non-negative integer. Max length 5 digits.

Number of processes allowed to run in parallel (added with
`number_of_processes_for_frontend_testing`).
Default value: `20`.

Despite its name, this key does not limit the number of process used by any
batch pool of tests, but is used in combination of
`number_of_processes_for_frontend_testing`.

### lock_on_queue

A non-negative integer. Max length 5 digits.

A label to associate a test to a specific Test Agent.
Default value: `0`.

### age_reuse_previous_test

A strictly positive integer. Max length 5 digits.

The shelf life of a test in seconds after its creation.
Default value: `600`.

If a new test is requested for the same zone name and parameters within the
shelf life of a previous test result, that test result is reused.
Otherwise a new test request is enqueued.


[API documentation]:                  ../using/backend/api.md
[DBD::mysql documentation]:           https://metacpan.org/pod/DBD::mysql#host
[Environement Variables]:             backend-environment-variables.md
[File format]:                        https://metacpan.org/pod/Config::IniFiles#FILE-FORMAT
[ISO 3166-1 alpha-2]:                 https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
[ISO 639-1]:                          https://en.wikipedia.org/wiki/ISO_639-1
[Installation instructions]:          ../installation/zonemaster-backend.md
[Language tag]:                       ../using/backend/api.md#language-tag
[LDH domain name]:                    https://datatracker.ietf.org/doc/html/rfc3696#section-2
[MariaDB identifier max lengths]:     https://mariadb.com/kb/en/identifier-names/#maximum-length
[MariaDB unquoted identifier]:        https://mariadb.com/kb/en/identifier-names/#unquoted
[MYSQL.host]:                         #host
[MYSQL.port]:                         #port
[PostgreSQL identifier]:              https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS
[Profile JSON files]:                 profiles.md
[Profile name section]:               ../using/backend/rpcapi-reference.md#profile-name
[Profiles]:                           Architecture.md#profile
[RPCAPI.enable_add_api_user]:         #enable_add_api_user
[RPCAPI.enable_add_batch_job]:        #enable_add_batch_job
[RPCAPI.enable_batch_create]:         #enable_batch_create
[RPCAPI.enable_user_create]:          #enable_user_create
[SQLITE.database_file]:               #database_file
[US ASCII printable characters]:      https://en.wikipedia.org/wiki/ASCII#Printable_characters
[Zonemaster-Engine share directory]:  https://github.com/zonemaster/zonemaster-engine/tree/master/share
[Zonemaster::Engine::Profile]:        https://metacpan.org/pod/Zonemaster::Engine::Profile#PROFILE-PROPERTIES
[Zonemaster Engine default profile]:  profiles.md#default-profile
