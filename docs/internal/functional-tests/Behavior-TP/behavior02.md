## BEHAVIOR02: NODATA returned in response in the event of querying a domain name that exists but no relevant answers in the answer section

### Test case identifier

**BEHAVIOR02:** NODATA returned in response in the event of querying a 
domain name that exist but no relevant answers in the answer section

### Objective 
Section 1 of [RFC 2308](https://datatracker.ietf.org/doc/html/rfc2308) mentions that
"NODATA" is a pseudo RCODE. "NODATA" indicates that there are RRs for the requested
domain name, but none of them match the record type queried.

"NODATA" is indicated by an answer with RCODE set to "NOERROR" (defined in RFC
[RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035)) and no relevant answers in the
answer section.

This test is to verify whether the engine responds with NODATA when
querying a domain name that exists, but the queried record type does not exist.

### Inputs

The domain to be tested. The domain should be already delegated in the DNS, but
should not contain delegation RRs or the queried RRs

### Results
Verifying a domain such as "gouv.fr" which does not have delegation RRs results
in expected results as you can see from the appendix.


### Appendix
```
zonemaster-cli gouv.fr
Seconds Level     Message
======= ========= =======
   1.16 CRITICAL  Nameservers for "fr" provided no NS records for tested zone.
RCODE given was NOERROR.
   1.16 CRITICAL  Not enough data about gouv.fr was found to be able to run
tests.
```
