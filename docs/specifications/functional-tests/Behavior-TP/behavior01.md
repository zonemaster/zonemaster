## BEHAVIOR01: NXDOMAIN returned in response in the event of querying a domain name that does not exist

### Test case identifier

**BEHAVIOR01:** Name Error RCODE returned in response in the event of
querying a domain name that does not exist

### Objective 
This test is to verify whether the engine responds with a RCODE NXDOMAIN when
querying a domain name that does not exist.

### Inputs

The domain to be tested. The domain should not be already delegated in the DNS.

### Ordered description of steps to be taken to execute the test case

1. Zonemaster CLI is used to verify an invalid domain
2. If the query don’t receive an RCODE NXDOMAIN, the test returns FAIL


### Appendix
```
zonemaster-cli afnics.fr
Seconds Level     Message
======= ========= =======
   1.17 CRITICAL  Nameserver for zone fr responded with NXDOMAIN to query for
glue.
   1.17 CRITICAL  Not enough data about afnics.fr was found to be able to run
tests.
```
