## DNSSEC07: If DNSKEY at child, parent should have DS

### Test case identifier
**DNSSEC07** If DNSKEY at child, parent should have DS

### Objective

If the child zone have a DNSKEY published, the intent may be to have a
secure chain up to the root. If there is no DS record published at the
parent zone, this might be a configuration error.

The method for authentication a DNS response is described in section 5 of
[RFC 4035](https://tools.ietf.org/html/rfc4035#section-5). The DS record
is described in section 5 of [RFC 4034](
https://tools.ietf.org/html/rfc4034#section-5) and the DNSKEY record is
described in section 2 of [RFC 4034](
https://tools.ietf.org/html/rfc4034#section-2).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the DNSKEY RR set from the child zone.
2. Retrieve the DS RR set from the parent zone.
3. Issue a warning if there is a DNSKEY in the child zone and no DS in the parent zone.

### Outcome(s)

A warning is issued there is a DNSKEY present in the child zone, and there
is no DS record present in the parent zone.

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
