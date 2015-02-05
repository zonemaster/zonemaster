## DNSSEC01: Legal values for the DS hash digest algorithm

### Test case identifier
**DNSSEC01** Legal values for the DS hash digest algorithm

### Objective

The allowed Digest Algorithms in a DS record published by the parent are
published by IANA in [Delegation Signer (DS) Resource Record (RR) Type
Digest Algorithms](https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xml).
No other DS Digest Algorithm values other than those allocated by IANA
should be published in DNS.

The use of the DS RR type is described in section 2.4 of
[RFC 4035](https://tools.ietf.org/html/rfc4035#section-2.4), and the exact
definition of the DS RR type is in
[RFC3658](https://tools.ietf.org/html/rfc3658).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the DS RR set from the parent zone.
2. From the DS RRs, extract the Digest type values.
3. If any value from the Digest type is not included in the IANA table
   (currently values 1 to 4 are valid), this test case fails.

### Outcome(s)

If any of the Digest type values from the DS RR set published in the parent
zone are not assigned by IANA, this test case fails.

### Special procedural requirements

Test case is only performed if DS records are found.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
