# DNSSEC16: Validate CDS and CDNSKEY

## Test case identifier
**DNSSEC16**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that they are they are valid. This Test case is
only relevant if the zone has either CDS or CDNSKEY record or both.

If an CDS record is included in the zone, the corresponding CDNSKEY
record should also be included ([RFC 7344][RFC 7344, section 4],
section 4).

The CNS and CDNSKEY RRsets should be consistent between all name
servers for the zone in question.

If there are both CDS RRs and CDNSKEY RRs in the zone they must match
in content ([RFC 7344][RFC 7344, section 4], section 4). It means that
both must be derived from the same DNSKEY or both being "delete" CDS
and CDNSKEY.

If a name server has issues covered by [Basic04] (basic name server
issues) no messages will be outputted from this test case.

It is assumed that the Child Zone has been tested by [DNSSEC15] and
that the servers give the same responses.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary
* If no CDS or CDNSKEY is found, the test case is not run.
* [ERROR] message if there is no DNSKEY RRset.
* [WARNING] message if a CDS record does not match any
  DNSKEY in DNSKEY RRset (except for "delete" CDS).
* [WARNING] message if a CDNSKEY record does not match any
  DNSKEY in DNSKEY RRset (except for "delete" CDNSKEY).
* [ERROR] message if CDS RRset is not signed.
* [ERROR] message if CDNSKEY RRset is not signed.
* [ERROR] message if CDS RRset is signed with an invalid RRSIG.
* [ERROR] message if CDNSKEY RRset signed with an invalid RRSIG.
* [ERROR] message if CDS RRset is signed but not by a key in DNSKEY
  RRset.
* [ERROR] message if CDNSKEY RRset is signed but not by a key in DNSKEY
  RRset.
* [WARNING] message if CDS RRset is signed by a key in the DNSKEY RRset
  but not with one that has signed the DNSKEY RRset.
* [WARNING] message if CDNSKEY RRset is signed by a key in the DNSKEY
  RRset but not with one that has signed the DNSKEY RRset.
* [INFO] message if CDS RRset have a "delete" CDS record as a single
  record.
* [INFO] message if CDNSKEY RRset have a "delete" CDNSKEY record as a
  single record.
* [ERROR] message if "delete" CDS record is mixed with normal CDS
  record.
* [ERROR] message if "delete" CDNSKEY record is mixed with normal
  CDNSKEY record.

## Ordered description of steps to be taken to execute the test case

1.  Create a CDS query with EDNS enabled and the DO bit set for the
    apex of the *Child Zone*.

2.  Create a CDNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

3.  Create a DNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

4.  Retrieve all name server IP addresses for the *Child Zone* using
    [Get-Del-NS-IPs] and [Get-Zone-NS-IPs] ("NS IP").

5.  Create the following empty sets:
    1.  Name server IP address and associated CDS RRset and its RRSIG
        records ("CDS RRsets"). A name server IP can hold an empty 
        RRset or no RRSIG records.
    2.  Name server IP address and associated CDNSKEY RRset and its
        RRSIG redords ("CDNSKEY RRsets"). A name server IP can hold an
        empty RRset or no RRSIG records.
    3.  Name server IP address and associated DNSKEY RRset and its 
        RRsig records ("DNSKEY RRsets"). A name server IP can hold an empty
        RRset or no RRSIG records.
    4.  Name server IP address ("No DNSKEY RRset").
    5.  Name server IP address ("Mixed Delete CDS").
    6.  Name server IP address ("Delete CDS").
    7.  Name server IP address and associated CDS key tag 
        ("No Match CDS With DNSKEY").
    8.  Name server IP address ("CDS Not Signed").
    9.  Name server IP address and key tag 
        ("CDS Signed Unknown DNSKEY").
    10. Name server IP address and key tag ("CDS Invalid RRSIG").
    11. Name server IP address and key tag
        ("CDS RRSIG Not Signed DNSKEY").
    12. Name server IP address ("Mixed Delete CDNSKEY").
    13. Name server IP address ("Delete CDNSKEY").
    14. Name server IP address and associated CDNSKEY key tag 
        ("No Match CDNSKEY With DNSKEY").
    15. Name server IP address ("CDNSKEY Not Signed").
    16. Name server IP address and key tag 
        ("CDNSKEY Signed Unknown DNSKEY").
    17. Name server IP address and key tag ("CDNSKEY Invalid RRSIG").
    18. Name server IP address and key tag
        ("CDNSKEY RRSIG Not Signed DNSKEY").

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
          CDS RRset to the *CDS RRsets* set. Also include any assciated
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
          *CDNSKEY RRsets* set. Also include any assciated RRSIG records.
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
          *DNSKEY RRsets* set. Also include any assciated RRSIG records.
    4. Go to next name server IP.

7.  If neither of the *CDS RRsets* and *CDNSKEY RRsets* sets,
    respectively, has any RRset then terminate this test case.

8.  For each name server IP in the *CDS RRsets* set do:

    1. Extract the CDS and its RRSIG records, if any.
    2. If any CDS record is a "delete" CDS, then do:
       1. If there is more than a single CDS record then add the name
          server IP to the *Mixed Delete CDS* set.
       2. Else, add the name server IP address to the *Delete CDS*
          set.
       2. Go to next name server IP.
    3. Extract the DNSKEY and its RRSIG records, if any, from the 
       *DNSKEY RRsets* for the same name server IP.
    4. If there are no DNSKEY records, then do:
       1. Add name server IP address to the *No DNSKEY RRset* set.
       2. Go to next name server IP.
    5. Repeat the following steps for each CDS record:
       1. Compare the key tag from the CDS record with the caculated
          key tags for the DNSKEY records.
       2. If the CDS record does not match any DNSKEY record then add
          the name server IP address and key tag to 
          *No Match CDS With DNSKEY*.
    6. If there are no RRSIG records for the CDS RRset, then add the
       name server IP address to the *CDS Not Signed* set.
    7. Else, for each RRSIG (CDS) do:
       1. If the key tag of the RRSIG does not match any DNSKEY then
          add the name server IP address and key tag to the
          *CDS Signed Unknown DNSKEY* set.
       2. Else, if the RRSIG cannot be validated by the DNSKEY it
          refers to by key tag, then add the name server IP and RRSIG
          key tag to the *CDS Invalid RRSIG* set.
       3. Else, if there is no RRSIG (DNSKEY) created by the same
          DNSKEY then add the name serve IP address and the DNSKEY key
          tag to the *CDS RRSIG Not Signed DNSKEY* set.
    8. Go to next name server IP address.

9.  For each name server IP in the *CDNSKEY RRsets* set do:

    1. Extract the CDNSKEY and its RRSIG records, if any.
    2. If any CDNSKEY record is a "delete" CDNSKEY, then do:
       1. If there is more than a single CDNSKEY record then add the
          name server IP to the *Mixed Delete CDNSKEY* set.
       2. Else, add the name server IP address to the *Delete CDNSKEY*
          set.
       2. Go to next name server IP.
    3. Extract the DNSKEY and its RRSIG records, if any, from the 
       *DNSKEY RRsets* for the same name server IP.
    4. If there are no DNSKEY records, then do:
       1. Add name server IP address to the *No DNSKEY RRset* set
          (duplicates not possible).
       2. Go to next name server IP.
    5. Repeat the following steps for each CDNSKEY record:
       1. Compare the CDNSKEY record with the DNSKEY records.
       2. If the CDNSKEY record does not match any DNSKEY record then
          add the name server IP address and key tag to 
          *No Match CDNSKEY With DNSKEY*.
    6. If there are no RRSIG records for the CDNSKEY RRset, then add
       the name server IP address to the *CDNSKEY Not Signed* set.
    7. Else, for each RRSIG (CDNSKEY) do:
       1. If the key tag of the RRSIG does not match any DNSKEY then
          add the name server IP address and key tag to the
          *CDNSKEY Signed Unknown DNSKEY* set.
       2. Else, if the RRSIG cannot be validated by the DNSKEY it
          refers to by key tag, then add the name server IP and RRSIG
          key tag to the *CDNSKEY Invalid RRSIG* set.
       3. Else, if there is no RRSIG (DNSKEY) created by the same
          DNSKEY then add the name serve IP address and the DNSKEY key
          tag to the *CDNSKEY RRSIG Not Signed DNSKEY* set.
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

16. If the *CDS Not Signed* set or the *CDNSKEY Not Signed* set is
    non-empty then output *[DS16_CDS_CDNSKEY_UNSIGNED]* with all
    name server IP addresses in the two sets.

17. If the *CDS Signed Unknown DNSKEY* set is non-empty then output
    *[DS16_CDS_SIGNED_UNKNOWN_DNSKEY]* with the name server IP
    addresses in the set.

18. If the *CDNSKEY Signed Unknown DNSKEY* set is non-empty then
    output *[DS16_CDNSKEY_SIGNED_UNKNOWN_DNSKEY]* with the name server
    IP addresses in the set.

19. If the *CDS Invalid RRSIG* set is non-empty then for each key tag
    in the set output *[DS16_CDS_INVALID_RRSIG]* with the RRSIG key
    tag and the name server IP addresses in the set per key tag.

20. If the *CDNSKEY Invalid RRSIG* set is non-empty then for each key
    tag in the set output *[DS16_CDNSKEY_INVALID_RRSIG]* with the RRSIG
    key tag and the name server IP addresses in the set per key tag.

21. If the *CDS RRSIG Not Signed DNSKEY* set is non-empty then for
    each key tag in the set output *[DS16_CDS_RRSIG_NOT_SIGNED_DNSKEY]*
    with the RRSIG key tag and the name server IP addresses in the set
    per key tag.

21. If the *CDNSKEY RRSIG Not Signed DNSKEY* set is non-empty then for
    each key tag in the set output 
    *[DS16_CDNSKEY_RRSIG_NOT_SIGNED_DNSKEY]* with the RRSIG key tag and
    the name server IP addresses in the set per key tag.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                              | Default [severity level]
:------------------------------------|:-----------------------------------
DS16_CDNSKEY_INVALID_RRSIG           | ERROR
DS16_CDNSKEY_MATCHES_NO_DNSKEY       | WARNING
DS16_CDNSKEY_RRSIG_NOT_SIGNED_DNSKEY | WARNING
DS16_CDNSKEY_SIGNED_UNKNOWN_DNSKEY   | ERROR
DS16_CDS_CDNSKEY_UNSIGNED            | ERROR
DS16_CDS_CDNSKEY_WITHOUT_DNSKEY      | ERROR
DS16_CDS_INVALID_RRSIG               | ERROR
DS16_CDS_MATCHES_NO_DNSKEY           | WARNING
DS16_CDS_RRSIG_NOT_SIGNED_DNSKEY     | WARNING
DS16_CDS_SIGNED_UNKNOWN_DNSKEY       | ERROR
DS16_DELETE_CDNSKEY                  | INFO
DS16_DELETE_CDS                      | INFO
DS16_MIXED_DELETE_CDS_CDNSKEY        | ERROR



## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
the ignored protocol.

## Intercase dependencies

None.


[Basic04]:                               ../Basic-TP/basic04.md
[DNSSEC15]:                              dnssec15.md
[DS16_CDNSKEY_INVALID_RRSIG]:            #outcomes
[DS16_CDNSKEY_MATCHES_NO_DNSKEY]:        #outcomes
[DS16_CDNSKEY_RRSIG_NOT_SIGNED_DNSKEY]:  #outcomes
[DS16_CDNSKEY_SIGNED_UNKNOWN_DNSKEY]:    #outcomes
[DS16_CDS_CDNSKEY_UNSIGNED]:             #outcomes
[DS16_CDS_CDNSKEY_WITHOUT_DNSKEY]:       #outcomes
[DS16_CDS_INVALID_RRSIG]:                #outcomes
[DS16_CDS_MATCHES_NO_DNSKEY]:            #outcomes
[DS16_CDS_RRSIG_NOT_SIGNED_DNSKEY]:      #outcomes
[DS16_CDS_SIGNED_UNKNOWN_DNSKEY]:        #outcomes
[DS16_DELETE_CDNSKEY]:                   #outcomes
[DS16_DELETE_CDS]:                       #outcomes
[DS16_MIXED_DELETE_CDS_CDNSKEY]:         #outcomes
[ERROR]:                                 #outcomes
[Get-Del-NS-IPs]:                        https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-delegation-ns-ip-addresses
[Get-Zone-NS-IPs]:                       https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-zone-ns-ip-addresses
[INFO]:                                  #outcomes
[NOTICE]:                                #outcomes
[RFC 7344, section 4]:                   https://tools.ietf.org/html/rfc7344#section-4
[RFC 7344]:                              https://tools.ietf.org/html/rfc7344
[RFC 8078]:                              https://tools.ietf.org/html/rfc8078
[Severity Level]:                        ../SeverityLevelDefinitions.md
[WARNING]:                               #outcomes




