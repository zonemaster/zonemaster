## NAMESERVER05: Behaviour against AAAA query

### Test case identifier
**NAMESERVER02** Behaviour against AAAA query

### Objective

Older implementations of authoritative name servers have shown different
misbehaviours trying to answer queries for AAAA records, as described in
[RFC 4074](https://tools.ietf.org/html/rfc4074). This test case is intended
to find out if the name server authoritative for the domain shows any of
these behaviours.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve all address records for all the name servers using
   [Method 4](../Methods.md#method-4-obtain-glue-address-records-from-parent) and
   [Method 5](../Methods.md##method-5-obtain-the-name-server-address-records-from-child),
   and do recursive lookups for the name servers that are out of bailiwick.
2. Send a DNS query to each name server IP address querying the AAAA record
   of the domain name.
3. If all of the answers displays the correct behaviour of either returning
   an AAAA record in the answer section and the RCODE NOERROR, or if the
   RCODE is NOERROR and the answer section is empty (as detailed in section 3,
   "Expected behaviour" of RFC 4074), this test case passes and there is no
   need for further execution of the test case.
4. If there is no answer from any of the name servers (the query is "dropped"),
   as described in section 4.1 of RFC 4074, this test case fails.
5. As described in section 4.2 and 4.3 of RFC 4074, if the answer has the
   RCODE 3 "Name Error", RCODE 4 "Not Implemented" or RCODE 2 "Server Failure"
   or RCODE 1 "Format Error", this test case fails.
6. If the answer contains an RDATA with 4 bytes this indicates a broken
   response as described in section 4.4 of RFC 4074, this test case fails.

### Outcome(s)

If there is any problem answering the AAAA query, this test case fails.

### Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of
the result of any test using this transport protocol. Log a message
reporting on the ignored result.

### Intercase dependencies

None.
