## DELEGATION06: Existence of SOA

### Test case identifier

**DELEGATION06:** Existence of SOA

### Objective

Section 6.1 of the [RFC 2182](http://tools.ietf.org/html/rfc2182) specifies
that the SOA record is mandatory for every zone. 

This test is intended to verify the prescence of a SOA record for the
domain.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. Query for the SOA record.
3. If there is an answer with NOERROR and there is no content in the
   answer section, this test case fails.

### Outcome(s)

If there is a SOA record present for the domain this test case succeeds.

### Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
