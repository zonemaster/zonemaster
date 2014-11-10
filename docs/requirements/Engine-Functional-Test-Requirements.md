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
with neither false positive nor false negative. 


|Req| Test requirement                           |Explanation|Status|
|:--|:-------------------------------------------|-----------|------|
|FR01|A DNS query with a label that exceeds the maximum length - 63 characters|[RESTRICTION01](../specifications/functional-tests/Restriction-TP/restriction01.md)|Cannot test|
|FR02|A FQDN that exceeds the maximum length - 255 octets|[RESTRICTION02](../specifications/functional-tests/Restriction-TP/restriction02.md)|Cannot test|
|FR03|A host name label with other than letters, digits and '-'character|[RESTRICTION03](../specifications/functional-tests/Restriction-TP/restriction03.md)|Not Verified|
|FR04|CNAME RRs collision (If a CNAME RR is present at a node, no other data should be present; (3.6.2) - RFC 1034)|[CONFIGURATION01](../specifications/functional-tests/Configuration-TP/configuration01.md)|Did not test|
|FR05|Zone cyclic dependency|[CONFIGURATION02](../specifications/functional-tests/Configuration-TP/configuration02.md)|Results inconclusive|
|FR06|Lame delegation |[CONFIGURATION03](../specifications/functional-tests/Configuration-TP/configuration03.md)|OK|
|FR07|Delegation Inconsistency|[CONFIGURATION04](../specifications/functional-tests/Configuration-TP/configuration04.md)|OK|
|FR08|Test whether the tool correctly treats the name error with "NXDOMAIN" in response|[BEHAVIOR01](../specifications/functional-tests/Behavior-TP/behavior01.md)|OK|
|FR09|Test whether the tool correctly treats when "no such data exist"  with "NODATA" in response|[BEHAVIOR02](../specifications/functional-tests/Behavior-TP/behavior02.md)|OK|
|FR10|Appropriate results when certain protocols are disabled (e.g.IPv6)|[BEHAVIOR03](../specifications/functional-tests/Behavior-TP/behavior03.md)|OK|
|FR11|Test whether the tool run only appropriate tests when the default test profile is modified|[BEHAVIOR04](../specifications/functional-tests/Behavior-TP/behavior04.md)|KO|
|FR12|Capable of running the test when the delegation parameters are specified|[BEHAVIOR05](../specifications/functional-tests/Behavior-TP/behavior05.md)|OK|
|FR13|Able to test non delegated domain|[BEHAVIOR05](../specifications/functional-tests/Behavior-TP/behavior05.md)|OK|
|FR14|Check whether timestamps are being displayed|[BEHAVIOR06](../specifications/functional-tests/Behavior-TP/behavior06.md)|OK|
|FR15|IDN verification|[BEHAVIOR07](../specifications/functional-tests/Behavior-TP/behavior07.md)|OK|
|FR16|Displays verbose information when launched with appropriate flags|[BEHAVIOR08](../specifications/functional-tests/Behavior-TP/behavior08.md)|OK|
|FR17|Triggers appropriate error code when the zone is misconfigured|[BEHAVIOR09](../specifications/functional-tests/Behavior-TP/behavior09.md)|OK|

