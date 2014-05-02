## DNSSEC06: Verify DNSSEC additional processing

### Test case identifier
**DNSSEC06** Verify DNSSEC additional processing

### Objective

In order for an authoritative name server to be DNSSEC compliant,
it must serve DNSKEY signatures (RRSIG) as additional data in a DNS answer.
This additional processing is described in section 3.1 of [RFC 4035]
(https://tools.ietf.org/html/rfc4035#section-3.1).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. For each name server configured for the domain:
2. Retrieve the DNSKEY RR set from the child zone.
3. If the answer from the query does contain a DNSKEY _and_ RRSIG, this
   test case passes.
4. If there is no DNSKEY RR or RRSIG RR in the answer and the RCODE is
   NOERROR, this test case fails.

### Outcome(s)

If any of the name servers configured for the domains fail to answer with
DNSSEC data, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

This test should only run if [DNSSEC07](dnssec07.md) has been successful
in finding a DNSKEY for the domain.
