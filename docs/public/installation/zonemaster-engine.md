# Installation: Zonemaster-Engine

## Table of contents

* [Local installation](#local-installation)
  * [Installation on Rocky Linux](#installation-on-rocky-linux)
  * [Installation on Debian and Ubuntu](#installation-on-debian-and-ubuntu)
  * [Installation on FreeBSD](#installation-on-freebsd)
* [Post-installation sanity check](#post-installation-sanity-check)
* [Troubleshooting installation](#troubleshooting-installation)
* [Global cache (experimental feature)](#global-cache-experimental-feature)
* [What to do next](#what-to-do-next)


## Local installation

### Installation on Rocky Linux

1) Install the [EPEL] repository:

   ```sh
   sudo dnf install --assumeyes epel-release
   sudo crb enable
   ```

2) Enable SHA-1 in the crypto policy:

   ```sh
   # Only on Rocky Linux 9:
   sudo update-crypto-policies --set DEFAULT:SHA1
   ```

3) Install locales:

   ```sh
   sudo dnf install --assumeyes glibc-all-langpacks
   ```

4) Install binary packages:

   ```sh
   sudo dnf --assumeyes install cpanminus gcc libidn2-devel openssl-devel perl-Class-Accessor perl-Clone perl-core perl-Devel-CheckLib perl-Email-Valid perl-ExtUtils-PkgConfig perl-File-ShareDir perl-File-Slurp perl-libintl perl-IO-Socket-INET6 perl-List-MoreUtils perl-Mail-SPF perl-Module-Find perl-Module-Install perl-Net-DNS perl-Pod-Coverage perl-Readonly perl-Sub-Override perl-Test-Differences perl-Test-Exception perl-Test-Fatal perl-Test-NoWarnings perl-Test-Pod perl-Text-CSV perl-Test-Simple
   ```

5) Install packages from CPAN:

   ```sh
   sudo cpanm --notest Locale::PO Log::Any MIME::Base32 Module::Install::XSUtil Net::IP::XS YAML::XS
   ```

6) Install Zonemaster::LDNS and Zonemaster::Engine:

   ```sh
   sudo cpanm --notest Zonemaster::LDNS Zonemaster::Engine
   ```

### Installation on Debian and Ubuntu

Using pre-built packages is the preferred method for Debian and Ubuntu.

#### Installation from pre-built packages

1) Upgrade to latest patch level

   ```sh
   sudo apt update && sudo apt upgrade
   ```

2) Add Zonemaster packages repository to repository list
   ```sh
   curl -LOs https://package.zonemaster.net/setup.sh
   sudo sh setup.sh
   ```

3) Install Zonemaster Engine
   ```sh
   sudo apt install libzonemaster-engine-perl
   ```

#### Installation from CPAN

1) Upgrade to latest patch level

   ```sh
   sudo apt update && sudo apt upgrade
   ```

2) Install dependencies from binary packages:

   ```sh
   sudo apt install autoconf automake build-essential cpanminus libclass-accessor-perl libclone-perl libdevel-checklib-perl libemail-valid-perl libextutils-pkgconfig-perl libfile-sharedir-perl libfile-slurp-perl libidn2-dev libintl-perl libio-socket-inet6-perl liblist-moreutils-perl liblocale-po-perl liblog-any-perl libmail-spf-perl libmime-base32-perl libmodule-find-perl libmodule-install-perl libmodule-install-xsutil-perl libnet-dns-perl libnet-ip-xs-perl libpod-coverage-perl libreadonly-perl libssl-dev libsub-override-perl libtest-differences-perl libtest-exception-perl libtest-fatal-perl libtest-nowarnings-perl libtest-pod-perl libtext-csv-perl libyaml-libyaml-perl libtool m4
   ```

3) Install Zonemaster::LDNS and Zonemaster::Engine.

   ```sh
   sudo cpanm --notest Zonemaster::LDNS Zonemaster::Engine
   ```

### Installation on FreeBSD

1) Become root:

   ```sh
   su -l
   ```

2) Update list of package repositories:

   Create the file `/usr/local/etc/pkg/repos/FreeBSD.conf` with the
   following content, unless it is already updated:

   ```
   FreeBSD: {
   url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
   }
   ```

3) Check or activate the package system:

   Run the following command, and accept the installation of the `pkg` package
   if suggested.

   ```
   pkg info -E pkg
   ```

4) Update local package repository:

   ```
   pkg update -f
   ```

5) Install dependencies from binary packages:

   ```sh
   pkg install devel/gmake dns/ldns libidn2 p5-App-cpanminus p5-Class-Accessor p5-Clone p5-Devel-CheckLib p5-Email-Valid p5-ExtUtils-PkgConfig p5-File-ShareDir p5-File-Slurp p5-IO-Socket-INET6 p5-List-MoreUtils p5-Locale-libintl p5-Locale-PO p5-Log-Any p5-Mail-SPF p5-MIME-Base32 p5-Module-Find p5-Module-Install p5-Module-Install-XSUtil p5-Net-DNS p5-Net-IP-XS p5-Pod-Coverage p5-Readonly p5-Sub-Override p5-Test-Differences p5-Test-Exception p5-Test-Fatal p5-Test-NoWarnings p5-Test-Pod p5-Text-CSV p5-YAML-LibYAML
   ```

6) Install Zonemaster::LDNS:

   ```sh
   cpanm --notest --configure-args="--no-internal-ldns" Zonemaster::LDNS
   ```

7) Install Zonemaster::Engine:

   ```sh
   cpanm --notest Zonemaster::Engine
   ```

## Post-installation sanity check

Make sure Zonemaster::Engine is properly installed.

```sh
time perl -MZonemaster::Engine -E 'say join "\n", Zonemaster::Engine->test_module("BASIC", "zonemaster.net")'
```

The command is expected to take a few seconds and print some results about the
delegation of zonemaster.net.


## Troubleshooting installation

If you have any issue with installation, and installed with `cpanm`, redo the
installation above but without the `--notest` and with the `--verbose` option.
Installation will take longer time.


## Global cache (experimental feature)

Global cache is an experimental feature that can be enabled in Zonemaster-Engine
and that can increase the performance when many tests are run within a short time
frame. See [global cache configuration].


## What to do next

* For a command line interface, follow the [Zonemaster::CLI installation] instruction.
* For a web interface, follow the [Zonemaster::Backend installation] and [Zonemaster::GUI installation] instructions.
* For a [JSON-RPC API], follow the [Zonemaster::Backend installation] instruction.
* For a Perl API, see the [Zonemaster::Engine API] documentation.


[EPEL]:                                              https://docs.fedoraproject.org/en-US/epel/
[Global cache configuration]:                        ../configuration/global-cache.md
[JSON-RPC API]:                                      ../using/backend/rpcapi-reference.md
[Zonemaster::Backend installation]:                  zonemaster-backend.md
[Zonemaster::CLI installation]:                      zonemaster-cli.md
[Zonemaster::Engine API]:                            https://metacpan.org/pod/Zonemaster::Engine
[Zonemaster::GUI installation]:                      zonemaster-gui.md
