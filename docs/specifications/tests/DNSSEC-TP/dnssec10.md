## DNSSEC10: Zone contains NSEC or NSEC3 records

### Test case identifier
**DNSSEC10** Zone contains NSEC or NSEC3 records

### Objective

Using DNSSEC, having NSEC or NSEC3 records provides a secure denial of
existence for records that is not present in the zone. This test case
verifies that correct NSEC or NSEC3 records with valid signatures are
returned for a query for an non-existent name, and that they cover the
queried name.

The use of the NSEC RR type is described in section 3.1.3 of
[RFC 4035](https://tools.ietf.org/html/rfc4035#section-3.1.3), and
the description of the NSEC RR itself is in section 4 of
[RFC 4034](https://tools.ietf.org/html/rfc4034#section-4).

The description of the NSEC3 RR is in section 3 of
[RFC 5155](https://tools.ietf.org/html/rfc5155#section-3), and its
use in the DNS response is described in section 7.2 of
[RFC 5155](https://tools.ietf.org/html/rfc5155#section-7.2).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. A query is made asking for the A RR with the qname xx--example.[domain].
2. If the answer does not have RCODE NOERROR or NXDOMAIN, the test ends.
3. If the answer does not contain an NSEC or NSEC3 RR in the Authority section, this test case fails.
4. The NSEC or NSEC3 RR returned must cover the qname, if they do not, this test case fails.
5. The NSEC or NSEC3 RRs must have valid RRSIGs. Match against DNSKEY and check that the RRSIG is within the validity period.
6. If the RRSIG(s) over the NSEC or NSEC3 RRs does not validate, this test case fails.

### Outcome(s)

If the answer contains NSEC or NSEC3 records that covers the qname, and the RRs
also have valid RRSIGs, this test case passes.

### Special procedural requirements

None.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
