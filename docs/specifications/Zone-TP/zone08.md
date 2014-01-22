## ZONE08: SOA master is not an alias

### Test case identifier
**ZONE08** SOA master is not an alias

### Objective

Any NS type record should not be a CNAME. The SOA MNAME should in this
respect not either be a CNAME.

Quote from 2.4 in [RFC 1912](http://tools.ietf.org/html/rfc1912):

> Having NS records pointing to a CNAME is bad and may conflict badly
> with current BIND servers.

The SOA MNAME field is described in section 3.3.13 in
[RFC 1035](http://tools.ietf.org/html/rfc1035).

The [RIPE-203](http://www.ripe.net/ripe/docs/ripe-203) recommendation
for the minimum value 2 days, but the negative caching is now the norm.
DNSCheck has a recommended value of between 300 seconds (5 minutes) and
86400 seconds (1 day).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA MNAME value from the SOA record of the domain being
   tested.
2. Query the A record of the host from MNAME.
3. If the answer to the query is a CNAME, this test case fails.

### Outcome(s)

If the SOA MNAME field is pointing to a CNAME, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
