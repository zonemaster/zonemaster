# Using Zonemaster-Backend Docker container

## Table of contents

* [Introduction](#introduction)
* [Invoking `zmtest` using Docker](#invoking-zmtest-using-docker)
* [Invoking `zmb` using Docker](#invoking-zmb-using-docker)
* [Invoking the command line tool using Docker](#invoking-the-command-line-tool-using-docker)
* [IPv6 support](#ipv6-support)


## Introduction:

This Docker image lets you run a working instance of Zonemaster-Backend.
It also contains a working version of zonemaster-cli which can be used
as a substitute for [zonemaster-cli],
how to use this version of cli is described at 
(the end of this document)[#invoking-the-command-line-tool-using-docker].

The container is configured to use an SQLite database and run 
all needed processes (rpcapi and testagent).
This image is designed to be used by one single user and
is therefore not suitable for production.

There is a limitation in Docker regarding IPv6.
Unless IPv6 has been enabled in the Docker daemon, there is no support for IPv6.
To avoid unnecessary errors,
use the corresponding option below if IPv6 support is not available.
See also the "IPv6 Support" section.

- zonemaster-cli: `--no-ipv6`
- zmtest: `--noipv6`
- zmb: `--ipv6 false`

## Invoking `zmtest` using Docker


The most basic use of the `zonemaster-backend` command is to just test a domain, e.g.
"zonemaster.net". To do so you first need to start `zonemaster/backend`
container and expose the port 5000
to be able to access the JSON RPC API.

```
docker run --rm -p 5000:5000 --name zm -d zonemaster/backend full
```
You can stop the Docker container with `docker stop zm`.

Once zonemaster/backend container started you can interact with it on 
`localhost:5000` usign JSON RPCAPI.

You can use `zmtest` embedded inside the backend image by using this command:
```
docker run -ti --rm --net host zonemaster/backend zmtest zonemaster.net
```
Run 
```sh
docker run -ti --rm --net host zonemaster/backend zmtest zonemaster.net
```
to get usage for `zmtest`.
```
## Invoking `zmb` using Docker


You can also use the `zmb` command to interact with the `zonemaster/backend` container.

```
docker run -ti --rm --net host zonemaster/backend zmb start_domain_test --domain zonemaster.net
docker run -ti --rm --net host zonemaster/backend zmb get_test_results --test-id ed38765834e45b6e --lang en
```

When piping the output of `docker run` directly into `jq`,
you might encounter display issues due to the way Docker handles output.
These issues are caused by carriage return characters (^M) in the output.
To filter out these characters,
you should pipe `docker run`’s output into `tr -d '^M'` before piping it into `jq`.

```
docker run -ti --rm --net host zonemaster/backend zmb get_test_results (...) |tr -d '^M' | jq
```

## Invoking the command line tool using Docker

`zonemaster/backend` also contains the CLI tool shipped in 
the [zonemaster-cli] container image.
You can invoke zonemaster-cli in the Zonemaster-Backend Docker image 
by running the following command:

```
docker run -ti --rm zonemaster/backend:local cli zonemaster.net
```



### IPv6 support

On a Linux system IPv6 support can be enabled by creating or updating
`/etc/docker/daemon.json`. This is a minimal file that enables IPv6 support:

```json
{
    "ipv6": true,
    "fixed-cidr-v6": "2001:db8:1::/64"
}
```

Restart the docker daemon:
```sh
sudo systemctl restart docker
```

Also see the official Docker documentation "[Enable IPv6 support]".

[Docker Image Creation]:               https://github.com/zonemaster/zonemaster/blob/master/docs/internal/maintenance/ReleaseProcess-create-docker-image.md
[Get started]:                     https://www.docker.com/get-started/
[IPv6 support]:                    #ipv6-support
[Enable IPv6 support]:             https://docs.docker.com/config/daemon/ipv6/
[zonemaster-cli]:                  ../cli.md
