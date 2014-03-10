## DNSSEC02: DS must match a DNSKEY in the designated zone

### Test case identifier
**DNSSEC02** DS must match a DNSKEY in the designated zone

### Objective

DNS delegations from a parent to a child are secured with DNSSEC by
publishing one or several Delgation Signer (DS) records in the parent
zone, along with the NS records for the delegation. For the secure
delegation to work, the DS record must match at least one DNSKEY record
in the child zone.

The method for authentication a DNS response is described in section 5 of
[RFC 4035](http://tools.ietf.org/html/rfc4035#section-5). The DS record
is described in section 5 of [RFC 4034]
(http://tools.ietf.org/html/rfc4034#section-5) and the DNSKEY record is
described in section 2 of [RFC 4034]
(http://tools.ietf.org/html/rfc4034#section-2).

The IANA registry of DNSKEY algorithm numbers is in the [dns-sec-alg-numbers]
(http://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xhtml).
The allowed Digest Algorithms in a DS record published by the parent are
published by IANA in [Delegation Signer (DS) Resource Record (RR) Type
Digest Algorithms](https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xhtml). 

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the DS RR set from the parent zone.
2. Retrieve the DNSKEY RR set from the child zone.
3. Convert the DNSKEY RR set to DS records with the same algorithms as
   those from the parent zone.
4. If none of the converted DNSKEY RR matches with any of the DS from the
   parent zone, this test case fails.

### Outcome(s)

If any of the Digest type values from the DS RR set published in the parent
zone are not assigned by IANA, this test case fails.

### Special procedural requirements

See the [level document](level.md) about DNSSEC algorithms.

### Intercase dependencies

None.
