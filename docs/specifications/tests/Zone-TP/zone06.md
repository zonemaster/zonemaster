## ZONE06: SOA 'minimum' maximum value

### Test case identifier
**ZONE06** SOA 'minimum' maximum value

### Objective

The SOA minimum field sets the default TTL for all records in a zone.
The recommended value is to be "cache-friendly". However, for a zone
that changes content often, there is a need to keep the TTL values
shorter. The use of the SOA minimum value today is the negative cache
(where a resolver find content is missing).

The SOA minimum field is described in section 3.3.13 in
[RFC 1035](https://tools.ietf.org/html/rfc1035), and clarified in
section 2.2 of [RFC 1912](https://tools.ietf.org/html/rfc1912).
The description of the implementation of negative caching is in
[RFC 2308](https://tools.ietf.org/html/rfc2308) (although it has been
updated by several DNSSEC related RFCs, it is still relevant for this
purpose).

The [RIPE-203](https://www.ripe.net/ripe/docs/ripe-203) recommendation
for the minimum value 2 days, but the negative caching is now the norm.
DNSCheck has a recommended value of between 300 seconds (5 minutes) and
86400 seconds (1 day).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from a delegated name server for the domain.
2. If the answer from step 1 is not authoritative, iterate step 1 until there is an authoritative answer.
3. Retrieve the SOA minimum value from the SOA record.
4. If the minimum value is larger than 86400 seconds (1 day), this test
   case fails.
5. If the minimum value is lower than 300 seconds (5 minutes), this test case
   fails.

### Outcome(s)

If the minimum value is larger than 86400 seconds or if the minimum value is
lower than 300 seconds, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
