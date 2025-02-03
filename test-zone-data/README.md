# Test Zone Data

## Table of contents

* [Introduction](#introduction)
* [Installing mandatory parts](#installing-mandatory-parts)
* [Installing Bind](#installing-bind)
* [Updating and installing Perl DNS libraries](#updating-and-installing-perl-dns-libraries)
* [Running instructions](#running-instructions)
  * [Start coredns in terminal 1](#start-coredns-in-terminal-1)
  * [Run zonemaster-cli in terminal 2](#run-zonemaster-cli-in-terminal-2)
  * [Run unit tests in terminal 2](#run-unit-tests-in-terminal-2)
  * [Running Bind](#running-bind)
* [Files](#files)
* [Directories](#directories)
* [Resources](#resources)
* [Test case based test zones](#test-case-based-test-zones)
* [Other test zones](#other-test-zones)


## Introduction

When loading `coredns` configuration the [test-zone-data] directory should be
the working directory, else it will not find all included data files. That
directory structure holds directories with zone files and `coredns` configurations
for the test zone scenarios.


## Installing mandatory parts

1. Only Ubuntu 22.04 is supported.
2. Install Zonemaster-CLI on the computer. Install current develop branch or the
   latest version of Zonemaster (it will not work with older version than v2022.2,
   first version with support for `--hint`).
3. Clone this repository or copy its contents to the computer.
4. Install `go` (here version 1.20 is assumed):
   ```
   sudo apt install golang-go 
   ```
5. Install `unbound`
   ```
   sudo apt install libunbound-dev
   ```
6. Install `coredns`:
   1. Reference https://github.com/coredns/coredns
   2. Clone `coredns`:
   ```
   git clone https://github.com/coredns/coredns
   cd coredns
   ```
   3. Add the line "unbound:github.com/coredns/unbound" to the plugin.cfg file
      found in the top of the repository, e.g.
   ```
   echo "unbound:github.com/coredns/unbound" >> plugin.cfg
   ```
   4. Add support for CHAOS class in more plugins. In
      `coredns/core/dnsserver/server.go` find `EnableChaos` at the end of the
      file. Add "template" and "acl" to the plugins that accepts CHAOS class. For
      reference see https://github.com/coredns/coredns/discussions/6373
   5. Generate and compile
   ```
   go get github.com/coredns/unbound
   go generate
   CGO_ENABLED=1 make
   ```
   6. `coredns` is now in top of repository. Add it to PATH and repeat this step
      every time `coredns` is recompiled (or create a symlink instead).
   ```
   sudo cp coredns  /usr/local/bin/
   ```

## Installing Bind

   This step can be skipped unless you will create or update DNS record with
   the help of Bind, e.g. for test zones for scenarios for DNSSEC10.
   ```
   sudo apt install bind9
   ```
   Make sure Bind is off and will not automatically start after restart.
   ```
   sudo systemctl stop named
   sudo systemctl disable named
   ```
   We will need to start named with configuration files in different locations
   so `apparmor` must be disabled for named. The change is permanent.
   ```
   sudo ln -s /etc/apparmor.d/usr.sbin.named /etc/apparmor.d/disable/
   sudo apparmor_parser -R /etc/apparmor.d/disable/usr.sbin.named
   ```

## Updating and installing Perl DNS libraries

   Utilities for DNSSEC handling at test zone creation for some test
   cases, e.g. DNSSEC10, require updated Net::DNS and installed
   Net::DNS::SEC. This update and installation, respectively, is not
   needed unless the scripts are to be run. See [utils/] for the scripts
   requiring these libraries.
   ```
   sudo cpanm -i Net::DNS
   sudo cpanm -i Net::DNS::SEC
   ```

## Running instructions

Two terminal windows to the computer are needed.

### Start coredns in terminal 1

1. Change to the [test-zone-data] directory (where this README file is).
2. If new IP addresses have been taken into use, [address-plan.md] must be
   updated.
3. Create all virtual interfaces. This step has to be done once for each session
   or again if additional interfaces have been added. (Reboot the computer to
   remove the interfaces, if needed.)
   ```
   ./set-ip.sh
   ```
4. Start `coredns`. It will use `main.cfg` and be running in the foreground
   until terminated.
   ```
   ./start-coredns.sh
   ```

### Run zonemaster-cli in terminal 2

1. Change directory to where this README file is.
2. Use `zonemaster-cli` with `--hint` and the appropriate name.root hint file.
   Example:
   ```
   zonemaster-cli UNEXPECTED-RCODE-MX.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   ```
   with output
   ```
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.07 WARNING   Z09_UNEXPECTED_RCODE_MX   ns_ip_list=ARRAY(0x5638fec55130); rcode=NOTIMPL
   0.07 NOTICE    Z09_MISSING_MAIL_TARGET
   ```

For more examples and information on how to interpret the example above, go to
section “[Directories](#directories)” below, find the test module, then the test
case within the module, and read the test case’s README file.

### Run unit tests in terminal 2

Unit tests based on these test zones for [Zonemaster-Engine] can now be run
in terminal 2 and the data can be recorded and saved as data files. See the
[t] directory in [Zonemaster-Engine] for more details.

### Running Bind
For the test zones for some scenarios DNS records are created by Bind, e.g.
DNSSEC10. For more information see the [Bind README][README-Bind.md].

## Files

The following files are found in [this directory](.), i.e. the same directory as
this README file.

* [address-plan.md]
  * A document that explains the IP plan and that also contains the
    IP plan in a markdown table.
* [main.cfg]
  * The default main `coredns` configuration file that includes all
    other data files.
* [README-Bind.md]
  * Instructions for running `Bind`.
* [set-ip.sh]
  * A script to populate the loopback based on the content of
    [address-plan.md].
* [start-coredns.sh]
  * A script to start CoreDNS correctly.

More files are found in the directories below.


## Directories

The following directories are found in [this directory][test-zone-data], i.e.
the same directory as this README file. More files and sub-directories are found
in those directories.

### Resources

Directories not holding direct test zone data, but resources for the test zone
data.

* [COMMON/]
  * Holds zone files and configuration that are shared between several scenarios
    for different test cases.

* [utils/]
  * Holds utility scripts for test zone construction, e.g. DNSSEC10 test zones.

### Test case based test zones

* Address-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Address-TP test module.
* [Basic-TP/]
  * Directory structure for scenarios for test cases in the Basic-TP test module.
* Connectivity-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Connectivity-TP test
    module.
* [Consistency-TP/]
  * Directory structure for scenarios for test cases in the Consistency-TP test
    module.
* [DNSSEC-TP/]
  * Directory structure for scenarios for test cases in the DNSSEC-TP test
    module.
* Delegation-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Delegation-TP test
    module.
* [Nameserver-TP/]
  * Directory structure for scenarios for test cases in the Nameserver-TP test
    module.
* Syntax-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Syntax-TP test
    module.
* [Zone-TP/]
  * Directory structure for scenarios for test cases in the Zone-TP test module.

### Other test zones

* [Engine/]
  * Directory structure for test zones for Perl modules in Zonemaster-Engine.
* [MethodsV2/]
  * Direcotry structure for scenarios for the shared methods for the test cases.



[address-plan.md]:                                     address-plan.md
[Basic-TP/]:                                           Basic-TP/
[COMMON/]:                                             COMMON/
[Consistency-TP/]:                                     Consistency-TP/
[DNSSEC-TP/]:                                          DNSSEC-TP/
[Engine/]:                                             Engine/
[main.cfg]:                                            main.cfg
[MethodsV2/]:                                          MethodsV2/
[Nameserver-TP/]:                                      Nameserver-TP/
[README-Bind]:                                         README-Bind.md
[set-ip.sh]:                                           set-ip.sh
[start-coredns.sh]:                                    start-coredns.sh
[t]:                                                   https://github.com/zonemaster/zonemaster-engine/tree/develop/t
[test-zone-data]:                                      .
[utils/]:                                              utils/
[Zone-TP/]:                                            Zone-TP/
[Zonemaster-Engine]:                                   https://github.com/zonemaster/zonemaster-engine/
