## DNSSEC08: RRSIG(DNSKEY) must be valid and created by a valid DNSKEY

### Test case identifier
**DNSSEC08** RRSIG(DNSKEY) must be valid and created by a valid DNSKEY

### Objective

The apex DNSKEY RRset should be signed with an RRSIG with a DNSKEY from
the RRset. This is described in section 2.4 of [RFC 4035](http://tools.ietf.org/html/rfc4035#section-2.4).

(In reality the RRSIG should be created by the DNSKEY matching the DS. All
algorithms from the DS should have a matching DNSKEY with those algorithms,
and all DNSKEY algorithms should have matching RRSIG with those algorithms.
Postponed for future tests. See future tests in the requirements document.)

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the DNSKEY RR set from the child zone.
2. Retrieve the RRSIG from the answer.
3. Match the RRSIGs with the DNSKEY RR set, and check the inception and
   expiration times and compare them with the current time.
4. If the RRSIGs validates the DNSKEY RR set, and the RRSIG is within the
   validity period this test case pass.
5. If any of the RRSIGs does not validate the DNSKEY RR set, this test
   case fails.

### Outcome(s)

If all RRSIG validates the DNSKEY RR set, this test case pass.

### Special procedural requirements

None.

### Intercase dependencies

None.
