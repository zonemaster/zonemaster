# Using Zonemaster-Backend docker container

## Table of contents

* [Introduction](#introduction)
* [Combining GUI and batch](#combining-gui-and-batch)
* [Configuration to run batches](#configuration-to-run-batches)
* [Create batch user](#create-batch-user)
* [Run a batch job](#run-a-batch-job)
  * [Start a batch job](#start-a-batch-job)
  * [Status of a batch job](#status-of-a-batch-job)
* [Scale out](#scale-out)
  * [Enable global cache](#enable-global-cache)
  * [Increase the worker pool size](#increase-the-worker-pool-size)
  * [Add more Test Agent services](#add-more-test-agent-services)
  * [Add more test servers](#add-more-test-servers)
* [Queues](#queues)
* [Appendix: Add more JSON-RPC API services]


## Introduction:

This docker image allows you to start a working backend of zonemaster.
The container is configured to use an SQLite database and run all needed processus (rpcapi et testagent).
Thereforce this image is not suitable for production.

There is a limitation in Docker regarding IPv6. Unless IPv6 has been enabled in the Docker daemon, there is no support for IPv6. To avoid meaningless errors, use --no-ipv6 if there is no IPv6 support. Also see section "IPv6 support".


## Build Zonemaster-Backend docker image

To run Zonemaster-Backend on docker you have to make sure that Docker is installed on the computer and that you can run Docker on it.

* Instructions for installation are found on Docker [get started] page.
* Run the command docker ps on the command line to verify that you can run Docker on the computer.

When Docker has been correctly installed, you need to build zonemaster/backend image.
To build your own docker image, see the [Docker Image Creation] documentation to build the necessary images.

Once the following docker images build on your system:
* zonemaster/ldns:local
* zonemaster/engine:local
* zonemaster/cli:local

You can build zonemaster/backend:local with the following command:

```
git clone git@github.com:zonemaster/zonemaster-backend.git
cd zonemaster-backend
perl Makefile.PL
make all dist docker-build
``

## Usage


```
docker run --rm -p 5000:5000 --name zm -d zonemaster/backend:local full
```

Once zonemaster/backend container started you can interact with it on `localhost:5000`
usign JSON RPCAPI.
If `zmtest` is installed on your system you can use it directly.

```
zmtest test.fr
```

Alternatively you can set the server address with the ip of the container
```
zmtest -s http://[ip_of_the_backend_container]:5000 test.fr
```


Otherwise you can use `zmtest` embedded inside the backend image by using this command:

```
docker run -ti --rm --net host zonemaster/backend:local zmtest test.fr
```

It's also possible to interract with it with `zmb`

```
docker run -ti --rm --net host zonemaster/backend:local zmb start_domain_test --domain test.fr
docker run -ti --rm --net host zonemaster/backend:local zmb get_test_results --test-id ed38765834e45b6e --lang en
```


You can stop the docker with `docker stop zm`.


## Options Available

Zonemaster/backend docker image offert multiple options that can be selected by passing argument to the image.

### full

TODO

### cli

TODO
offer the same possibility as zonemaster-cli container image (TODO: add link to documentation of zonemaster-cli docker)

docker run -ti --rm zonemaster/backend:local cli test.fr


### zmtest

TODO

### rpcapi

TODO

### testagent

TODO

## Troubleshooting

### piping docker output to `jq`

docker run -ti --rm --net host zonemaster/backend:local zmb get_test_results (...) |tr -d '^M' | jq



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
