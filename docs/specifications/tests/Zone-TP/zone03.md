## ZONE03: SOA 'retry' lower than 'refresh'

### Test case identifier
**ZONE03** SOA 'retry' lower than 'refresh'

### Objective

The SOA retry value is the number of seconds that describes
minimum time elapsed since a failed zone refresh from the primary
name server. The SOA refresh value is described
in section 3.3.13 in [RFC 1035](https://tools.ietf.org/html/rfc1035),
and clarified in section 2.2 of
[RFC 1912](https://tools.ietf.org/html/rfc1912).

> It's typically some fraction of the refresh interval.

Setting the retry value low will increase the DNS traffic between
the servers, and also increase the load on the master name server.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the retry value from the SOA record of the domain being
   tested.
2. If the retry value is higher than or equal to the refresh value,
   this test case fails.

### Outcome(s)

If the SOA retry value is higher than or equal to the refresh value,
this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
