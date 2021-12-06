Release Process - Create Docker Image
=====================================

## Table of contents

* [1. Overview](#1-overview)
* [2. Prerequsite](#2-prerequsite)
* [3. Create Docker images](#3-create-docker-images)
* [4. Upload images to Docker Hub](#4-upload-images-to-docker-hub)
* [5. Image sanity checks][sanity checks]
* [6. Handy Docker commands][Handy Docker commands]

## 1. Overview

This document covers two stages in the release processes:

1. Creating Docker images for testing.
2. Creating Docker image for publishing on Docker Hub

Presently only Zonemaster-CLI is published, and therefore only Zonemaster-LDNS,
Zonemaster-Engine and Zonemaster-CLI are covered here.


## 2. Prerequsite

The steps in this documents are assumed to be executed on a computer installed
as an [Ubuntu Build Environment] computer. It could work on another OS as long
as the same support is available.

All commands in this instruction are assumed to be executed from the one and the
same directory. If you run `cd`, then you have to run `cd` back to the start
directory.

The Docker environment is assumed to be clean. Consider running the following
commands before proceeding (see section "[Handy Docker commands]") to clean up:
```sh
[ "$(docker ps -a -q)" != '' ] && docker rm -f $(docker ps -a -q)
```
```sh
[ "$(docker image ls -q)" != '' ] && docker image prune -a
```


## 3. Create Docker images

Clone the three repositories:

```sh
git clone https://github.com/zonemaster/zonemaster-ldns
git clone https://github.com/zonemaster/zonemaster-engine
git clone https://github.com/zonemaster/zonemaster-cli
```

Check out right branch depending on the use case.

* Check out `develop` branch when creating an image for release testing:

```sh
git -C zonemaster-ldns checkout origin/develop
git -C zonemaster-engine checkout origin/develop
git -C zonemaster-cli checkout origin/develop
```

* Check out `master` branch when creating an image for Docker Hub at release, or
when creating an image based on release version:

```sh
git -C zonemaster-ldns checkout origin/master
git -C zonemaster-engine checkout origin/master
git -C zonemaster-cli checkout origin/master
```

Create `Makefile` in all three repositories

```sh
(cd zonemaster-ldns; git clean -dfx; git reset --hard; perl Makefile.PL)
```
```sh
(cd zonemaster-engine; git clean -dfx; git reset --hard; perl Makefile.PL)
```
```sh
(cd zonemaster-cli; git clean -dfx; git reset --hard; perl Makefile.PL)
```

Create an image for each repository. That image will be tagged "local". The
images must be created in order since there is a dependency on the previous
image in each step.
```sh
make -C zonemaster-ldns all dist docker-build
```
```sh
make -C zonemaster-engine all dist docker-build
```
```sh
make -C zonemaster-cli all dist docker-build
```

For the Zonemaster-CLI image, add a version tag and a tag "latest".

* Add version tag:
```sh
make -C zonemaster-cli docker-tag-version
```

* Add tag "latest":
```sh
make -C zonemaster-cli docker-tag-latest
```

All the created images can now be listed. Also consider doing [sanity checks] to
verify that all images work. Images without tag are temporary images without
further use. List images:

```sh
docker images
```

## 4. Upload images to Docker Hub

To upload an image to the Zonemaster Docker Hub organization you have to have
a Docker Hub account and the authorization to upload images.

```sh
docker login
```

The same image is pushed twice with different tags. Verify in the listing
above that they have the same ID.

* Push latest.
```sh
docker push zonemaster/cli:latest
```

* Set correct version (see listing above) and push image with version tag:
```sh
docker push zonemaster/cli:v0.0.0
```

## 5. Image sanity checks

Zonemaster-LDNS:

```sh
docker run --rm zonemaster/ldns:local perl -MZonemaster::LDNS -E 'say Zonemaster::LDNS->new("9.9.9.9")->query("zonemaster.net")->string'
```

Zonemaster-Engine:

```sh
docker run --rm zonemaster/engine:local perl -MZonemaster::Engine -E 'say join "\n", Zonemaster::Engine->test_module("BASIC", "zonemaster.net")'
```

Zonemaster-CLI:

```sh
docker run --rm zonemaster/cli:local zonemaster.net
```

## 6. Handy Docker commands

List all containers, including stopped containers.

```sh
docker ps -a
```

List all images
```sh
docker images
```

Remove container indentified as "ID"
```sh
docker rm ID
```

Remove image identified as "ID"
```sh
docer rmi ID
```

Remove all containers
```sh
docker rm -f $(docker ps -a -q)
```

Remove all images
```sh
docker image prune -a
```

Save an image to a tar file
```sh
docker save -o docker-zonemaster-cli.tar zonemaster/engine
```

Load an image from a tar file
```sh
docker load -i docker-zonemaster-cli.tar
```


[Ubuntu Build Environment]:               ../distrib-testing/Ubuntu-build-environment.md
[Sanity checks]:                          #5-image-sanity-checks
[Handy Docker commands]:                  #6-handy-docker-commands
