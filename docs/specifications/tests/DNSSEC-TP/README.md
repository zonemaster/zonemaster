# DNSSEC Test Plan

These are the DNSSEC tests for a domain.

This document uses the terminology defined in the [Master Test Plan].

The list of Connectivity test cases is found in the [Test Case README].

## Default DNS query flags for all DNSSEC tests

* Transport: UDP
* Bufsize: EDNS0 buffer size (512)
* Flags -- query flags
    * do -- DNSSEC ok (1)
    * cd -- Checking Disabled (1)
    * rd -- Recursion Desired (0)
    * ad -- Authenticated Data (0)

See section 3.2 of [RFC 4035]
for a description of the flags used by a recursive name server.

## Key, hash and signature algorithms

There are many algorithms defined for doing DNSSEC, not all of them are
mandatory to implement. This test case should strive not only to implement
all mandatory algorithms, but also most of those that are in use on the
internet today as well.

If any algorithm in a DNSSEC record type is not recognized by the test
system, the test system should emit a notice about this.


[Master Test Plan]:             ../MasterTestPlan.md
[RFC 4035]:                     https://tools.ietf.org/html/rfc4035#section-3.2
[Test Case README]:             ../README.md

