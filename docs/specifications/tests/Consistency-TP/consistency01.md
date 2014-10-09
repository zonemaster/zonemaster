## CONSISTENCY01: SOA serial number consistency

### Test case identifier

**CONSISTENCY01:** SOA serial number consistency

### Objective

For the data served by the authoritative name servers for a desginated zone
to be consistent, all authoritative name servers must serve the same SOA
record for the designated zone.   

If the serial number (explained in 3.3.13. of [RFC 1035](https://tools.ietf.org/html/rfc1035)) 
, which is part of the SOA record, is not consistent between authoritative servers, 
there is a possibility that the data served is inconsistent. The reasons for this 
inconsistency may be different - such as misconfiguration, or as a result of slow 
propagation to the secondary name servers.

The objective of this test is to verify that the serial number is consistent
between different authoritative name servers.

For reference purposes : [RFC1982](https://tools.ietf.org/html/rfc1982) 
explains the serial number arithmetic, and section 4.3.5 of 
[RFC 1034](https://tools.ietf.org/html/rfc1035) explains the importance of
serial number consistency.


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method4](../Methods.md) and
   [Method5](../Methods.md)
2. Retrieve the SOA RR from all the name servers. 
3. If the SOA serial number is not the same from all the answers received
   from step 2, then
	3.a. Check if the difference is minor (An integer should be added to
	define what is the minor value)
	3.b. If the difference is greater than the minor value, then the
	test case fails
	3.c. If the difference is less than or equal to the minor value,
	then the test is passed

### Outcome(s)

All authoritative name servers must have consistent serial numbers. If the
test does not find any inconsistency, then the test case passes.

### Special procedural requirements	

A manual inspection of the SOA serial may be needed to determine if the zone
updates work properly or not, and if the serial values are within a
reasonable range, then the test is OK.

### Intercase dependencies

None
