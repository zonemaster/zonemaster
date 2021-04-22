# DNSSEC15: Existence of CDS and CDNSKEY

## Test case identifier
**DNSSEC15**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that they are correctly set-up, if included in the
zone.

If a CDS record is included in the zone, the corresponding CDNSKEY
record should also be included ([RFC 7344][RFC 7344, section 4],
section 4).

The CNS and CDNSKEY RRsets should be consistent between all name
servers for the zone in question.

If there are both CDS RRs and CDNSKEY RRs in the zone they must match in 
content ([RFC 7344][RFC 7344, section 4], section 4). It means that both
must be derived from the same DNSKEY or both being "delete" CDS and
CDNSKEY.

If a name server has issues covered by [Basic04] (basic name server
issues) no messages will be outputted from this test case.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

* [INFO] message if CDS RRset is found on any name server for the zone.
* [INFO] message if CDNSKEY RRset is found on any name server for the zone.
* [NOTICE] message if only one type is found.
* [ERROR] message if the two RRsets (CDS and CDNSKEY) both exist but do not 
  match.
* [ERROR] message if not all servers have the same CDS RRset (if CDS exists)
* [ERROR] message if not all servers have the same CDNSKEY RRset (if CDNSKEY
  exists)

## Ordered description of steps to be taken to execute the test case

1.  Create a CDS query with EDNS enabled with the DO bit set for the
    apex of the *Child Zone*.

2.  Create a CDNSKEY query with EDNS enabled with the DO bit set for
    the apex of the *Child Zone*.

4.  Retrieve all name server IP addresses for the *Child Zone* using
    [Get-Del-NS-IPs] and [Get-Zone-NS-IPs] ("NS IP").

5.  Create the following empty sets:
    1. Name server IP address and associated CDS RRset ("CDS RRsets"). A
       name server IP can hold an empty RRset.
    2. Name server IP address and associated CDNSKEY RRset ("CDNSKEY RRsets"). 
       A name server IP can hold an empty RRset.
    3. Name server IP set ("Mismatch CDS/CDNSKEY").

6.  Repeat the following steps for each name server IP address in *NS IP*:

    1. Send the CDS query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server IP.
       2. Else, if AA bit is not set in the DNS response, then go to next 
          name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then go to
          next name server IP.
       4. Else, if the DNS response contains no CDS record in the
          answer section, then add the name server IP and an empty RRset to
          the *CDS RRsets* set.
       5. Else, add the name server IP and the CDS RRset from the answer
          section to the *CDS RRsets* set.
    2. Send the CDNSKEY query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server IP.
       2. Else, if AA bit is not set in the DNS response, then go to next
          name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then go to
          next name server IP.
       4. Else, if the DNS response contains no CDNSKEY record in the
          answer section, then add the name server IP and an empty RRset to
          the *CDNSKEY RRsets* set and go to next name server IP.
       5. Else, add the name server IP and the CDNSKEY RRset from the answer
          section to the *CDNSKEY RRsets* set and go to next name server IP.

7.  If the two sets, *CDS RRsets* and *CDNSKEY RRsets*, both have only
    empty RRsets then output *[DS15_NO_CDS_CDNSKEY]* and terminate this
    test case.

8.  If the *CDS RRsets* set has at least one non-empty RRset but no
    non-empty RRsets in the *CDNSKEY RRsets* set then output
    *[DS15_HAS_CDS_NO_CDNSKEY]*.
         
9.  If the *CDNSKEY RRsets* set has at least one non-empty RRset but no
    non-empty RRsets in the *CDS RRsets* set then output
    *[DS15_HAS_CDNSKEY_NO_CDS]*.

10. If each of the *CDS RRsets* set and the *CDNSKEY RRsets* set has
    at least one non-empty RRset then output *[DS15_HAS_CDS_CDNSKEY]*.

11. If not all CDS RRsets in the *CDS RRsets* set are identical then
    output *[DS15_INCONSISTENT_CDS]*.

12. If not all CDNSKEY RRsets in the *CDNSKEY RRsets* set are identical
    then output *[DS15_INCONSISTENT_CDNSKEY]*.

13. For each name server IP in the *CDS RRsets* set do:

    1. Extract the CDS RRset (possibly empty).
    2. Extract the CDNSKEY RRset (possibly empty) for the same IP from
       the *CDNSKEY RRsets* set.
    3. If both RRsets are non-empty then do:
       1. For each CDS RR verify that there is a matching CDNSKEY (derived
          from the same DNSKEY or being "delete").
       2. For each CDNSKEY RR verify that there is a matching CDS (derived
          from the same DNSKEY or being "delete").
       3. If one of both of the verifications fail then add the name server
          IP to the *Mismatch CDS/CDNSKEY* set.

14. If the *Mismatch CDS/CDNSKEY* set is non-empty, then output
    *[DS15_MISMATCH_CDS_CDNSKEY]* and list the name server IPs from
    the set.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default [severity level]
:-----------------------------|:-----------------------------------
DS15_HAS_CDNSKEY_NO_CDS       | NOTICE
DS15_HAS_CDS_CDNSKEY          | INFO
DS15_HAS_CDS_NO_CDNSKEY       | NOTICE
DS15_INCONSISTENT_CDNSKEY     | ERROR
DS15_INCONSISTENT_CDS         | ERROR
DS15_MISMATCH_CDS_CDNSKEY     | ERROR
DS15_NO_CDS_CDNSKEY           | INFO

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
the ignored protocol.

## Intercase dependencies

None.



[Basic04]:                    ../Basic-TP/basic04.md
[DS15_HAS_CDNSKEY_NO_CDS]:    #outcomes
[DS15_HAS_CDS_CDNSKEY]:       #outcomes
[DS15_HAS_CDS_NO_CDNSKEY]:    #outcomes
[DS15_INCONSISTENT_CDNSKEY]:  #outcomes
[DS15_INCONSISTENT_CDS]:      #outcomes
[DS15_MISMATCH_CDS_CDNSKEY]:  #outcomes
[DS15_NO_CDS_CDNSKEY]:        #outcomes
[ERROR]:                      #outcomes
[Get-Del-NS-IPs]:             https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-delegation-ns-ip-addresses
[Get-Zone-NS-IPs]:            https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-zone-ns-ip-addresses
[INFO]:                       #outcomes
[NOTICE]:                     #outcomes
[RFC 7344, section 3.1]:      https://tools.ietf.org/html/rfc7344#section-3.1
[RFC 7344, section 3.2]:      https://tools.ietf.org/html/rfc7344#section-3.2
[RFC 7344, section 4.1]:      https://tools.ietf.org/html/rfc7344#section-4.1
[RFC 7344, section 4]:        https://tools.ietf.org/html/rfc7344#section-4
[RFC 7344]:                   https://tools.ietf.org/html/rfc7344
[RFC 8078]:                   https://tools.ietf.org/html/rfc8078
[Severity Level]:             ../SeverityLevelDefinitions.md



