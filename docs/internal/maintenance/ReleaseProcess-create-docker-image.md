Release Process - Create Docker Image
=====================================

## Table of contents

* [1. Overview](#1-overview)
* [2. Prerequisite](#2-prerequisite)
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


## 2. Prerequisite

The steps in this documents are assumed to be executed on a computer installed
as an [Ubuntu Build Environment] computer. It could work on another OS as long
as the same support is available.

All commands in this instruction are assumed to be executed from the one and the
same directory. If you run `cd`, then you have to run `cd` back to the start
directory.

The Docker environment is assumed to be clean. Consider running the following
commands to clean up before proceeding (see section "[Handy Docker commands]"):
```sh
[ "$(docker ps -a -q)" != '' ] && docker rm -f $(docker ps -a -q)
```
```sh
[ "$(docker image ls -q)" != '' ] && docker image prune -a
```


## 3. Create Docker images

### Clone the three repositories

```sh
git clone https://github.com/zonemaster/zonemaster-ldns
git clone https://github.com/zonemaster/zonemaster-engine
git clone https://github.com/zonemaster/zonemaster-cli
```

### Check out right branch depending on the use case

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

### Make sure repositories are clean and create `Makefile` in all three repositories

```sh
(cd zonemaster-ldns; git submodule update; git clean -dfx; git reset --hard; perl Makefile.PL)
```
```sh
(cd zonemaster-engine; git clean -dfx; git reset --hard; perl Makefile.PL)
```
```sh
(cd zonemaster-cli; git clean -dfx; git reset --hard; perl Makefile.PL)
```

### Create images

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

### Determine version of Zonemaster-CLI image

> The description in this section must be followed if the image is to be uploaded
> to Docker Hub below. If not, this section can be skipped, modified or followed
> depending on needs.

The version of Zonemaster-CLI has the format "v0.0.0" and it is the normal
version of the Docker image too. If needed a "dash version" is used on the Docker
images, and that has the format "v0.0.0-N" where "v0.0.0" is the same version as
Zonemaster-CLI, and "N" is a positive integer starting with "1".

First determine what the version should be. Compare the version of
Zonemaster-Cli just built with the highest version of the image uploaded to
Docker Hub. There are three valid possibilities:

1. The version on Docker Hub has lower version than the local version. If so
   set the tags of the image with the simple steps below ignoring "dash
   versions".

*Example: version on Docker Hub is v6.0.0 of v6.0.0-1, local version is v6.0.1,
new image will have version v6.0.1.*

2. The version on Docker Hub has the same version as the local version. Set the
   version on the new Docker image to be "v0.0.0-1" where "v0.0.0" is equal to
   the local version.

*Example: version on Docker Hub is v6.0.1, local version is v6.0.1, new image
will have version v6.0.1-1.*

3. The version on Docker Hub is a "dash version" where the "v0.0.0" part is the
   same as the local version. Set the version of the new Docker image to be
   "v0.0.0-N" where "v0.0.0" is equal to the local version and "N" is the
   integer incremented by 1 compared to the version on Docker Hub.

*Example: version on Docker Hub is v6.0.1-1, local version is v6.0.1, new image
will have version v6.0.1-2.*


### Tag the Zonemaster-CLI image

For the Zonemaster-CLI image, add a version tag and a tag "latest".

* Add version tag:
```sh
make -C zonemaster-cli docker-tag-version
```

* Add tag "latest":
```sh
make -C zonemaster-cli docker-tag-latest
```

* If "dash version" is to be used, set tag with that version and remove tag with
plain version where "v0.0.0" should be the local version and "v0.0.0-N" should be
the "dash version" determined above:
```
cd zonemaster-cli
docker tag zonemaster/cli:local zonemaster/cli:v0.0.0-N 
docker rmi zonemaster/cli:v0.0.0
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

* Set correct version (see listing above) and push image with version tag. If
  "dash version" is used, use "v0.0.0-N" set to correct version instead.
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

Remove container identified as "ID"
```sh
docker rm ID
```

Remove image identified as "ID"
```sh
docker rmi ID
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
