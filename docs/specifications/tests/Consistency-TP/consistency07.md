## CONSISTENCY07: CDS record consistency

### Test case identifier

**CONSISTENCY07:** CDS record consistency

### Objective

To be able to participate on the automation of DNSSEC delegation trust
maintenance (RFC7344), a zone must have the same CDS record content
between all the authoritative servers.

The objective of this test is to verify that the CDS record RDATA value
is consistent between different authoritative name servers.

For reference purposes : [RFC7344](https://tools.ietf.org/html/rfc7344) 
explains the CDS record and consistency requirements, and section 5.1 of 
[RFC 4034](https://tools.ietf.org/html/rfc4034) explains the format
of the DS format RDATA, from which CDS is derived.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

 1. Obtain the list of name servers from [Method4] and [Method5].
 2. Retrieve the CDS RR from all the name servers using TCP.
 3. The CDS RR RDATA value in its "string representation" must be the
    same for all servers from step 2.

### Outcome(s)

All authoritative name servers must have consistent CDS RR RDATA. If
the test does not find any inconsistency, then the test case passes.

### Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

If there's no CDS record in the zone, we consider such absence as a normal
answer, so it should be consistent between all the authoritative
nameservers to pass the test.

When bootstraping a new CDS key for setting up a DNSSEC delegation for
the first time, there's a need to have extra security defenses against
UDP injection attacks. Therefore, the transport for the query should be
forced to TCP. If there's no TCP response from any nameserver, the test
should fail.

### Intercase dependencies

None

-------
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
