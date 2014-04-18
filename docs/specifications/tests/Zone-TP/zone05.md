## ZONE05: SOA 'expire' minimum value

### Test case identifier
**ZONE05** SOA 'expire' minimum value

### Objective

The SOA expire value specifies for how long any secondary name server
keeps the zone valid without any contact with the primary name server.
This value should be greater than how long a major outage would
typically last. The expire value should also be larger than the
refresh and retry values, as described in section 3.3.13 in
[RFC 1035](http://tools.ietf.org/html/rfc1035), and clarified in
section 2.2 of [RFC 1912](http://tools.ietf.org/html/rfc1912).

Setting the expire value low will increase the risk of any unwanted
non-availability of the zone because of any failures in contacting
the primary name server.

The [RIPE-203](http://www.ripe.net/ripe/docs/ripe-203) recommendation
for the expire value is 1000 hours (roughly 41 days). Older DNSCheck code
had a 7 day minimum value (604800 seconds), and this is the minimum
value we recommend as an absolut minimum.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the expire value and the refresh value from the SOA record
   of the domain being tested.
2. If the expire value is less than 604800 seconds (7 days), this test
   case fails.
3. If the expire value is lower than the refresh value, this test case
   fails.

### Outcome(s)

If the expire value is less than 604800 seconds or if the expire value is
lower than the refresh value, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
