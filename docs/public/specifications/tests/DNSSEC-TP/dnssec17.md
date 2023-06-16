# DNSSEC17: Validate CDNSKEY

## Test case identifier
**DNSSEC17**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that the CDNSKEY RRset is valid. This test case is
only relevant if the zone has at least one CDNSKEY record. For tests of the
CDS, see test case [DNSSEC16].

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

It is assumed that *Child Zone* has been tested or will be tested by
[DNSSEC15] and [DNSSEC16] and that the servers give the same responses.
Running this test case without running [DNSSEC15] and [DNSSEC16] can
give an incomplete report of the CDS and CDNSKEY status of
*Child Zone*.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

* If no CDNSKEY record is found, the test case will terminate early
  with no message tag outputted.
* If a CDNSKEY record is of "delete" type, then it can by
  definition not match or point at any DNSKEY record.

Message Tag outputted                | [Default level] | Description of when message tag is outputted
:------------------------------------|:--------|:-----------------------------------------
DS17_CDNSKEY_INVALID_RRSIG           | ERROR   | CDNSKEY RRset signed with an invalid RRSIG.
DS17_CDNSKEY_IS_NON_SEP              | NOTICE  | CDNSKEY record has the SEP bit (bit 15) unset.
DS17_CDNSKEY_IS_NON_ZONE             | ERROR   | CDNSKEY record has the zone bit (bit 7) unset.
DS17_CDNSKEY_MATCHES_NO_DNSKEY       | WARNING | CDNSKEY record does not match any DNSKEY in DNSKEY RRset.
DS17_CDNSKEY_NOT_SIGNED_BY_CDNSKEY   | NOTICE  | CDNSKEY RRset is not signed by the key that the CDNSKEY record points to.
DS17_CDNSKEY_SIGNED_BY_UNKNOWN_DNSKEY| ERROR   | CDNSKEY RRset is signed by a key not in DNSKEY RRset.
DS17_CDNSKEY_UNSIGNED                | ERROR   | CDNSKEY RRset is unsigned.
DS17_CDNSKEY_WITHOUT_DNSKEY          | ERROR   | CDNSKEY RRset exists, but there is no DNSKEY RRset.
DS17_DELETE_CDNSKEY                  | INFO    | CDNSKEY RRset has a "delete" CDNSKEY record as a single record.
DS17_DNSKEY_NOT_SIGNED_BY_CDNSKEY    | WARNING | DNSKEY RRset is not signed by the key or keys that the CDNSKEY records point to.
DS17_MIXED_DELETE_CDNSKEY            | ERROR   | "Delete" CDNSKEY record is mixed with normal CDNSKEY record.

## Ordered description of steps to be taken to execute the test case

1.  Create the following empty sets:
    1.  Name server IP address and associated CDNSKEY RRset and its
        RRSIG redords ("CDNSKEY RRsets"). The set of RRSIG records may be empty
    2.  Name server IP address and associated DNSKEY RRset and its
        RRSIG records ("DNSKEY RRsets"). The set of RRSIG records may be empty.
    3.  Name server IP address ("No DNSKEY RRset").
    4.  Name server IP address ("Mixed Delete CDNSKEY").
    5.  Name server IP address ("Delete CDNSKEY").
    6.  Name server IP address and associated CDNSKEY key tag
        ("No Match CDNSKEY With DNSKEY").
    7.  Name server IP address and associated CDNSKEY key tag
        ("CDNSKEY is non-zone key").
    8.  Name server IP address and associated CDNSKEY key tag
        ("CDNSKEY is non-SEP key").
    9.  Name server IP address and key tag
        ("DNSKEY Not Signed By CDNSKEY").
    10. Name server IP address and key tag
        ("CDNSKEY Not Signed By CDNSKEY").
    11. Name server IP address ("CDNSKEY Not Signed").
    12. Name server IP address and key tag
        ("CDNSKEY Signed By Unknown DNSKEY").
    13. Name server IP address and key tag ("CDNSKEY Invalid RRSIG").

2.  Create a CDNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

3.  Create a DNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

4.  Retrieve all name server IP addresses for the *Child Zone* using
    [Method4] and [Method5] ("NS IP").

5.  Repeat the following steps for each name server IP address in
    *NS IP*:

    1. Send the CDNSKEY query over UDP to the name server IP address.
       1. If no DNS response is returned, then go to next name server
          IP.
       2. Else, if AA bit is not set in the DNS response, then go to
          next name server IP.
       3. Else, if the RCODE in the DNS response is not *NOERROR*, then
          go to next name server IP.
       4. Else, if the answer section has no CDNSKEY records, go to
          next name server IP.
       5. Add the name server IP and the CDNSKEY RRset from the answer
          section to the *CDNSKEY RRsets* set. Also include any
          associated RRSIG records in the answer section.
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
          *DNSKEY RRsets* set. Also include any associated RRSIG records
          in the answer section.
    3. Go to next name server IP.

6.  If the *CDNSKEY RRsets* set is empty then terminate this test case.

7.  For each name server IP in the *CDNSKEY RRsets* set do:

    1. If the CDNSKEY RRset is empty go to next name server IP address.
    2. Get the CDNSKEY RRset and the associated RRSIG records, if any, from the
       *CDNSKEY RRsets* set for the name server IP.
    3. If any CDNSKEY record is a "delete" CDNSKEY, then do:
       1. If there is more than a single CDNSKEY record then add the
          name server IP to the *Mixed Delete CDNSKEY* set.
       2. Else, add the name server IP address to the *Delete CDNSKEY*
          set.
    4. Get the DNSKEY RRset and the associated RRSIG records, if any, from the
       *DNSKEY RRsets* for the same name server IP.
    5. If there are no DNSKEY records, then do:
       1. Add name server IP address to the *No DNSKEY RRset* set
          (duplicates not possible).
       2. Go to next name server IP.
    6. Repeat the following steps for each CDNSKEY record unless it is a "delete"
       CDNSKEY record:
       1. If bit 7 of the flags field of the CDNSKEY record is unset (value 0)
          then add the name server IP address and the
          [key tag calculated][Key Tag Calculation] from the CDNSKEY record to
          the *CDNSKEY is non-zone key* set.
       2. Else, do:
          1. If bit 15 of the flags field of the CDNSKEY is unset (value 0) then
             add the name server IP address and the
             [key tag calculated][Key Tag Calculation] from the CDNSKEY to the
             *CDNSKEY is non-SEP key* set.
          2. Compare the CDNSKEY record with the DNSKEY records.
          3. If the CDNSKEY record does not match any DNSKEY record then
             add the name server IP address and the
             [key tag calculated][Key Tag Calculation] from the CDNSKEY record
             to the *No Match CDNSKEY With DNSKEY* set.
          4. Else, do:
             1. If the DNSKEY RRset is not signed by the DNSKEY record that
                corresponds to the CDNSKEY record then add the name server IP
                address and [key tag calculated][Key Tag Calculation] from
                CDNSKEY record to the *DNSKEY Not Signed By CDNSKEY* set.
             2. If the CDNSKEY RRset is not signed by the DNSKEY record that
                corresponds to the CDNSKEY record then add the name server IP
                address and [key tag calculated][Key Tag Calculation] from
                CDNSKEY record to the *CDNSKEY Not Signed By CDNSKEY* set.

    7. If the CDNSKEY RRset is not signed, then add the name server IP address to
       the *CDNSKEY Not Signed* set.
    8. Else, for each RRSIG for the CDNSKEY RRset do:
       1. If the key tag of the RRSIG does not match any DNSKEY record in the
          DNSKEY RRset then add the name server IP address and key tag to the
          *CDNSKEY Signed By Unknown DNSKEY* set.
       2. Else, if the RRSIG cannot be validated by the DNSKEY it
          refers to by key tag, then add the name server IP and RRSIG
          key tag to the *CDNSKEY Invalid RRSIG* set.
    9. Go to next name server IP address.

8.  If the *No DNSKEY RRset* set is non-empty, then output
    *[DS17_CDNSKEY_WITHOUT_DNSKEY]* with all name server IP addresses
    in the set.

9. If the the *Mixed Delete CDNSKEY* set is
    non-empty, then output *[DS17_MIXED_DELETE_CDNSKEY]* with all
    name server IP addresses in the set.

10. If the *Delete CDNSKEY* set is non-empty then output
    *[DS17_DELETE_CDNSKEY]* with all name server IP addresses.

11. If the *No Match CDNSKEY With DNSKEY* set is non-empty then do:
    * For each CDNSKEY key tag in the set do:
        * Output *[DS17_CDNSKEY_MATCHES_NO_DNSKEY]* with the CDNSKEY
          key tag and the name server IP addresses in the set for that
          key tag.

12. If the *CDNSKEY is non-zone key* set is non-empty then do:
    * For each CDNSKEY key tag in the set do:
        * Output *[DS17_CDNSKEY_IS_NON_ZONE]* with the CDNSKEY key tag
          and the name server IP addresses in the set for that key tag.

13. If the *CDNSKEY is non-SEP key* set is non-empty then do:
    * For each CDNSKEY key tag in the set do:
        * Output *[DS17_CDNSKEY_IS_NON_SEP]* with the CDNSKEY key tag
          and the name server IP addresses in the set for that key tag.

14. If the *DNSKEY Not Signed By CDNSKEY* set is non-empty then do:
    * For each CDNSKEY key tag in the set do:
        * Output *[DS17_DNSKEY_NOT_SIGNED_BY_CDNSKEY]* with the CDNSKEY
          key tag and the name server IP addresses in the set for that
          key tag.

15. If the *CDNSKEY Not Signed By CDNSKEY* set is non-empty then do:
    * For each CDNSKEY key tag in the set do:
        * Output *[DS17_CDNSKEY_NOT_SIGNED_BY_CDNSKEY]* with the CDNSKEY key tag
          and the name server IP addresses in the set for that key tag.

16. If the *CDNSKEY Invalid RRSIG* set is non-empty then do:
    * For each RRSIG key tag in the set do:
        * Output *[DS17_CDNSKEY_INVALID_RRSIG]* with the RRSIG key tag
          and the name server IP addresses in the set for that key tag.

17. If the *CDNSKEY Not Signed* set is
    non-empty then output *[DS17_CDNSKEY_UNSIGNED]* with all
    name server IP addresses in the set.

18. If the *CDNSKEY Signed By Unknown DNSKEY* set is non-empty then
    output *[DS17_CDNSKEY_SIGNED_BY_UNKNOWN_DNSKEY]* with the name server
    IP addresses in the set.

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
[DNSSEC16]:                              dnssec16.md
[DS17_CDNSKEY_INVALID_RRSIG]:            #summary
[DS17_CDNSKEY_IS_NON_SEP]:               #summary
[DS17_CDNSKEY_IS_NON_ZONE]:              #summary
[DS17_CDNSKEY_MATCHES_NO_DNSKEY]:        #summary
[DS17_CDNSKEY_NOT_SIGNED_BY_CDNSKEY]:    #summary
[DS17_CDNSKEY_SIGNED_BY_UNKNOWN_DNSKEY]: #summary
[DS17_CDNSKEY_UNSIGNED]:                 #summary
[DS17_CDNSKEY_WITHOUT_DNSKEY]:           #summary
[DS17_DELETE_CDNSKEY]:                   #summary
[DS17_DNSKEY_NOT_SIGNED_BY_CDNSKEY]:     #summary
[DS17_MIXED_DELETE_CDNSKEY]:             #summary
[Default level]:                         ../SeverityLevelDefinitions.md
[ERROR]:                                 ../SeverityLevelDefinitions.md#error
[INFO]:                                  ../SeverityLevelDefinitions.md#info
[Key Tag Calculation]:                   https://datatracker.ietf.org/doc/html/rfc4034#appendix-B
[Method4]:                               ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                               ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                ../SeverityLevelDefinitions.md#notice
[RFC 7344, section 4]:                   https://datatracker.ietf.org/doc/html/rfc7344#section-4
[RFC 7344]:                              https://datatracker.ietf.org/doc/html/rfc7344
[RFC 8078]:                              https://datatracker.ietf.org/doc/html/rfc8078
[WARNING]:                               ../SeverityLevelDefinitions.md#warning

