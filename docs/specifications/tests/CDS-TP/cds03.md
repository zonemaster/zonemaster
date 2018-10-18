# CDS03: Verify valid RRSIG with current DS

## Test case identifier

**CDS03**

## Objective

To be able to participate on the automation of DNSSEC delegation trust
maintenance ([RFC 7344]), a zone must have valid DNSSEC signatures with
the current DS in the parent zone, so not to break the secure chain
(section 4.1).

For reference purposes, [RFC 7344] explains the CDS/CDNSKEY records 
requirements, and section 5.1 of [RFC 4034] explains the format
of the DS/DNSKEY format RDATA, from which CDS/CDNSKEY are derived.


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1. Retrieve the DS rrset from the parent zone.

2. If there's no DS from the parent, output [NO_DS] and exit.

3. Retrieve the DNSKEY rrset from the child zone with its corresponding
   RRSIG sets (DO flag).

4. If there's no DNSKEY rrset, output [NO_DNSKEY] and exit.

5. If there's no key inside the DNSKEY rrset which corresponds to the
   DS rrset from the parent zone, output [NO_CHAIN] and exit.

6. Match and validate the signatures from the DNSKEY rrset with the
   key which corresponds to the DS parent RRset. Output [BROKEN_CHAIN]
   and exit if there's no valid signature.

7. Retrieve the CDS and CDNSKEY rrsets from the child zone with its
   corresponding RRSIG sets (DO flag). Output [NO_CDS_CDNSKEY] and exit
   if there're no records.

8. Output [NO_CDS_CDNSKEY_SIGS] and exit if there're no RRSIGs for them.

9. Match and validate the signatures with any of the keys of the
   DNSKEY rrset. Output [CDS_CDSNKEY_VALID] if they're valid,
   otherwise [CDS_CDNSKEY_BOGUS]


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                 | Default severity level (when message is outputted)
:-----------------------|:-----------------------------------
NO_DS                   | INFO
NO_DNSKEY               | ERROR
NO_CHAIN                | ERROR
BROKEN_CHAIN            | ERROR
NO_CDS_CDNSKEY          | INFO
NO_CDS_CDNSKEY_SIGS     | ERROR
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

