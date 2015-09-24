## DNSSEC11: Delegation from parent to child is properly signed

### Test case identifier
**DNSSEC11** Delegation from parent to child is properly signed

### Objective

The delegation step from the parent zone to the child zone is vitally
important. Securing this step with DNSSEC involves several separate
steps. Most of these individual steps are tested in other tests
(specifically [DNSSEC02](dnssec02.md), [DNSSEC06](dnssec06.md),
[DNSSEC07](dnssec07.md) and [DNSSEC08](dnssec08.md)). This test
adds a check that the DNSKEY signing the apex DNSKEY RRset is the one
that has a matching DS record at the parent, and verifies the delegation
step as a whole.

Section 5 in [RFC 4035](https://tools.ietf.org/html/rfc4035) describes
how a resolver authenticates DNS responses with DNSSEC.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. The DS RRset for the zone is fetched from the parent.
2. If no DS record is found, the test fails.
3. The apex DNSKEY RRset is fetched from the zone.
4. If no apex DNSKEY is found, the test fails.
5. If no RRSIG records are included with the DNSKEY RRset, the test fails.
6. If no DS record matching a DNSKEY record can be found, the test fails.
7. If no RRSIG records were made with a DNSKEY matching a DS, the test fails.
8. If the relevant RRSIG records do not contain a valid signature of the apex
   DNSKEY RRset using the given DNSKEY record, or if they are outside of
   their validity period, the test fails.
9. Otherwise, that is if there is a DS record that matches a DNSKEY record
   that correctly signs the apex DNSKEY RRset, the test succeeds.

### Outcome(s)

If there is a DS record that matches a DNSKEY record that correctly signs the
apex DNSKEY RRset, the test case passes.

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
