## NAMESERVER08: Testing QNAME case insensitivity

### Test case identifier
NAMESERVER08 Verify whether the authoritative nameserver returns same results
for equivalent names with different cases in the request.


### Objective
There has been cases where the nameservers respond with complete case-sensitivity (in violation of the DNS standards): that is, they match the exact case of the name in the response; but
return different results for equivalent names with different cases in the
request (typically NXDOMAIN).



### Inputs
The domain name to be tested.

### Ordered description of steps to be taken to execute the test case
1. Find all hostnames for all the name servers used for the domain
using [Method 2](../Methods.md#method-2-obtain-name-servers-from-parent) and
[Method 3](../Methods.md#method-3-obtain-name-servers-from-child)
2. Different queries for the same FQDN with mixed cases (e.g. Www.iETF.oRG,
www.ietf.org, WWW.IETF.ORG) are sent to each of the name server found in step 1.
3. Verify that all queries in step 2 return exact results.
4. If all the results in step 3 are not same, the test case fails.

### Outcome(s)
The test case passes only if the results of all queries are exactly the same. 

### Special procedural requirements
None.

### Intercase dependencies
None.

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure
Foundation) Copyright (c) 2013, 2014, 2015, AFNIC Creative Commons Attribution
4.0 International License

You should have received a copy of the license along with this work. If not,
seehttp://creativecommons.org/licenses/by/4.0/.

