Engine - Functional Test requirements
======================================

Objective
----------
The purpose of Zonemaster tool is to test the quality of a DNS delegation.
The tool comprises of three different functional blocks: 
   1. Test engine – which comprises of necessary source code to run test
implementations and report results
   2. Web GUI – will enable users to provide input (such as a domain name 
with different options) and call the test engine and read results from a web
browser
   3. CLI – will enable users to provide input (such as a domain name with
different options) and call the test engine and read results from a text
console

The objective of this document is to run functional tests for the two
functional blocks – Test engine and GUI. As of now CLI is not within the
scope of this document.

Scope
------

The test specifciation (which is part of the test engine) implemented has already
gone/going through the process of unit testing. Unit testing is done to
confirm that a unitary code (such as a single test case source code)
component provides the correct output for a given input. 

Functional tests are intended to verify whether the code (written as part of
the test engine) accurately detects the DNS problem's it is meant to detect
with neither false positive nor false negative. As part of writing the
functional tests for the test engine, following steps should be followed:
   * Write the functional test requirements
   * Follow the method (as done for unit tests) to elaborate the test
   requirements
   * Write simple scripts to launch the test or use the CLI.  Compare the 
   results of the test with the results of both Zonecheck and DNScheck



|Req| Test case                                  | 
|:--|:-------------------------------------------|
|R01|A DNS query with a label that exceeds the maximum length - 63 characters|[Test Case](../specifications/tests/Connectivity-TP/connectivity01.md)|
|R02|A FQDN that exceeds the maximum length - 255 octets||
|R03|A host name label with other than letters, digits and '-' character ||
|R04|CNAME RRs collision (If a CNAME RR is present at a node, no other data should be present; (3.6.2) - RFC 1034) ||
|R05|Error in the RR format (3.3 - RFC 1035)||
|R06|Test whether the tool correctly treats the name error with "NXDOMAIN" in response||
|R07|Test whether the tool correctly treats when "no such data exist"  with "NODATA" in response||
|R08|Test whether the tool triggers appropriate error when network connectivity is disabled||
|R09|Test whether the tool triggers appropriate error when network connectivity is enabled||
|R10|Match the results with existing ZC/DC when certain protocols are disabled (e.g. IPv6||
|R11|Test whether the tool Run only appropriate tests when the default test profile is modified||
|R12|Capable of running the test when the delegation parameters are specified||
|R13|Able to test non delegated domain||
|R14|Check whether timestamps on the test being run are being displayed||
|R15|With the report flag enabled check whether the tool reports tests as they are being run||
|R16|Check whether the tool displays statistics on network performance, RTT: min, max, stddev, avg, per protocol and queries sent per name server||
|R17|Provides the same results as in ZC/DC when IDNs are used||
|R18|Test whether the tool displays verbose information when launched with appropriate flags||
|R19|Test whether the tool triggers appropriate error code when the server is misconfigured||
|R20|Test whether the tool respond with one or more RRs if data does exist for the DNS query in question||


