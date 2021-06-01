# DNSSEC02: DS must match a valid DNSKEY in the child zone

## Test case identifier
**DNSSEC02**

## Objective

DNS delegations from a parent to a child are secured with DNSSEC by
publishing one or several Delgation Signer (DS) records in the parent
zone, along with the NS records for the delegation.

For the secure delegation to work, at least one DS record must match a
DNSKEY record in the child zone ([RFC 4035][RFC 4035#5], section 5).
Each DS record should match a DNSKEY record in the child zone. More
than one DS may match the same DNSKEY. The DNSKEY that the DS record
refer to must be used to sign the DNSKEY RRset in the child zone
([RFC 4035][RFC 4035#5], section 5).

The DNSKEY record that the DS record refer to must have bit 7
("Zone Key flag") set in the DNSKEY RR Flags ([RFC 4034][RFC 4034#5.2], 
section 5.2).

Bit 15 ("Secure Entry Point flag") on a DNSKEY record signals that it
is meant to be a KSK and pointed out by a DS record. It is noted if
the DNSKEY record that the DS points at does not have that flag set
([RFC 4034][RFC 4034#2.1.1], section 2.1.1).

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested.
* "Test Type" - The test type with value "undelegated" or "normal".
* "Undelegated DS" - The DS record or records submitted
  (only if *Test Type* is undelegated).

## Ordered description of steps to be taken to execute the test case

1. Create an empty set, "DS records".

2. If the *Test Type* is "undelegated, then:
   1. Add *Undelegated DS* set to *DS records*.

3. Else, do:
   1. Create a DS query with DO flag set for the name of the
      *Child Zone* (*Test Type* is "normal").
   2. Retrieve all name server IP addresses for the parent zone of
      *Child Zone* using [Method1] ("Parent NS IP").
   3. For each IP address in *Parent NS IP* do:
      1. Send the DS query over UDP and collect the response.
      2. If there is no DNS response, then output *[NO_RESPONSE]*.
      3. Else, if the RCODE is not NOERROR, then output
         *[UNEXPECTED_RESPONSE_DS]*.
      4. Else, go to next IP address if there is no DS in the
         response.
      5. Else, extract all DS records from the DNS response and
         add them to *DS Records*.

4. If *DS Records* is empty, exit this test case.

5. Create a DNSKEY query with DO flag set for the apex of the
   *Child Zone*.

6. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

7. For each name server IP address in *NS IP* do:
   1. Send the DNSKEY query over UDP.
   2. If no DNS response is returned, then output *[NO_RESPONSE]*
      and go to next name server IP.
   3. If the DNS response does not contain an DNSKEY RRset,
      then output *[NO_RESPONSE_DNSKEY]* and go to next name server
      IP.
   4. Extract the DNSKEY RRset ("DNSKEY RRs").
   5. If the DNS response does not contain any RRSIG records covering
      the DNSKEY RRset, then output *[NO_RRSIG_DNSKEY]*.
   5. Extract the RRSIG records covering the DNSKEY RRset, possibly
      none ("DNSKEY RRSIG").
   6. For each DS in *DS Records*, do:
      1. Find the equivalent DNSKEY in *DNSKEY RRs* by key ID (key tag).
      2. If matching DNSKEY is not found, output *[NO_MATCHING_DNSKEY]*.
      3. If the DS values (algorithm and digest) do not match the
         DNSKEY then output *[BROKEN_DS]*.
      4. If bit 7 of the DNSKEY flags field has the value of 0 (nil),
         then output *[DNSKEY_NOT_ZONE_SIGN]* and go to next DS.
      5. If bit 15 of the DNSKEY flags field has the value of 0 (nil),
         then output *[DNSKEY_KSK_NOT_SEP]*.
      6. Find the equivalent RRSIG in *DNSKEY RRSIG* by key ID (key tag).
      7. If matching RRSIG is not found, output *[NO_MATCHING_RRSIG]*.
      8. If the RRSIG values (algorithm and signature) do not match
         the DNSKEY then output *[BROKEN_RRSIG]*.

8. If no message, besides possibly *[NO_RESPONSE]* or 
   *[DNSKEY_KSK_NOT_SEP]*, has been outputted, then output 
   *[DS_MATCHES]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
BROKEN_DS                     | ERROR
BROKEN_RRSIG                  | ERROR
DNSKEY_KSK_NOT_SEP            | NOTICE
DNSKEY_NOT_ZONE_SIGN          | ERROR
DS_MATCHES                    | INFO
NO_MATCHING_DNSKEY            | ERROR
NO_MATCHING_RRSIG             | ERROR
NO_RESPONSE                   | DEBUG
NO_RESPONSE_DNSKEY            | ERROR
NO_RRSIG_DNSKEY               | ERROR
UNEXPECTED_RESPONSE_DS        | WARNING


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

Test case is only performed if DS records are found.

## Intercase dependencies

None.



[Basic04]:                 ../Basic-TP/basic04.md
[BROKEN_DS]:               #outcomes
[BROKEN_RRSIG]:            #outcomes
[DNSKEY_KSK_NOT_SEP]:      #outcomes
[DNSKEY_NOT_ZONE_SIGN]:    #outcomes
[DS_MATCHES]:              #outcomes
[NO_MATCHING_DNSKEY]:      #outcomes
[NO_MATCHING_RRSIG]:       #outcomes
[NO_RESPONSE]:             #outcomes
[NO_RESPONSE_DNSKEY]:      #outcomes
[NO_RRSIG_DNSKEY]:         #outcomes
[UNEXPECTED_RESPONSE_DS]:  #outcomes

[RFC 4034#2.1.1]:          https://tools.ietf.org/html/rfc4034#section-2.1.1
[RFC 4034#5.2]:            https://tools.ietf.org/html/rfc4034#section-5.2
[RFC 4035#5]:              https://tools.ietf.org/html/rfc4035#section-5

[DNSSEC README]:           ./README.md

[Method1]:                 ../Methods.md#method-1-obtain-the-parent-domain
[Method4]:                 ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                 ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

