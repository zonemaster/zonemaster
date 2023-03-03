# Installation: Zonemaster-LDNS

## Recommended installation

The recommended way to install Zonemaster::LDNS is to follow the
[installation instructions for Zonemaster::Engine] where you will find all
prerequisites and dependencies for Zonemaster::LDNS before installing it.


## Docker

Zonemaster-CLI is available on [Docker Hub], and can be conveniently downloaded
and run without any installation. See [USING] Zonemaster-CLI for how to run
Zonemaster-CLI on Docker.

To build your own Docker image, see the [Docker Image Creation] documentation.


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
