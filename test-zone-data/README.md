# Test Zone Data

## Table of contents


* [Installation instructions](#installation-instructions)
* [Running instructions](#running-instructions)
  * [Start coredns in terminal 1](#start-coredns-in-terminal-1)
  * [Run zonemaster-cli in terminal 2](#run-zonemaster-cli-in-terminal-2)
  * [Run unit tests in terminal 2](#run-unit-tests-in-terminal-2)
* [Files in current directory](#files-in-current-directory)
* [Directories in current directory](#directories-in-current-directory)
* [Notes](#notes)



This is work-in-progress.

When loading `coredns` configuration this directory should be the working
directory, else it will not find all included data files. This directory
structure holds directories with zonefiles and `coredns` configurations
for the test zone scenarios.

## Installation instructions

1. Only Ubuntu 22.04 is supported.
2. Install Zonemaster-CLI on the computer. Install either current develop branch
   (to get support for `--hint`) or Zonemaster v2022.2 (first version with
   support for `--hint`).
3. Clone this repository or copy its contents to the computer.
4. Install `go`:
   ```
   sudo apt  install golang-go 
   ```
5. Install `unbound`
   ```
   sudo apt install libunbound-dev
   ```
5. Install `coredns`:
   1. Reference https://github.com/coredns/coredns
   2. Clone `coredns`:
   ```
   git clone https://github.com/coredns/coredns
   cd coredns
   ```
   3. Add the line "unbound:github.com/coredns/unbound" to the plugin.cfg
      file found in the top of the repository, e.g.
   ```
   echo "unbound:github.com/coredns/unbound" >> plugin.cfg
   ```
   4. Generate and compile
   ```
   go get github.com/coredns/unbound
   go generate
   CGO_ENABLED=1 make
   ```
   5. `coredns` is now in top of repository. Add it to PATH:
   ```
   sudo cp coredns  /usr/local/bin/
   ```
   6. Create `add-ip.sh` from the address plan (TBD).

## Running instructions

Two terminal windows to the computer are needed.

### Start coredns in terminal 1

1. Change directory to where this README file is.
2. Create all virtual interfaces. This step has to be done once for each session
   or again if additional interfaces have been added. (Reboot the computer to
   remove the interfaces.)
   ```
   sudo sh add-ip.sh
   ```
3. Start `coredns`. It will be running in the forground until terminated.
   ```
   sudo coredns --conf main.cfg
   ```

### Run zonemaster-cli in terminal 2

1. Change directory to where this README file is.
2. Use `zonemaster-cli` with `--hint` and the appropriate name.root hint file.
   Example:
   ```
   zonemaster-cli NO-RESPONSE-MX-QUERY.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   ```
   
### Run unit tests in terminal 2

TBD.


## Files in current directory
In this directory the following files are to be found:

* main.cfg
  * The default main `coredns` configuration file that includes all
    other data files.
* address-plan.md
  * A document that explains the IP plan and that also contains the
    the IP plan in a markdown table.
* add-ip.sh
  * A script, generated from the IP plan, to populate the loopback
    interface with IP addresses. Generated versions to be checked-in.
* make-add-ip.pl
  * A script that will generate add-ip.sh when the IP plan has
    been updated. To be manually run when needed. (TBD)
* named.root (TBD)
  * Default hint file to be used by `zonemaster-cli` when testing
    against the test zones created by this structure.
* named.root-XXXX (TBD)
  * An alternative hint file for a specific scenario (XXXX to
    be the combination of scenario name and test case ID).
* Additional scripts may be needed. (TB)
* Private keys for DNSKEY (TBD)





## Directories in current directory
In this directory the following directories will be found:

* COMMON/
  * Holds zone files and configuration that are shared between several scenarios
    for different test cases.
* Address-TP/
  * Directory structure for scenarios for test cases in the Adress-TP test module.
* Basic-TP/
  * Directory structure for scenarios for test cases in the Basic-TP test module.
* Connectivity-TP/
  * Directory structure for scenarios for test cases in the Connectivity-TP test
    module.
* Consistency-TP/
  * Directory structure for scenarios for test cases in the Consistency-TP test
    module.
* DNSSEC-TP/
  * Directory structure for scenarios for test cases in the DNSSEC-TP test
    module.
* Delegation-TP/
  * Directory structure for scenarios for test cases in the Delegation-TP test
    module.
* Nameserver-TP/
  * Directory structure for scenarios for test cases in the Nameserver-TP test
    module.
* Syntax-TP/
  * Directory structure for scenarios for test cases in the Syntax-TP test
    module.
* Zone-TP/
  * Directory structure for scenarios for test cases in the Zone-TP test module.


## Notes

Instructions below will be elaborated and updated

* Installation of `Golang`
* Clone `coredns`
* Maybe patch `coredns`
* Compile `coredns`
* Identify binary
  * Copy to directory in path?
  * Symlink from ~/bin/?
* Maybe installtion of `Bind`
* Instructions for updating some RRSIG
* Instructions for running `make-add-ip.pl`
* Instructions for running `add-ip.sh`




