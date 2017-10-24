## NAMESERVER07:  To check whether authoritative name servers return an upward referral

### Test case identifier
NAMESERVER07 To check whether authoritative name servers return an upward
referral


### Objective
The configuration and/or implementation of some authoritative name servers
causes them to return an upward referral to the root zone. There are proofs that
such a [behaviour could be used for DDoS attacks] (https://www.dns-oarc.net/oarc/articles/upward-referrals-considered-harmful)


### Inputs
The domain name to be tested.

### Ordered description of steps to be taken to execute the test case
1. If the input domain to be tested is the root, exit from the test.
2. Retrieve all address records for all the name servers using [Method 
   4](../Methods.md) and [Method 5](../Methods.md).
3. An NS query is sent to each name server IP address found in step 2,
   with the root “.” as the destination 
4. If any of the query returns with one or more responses in the
   authority section, then this test case fails.

### Outcome(s)
The test case is Ok only if there are no responses in the authority section 

### Special procedural requirements
None.

### Intercase dependencies
None.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure
Foundation) Copyright (c) 2013, 2014, 2015, AFNIC Creative Commons Attribution
4.0 International License

You should have received a copy of the license along with this work. If not,
seehttps://creativecommons.org/licenses/by/4.0/.

