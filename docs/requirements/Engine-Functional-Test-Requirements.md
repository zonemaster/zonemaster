Engine - Functional Test requirements
======================================

Objective
----------
The purpose of Zonemaster tool is to test the quality of a DNS delegation.
The tool comprises of three different functional blocks: 1. Test engine – 
which comprises of necessary source code to run test
implementations and report results
   2. Web GUI – will enable users to provide input (such as a domain name 
with
different options) and call the test engine and read results from a web
browser
   3. CLI – will enable users to provide input (such as a domain name with
different options) and call the test engine and read results from a text
console

The objective of this document is to run functional tests for the two
functional blocks – Test engine and GUI. As of now CLI is not within the
scope of this document.

Scope
------

The test cases (which is part of the test engine) implemented has already
gone/going through the process of unit testing. Unit testing is done to
confirm that a unitary code (such as a single test case source code)
component provides the correct output for a given input. As part of the
functional tests for the test engine, following steps should be followed:
   * Write the test cases
   * Write simple scripts to launch the test or use the CLI.  Compare the 
   * results of the test with the results of both Zonecheck and
DNScheck



|Req| Test case                                  | 
|:--|:-------------------------------------------|
|R01|Triggers when it detects a DNS query with a label that exceeds the maximum length - 63 characters|
|R02|Triggers when it detects a FQDN that exceeds the maximum length - 255 octets|
|R03|Triggers when it detects other than letters, digits and '-' character in a label for a host name|
|R04|Match the results with existing ZC/DC when certain protocols are disabled (e.g. IPv6|
|R05| Run only appropriate tests when the default test profile is modified.  
Match the results with existing ZC/DC under the same configuration|
|R06|Capale of running the test when the delegation parameters are specified|
|R07|Able to test non delegated domain|
|R08|Check whether timestamps on the test being run are being displayed|
|R09|With the report flag enabled check whether the tool reports tests as they are being run|
|R10|Check whether the tool displays statistics on network performance, RTT: 
min, max, stddev, avg, per protocol and queries sent per name server|
|R11|Provides the same results as in ZC/DC when IDNs are used|
|R12|Trigger when there is a collision with CNAME RRs (If a CNAME RR is present at a node, no other data should be present; (3.6.2) - RFC 1034) |
|R13|Trigger when there is an error in the RR format (3.3 - RFC 1035)|
|R14|Test whether the tool displays verbose information when launched with appropriate flags|
|R15|Test whether the tool triggers appropriate error when network connectivity is disabled. Match the results with current DC/ZC|
|R16|Test whether the tool triggers appropriate error when network connectivity is enabled. Match the results with current DC/ZC|
|R17|Test whether the tool triggers appropriate error code when the server is misconfigured|
|R18|Test whether the tool respond with one or more RRs if data does exist for the DNS query in question|
|R19|Test whether the tool correctly treats the name error with "NXDOMAIN" in response|
|R20|Test whether the tool correctly treats when "no such data exist"  with "NODATA" in response|


