# Test Zone Data

## Table of contents


* [Installation instructions](#installation-instructions)
* [Running instructions](#running-instructions)
  * [Start coredns in terminal 1](#start-coredns-in-terminal-1)
  * [Run zonemaster-cli in terminal 2](#run-zonemaster-cli-in-terminal-2)
  * [Run unit tests in terminal 2](#run-unit-tests-in-terminal-2)
* [Files](#files)
* [Directories](#directories)
* [Notes](#notes)

When loading `coredns` configuration the [test-zone-data] directory should be
the working directory, else it will not find all included data files. That
directory structure holds directories with zone files and `coredns` configurations
for the test zone scenarios.

## Installation instructions

1. Only Ubuntu 22.04 is supported.
2. Install Zonemaster-CLI on the computer. Install current develop branch or the
   latest version of Zonemaster (it will not work with older version than v2022.2,
   first version with support for `--hint`).
3. Clone this repository or copy its contents to the computer.
4. Install `go`:
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
   4. Generate and compile
   ```
   go get github.com/coredns/unbound
   go generate
   CGO_ENABLED=1 make
   ```
   5. `coredns` is now in top of repository. Add it to PATH and repeat this step
      every time `coredns` is recompiled (or create a symlink instead).
   ```
   sudo cp coredns  /usr/local/bin/
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
3. Start `coredns`. It will be running in the foreground until terminated.
   ```
   sudo coredns --conf main.cfg
   ```

### Run zonemaster-cli in terminal 2

1. Change directory to where this README file is.
2. Use `zonemaster-cli` with `--hint` and the appropriate name.root hint file.
   Example
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


## Files

The following files are found in [this directory](.), i.e. the same directory as
this README file.

* [main.cfg]
  * The default main `coredns` configuration file that includes all
    other data files.
* [address-plan.md]
  * A document that explains the IP plan and that also contains the
    IP plan in a markdown table.
* [set-ip.sh]
  * A script to populate the loopback based on the content of
    [address-plan.md].

More files are found in the directories below.


## Directories

The following directories are found in [this directory][test-zone-data], i.e.
the same directory as this README file. More files and sub-directories are found
in those directories.

* [COMMON/]
  * Holds zone files and configuration that are shared between several scenarios
    for different test cases.
* Address-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Address-TP test module.
* Basic-TP/ (*not yet available*)
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
* Nameserver-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Nameserver-TP test
    module.
* Syntax-TP/ (*not yet available*)
  * Directory structure for scenarios for test cases in the Syntax-TP test
    module.
* [Zone-TP/]
  * Directory structure for scenarios for test cases in the Zone-TP test module.


[add-ip.sh]:                                           add-ip.sh
[address-plan.md]:                                     address-plan.md
[COMMON/]:                                             COMMON/
[Consistency-TP/]:                                     Consistency-TP/
[DNSSEC-TP/]:                                          DNSSEC-TP/
[main.cfg]:                                            main.cfg
[set-ip.sh]:                                           set-ip.sh
[t]:                                                   https://github.com/zonemaster/zonemaster-engine/tree/develop/t
[test-zone-data]:                                      .
[Zone-TP/]:                                            Zone-TP/
[Zonemaster-Engine]:                                   https://github.com/zonemaster/zonemaster-engine/

