## ZONE04: SOA 'retry' at least 1 hour

### Test case identifier
**ZONE04** SOA 'retry' at least 1 hour

### Objective

The SOA retry value is the number of seconds that describes
minimum time elapsed since a failed zone refresh from the primary
name server. The SOA refresh value is described
in section 3.3.13 in [RFC 1035](https://tools.ietf.org/html/rfc1035),
and clarified in section 2.2 of
[RFC 1912](https://tools.ietf.org/html/rfc1912).

Setting the retry value low will increase the DNS traffic between
the servers, and also increase the load on the master name server.

The [RIPE-203](https://www.ripe.net/ripe/docs/ripe-203) recommendation
for the retry value is 2 hours (7200 seconds). Older DNSCheck code
had a one hour minimum value (3600 seconds), and this is the minimum
value we recommend.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from a delegated name server for the domain.
2. If the answer from step 1 is not authoritative, iterate step 1 until there is an authoritative answer.
3. Retrieve the retry value from the SOA record.
4. If the retry value is less than 3600 seconds, this test case fails.

### Outcome(s)

If the retry value is less than 3600 seconds, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
