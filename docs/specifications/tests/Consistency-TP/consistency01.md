## CONSISTENCY01: SOA serial number consistency

### Test case identifier

**CONSISTENCY01:** SOA serial number consistency

### Objective

For the data served by the authoritative name servers for a desginated zone
to be consistent, all authoritative name servers must serve the same SOA
record for the designated zone.   

If the serial number, which is part of the SOA record is not consistent
between authoritative servers, there is a possibility that the data served
is inconsistent. The reasons for this inconsistency may be different - such
as misconfiguration, or as a result of slow propagation to the secondary
name servers.

The objective of this test is to verify that the serial number is consistent
between different authoritative name servers.

[Technical Reference to be provided]

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
   [Method3](../Methods.md)
2. Retrieve the SOA RR from all the name servers. 
3. If the SOA serial number is not the same from all the answers received
   from step 2, then the test fails

### Outcome(s)

All authoritative name servers must have consistent serial numbers. If the
test does not find any inconsistency, then the test case passes.

### Special procedural requirements	

None

### Intercase dependencies

None
