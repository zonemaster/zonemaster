This is work-in-progress.

When loading `coredns` configuration this directory should be the working
directory, else it will not find all included data files.


In this directory the following items will be found:

* data/
  *A directory with data files. See README.md in that directory
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
  * A script that will generate app-ip.sh when the IP plan has
    been updated. To be manually run when needed.
* named.root
  * Default hint file to be used by `zonemaster-cli` when testing
    against the test zones created by this structure.
* named.root-XXXX
  * An alternative hint file for a specific scenario (XXXX to
    be the combination of scenario name and test case ID).
* Additional scripts may be needed.
* Private keys for DNSKEY

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
* Instructions för running `add-ip.sh`
