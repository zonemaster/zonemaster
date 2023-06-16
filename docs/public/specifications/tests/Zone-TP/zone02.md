## ZONE02: SOA 'refresh' minimum value

### Test case identifier
**ZONE02** SOA 'refresh' minimum value

### Objective

The SOA refresh value is the number of seconds that describes
how often a secondary name server will poll the primary name server
to see if there is any updates. The SOA refresh value is described
in section 3.3.13 in [RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035),
and clarified in section 2.2 of
[RFC 1912](https://datatracker.ietf.org/doc/html/rfc1912).
Setting the refresh value low will increase the DNS traffic between
the servers, and also increase the load on the master name server.
The primary name server will in most cases send DNS notifications to
tell the secondary name servers that zone content has been updated,
as described in [RFC 1996](https://datatracker.ietf.org/doc/html/rfc1996).

The [RIPE-203](https://www.ripe.net/publications/docs/ripe-203) recommendation
for the refresh value is 24 hours (86400 seconds). Older DNSCheck code
had a four hour minimum value, and this is the minimum value we
recommend.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from a delegated name server for the domain.
2. If the answer from step 1 is not authoritative, iterate step 1 until there is an authoritative answer.
3. Retrieve the refresh value from the SOA record.
4. If the refresh value is less than 14400 (four hours in seconds)
   this test case fails.

### Outcome(s)

If the SOA refresh value is less than 14400 this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
