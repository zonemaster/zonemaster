## NAMESERVER02: Test of EDNS0 support

### Test case identifier
**NAMESERVER02** Test of EDNS0 support

### Objective

EDNS(0) is a mechanism to announce capabilities of a DNS implementation,
and is now basically required by any new functionality in DNS such as
DNSSEC.
Initially standardized in [RFC 2671](http://tools.ietf.org/search/rfc2671)
and later updated by [RFC 6891](http://tools.ietf.org/search/rfc6891),
EDNS(0) is a mechanism to announce capabilities of a DNS implementation.
This test case checks that all name servers has the capability to do
EDNS(0).

Servers not implementing EDNS(0) returns FORMERR:

> Responders that choose not to implement the protocol extensions
> defined in this document MUST respond with a return code (RCODE) of
> FORMERR to messages containing an OPT record in the additional
> section and MUST NOT include an OPT record in the response.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Find all hostnames for all the name servers used by the domain.
   (This is all the name servers from the parent delegation, and all the
   name servers in the apex of the zone itself.)
2. Send a DNS query to each name server IP address querying the SOA record
   of the domain name with the DO bit set and a payload size ("bufsize")
   set to 512.
3. If any answer from step 2 contains a FORMERR RCODE this test case fails.

### Outcome(s)

If any name server returns FORMERR for a query using EDNS(0), this test
case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
