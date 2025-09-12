# Installation instructions

## Manual installation

Before installing Zonemaster, check the [prerequisites] first.

Start by installing the following components, in order:

 * [Zonemaster-LDNS];
 * [Zonemaster-Engine];
 * [Zonemaster-CLI].

At this point, tests can be run from the command-line on the local machine. To install the Web GUI, install the following additional components, in order:

 * [Zonemaster-Backend];
 * [Zonemaster-GUI].

## Docker

Alternatively, Zonemaster-CLI is available on [Docker Hub], and can be
conveniently downloaded and run without any installation. Through [Docker]
Zonemaster-CLI can be run on Linux, macOS and Windows. See [Using the CLI] for
how to run Zonemaster-CLI on Docker.

To build your own Docker image, see the [Docker Image Creation] documentation.

[Docker Hub]:                          https://hub.docker.com/u/zonemaster
[Docker Image Creation]:               https://github.com/zonemaster/zonemaster/blob/master/docs/internal/maintenance/ReleaseProcess-create-docker-image.md
[Docker]:                              https://www.docker.com/get-started/
[prerequisites]:                       prerequisites.md
[Using the CLI]:                       ../using/cli.md
[Zonemaster-Backend]:                  zonemaster-backend.md
[Zonemaster-CLI]:                      zonemaster-cli.md
[Zonemaster-Engine]:                   zonemaster-engine.md
[Zonemaster-GUI]:                      zonemaster-gui.md
[Zonemaster-LDNS]:                     zonemaster-ldns.md
