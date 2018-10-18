# CDS04: Verify valid RRSIG with new CDS/CDNSKEY

## Test case identifier

**CDS04**

## Objective

To be able to participate on the automation of DNSSEC delegation trust
maintenance ([RFC 7344]), a zone must have valid DNSSEC signatures with
the future DS derived from the CDS/CDNSKEY in the child zone, so not to
break the secure chain (section 4.1).

For reference purposes, [RFC 7344] explains the CDS/CDNSKEY records
requirements, and section 5.1 of [RFC 4034] explains the format
of the DS/DNSKEY format RDATA, from which CDS/CDNSKEY are derived.


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1. Retrieve the CDS and CDNSKEY rrsets from the child zone along with
   their corresponding RRSIGs (DO bit set).

2. If there're no CDS nor CDNSKEY rrsets, output [NO_CDS_CDNSKEY] and
   exit.

3. Retrieve the DNSKEY rrset from the child zone with its corresponding
   RRSIG sets (DO flag).

4. If there's no DNSKEY rrset, output [NO_DNSKEY] and exit.

5. If there's no key inside the DNSKEY rrset which corresponds with the
   CDS/CDNSKEY rrsets, output [NO_CDS_CDNSKEY_KEYSET] and exit.

6. Match and validate the signatures from the DNSKEY rrset with the
   key which corresponds to the CDS or CDNSKEY rrsets. Output
   [DNSKEY_VALID] if they're valid, otherwise [DNSKEY_BOGUS] and exit.

7. Match and validate the signatures from the CDS/CDNSKEY rrsets with
   any key which corresponds to the DNSKEY rrsets. Output
   [CDS_CDNSKEY_VALID] if they're valid, otherwise [CDS_CDNSKEY_BOGUS].


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                 | Default severity level (when message is outputted)
:-----------------------|:-----------------------------------
NO_CDS_CDNSKEY          | INFO
NO_DNSKEY               | ERROR
NO_CDS_CDSNKEY_KEYSET   | ERROR
DNSKEY_VALID            | INFO
DNSKEY_BOGUS            | ERROR
CDS_CDNSKEY_VALID       | INFO
CDS_CDNSKEY_BOGUS       | ERROR


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

If there's no CDS record in the zone, we consider such absence as a normal
answer.

There's no need to force TCP as transport for the queries, because
DNSSEC protects the data against forgeries.


## Intercase dependencies

None.


[RFC 7344]: https://tools.ietf.org/html/rfc7344
[RFC 4034]: https://tools.ietf.org/html/rfc4034
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

