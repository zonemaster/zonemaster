## DNSSEC05: Check for invalid DNSKEY algorithms

### Test case identifier
**DNSSEC05** Check for invalid DNSKEY algorithms

### Objective

The domain should only use DNSKEY RRs that are defined by IANA.

The DNSKEY record is described in section 2 of [RFC 4034]
(http://tools.ietf.org/html/rfc4034#section-2).

The IANA registry of DNSKEY algorithm numbers is in the [dns-sec-alg-numbers]
(http://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xhtml).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the DNSKEY RR set from the child zone.
2. The DNSKEY algorithm numbers are derived from all the DNSKEY RRs.
3. The algorithm numbers are matched with the IANA DNSKEY algorithm table.
4. If any the algorithm numbers is unassigned, reserved, a private algorithm
   or deprecated, this test case fails.

### Outcome(s)

If any DNSKEY algorithm number is unassigned, reserved, a private algorithm
or deprecated, this test case fails.

### Special procedural requirements

See the [level document](level.md) about DNSSEC algorithms.

Test case is only performed if DNSKEY records are found.

### Intercase dependencies

None.
