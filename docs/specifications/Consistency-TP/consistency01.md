## CONSISTENCY01: Serial number must be consistent between authoritative name servers 

### Test case identifier

**CONSISTENCY01:** Serial number must be consistent between authoritative name servers 

### Objective

For the data served by the authoritative name servers for a desginated zone to be consistent, all authoritative name servers must serve the same SOA record for the designated zone.   

If the serial number, which is part of the SOA record is not consistent between authoritative servers, there is a possibility that the data served is inconsistent. The reasons for this inconsistency may be different - such as misconfiguration, or as a result of slow propagation to the secondary name servers.

The objective of this test is to verify that the serial number is consistent between different authoritative name servers.

[Technical Reference to be provided]

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Retrieve all the authoritative name servers for the fomain
2. The SOA record is queried from all the authoritative name servers for the domain. 
3. If the SOA serial number is not the same from all the answers received from step 2, then the test fails

### Outcome(s)
All authoritative name servers must have consistent serial numbers. If the test does not find any inconsistency, then the test succeeds

### Special procedural requirements	

If for operational reasons, the zone content fluctuates rapidly (e.g. within a second), then the test may fail even though there is no misconfigurations. In this case, the serial numbers between different authoritative name servers need only to be loosely coherent. A manual inspection of the SOA serial should be enough to determine if the zone updates work properly or not, and if the serial values are within a reasonable range, the test is OK. 

Such manual inspection is needed in the case of zones which rapidly fluctuates, as in the case of Top Level Domains (TLDs).  

### Intercase dependencies

None
