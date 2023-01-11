# Zonemaster LDNS

## Table of contents

* [Introduction](#introduction)
* [Dependencies and Compatibility](#dependencies-and-compatibility)
* [Installation and verification](#installation-and-verification)
  * [Recommended installation](#recommended-installation)
  * [Docker](#docker)
  * [Installation from source](#installation-from-source)
  * [Post-installation sanity check](#post-installation-sanity-check)
  * [Testing](#testing)
* [Optional features](#optional-features)
  * [Ed25519]
  * [IDN]
  * [Internal ldns]
  * [Randomized capitalization](#randomized-capitalization)
  * [Custom OpenSSL]
  * [Custom LDNS]
  * [Custom Libidn]
  * [Debug]
* [License](#license)

## Introduction

This module provides a Perl interface to the [ldns library] from [NLnet Labs]
and depends on it being available. The module can either compile and use those
libraries internally or link to already available ldns library given that the
version is high enough. In both cases it relies on a sufficiently recent version
of OpenSSL being present.

This module is written as part of the [Zonemaster project], and therefore
primarily exposes the functionality needed for that. Since Zonemaster is a
diagnostic tool, that means the functions most used are those for looking things
up and inspecting them.

If you want a module that specifically aims to be a complete and transparent
interface to ldns, [DNS::LDNS] is a better fit than this module.

Initially this module was named Net::LDNS.

## Dependencies and compatibility

Run-time dependencies:
 * `openssl` (openssl >= 1.1.1 unless [Ed25519] is disabled)
 * `libidn2` (if [IDN] is enabled)
 * `libldns` (if [Internal ldns] is disabled; libldns >= 1.7.0, or
   libldns >= 1.7.1 if [Ed25519] is enabled)

Compile-time dependencies (only when installing from source):
 * `make`
 * `Devel::CheckLib`
 * `Module::Install`
 * `Module::Install::XSUtil`
 * `Test::More >= 1.302015`
 * `git` (if [Internal ldns] is enabled)
 * `libtool` (if [Internal ldns] is enabled)
 * `autoconf` (if [Internal ldns] is enabled)
 * `automake` (if [Internal ldns] is enabled)

Test-time dependencies:
 * `Test::Fatal`

There is a small part in the code that may not be compatible with non-Unix
operating systems, in that it assumes that the file /dev/null exists.

## Installation and verification

### Recommended installation

The recommended way to install Zonemaster::LDNS is to follow the
[installation instructions for Zonemaster::Engine] where you will find all
prerequisites and dependencies for Zonemaster::LDNS before installing it.


### Docker

Zonemaster-CLI is available on [Docker Hub], and can be conveniently downloaded
and run without any installation. See [USING] Zonemaster-CLI for how to run
Zonemaster-CLI on Docker.

To build your own Docker image, see the [Docker Image Creation] documentation.


### Installation from source

Override the default set of features by appending `--FEATURE` and/or
`--no-FEATURE` options to the `perl Makefile.PL` command.

```sh
git clone https://github.com/zonemaster/zonemaster-ldns
cd zonemaster-ldns
perl Makefile.PL
make
make test
make install
```

> **Note:** The source ZIP files downloaded from Github are broken with
> respect to this instruction.


### Post-installation sanity check

```sh
perl -MZonemaster::LDNS -E 'say Zonemaster::LDNS->new("8.8.8.8")->query("zonemaster.net")->string'
```

The above command should print some `dig`-like output.


### Testing

Some of the unit tests depend on data on the Internet, which may change. To avoid
false fails, those unit tests are only run if the environment variable
`TEST_WITH_NETWORK` is `true`. By default that variable is unset (those tests are
not run). To run all tests, execute

```sh
TEST_WITH_NETWORK=1 make test
```

## Optional features

When installing from source, you can choose to enable or disable a number
of optional features using command line options to the `perl Makefile.PL`
commands.

### Ed25519

Enabled by default.
Disabled with `--no-ed25519`

Requires support for algorithms Ed25519 and Ed448 in both openssl and ldns.

>
> *Note:* Zonemaster Engine relies on this feature for its analysis when Ed25519
> (DNSKEY algorithm 15) or Ed448 (DNSKEY algorithm 16) is being used in DNSSEC
> signatures.
>

### IDN

Enabled by default.
Disable with `--no-idn`.

If the IDN feature is enabled, the GNU `libidn2` library will be used to
add a simple function that converts strings from Perl's internal encoding
to IDNA domain name format.
In order to convert strings from whatever encoding you have to Perl's
internal format, use L<Encode>.
If you need any kind of control or options, use L<Net::LibIDN>.
The included function here is only meant to assist in the most basic case,
although that should cover a lot of real-world use cases.

> **Note:** The Zonemaster Engine test suite assumes this feature
> is enabled.

### Internal ldns

Enabled by default.
Disable with `--no-internal-ldns`.

When enabled, an included version of ldns is statically linked into
Zonemaster::LDNS.
When disabled, libldns is dynamically linked just like other dependencies.

### Randomized capitalization

Disabled by default.
Enable with `--randomize`.

> **Note:** This feature is experimental.

Randomizes the capitalization of returned domain names.


### Custom OpenSSL

Disabled by default.
Enabled with `--prefix-openssl=/path/to/openssl` or
`--openssl-inc=/path/to/openssl_inc` or `--openssl-lib=/path/to/openssl_lib`.

Enabling this makes the build tools look for OpenSSL in a non-standard place.

Technically this does two things:
 * Libcrypto is sought in the `lib` directory under the given directory.
 * The `include` directory under the given directory is added to the include
   path.

> **Note:** The `lib` directory under the given path must be known to the
> dynamic linker or feature checks will fail.

If both headers and libraries directories (`include` and `lib`) are not in the
same parent directory, use `--openssl-inc` and `--openssl-lib` options to
specify both paths.


### Custom LDNS

Disabled by default.
Enabled with `--ldns-inc=/path/to/ldns_inc` or `--ldns-lib=/path/to/ldns_lib`.

Enabling this makes the build tools look for LDNS in a non-standard place.

> Requires [Internal LDNS] to be disabled.


### Custom Libidn

Disabled by default.
Enabled with `--libidn-inc=/path/to/libidn_inc` or
`--libidn-lib=/path/to/ldns_lib`.

Enabling this makes the build tools look for Libidn in a non-standard place.

> Requires [IDN] to be enabled.


### Debug

Disabled by default.
Enabled with `--debug`.

Gives a more verbose output.

## License

This is free software under a 2-clause BSD license. The full text of the license can
be found in the [LICENSE](LICENSE) file included in this respository.


[Custom LDNS]:                                       #custom-ldns
[Custom Libidn]:                                     #custom-libidn
[Custom OpenSSL]:                                    #custom-openssl
[Debug]:                                             #debug
[DNS::LDNS]:                                         http://search.cpan.org/~erikoest/DNS-LDNS/
[Docker Hub]:                                        https://hub.docker.com/u/zonemaster
[Docker Image Creation]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/internal-documentation/maintenance/ReleaseProcess-create-docker-image.md
[Ed25519]:                                           #ed25519
[IDN]:                                               #idn
[Installation instructions for Zonemaster::Engine]:  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Installation.md
[Internal ldns]:                                     #internal-ldns
[Ldns library]:                                      https://www.nlnetlabs.nl/projects/ldns/
[NLnet Labs]:                                        https://www.nlnetlabs.nl/
[USING]:                                             https://github.com/zonemaster/zonemaster-cli/blob/master/USING.md
[Zonemaster project]:                                http://github.com/zonemaster/zonemaster

