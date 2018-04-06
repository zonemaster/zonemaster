## DNSSEC05: Check for invalid DNSKEY algorithms

### Test case identifier
**DNSSEC05** Check for invalid DNSKEY algorithms

### Objective

The domain should only use DNSKEY algorithms that are defined by IANA.

The DNSKEY record is described in section 2 of [RFC 4034](
https://tools.ietf.org/html/rfc4034#section-2).

The IANA registry of DNSKEY algorithm numbers is in the [dns-sec-alg-numbers](
https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain a set of name server IP addresses using [Method4] and [Method5].
2. Create a DNSKEY query with DO flag set for the apex of the the zone.
3. Send the DNSKEY query over UDP to one the name server IP addresses.
4. The DNSKEY algorithm numbers are derived from all the DNSKEY RRs.
5. The algorithm numbers are matched with the IANA DNSKEY algorithm table.
6. If any the algorithm numbers is unassigned, reserved, a private algorithm
   or deprecated, this test case fails.

### Outcome(s)

If any DNSKEY algorithm number is unassigned, reserved, a private algorithm
or deprecated, this test case fails.

### Special procedural requirements

See the [level document](README.md) about DNSSEC algorithms.

Test case is only performed if DNSKEY records are found.

### Intercase dependencies

None.

-------
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
