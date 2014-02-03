## DELEGATION06: Test whether there is an authoritative ANSWER for the nameserver (RFC 2181 [subsection 6.1])

### Test case identifier
**DELEGATION06:** Test whether there is an authoritative ANSWER for the nameserver 

### Objective
Subsection 6.1 of [RFC 2181](http://tools.ietf.org/html/rfc2181) specifies that the nameservers must answer authoritatively for the designated zone. Responses to queries to the name servers for the designated zone must have the "AA" bit set

### Inputs
1. The FQDN of the authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. All name servers listed are queried for the SOA record over TCP and UDP
2. If any of the name server fail to give an authoritative answer ("AA-bit" is set in the answer), the test fails


### Outcome(s)
If all the listed name servers answer with the AA-bit set, then the test succeeds

### Special procedural requirements
None

### Intercase dependencies
None
