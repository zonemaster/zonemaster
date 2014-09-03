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


|Req| Test requirement                           |Explanation|
|:--|:-------------------------------------------|-----------|
|FR01|A DNS query with a label that exceeds the maximum length - 63 characters|[SYNTAX01](../specifications/functional-tests/SYNTAX-TP/syntax01.md)|
|FR02|A FQDN that exceeds the maximum length - 255 octets|[SYNTAX02](../specifications/functional-tests/SYNTAX-TP/syntax02.md)|
|FR03|A host name label with other than letters, digits and '-' character|[SYNTAX03](../specifications/functional-tests/SYNTAX-TP/syntax03.md)|
|FR04|CNAME RRs collision (If a CNAME RR is present at a node, no other data should be present; (3.6.2) - RFC 1034) |[CONFIGURATION01](../specifications/functional-tests/CONFIGURATION-TP/configuration01.md)|
|FR05|Triggers when, in order to resolve a zone 'x', the resolver needs to query 'y', which in order to be resolved requires 'x' to be resolved first - - "Zone cyclic dependency"|[CONFIGURATION02](../specifications/functional-tests/CONFIGURATION-TP/configuration02.md)|
|FR06|Triggers when NS RRset declared at the parent is not the same as the one declared in the child zone|[COHERENCY01](../specifications/functional-tests/COHERENCY-TP/coherency01.md)|
|FR07|Triggers when glue A record does not point to the same IP address as the corresponding authoritative A record|[COHERENCY02](../specifications/functional-tests/COHERENCY-TP/coherency02.md)|
|FR08|Triggers when the TTL values are not consistent for the same RRset in both parent and child zone|[COHERENCY03](../specifications/functional-tests/COHERENCY-TP/coherency03.md)|
|FR09|When a nameserver that is registered in the DNS system as authoritative for a zone , does not provide authoritative answers for the zone |[COHERENCY04](../specifications/functional-tests/COHERENCY-TP/coherency04.md)|
|FR10|A nameserver that is authoritative for a zone does not have authoritative data|[COHERENCY05](../specifications/functional-tests/COHERENCY-TP/coherency05.md)|
|FR11|Test whether the tool triggers appropriate error when network connectivity is disabled|[CONNECTIVITY01](../specifications/functional-tests/CONNECTIVITY-TP/connectivity01.md)|
|FR12|Test whether the tool triggers appropriate error when network connectivity is enabled|[CONNECTIVITY02](../specifications/functional-tests/CONNECTIVITY-TP/connectivity02.md)|
|FR13|Test whether the tool correctly treats the name error with "NXDOMAIN" in response|[BEHAVIOR01](../specifications/functional-tests/BEHAVIOR-TP/behavior01.md)|
|FR14|Test whether the tool correctly treats when "no such data exist"  with "NODATA" in response|[BEHAVIOR02](../specifications/functional-tests/BEHAVIOR-TP/behavior02.md)|
|FR15|Match the results with existing ZC/DC when certain protocols are disabled (e.g. IPv6|[BEHAVIOR03](../specifications/functional-tests/BEHAVIOR-TP/behavior03.md)|
|FR16|Test whether the tool Run only appropriate tests when the default test profile is modified|[BEHAVIOR04](../specifications/functional-tests/BEHAVIOR-TP/behavior04.md)|
|FR17|Capable of running the test when the delegation parameters are specified|[BEHAVIOR05](../specifications/functional-tests/BEHAVIOR-TP/behavior05.md)|
|FR18|Able to test non delegated domain|[BEHAVIOR06](../specifications/functional-tests/BEHAVIOR-TP/behavior06.md)|
|FR19|Check whether timestamps on the test being run are being displayed|[BEHAVIOR07](../specifications/functional-tests/BEHAVIOR-TP/behavior07.md)|
|FR20|With the report flag enabled check whether the tool reports tests as they are being run|[BEHAVIOR08](../specifications/functional-tests/BEHAVIOR-TP/behavior08.md)|
|FR21|Check whether the tool displays statistics on network performance, RTT: min, max, stddev, avg, per protocol and queries sent per name server|[BEHAVIOR09](../specifications/functional-tests/BEHAVIOR-TP/behavior09.md)|
|FR22|Provides the same results as in ZC/DC when IDNs are used|[BEHAVIOR10](../specifications/functional-tests/BEHAVIOR-TP/behavior10.md)|
|FR23|Test whether the tool displays verbose information when launched with appropriate flags|[BEHAVIOR11](../specifications/functional-tests/BEHAVIOR-TP/behavior11.md)|
|FR24|Test whether the tool triggers appropriate error code when the server is misconfigured|[BEHAVIOR12](../specifications/functional-tests/BEHAVIOR-TP/behavior12.md)|
|FR25|Test whether the tool respond with one or more RRs if data does exist for the DNS query in question|[BEHAVIOR13](../specifications/functional-tests/BEHAVIOR-TP/behavior13.md)|

