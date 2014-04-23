## NAMESERVER04: Same source address

### Test case identifier
**NAMESERVER04** Same source address

### Objective

Responses from the authoritative name servers must contain same source IP
address as the destination IP address of the initial query. This has been
clarified in section 4 of
[RFC 2181](https://tools.ietf.org/html/rfc2181#section-4).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers for the domain using [Method 2]
   (../Methods.md#method-2-obtain-name-servers-from-parent) and [Method 3]
   (../Methods.md#method-3-obtain-name-servers-from-child).

2. A SOA query for the domain name sent to the each name server found in
   step 1.
3. Any answer received from the SOA query must come from the same source IP address
   as the query was sent to. If there is a mismatch, this test case fails.

### Outcome(s)

If any response comes from another IP address than the query was sent to,
this test case fails.

### Special procedural requirements

If there are many authoritative DNS nodes behind the IP adress the query
is sent to, there could be multiple answers with possibly different source
addresses for the query. This special case is currently ignored.

### Intercase dependencies

None.
