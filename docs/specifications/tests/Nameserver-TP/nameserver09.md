## NAMESERVER09: Testing QNAME case sensitivity

### Test case identifier
NAMESERVER09 Verify whether the authoritative nameserver returns same results
for equivalent names with different cases in the request.


### Objective
There has been cases where the nameservers respond with complete
case-sensitivity (in violation of the DNS standards): that is, they match the
exact case of the name in the response; but return different results for
equivalent names with different cases in the request (typically NXDOMAIN). 


### Inputs
The domain name to be tested.

### Ordered description of steps to be taken to execute the test case
1. Retrieve all address records for all the name servers using [Method 
   4](../Methods.md) and [Method 5](../Methods.md).
2. Send a query with the input string in a mixed case (e.g. wWW.iETF.oRG) to
   each of the name server IP address found in step 1. 
3. If the "answer" flag is greater than 0, remember the "answer" section, else
   remember the status flag. 
4. Send another query with an alternative mixed case (e.g. Www.Ietf.Org) to each
   of the name server found in step 1.
5. If the "answer" flag is greater than 0, remember the "answer" section, else
   remember the status flag. 
6. Compare the results remembered in step3 and step5.
7. If the results in step 6 are not equal, the test case fails.

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

