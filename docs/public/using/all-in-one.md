# Using the All-In-One docker image

## Table of contents
* [All-In-One](#all-in-one)
* [Using Docker](#using-docker)
* [Invoking the command line tool using AIO image](#invoking-the-command-line-tool-using-aio-image)
* [Docker tips](#docker-tips)

## All-In-One

The `zonemaster-all-in-one` docker image provides an All-In-One solution containing Zonemaster-Backend, Zonemaster-CLI, and Zonemaster-GUI.

The `zonemaster-all-in-one` image can be run from computer that
has Docker is installed.


### Using Docker

To run Zonemaster via the All-In-One Docker image you have to make sure that Docker is installed
on the computer and that you can run Docker on it.
* Instructions for installation are found on Docker [get started] page.
* Run the command `docker ps` on the command line to verify that you can run
  Docker on the computer.

When Docker has been correctly installed, no more installation is needed to run
`zonemaster-cli`. Just follow the examples below.

There is a limitation in Docker regarding IPv6. Unless IPv6 has been enabled in
the Docker daemon, there is no support for IPv6. To avoid meaningless errors,
use `--no-ipv6` if there is no IPv6 support. Also see section "[IPv6 support]".



## Invoking the command line tool using All-In-One image


The zonemaster cli tool `zonemaster-cli` can also be invoked from the `zonemaster-all-in-one` image like 
`zonemaster-cli` docker image, by adding `cli` argument.

There are two usable Docker images to run `zonemaster-cli`:
`zonemaster/cli` and `zonemaster/backend`.
For more information on how to use `zonemaster/backend` image to invoke
the cli, see the [Docker Zonemaster-Backend] documentation.


```sh
docker run -t --rm zonemaster/all-in-one cli zonemaster.net --no-ipv6
```
or
```sh
docker run -t --rm zonemaster/all-in-one cli zonemaster.net
```

To make sure that Docker uses the latest version, add `--pull always`, e.g.

```sh
docker run -t --rm --pull always zonemaster/all-in-one zonemaster.net --no-ipv6
```

If `--pull always` is skipped, the invocation is quicker. The recommendation is
to include `--pull always` in the first command of a session to make sure latest
version is used, and then to exclude it to improve performance.

## Docker tips

If you run Docker on Mac computer with the M1 chip or if you want to have ipv6 inside
docker, see [Docker cli]

[Get started]:                     https://www.docker.com/get-started/
[Docker Zonemaster-Backend]:       backend/Using-Zonemaster-Backend-Docker.md#invoking-the-command-line-tool-using-docker
[Docker cli]:                      cli.md#docker-on-mac-with-m1-chip
