# DNSSEC17: Validate trust from DS to CDS and CDNSKEY

## Test case identifier
**DNSSEC17**

## Objective

CDS and CDNSKEY record types are defined in [RFC 7344] and [RFC 8078].
Both record types are optional in a zone. The objective of this test
case is to verify that they are there is a correct chain of trust
from DS, in the parent zone to the CDS and CDNSKEY RRsets
([RFC 7344][RFC 7344, section 4.1], section 4.1).

This Test case is only relevant if 
* The *Child Zone* has either CDS or CDNSKEY record or both.
* The parent zone has a DS RRset for the *Child Zone*.

If a name server has issues covered by [Basic04] (basic name server
issues) no messages will be outputted from this test case.

It is assumed that the Child Zone has been tested by [DNSSEC15] and
[DNSSEC16] and that the servers still give the same responses.

## Inputs

* "Child Zone" - The domain name to be tested.
* "Test Type" - The test type with value "undelegated" or "normal".
* "Undelegated DS" - The DS record or records submitted (only if
  Test Type is undelegated).

## Summary
* If no CDS or CDNSKEY records are found, this test case is not run.
* If no DS records are found at parent, this test case is not run.
* [ERROR] message if the CDS RRset is not signed with the private key
  of the DNSKEY record that a DS record points at.
* [ERROR] message if the CDNSKEY RRset is not signed with the private
  key of the DNSKEY record that a DS record points at.

## Ordered description of steps to be taken to execute the test case

1.  Create a CDS query with EDNS enabled and the DO bit set for the
    apex of the *Child Zone*.

2.  Create a CDNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

3.  Create a DNSKEY query with EDNS enabled and the DO bit set for
    the apex of the *Child Zone*.

4.  Create a DS query with EDNS enabled and DO flag set for the name of
    the *Child Zone*.

5.  Create the following empty sets:
    1.  Name server IP address and associated CDS RRset and its RRSIG
        records ("CDS RRsets"). A name server IP can hold an empty 
        RRset or no RRSIG records.
    2.  Name server IP address and associated CDNSKEY RRset and its
        RRSIG redords ("CDNSKEY RRsets"). A name server IP can hold an
        empty RRset or no RRSIG records.
    3.  Name server IP address and associated DNSKEY RRset
        ("DNSKEY RRsets"). A name server IP can hold an empty RRset.
    4.  DS record set ("DS Records").
    5.  Name server IP and DS record key tag ("DS No Match CDS RRSIG").
    6.  Name server IP and DS record key tag 
        ("DS No Match CDNSKEY RRSIG").

6. If the *Test Type* is "undelegated, then:
   1. Add *Undelegated DS* set to *DS Records*.

7. Else, do (*Test Type* is "normal"):
   1. Retrieve all name server IP addresses for the parent zone of
      *Child Zone* using [Get-Parent-Zone] ("Parent NS IP").
   2. For each IP address in *Parent NS IP* do:
      1. Send the DS query over UDP to the name server IP.
      2. If no DNS response is returned, then go to next name server
         IP.
      3. Else, if AA bit is not set in the DNS response, then go to
         next name server IP.
      3. Else, if the RCODE in the DNS response is not *NOERROR*, then
         go to next name server IP.
      4. Else, if the DNS response contains at least one DS record
         add all DS records to *DS Records*.

8. If *DS Records* is empty, terminate this test case.

9.  Retrieve all name server IP addresses for the *Child Zone* using
    [Get-Del-NS-IPs] and [Get-Zone-NS-IPs] ("NS IP").

10. Repeat the following steps for each name server IP address in 
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
          *DNSKEY RRsets* set.
    4. Go to next name server IP.

11. If neither of the *CDS RRsets* and *CDNSKEY RRsets* sets,
    respectively, has any RRset then terminate this test case.

12. If the *DNSKEY RRsets* is empty, then terminate this test case.

13. For each name server IP in the *CDS RRsets* set do:

    1. Extract the RRSIG records for the CDS RRset.
    2. Extract the DNSKEY from the *DNSKEY RRsets* for the same name
       server IP.
    3. For each DS record in *DS Records* do:
       1. If the DS record does not point at a DNSKEY record then add
          name server IP and DS key tag to the 
          *DS No Match CDS RRSIG*.
       2. Else, if the DNSKEY that the DS record points at does not
          match any RRSIG for CDS RRset then add name server IP and
          DS key tag to the *DS No Match CDS RRSIG*.
    4. Go to next name server IP address.

14. For each name server IP in the *CDNSKEY RRsets* set do:

    1. Extract the RRSIG records for the CDNSKEY RRset.
    2. Extract the DNSKEY from the *DNSKEY RRsets* for the same name
       server IP.
    3. For each DS record in *DS Records* do:
       1. If the DS record does not point at a DNSKEY record then add
          name server IP and DS key tag to the 
          *DS No Match CDNSKEY RRSIG*.
       2. Else, if the DNSKEY that the DS record points at does not
          match any RRSIG for CDNSKEY RRset then add name server IP and
          DS key tag to the *DS No Match CDNSKEY RRSIG*.
    4. Go to next name server IP address.

15. If the *DS No Match CDS RRSIG* set is non-empty then for each
    key tag in the set output *[DS17_DS_NO_MATCH_CDS_RRSIG]* with the
    DS key tag and the name server IP addresses in the set per key
    tag.

16. If the *DS No Match CDNSKEY RRSIG* set is non-empty then for each
    key tag in the set output *[DS17_DS_NO_MATCH_CDNSKEY_RRSIG]* with the
    DS key tag and the name server IP addresses in the set per key
    tag.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                              | Default [severity level]
:------------------------------------|:-----------------------------------
DS17_DS_NO_MATCH_CDS_RRSIG           | ERROR
DS17_DS_NO_MATCH_CDNSKEY_RRSIG       | ERROR

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
the ignored protocol.

## Intercase dependencies

None.


[Basic04]:                               ../Basic-TP/basic04.md
[DNSSEC15]:                              dnssec15.md
[DNSSEC16]:                              dnssec16.md
[DS17_DS_NO_MATCH_CDNSKEY_RRSIG]:        #outcomes
[DS17_DS_NO_MATCH_CDS_RRSIG]:            #outcomes
[ERROR]:                                 #outcomes
[Get-Del-NS-IPs]:                        https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-delegation-ns-ip-addresses
[Get-Parent-Zone]:                       https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-parent-zone
[Get-Zone-NS-IPs]:                       https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/MethodsNT.md#method-get-zone-ns-ip-addresses
[INFO]:                                  #outcomes
[NOTICE]:                                #outcomes
[RFC 7344, section 4.1]:                 https://tools.ietf.org/html/rfc7344#section-4.1
[RFC 7344]:                              https://tools.ietf.org/html/rfc7344
[RFC 8078]:                              https://tools.ietf.org/html/rfc8078
[Severity Level]:                        ../SeverityLevelDefinitions.md
[WARNING]:                               #outcomes

