# DNSSEC16: Validate CDS and CDNSKEY

## Test case identifier
**DNSSEC16**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that they are are valid. This Test case is
only relevant if the zone has either CDS or CDNSKEY record or both.

If a CDS record is included in the zone, the corresponding CDNSKEY
record should also be included ([RFC 7344][RFC 7344, section 4],
section 4).

The CNS and CDNSKEY RRsets should be consistent between all name
servers for the zone in question.

If there are both CDS RRs and CDNSKEY RRs in the zone they must match
in content ([RFC 7344][RFC 7344, section 4], section 4). It means that
both must be derived from the same DNSKEY or both being "delete" CDS
and CDNSKEY.

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

It is assumed that *Child Zone* has been tested by [DNSSEC15] and
that the servers give the same responses. Running this test case
without running [DNSSEC15], before or after, can give an incomplete
report of CDS and CDNSKEY status of *Child Zone*.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

* If no CDS or CDNSKEY is found, the test case will terminate early
  with no message tag outputted.
* In the table below, "CDS (CDNSKEY)" means "CDS" or "CDNSKEY" or both,
  as applicable.
* If a CDS or CDNSKEY record is of "delete" type, then it can by
  definition not match or point at any DNSKEY record.

Message Tag outputted                | [Default level] | Description of when message tag is outputted
:------------------------------------|:--------|:-----------------------------------------
DS16_CDNSKEY_INVALID_RRSIG           | ERROR   | CDNSKEY RRset signed with an invalid RRSIG.
DS16_CDNSKEY_MATCHES_NO_DNSKEY       | WARNING | CDNSKEY record does not match any DNSKEY in DNSKEY RRset.
DS16_CDNSKEY_SIGNED_BY_UNKNOWN_DNSKEY| ERROR   | CDNSKEY RRset is signed but not by a key in DNSKEY RRset.
DS16_CDS_CDNSKEY_UNSIGNED            | ERROR   | CDS (CDNSKEY) RRset is not signed.
DS16_CDS_CDNSKEY_WITHOUT_DNSKEY      | ERROR   | CDS (CDNSKEY) RRset exists, but no DNSKEY RRset.
DS16_CDS_INVALID_RRSIG               | ERROR   | CDS RRset is signed with an invalid RRSIG.
DS16_CDS_MATCHES_NO_DNSKEY           | WARNING | CDS record does not match any DNSKEY in DNSKEY RRset.
DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY    | ERROR   | CDS RRset is signed but not by a key in DNSKEY RRset.
DS16_DELETE_CDNSKEY                  | INFO    | CDNSKEY RRset have a "delete" CDNSKEY record as a single record.
DS16_DELETE_CDS                      | INFO    | CDS RRset have a "delete" CDS record as a single record.
DS16_DNSKEY_NOT_SIGNED_BY_CDNSKEY    | WARNING | DNSKEY RRset is not signed by the key or keys that the CDNSKEY records point to.
DS16_DNSKEY_NOT_SIGNED_BY_CDS        | WARNING | DNSKEY RRset is not signed by the key or keys that the CDS records point to.
DS16_MIXED_DELETE_CDS_CDNSKEY        | ERROR   | "Delete" CDS (CDNSKEY) record is mixed with normal CDS (CDNSKEY) record.

## Ordered description of steps to be taken to execute the test case

1.  Create a CDS query with EDNS enabled and the DO bit set for the
    apex of the *Child Zone*.

2.  Create a CDNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

3.  Create a DNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

4.  Retrieve all name server IP addresses for the *Child Zone* using
    [Method4] and [Method5] ("NS IP").

5.  Create the following empty sets:
    1.  Name server IP address and associated CDS RRset and its RRSIG
        records ("CDS RRsets"). A name server IP may hold an empty
        RRset or no RRSIG records.
    2.  Name server IP address and associated CDNSKEY RRset and its
        RRSIG redords ("CDNSKEY RRsets"). A name server IP may hold an
        empty RRset or no RRSIG records.
    3.  Name server IP address and associated DNSKEY RRset and its 
        RRsig records ("DNSKEY RRsets"). A name server IP may hold an empty
        RRset or no RRSIG records.
    4.  Name server IP address ("No DNSKEY RRset").
    5.  Name server IP address ("Mixed Delete CDS").
    6.  Name server IP address ("Delete CDS").
    7.  Name server IP address and associated CDS key tag 
        ("No Match CDS With DNSKEY").
    8.  Name server IP address and associated CDS key tag
        ("DNSKEY Not Signed By CDS").
    9.  Name server IP address ("CDS Not Signed").
    10. Name server IP address and key tag
        ("CDS Signed By Unknown DNSKEY").
    11. Name server IP address and key tag ("CDS Invalid RRSIG").
    12. Name server IP address ("Mixed Delete CDNSKEY").
    13. Name server IP address ("Delete CDNSKEY").
    14. Name server IP address and associated CDNSKEY key tag 
        ("No Match CDNSKEY With DNSKEY").
    15. Name server IP address and key tag
        ("DNSKEY Not Signed By CDNSKEY").
    16. Name server IP address ("CDNSKEY Not Signed").
    17. Name server IP address and key tag
        ("CDNSKEY Signed By Unknown DNSKEY").
    18. Name server IP address and key tag ("CDNSKEY Invalid RRSIG").

6.  Repeat the following steps for each name server IP address in 
    *NS IP*:

    1. Send the CDS query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server 
          IP.
       2. Else, if AA bit is not set in the DNS response, then go to
          next name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then
          go to next name server IP.
       4. Else, if the DNS response contains at least one CDS record
          in the answer section, then add the name server IP and the
          CDS RRset to the *CDS RRsets* set. Also include any associated
          RRSIG records.
    2. Send the CDNSKEY query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server
          IP.
       2. Else, if AA bit is not set in the DNS response, then go to
          next name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then
          go to next name server IP.
       4. Else, if the DNS response contains at least one CDNSKEY
          record in the answer section, then add the name server IP and
          the CDNSKEY RRset from the answer section to the 
          *CDNSKEY RRsets* set. Also include any associated RRSIG records.
    3. Send the DNSKEY query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server
          IP.
       2. Else, if AA bit is not set in the DNS response, then go to
          next name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then
          go to next name server IP.
       4. Else, if the DNS response contains at least one DNSKEY
          record in the answer section, then add the name server IP and
          the CDNSKEY RRset from the answer section to the 
          *DNSKEY RRsets* set. Also include any associated RRSIG records.
    4. Go to next name server IP.

7.  If neither of the *CDS RRsets* and *CDNSKEY RRsets* sets,
    respectively, has any RRset then terminate this test case.

8.  For each name server IP in the *CDS RRsets* set do:

    1. Get the CDS and its RRSIG records, if any.
    2. If any CDS record is a "delete" CDS, then do:
       1. If there is more than a single CDS record then add the name
          server IP to the *Mixed Delete CDS* set.
       2. Else, add the name server IP address to the *Delete CDS*
          set.
       3. Go to next name server IP.
    3. Get the DNSKEY and its RRSIG records, if any, from the
       *DNSKEY RRsets* for the same name server IP.
    4. If there are no DNSKEY records, then do:
       1. Add name server IP address to the *No DNSKEY RRset* set.
       2. Go to next name server IP.
    5. Repeat the following steps for each CDS record:
       1. Compare the key tag from the CDS record with the calculated
          key tags for the DNSKEY records.
       2. If the CDS record does not match any DNSKEY record then add
          the name server IP address and key tag to 
          *No Match CDS With DNSKEY* set.
       3. Else, if there is no RRSIG for the DNSKEY RRset created by
          the DNSKEY record that the CDS record points at then add the
          name server IP address and key tag of CDS record to the
          *DNSKEY Not Signed By CDS* set.
    6. If there are no RRSIG records for the CDS RRset, then add the
       name server IP address to the *CDS Not Signed* set.
    7. Else, for each RRSIG (CDS) do:
       1. If the key tag of the RRSIG does not match any DNSKEY then
          add the name server IP address and key tag to the
          *CDS Signed By Unknown DNSKEY* set.
       2. Else, if the RRSIG cannot be validated by the DNSKEY it
          refers to by key tag, then add the name server IP and RRSIG
          key tag to the *CDS Invalid RRSIG* set.
    8. Go to next name server IP address.

9.  For each name server IP in the *CDNSKEY RRsets* set do:

    1. Get the CDNSKEY and its RRSIG records, if any.
    2. If any CDNSKEY record is a "delete" CDNSKEY, then do:
       1. If there is more than a single CDNSKEY record then add the
          name server IP to the *Mixed Delete CDNSKEY* set.
       2. Else, add the name server IP address to the *Delete CDNSKEY*
          set.
       2. Go to next name server IP.
    3. Get the DNSKEY and its RRSIG records, if any, from the
       *DNSKEY RRsets* for the same name server IP.
    4. If there are no DNSKEY records, then do:
       1. Add name server IP address to the *No DNSKEY RRset* set
          (duplicates not possible).
       2. Go to next name server IP.
    5. Repeat the following steps for each CDNSKEY record:
       1. Compare the CDNSKEY record with the DNSKEY records.
       2. If the CDNSKEY record does not match any DNSKEY record then
          add the name server IP address and key tag to 
          *No Match CDNSKEY With DNSKEY* set.
       3. Else, if there is no RRSIG for the DNSKEY RRset created by
          the DNSKEY record matching the CDNSKEY record then add the
          name server IP address and key tag of CDNSKEY record to the
          *DNSKEY Not Signed By CDNSKEY* set.
    6. If there are no RRSIG records for the CDNSKEY RRset, then add
       the name server IP address to the *CDNSKEY Not Signed* set.
    7. Else, for each RRSIG (CDNSKEY) do:
       1. If the key tag of the RRSIG does not match any DNSKEY then
          add the name server IP address and key tag to the
          *CDNSKEY Signed By Unknown DNSKEY* set.
       2. Else, if the RRSIG cannot be validated by the DNSKEY it
          refers to by key tag, then add the name server IP and RRSIG
          key tag to the *CDNSKEY Invalid RRSIG* set.
    8. Go to next name server IP address.

10. If the *No DNSKEY RRset* set is non-empty, then output
    *[DS16_CDS_CDNSKEY_WITHOUT_DNSKEY]* with all name server IP addresses
    in the set.

11. If the *Mixed Delete CDS* set or the *Mixed Delete CDNSKEY* set is
    non-empty, then output *[DS16_MIXED_DELETE_CDS_CDNSKEY]* with all
    name server IP addresses in the two sets.

12. If the *Delete CDS* set is non-empty, then output
    *[DS16_DELETE_CDS]* with all name server IP addresses.

13. If the *Delete CDNSKEY* set is non-empty then output
    *[DS16_DELETE_CDNSKEY]* with all name server IP addresses.

14. If the *No Match CDS With DNSKEY* set is non-empty then for each
    key tag in the set output *[DS16_CDS_MATCHES_NO_DNSKEY]* with the
    CDS key tag and the name server IP addresses in the set per key
    tag.

15. If the *No Match CDNSKEY With DNSKEY* set is non-empty then for
    each key tag in the set output *[DS16_CDNSKEY_MATCHES_NO_DNSKEY]*
    with the CDNSKEY key tag and the name server IP addresses in the
    set per key tag.

16. If the *DNSKEY Not Signed By CDS* set is non-empty then for
    each key tag in the set output *[DS16_DNSKEY_NOT_SIGNED_BY_CDS]*
    with the RRSIG key tag and the name server IP addresses in the set
    per key tag.

17. If the *DNSKEY Not Signed By CDNSKEY* set is non-empty then for
    each key tag in the set output
    *[DS16_DNSKEY_NOT_SIGNED_BY_CDNSKEY]* with the RRSIG key tag and
    the name server IP addresses in the set per key tag.

18. If the *CDS Not Signed* set or the *CDNSKEY Not Signed* set is
    non-empty then output *[DS16_CDS_CDNSKEY_UNSIGNED]* with all
    name server IP addresses in the two sets.

19. If the *CDS Signed By Unknown DNSKEY* set is non-empty then output
    *[DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY]* with the name server IP
    addresses in the set.

20. If the *CDNSKEY Signed By Unknown DNSKEY* set is non-empty then
    output *[DS16_CDNSKEY_SIGNED_BY_UNKNOWN_DNSKEY]* with the name server
    IP addresses in the set.

21. If the *CDS Invalid RRSIG* set is non-empty then for each key tag
    in the set output *[DS16_CDS_INVALID_RRSIG]* with the RRSIG key
    tag and the name server IP addresses in the set per key tag.

22. If the *CDNSKEY Invalid RRSIG* set is non-empty then for each key
    tag in the set output *[DS16_CDNSKEY_INVALID_RRSIG]* with the RRSIG
    key tag and the name server IP addresses in the set per key tag.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
the ignored protocol.

## Intercase dependencies

None.


[Basic04]:                               ../Basic-TP/basic04.md
[DNSSEC15]:                              dnssec15.md
[DS16_CDNSKEY_INVALID_RRSIG]:            #summary
[DS16_CDNSKEY_MATCHES_NO_DNSKEY]:        #summary
[DS16_CDNSKEY_SIGNED_BY_UNKNOWN_DNSKEY]: #summary
[DS16_CDS_CDNSKEY_UNSIGNED]:             #summary
[DS16_CDS_CDNSKEY_WITHOUT_DNSKEY]:       #summary
[DS16_CDS_INVALID_RRSIG]:                #summary
[DS16_CDS_MATCHES_NO_DNSKEY]:            #summary
[DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY]:     #summary
[DS16_DELETE_CDNSKEY]:                   #summary
[DS16_DELETE_CDS]:                       #summary
[DS16_DNSKEY_NOT_SIGNED_BY_CDNSKEY]:     #summary
[DS16_DNSKEY_NOT_SIGNED_BY_CDS]:         #summary
[DS16_MIXED_DELETE_CDS_CDNSKEY]:         #summary
[Default level]:                         ../SeverityLevelDefinitions.md
[ERROR]:                                 #summary
[Method4]:                               ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                               ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 7344, section 4]:                   https://tools.ietf.org/html/rfc7344#section-4
[RFC 7344]:                              https://tools.ietf.org/html/rfc7344
[RFC 8078]:                              https://tools.ietf.org/html/rfc8078




