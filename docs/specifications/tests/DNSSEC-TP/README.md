# List of DNSSEC tests

These are the DNSSEC tests for a domain.

This document uses the terminology defined in the
[Master Test Plan](../MasterTestPlan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                 | Test Case |
|:--|:------------------------------------------------------------|:----------|
|R58|Legal values for the DS hash digest algorithm                |[DNSSEC01](dnssec01.md)|
|R59|DS must match a DNSKEY in the designated zone                |[DNSSEC02](dnssec02.md)|
|R60|Check for too many NSEC3 iterations                          |[DNSSEC03](dnssec03.md)|
|R61|Check for too short or too long RRSIG lifetimes              |[DNSSEC04](dnssec04.md)|
|R62|Check for invalid DNSKEY algorithms                          |[DNSSEC05](dnssec05.md)|
|R63|Verify DNSSEC additional processing                          |[DNSSEC06](dnssec06.md)|
|R64|If there exists DNSKEY at child, the parent should have a DS |[DNSSEC07](dnssec07.md)|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY    |[DNSSEC08](dnssec08.md)|
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY       |[DNSSEC09](dnssec09.md)|
|R76|Zone contains NSEC or NSEC3 records                          |[DNSSEC10](dnssec10.md)|
|R79|If DS at parent, child zone must be signed                   |[DNSSEC11](dnssec11.md)|
|R84|Test for DNSSEC Algorithm Completeness (DS->DNSKEY->RRSIG)   |[DNSSEC12](dnssec12.md)|
|R??|All DNSKEY algorithms used to sign the zone                  |[DNSSEC13](dnssec13.md)|

## Default DNS query flags for all DNSSEC tests

* Transport: UDP
* Bufsize: EDNS0 buffer size (512)
* Flags -- query flags
    * do -- DNSSEC ok (1)
    * cd -- Checking Disabled (1)
    * rd -- Recursion Desired (0)
    * ad -- Authenticated Data (0)

See section 3.2 of [RFC 4035](https://tools.ietf.org/html/rfc4035#section-3.2)
for a description of the flags used by a recursive name server.

## Key, hash and signature algorithms

There are many algorithms defined for doing DNSSEC, not all of them are
mandatory to implement. This test case should strive not only to implement
all mandatory algorithms, but also most of those that are in use on the
internet today as well.

If any algorithm in a DNSSEC record type is not recognized by the test
system, the test system should emit a notice about this.
