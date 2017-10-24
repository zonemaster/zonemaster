## CONSISTENCY03: SOA parameters consistency

### Test case identifier

**CONSISTENCY03:** SOA parameters consistency

### Objective

All authoritative name servers must serve the same SOA record for the
designated domain. As per section 3.3.13 of [RFC 1035](https://tools.ietf.org/html/rfc1035),
the field "REFRESH" in the SOA RDATA refers to the 32 bit time interval before the
zone should be refereshed. The field "RETRY" refers to the 32 bit interval
before a failed refresh should be retried, the field "EXPIRE" refers to a 32
bit time value that specifies the upper limit on the time interval that can
elapse before the zone is no longer authoritative and the field "MINIMUM" is
the unsigned 32 bit minimum TTL field that should be exported with any
resource record from the domain's zone

The inconsistency in these different fields for the designated zone (*Got to
Verify*) might result in operational inconsistencies.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method4](../Methods.md) and
   [Method5](../Methods.md).
2. Retrieve the SOA RR from all the name servers. 
3. If the SOA RNAME field is not the same from all the answers
   received from step 2, then the test case fails.

### Outcome(s)

All authoritative name servers must have consistent RNAME field.
If the test does not find any inconsistency, then the test succeeds.

### Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

### Intercase dependencies

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
