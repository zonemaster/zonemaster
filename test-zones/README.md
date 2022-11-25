This is work-in-progress.

When loading `coredns` configuration this directory should be the working
directory, else it will not find all included data files. This directory
structure holds directories with zonefiles and `coredns` configurations
for the test zone scenarios.


In this directory the following files will be found:

* main.cfg
  * The default main `coredns` configuration file that includes all
    other data files.
* main-XXXX.cfg
  * An alternative `coredns` configuration file for a specific
    scenario (XXXX to be the combination of scenario name and test case ID).
* iptable.md
  * A document that explains the IP plan and that also contains the
    the IP plan in a markdown table.
* add-ip.sh
  * A script, generated from the IP plan, to populate the loopback
    interface with IP addresses. Generated versions to be checked-in.
* make-add-ip.pl
  * A script that will generate add-ip.sh when the IP plan has
    been updated. To be manually run when needed.
* named.root
  * Default hint file to be used by `zonemaster-cli` when testing
    against the test zones created by this structure.
* named.root-XXXX
  * An alternative hint file for a specific scenario (XXXX to
    be the combination of scenario name and test case ID).
* Additional scripts may be needed.
* Private keys for DNSKEY


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




