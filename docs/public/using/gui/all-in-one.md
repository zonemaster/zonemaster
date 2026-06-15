# Using the All-In-One docker image

## Table of contents
* [All-In-One](#all-in-one)
* [Using Docker](#using-docker)
* [Invoking the command line tool using AIO image](#invoking-the-command-line-tool-using-aio-image)
* [Docker tips](#docker-tips)

## All-In-One

The `zonemaster-all-in-one` docker image provides an All-In-One solution containing Zonemaster-CLI, Zonemaster-Backend, and Zonemaster-GUI.

The `zonemaster-all-in-one` image can be run from any computer that has Docker installed.


### Using Docker

To run Zonemaster via the All-In-One Docker image you have to make sure that Docker is installed
and running.
* Instructions for installation are found on Docker [Get started] page.
* Run the command `docker ps` on the command line to verify that you can run
  Docker on the computer.

When Docker has been correctly installed, no more installation is needed to run
`zonemaster-cli`. Just follow the examples below.

There is a limitation in Docker regarding IPv6. Unless IPv6 has been enabled in
the Docker daemon, there is no support for IPv6. To avoid meaningless errors,
use `--no-ipv6` if there is no IPv6 support. Also see section "[IPv6 support]".


## Using the All-In-One image

Start the All-In-One container with this command:
```sh
docker run --rm -d --name zm-aio -p 8080:80 zonemaster/all-in-one gui
```

The Zonemaster GUI is now accessible via your browser at `http://localhost:8080/`.

To stop the container:
```sh
docker stop zm-aio
```

## Invoking the command line tool using AIO image


The Zonemaster-CLI tool `zonemaster-cli` can also be invoked from the `zonemaster-all-in-one` image by adding the `cli` argument.

Moreover, there are two more usable Docker images to run `zonemaster-cli`:
`zonemaster/cli` and `zonemaster/backend`.
For more information on how to use the `zonemaster/backend` image to invoke
Zonemaster-CLI, see the [Docker Zonemaster-Backend] documentation.


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
to include `--pull always` in the first command of a session to make sure that the
latest version is used, and then to exclude it to improve performance.

## Docker tips

If you run Docker on Mac computer with the M1 chip or if you want to have IPv6 inside
Docker, see [Docker cli].

[Get started]:                     https://www.docker.com/get-started/
[Docker Zonemaster-Backend]:       ../backend/Using-Zonemaster-Backend-Docker.md#invoking-the-command-line-tool-using-docker
[CLI#docker-on-mac-with-m1-chip]:  ../cli.md#docker-on-mac-with-m1-chip
[CLI#ipv6-support]:                ../cli.md#ipv6-support
