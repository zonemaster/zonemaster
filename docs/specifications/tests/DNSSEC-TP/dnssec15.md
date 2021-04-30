# DNSSEC15: Existence of CDS and CDNSKEY

## Test case identifier
**DNSSEC15**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that they are correctly set-up, if included in the
zone.

If a CDS record is included in the zone, the corresponding CDNSKEY
record should also be included ([RFC 7344][RFC 7344#4], section 4).

The CDS and CDNSKEY RRsets should be consistent between all name
servers for the zone in question.

If there are both CDS RRs and CDNSKEY RRs in the zone they must match in 
content ([RFC 7344][RFC 7344#4], section 4). It means that both
must be derived from the same DNSKEY or both being "delete" CDS and
CDNSKEY.

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag outputted     | [Default level] | Description of when message tag is outputted
:-------------------------|:----------------|:-----------------------------------------
DS15_HAS_CDNSKEY_NO_CDS   | NOTICE          | CDNSKEY RRset is found, but no CDS RRset.
DS15_HAS_CDS_AND_CDNSKEY  | INFO            | CDNSKEY and CDS RRsets are found.
DS15_HAS_CDS_NO_CDNSKEY   | NOTICE          | CDS RRset is found, but no CDNSKEY RRset.
DS15_INCONSISTENT_CDNSKEY | ERROR           | All servers do not have the same CDNSKEY RRset.
DS15_INCONSISTENT_CDS     | ERROR           | All servers do not have the same CDS RRset.
DS15_MISMATCH_CDS_CDNSKEY | ERROR           | Both CDS and CDNSKEY RRsets are found but they do not match.
DS15_NO_CDS_CDNSKEY       | INFO            | No CDS or CDNSKEY RRsets are found on any name server.

## Ordered description of steps to be taken to execute the test case

1.  Create the following empty sets:
    1. Name server IP address and associated CDS RRset ("CDS RRsets"). A
       name server IP can hold an empty RRset.
    2. Name server IP address and associated CDNSKEY RRset ("CDNSKEY RRsets").
       A name server IP can hold an empty RRset.
    3. Name server IP address set ("Mismatch CDS/CDNSKEY").
    4. Name server IP address set ("Has CDS No CDNSKEY").
    5. Name server IP address set ("Has CDNSKEY No CDS").
    6. Name server IP address set ("Has CDS And CDNSKEY").

2.  Retrieve all name server IP addresses for the *Child Zone* using
    [Method4] and [Method5] ("NS IP").

3.  Create a CDS query with EDNS enabled with the DO bit set for the
    apex of the *Child Zone*.

4.  Create a CDNSKEY query with EDNS enabled with the DO bit set for
    the apex of the *Child Zone*.

5.  Repeat the following steps for each name server IP address in *NS IP*:

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
          the *CDNSKEY RRsets* set.
       5. Else, add the name server IP and the CDNSKEY RRset from the answer
          section to the *CDNSKEY RRsets* set.
    3. Go to next name server IP.

6.  If the *CDS RRsets* set and the *CDNSKEY RRsets* set are empty
    then output *[DS15_NO_CDS_CDNSKEY]* and terminate this
    test case.

7.  Repeat the following steps for each name server IP address in *NS IP*:

    1. If the name server IP address has a non-empty RRset in the
       *CDS RRsets* set, but an empty RRset in the *CDNSKEY RRsets*
       set, then add the name server IP address to *Has CDS No CDNSKEY*.
    2. If the name server IP address has a non-empty RRset in the
       *CDNSKEY RRsets* set, but an empty RRset in the *CDS RRsets*
       set, then add the name server IP address to *Has CDNSKEY No CDS*.
    3. If the name server IP address has a non-empty RRset in both
       sets, *CDNSKEY RRsets* and *CDS RRsets*, then add the name
       server IP address to *Has CDS And CDNSKEY*.
    4. Go to next name server IP.

8.  If the *Has CDS No CDNSKEY* set is non-empty then output
    *[DS15_HAS_CDS_NO_CDNSKEY]* with the name server IP addresses from
    the set.

9.  If the *Has CDNSKEY No CDS* set is non-empty then output
    *[DS15_HAS_CDNSKEY_NO_CDS]* with the name server IP addresses from
    the set.

10. If the *Has CDS And CDNSKEY* set is non-empty then output
    *[DS15_HAS_CDS_AND_CDNSKEY]* with the name server IP addresses from
    the set.

11. If not all CDS RRsets in the *CDS RRsets* set are identical, where
    a non-empty RRset is considered to be different from an empty
    RRset, then output *[DS15_INCONSISTENT_CDS]*.

12. If not all CDNSKEY RRsets in the *CDNSKEY RRsets* set are identical,
    where a non-empty RRset is considered to be different from an
    empty RRset, then output *[DS15_INCONSISTENT_CDNSKEY]*.

13. For each name server IP in the *CDS RRsets* set do:

    1. Extract the CDS RRset (possibly empty).
    2. Extract the CDNSKEY RRset (possibly empty) for the same IP from
       the *CDNSKEY RRsets* set.
    3. If both RRsets are non-empty then do:
       1. For each CDS RR verify that there is a matching CDNSKEY (derived
          from the same DNSKEY or being "delete").
       2. For each CDNSKEY RR verify that there is a matching CDS (derived
          from the same DNSKEY or being "delete").
       3. If one or both of the verifications fail then add the name server
          IP to the *Mismatch CDS/CDNSKEY* set.

14. If the *Mismatch CDS/CDNSKEY* set is non-empty, then output
    *[DS15_MISMATCH_CDS_CDNSKEY]* and list the name server IPs from
    the set.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
the ignored protocol.

## Intercase dependencies

None.


[Basic04]:                    ../Basic-TP/basic04.md
[CRITICAL]:                   ../SeverityLevelDefinitions.md#critical
[DS15_HAS_CDNSKEY_NO_CDS]:    #summary
[DS15_HAS_CDS_AND_CDNSKEY]:   #summary
[DS15_HAS_CDS_NO_CDNSKEY]:    #summary
[DS15_INCONSISTENT_CDNSKEY]:  #summary
[DS15_INCONSISTENT_CDS]:      #summary
[DS15_MISMATCH_CDS_CDNSKEY]:  #summary
[DS15_NO_CDS_CDNSKEY]:        #summary
[Default level]:              ../SeverityLevelDefinitions.md
[ERROR]:                      ../SeverityLevelDefinitions.md#error
[INFO]:                       ../SeverityLevelDefinitions.md#info
[Method4]:                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                     ../SeverityLevelDefinitions.md#notice
[RFC 7344#4]:                 https://tools.ietf.org/html/rfc7344#section-4
[RFC 7344]:                   https://tools.ietf.org/html/rfc7344
[RFC 8078]:                   https://tools.ietf.org/html/rfc8078
[WARNING]:                    ../SeverityLevelDefinitions.md#warning
