## NAMESERVER01: A name server should not be a recursor

### Test case identifier
**NAMESERVER01** A name server should not be a recursor

### Objective

To ensure consistency in DNS, an authoritative name server should not be
configured to do recursive lookups. Also, open recursive resolvers are
considered bad internet practice due to their capability of assisting in
large scale DDoS attacks. The introduction to [RFC 5358]
(https://tools.ietf.org/html/rfc5358) elaborates on mixing recursor and
authoritative functionality, and the issue is further elaborated by
[D.J. Bernstein](http://cr.yp.to/djbdns/separation.html).

Section 2.5 of [RFC 2870](https://tools.ietf.org/html/rfc2870) have very
specific requirement on disabling recursion functionality on root name
servers.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Find all hostnames for all the name servers used for the domain using
   [Method 2](../Methods.md#method-2-obtain-name-servers-from-parent) and
   [Method 3](../Methods.md#method-3-obtain-name-servers-from-child).
2. A SOA query for an almost certainly nonexistent name sent to the each
   name server found in step 1, with the flag Recursion Desired (RD) set.
3. If any answer of the queries made in step 2 contains an RCODE with
   NXDOMAIN, this test case fails.

### Outcome(s)

If the response is a possible answer with the RCODE NXDOMAIN, this test
case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
