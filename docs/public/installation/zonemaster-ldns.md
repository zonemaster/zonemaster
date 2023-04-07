# Installation: Zonemaster-LDNS

## Recommended installation

The recommended way to install Zonemaster::LDNS is to follow the
[installation instructions for Zonemaster::Engine] where you will find all
prerequisites and dependencies for Zonemaster::LDNS before installing it.

## Installation from source

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


### Optional features

When installing from source, you can choose to enable or disable a number
of optional features using command line options to the `perl Makefile.PL`
commands.

#### Ed25519

Enabled by default.
Disabled with `--no-ed25519`

Requires support for algorithms Ed25519 and Ed448 in both openssl and ldns.

>
> *Note:* Zonemaster Engine relies on this feature for its analysis when Ed25519
> (DNSKEY algorithm 15) or Ed448 (DNSKEY algorithm 16) is being used in DNSSEC
> signatures.
>

#### IDN

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

#### Internal ldns

Enabled by default.
Disable with `--no-internal-ldns`.

When enabled, an included version of ldns is statically linked into
Zonemaster::LDNS.
When disabled, libldns is dynamically linked just like other dependencies.

#### Randomized capitalization

Disabled by default.
Enable with `--randomize`.

> **Note:** This feature is experimental.

Randomizes the capitalization of returned domain names.


#### Custom OpenSSL

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


#### Custom LDNS

Disabled by default.
Enabled with `--ldns-inc=/path/to/ldns_inc` or `--ldns-lib=/path/to/ldns_lib`.

Enabling this makes the build tools look for LDNS in a non-standard place.

> Requires [Internal LDNS] to be disabled.


#### Custom Libidn

Disabled by default.
Enabled with `--libidn-inc=/path/to/libidn_inc` or
`--libidn-lib=/path/to/ldns_lib`.

Enabling this makes the build tools look for Libidn in a non-standard place.

> Requires [IDN] to be enabled.


#### Debug

Disabled by default.
Enabled with `--debug`.

Gives a more verbose output.


## Post-installation sanity check

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


[Docker Hub]:                                        https://hub.docker.com/u/zonemaster
[Docker Image Creation]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/internal/maintenance/ReleaseProcess-create-docker-image.md
[Installation instructions for Zonemaster::Engine]:  zonemaster-engine.md
[USING]:                                             ../using/
