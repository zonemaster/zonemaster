## DELEGATION05: Test whether there is an authoritative ANSWER for the name server

### Test case identifier

**DELEGATION05:** Test whether there is an authoritative ANSWER for the name server 

### Objective

Subsection 6.1 of [RFC 2181](http://tools.ietf.org/html/rfc2181) specifies
that the nameservers must answer authoritatively for the designated zone.
Responses to queries to the name servers for the designated zone must have
the "AA" bit set

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
2. All name servers obtained as the result of step 1 are queried for the SOA
record over TCP and UDP
3. If any of the name server fail to give an authoritative answer ("AA-bit"
is set in the answer), the test fails

### Outcome(s)

If all the name servers answer with the AA-bit set, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
