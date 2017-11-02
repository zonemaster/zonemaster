## DNSSEC09: RRSIG(SOA) must be valid and created by a valid DNSKEY

### Test case identifier
**DNSSEC09** RRSIG(SOA) must be valid and created by a valid DNSKEY

### Objective

If the zone is signed, the SOA RR should be signed with a valid RRSIG 
using a DNSKEY from the DNSKEY RR set. This is use signatures isdescribed
in section 2.2 of
[RFC 4035](https://tools.ietf.org/html/rfc4035#section-2.2).

(In reality the RRSIG should be created by the DNSKEY matching the DS. All
algorithms from the DS should have a matching DNSKEY with those algorithms,
and all DNSKEY algorithms should have matching RRSIG with those algorithms.
Postponed for future tests. See future tests in the requirements document.)

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA RR set from the child zone.
2. Retrieve the RRSIGs from the answer.
3. Match the RRSIGs with the SOA RR, and check the inception and
   expiration times and compare them with the current time.
4. If the RRSIGs validates the SOA RR, and the RRSIG is within the
   validity period this test case pass.
5. If any of the RRSIGs does not validate the SOA RR, this test
   case fails.

### Outcome(s)

If all RRSIG validates the SOA RR, this test case pass.

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
