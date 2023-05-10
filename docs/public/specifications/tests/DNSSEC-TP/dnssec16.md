# DNSSEC16: Validate CDS

## Test case identifier
**DNSSEC16**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that the CDS RRset is valid. This test case is
only relevant if the zone has at least one CDS record. For tests of the
CDNSKEY, see test case [DNSSEC17].

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

It is assumed that *Child Zone* has been tested or will be tested by
[DNSSEC15] and [DNSSEC17] and that the servers give the same responses.
Running this test case without running [DNSSEC15] and [DNSSEC17] can
give an incomplete report of the CDS and CDNSKEY status of
*Child Zone*.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

* If no CDS record is found, the test case will terminate early
  with no message tag outputted.
* If a CDS record is of "delete" type, then it can by definition not
  match or point at any DNSKEY record.

Message Tag outputted                | [Default level] | Description of when message tag is outputted
:------------------------------------|:--------|:-----------------------------------------
DS16_CDS_INVALID_RRSIG               | ERROR   | CDS RRset is signed with an invalid RRSIG.
DS16_CDS_MATCHES_NON_SEP_DNSKEY      | NOTICE  | CDS record matches a DNSKEY with SEP bit (bit 15) unset.
DS16_CDS_MATCHES_NON_ZONE_DNSKEY     | ERROR   | CDS record matches a DNSKEY with zone bit (bit 7) unset.
DS16_CDS_MATCHES_NO_DNSKEY           | WARNING | CDS record does not match any DNSKEY in DNSKEY RRset.
DS16_CDS_NOT_SIGNED_BY_CDS           | NOTICE  | CDS RRset is not signed by the key that the CDS record points to.
DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY    | ERROR   | CDS RRset is signed by a key not in DNSKEY RRset.
DS16_CDS_UNSIGNED                    | ERROR   | CDS RRset is unsigned.
DS16_CDS_WITHOUT_DNSKEY              | ERROR   | CDS RRset exists, but there is no DNSKEY RRset.
DS16_DELETE_CDS                      | INFO    | CDS RRset has a "delete" CDS record as a single record.
DS16_DNSKEY_NOT_SIGNED_BY_CDS        | WARNING | DNSKEY RRset is not signed by the key or keys that the CDS records point to.
DS16_MIXED_DELETE_CDS                | ERROR   | "Delete" CDS record is mixed with normal CDS record.

## Ordered description of steps to be taken to execute the test case

1.  Create the following empty sets:
    1.  Name server IP address and associated CDS RRset and its RRSIG
        records ("CDS RRsets"). The set of RRSIG records may be empty.
    2.  Name server IP address and associated DNSKEY RRset and its
        RRSIG records ("DNSKEY RRsets"). The set of RRSIG records may be empty.
    3.  Name server IP address ("No DNSKEY RRset").
    4.  Name server IP address ("Mixed Delete CDS").
    5.  Name server IP address ("Delete CDS").
    6.  Name server IP address and associated CDS key tag
        ("No Match CDS With DNSKEY").
    7.  Name server IP address and associated CDS key tag
        ("CDS points to non-zone DNSKEY").
    8.  Name server IP address and associated CDS key tag
        ("CDS points to non-SEP DNSKEY").
    9.  Name server IP address and associated CDS key tag
        ("DNSKEY Not Signed By CDS").
    10. Name server IP address and associated CDS key tag
        ("CDS Not Signed By CDS").
    11. Name server IP address ("CDS Not Signed").
    12. Name server IP address and key tag
        ("CDS Signed By Unknown DNSKEY").
    13. Name server IP address and key tag ("CDS Invalid RRSIG").

2.  Create a CDS query with EDNS enabled and the DO bit set for the
    apex of the *Child Zone*.

3.  Create a DNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

4.  Retrieve all name server IP addresses for the *Child Zone* using
    [Method4] and [Method5] ("NS IP").

5.  Repeat the following steps for each name server IP address in
    *NS IP*:

    1. Send the CDS query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server
          IP.
       2. Else, if AA bit is not set in the DNS response, then go to
          next name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then
          go to next name server IP.
       4. Else, if the answer section has no CDS records, go to next
          name server IP.
       5. Add the name server IP and the CDS RRset from the answer
          section to the *CDS RRsets* set. Also include any associated
          RRSIG records in the answer section.
    2. Send the DNSKEY query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server
          IP.
       2. Else, if AA bit is not set in the DNS response, then go to
          next name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then
          go to next name server IP.
       4. Else, if the DNS response contains at least one DNSKEY
          record in the answer section, then add the name server IP and
          the DNSKEY RRset from the answer section to the
          *DNSKEY RRsets* set. Also include any associated RRSIG
          records in the answer section.
    3. Go to next name server IP.

6.  If the *CDS RRsets* set is empty then terminate this test case.

7.  For each name server IP in the *CDS RRsets* set do:

    1. If the CDS RRset is empty go to next name server IP address.
    2. Get the CDS RRset and the associated RRSIG records, if any, from the
       *CDS RRsets* set for the name server IP.
    3. If any CDS record is a "delete" CDS, then do:
       1. If there is more than a single CDS record then add the name
          server IP to the *Mixed Delete CDS* set.
       2. Else, add the name server IP address to the *Delete CDS*
          set.
    4. Get the DNSKEY RRset and the associated RRSIG records, if any, from the
       *DNSKEY RRsets* for the same name server IP.
    5. If there are no DNSKEY records, then do:
       1. Add name server IP address to the *No DNSKEY RRset* set.
       2. Go to next name server IP.
    6. Repeat the following steps for each CDS record unless it is a "delete"
       CDS record:
       1. Compare the key tag from the CDS record with the
          [calculated key tags][Key Tag Calculation] for the DNSKEY records.
       2. If the CDS record does not match any DNSKEY record then add
          the name server IP address and CDS record key tag to the
          *No Match CDS With DNSKEY* set.
       3. Else, if bit 7 of the flags field of the DNSKEY that the DS record
          points to is unset (value 0) then add the name server IP address and
          CDS record key tag to the *CDS points to non-zone DNSKEY* set.
       4. Else, do:
          1. If the DNSKEY RRset has not been signed by the DNSKEY record that
             the CDS record points at then add the name server IP address and
             key tag of CDS record to the *DNSKEY Not Signed By CDS* set.
          2. If the CDS RRset has not been signed by the DNSKEY record that
             the CDS record points at then add the name server IP address and
             key tag of CDS record to the *CDS Not Signed By CDS* set.
          3. If bit 15 of the flags field of the DNSKEY that the CDS record
             points at is unset (value 0) then add the name server IP address
             and the key tag of the CDS record to the
             *CDS points to non-SEP DNSKEY* set.
    7. If CDS RRset is not signed, then add the name server IP address to the
       *CDS Not Signed* set.
    8. Else, for each RRSIG for the CDS RRset do:
       1. If the key tag of the RRSIG does not match any DNSKEY record in the
          DNSKEY RRset then add the name server IP address and key tag to the
          *CDS Signed By Unknown DNSKEY* set.
       2. Else, if the RRSIG cannot be validated by the DNSKEY it
          refers to by key tag, then add the name server IP and RRSIG
          key tag to the *CDS Invalid RRSIG* set.
    9. Go to next name server IP address.

8.  If the *No DNSKEY RRset* set is non-empty, then output
    *[DS16_CDS_WITHOUT_DNSKEY]* with all name server IP addresses
    in the set.

9.  If the *Mixed Delete CDS* set is
    non-empty, then output *[DS16_MIXED_DELETE_CDS]* with all
    name server IP addresses in the set.

10. If the *Delete CDS* set is non-empty, then output
    *[DS16_DELETE_CDS]* with all name server IP addresses.

11. If the *No Match CDS With DNSKEY* set is non-empty then do:
    * For each CDS key tag in the set do:
        * Output *[DS16_CDS_MATCHES_NO_DNSKEY]* with the CDS key tag
          and the name server IP addresses in the set for that key
          tag.

12. If the *CDS points to non-zone DNSKEY* set is non-empty then do:
    * For each CDS key tag in the set do:
        * Output *[DS16_CDS_MATCHES_NON_ZONE_DNSKEY]* with the CDS key tag
          and the name server IP addresses in the set for that key
          tag.

13. If the *CDS points to non-SEP DNSKEY* set is non-empty then do:
    * For each CDS key tag in the set do:
        * Output *[DS16_CDS_MATCHES_NON_SEP_DNSKEY]* with the CDS key tag
          and the name server IP addresses in the set for that key
          tag.

14. If the *DNSKEY Not Signed By CDS* set is non-empty then do:
    * For each CDS key tag in the set do:
        * Output *[DS16_DNSKEY_NOT_SIGNED_BY_CDS]* with the CDS key
          tag and the name server IP addresses in the set for that
          key tag.

15. If the *CDS Not Signed By CDS* set is non-empty then do:
    * For each CDS key tag in the set do:
        * Output *[DS16_CDS_NOT_SIGNED_BY_CDS]* with the CDS key
          tag and the name server IP addresses in the set for that
          key tag.

16. If the *CDS Invalid RRSIG* set is non-empty then do:
    * For each RRSIG key tag in the set do:
        * Output *[DS16_CDS_INVALID_RRSIG]* with the RRSIG key tag and
          the name server IP addresses in the set for that key tag.

17. If the *CDS Not Signed* set is non-empty then output
    *[DS16_CDS_UNSIGNED]* with all name server IP addresses in the set.

18. If the *CDS Signed By Unknown DNSKEY* set is non-empty then output
    *[DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY]* with the name server IP
    addresses in the set.

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


[Connectivity01]:                        ../Connectivity-TP/connectivity01.md
[CRITICAL]:                              ../SeverityLevelDefinitions.md#critical
[DNSSEC15]:                              dnssec15.md
[DNSSEC17]:                              dnssec17.md
[DS16_CDS_INVALID_RRSIG]:                #summary
[DS16_CDS_MATCHES_NON_SEP_DNSKEY]:       #summary
[DS16_CDS_MATCHES_NON_ZONE_DNSKEY]:      #summary
[DS16_CDS_MATCHES_NO_DNSKEY]:            #summary
[DS16_CDS_NOT_SIGNED_BY_CDS]:            #summary
[DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY]:     #summary
[DS16_CDS_UNSIGNED]:                     #summary
[DS16_CDS_WITHOUT_DNSKEY]:               #summary
[DS16_DELETE_CDS]:                       #summary
[DS16_DNSKEY_NOT_SIGNED_BY_CDS]:         #summary
[DS16_MIXED_DELETE_CDS]:                 #summary
[Default level]:                         ../SeverityLevelDefinitions.md
[ERROR]:                                 ../SeverityLevelDefinitions.md#error
[INFO]:                                  ../SeverityLevelDefinitions.md#info
[Key Tag Calculation]:                   https://datatracker.ietf.org/doc/html/rfc4034#appendix-B
[Method4]:                               ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                               ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                ../SeverityLevelDefinitions.md#notice
[RFC 7344, section 4]:                   https://tools.ietf.org/html/rfc7344#section-4
[RFC 7344]:                              https://tools.ietf.org/html/rfc7344
[RFC 8078]:                              https://tools.ietf.org/html/rfc8078
[WARNING]:                               ../SeverityLevelDefinitions.md#warning
