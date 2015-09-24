## CONSISTENCY02: RNAME consistency

### Test case identifier

**CONSISTENCY02:** RNAME consistency

### Objective

All authoritative name servers must serve the same SOA record (section
4.2.1) of [RFC 1034](https://tools.ietf.org/html/rfc1034) for the
tested domain. As per section 3.3.13 of [RFC 1035](https://tools.ietf.org/html/rfc1035),
the RNAME field in the SOA RDATA refers to the administrative contact. The inconsistency in
the administrative contact for the a domain might result in operational
failures being informed to different persons.

The objective of this test is to verify that the administrative contact is
consistent between different authoritative name servers.

### Inputs

1. The domain name to be tested

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

None

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
