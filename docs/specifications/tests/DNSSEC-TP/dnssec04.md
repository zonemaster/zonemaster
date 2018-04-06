## DNSSEC04: Check for too short or too long RRSIG lifetimes

### Test case identifier
**DNSSEC04** Check for too short or too long RRSIG lifetimes

### Objective

Having RRSIG signature lifetimes last for too long opens up for DNS replay
attacks. Having too short RRSIG signature lifetimes is likely to have
a major operational impact if the master name server is down for that long.

There is no clear recommendation of the exact validity periods to use with
DNSSEC. Shorter validity than 12 hours until expiration will give a serious
operational problem just in case of temporary network problems, and longer
than 180 days will create wide open holes for replay attacks.

The considerations are described in [RFC6781](
https://tools.ietf.org/html/rfc6781).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain a set of name server IP addresses using [Method4] and [Method5].
2. Create a DNSKEY query with DO flag set for the apex of the child zone.
3. Create a SOA query with DO flag set for the apex of the child zone.
4. Send the DNSKEY query over UDP to one of the name server IP addresses.
5. Send the SOA query over UDP to one of the name server IP addresses.
6. If any RRSIG validity is found where the expiration time already has
   passed, this test case fails.
7. If any RRSIG validity time is shorter than 12 hours (from "now"),
   this test case fails.
8. If any RRSIG validity time is longer than 180 days (from "now"), this
   test fails.
9. If any RRSIG validity from inception to expiration is longer than 180
   days, this test case fails.

### Outcome(s)

If any of the signature expirations time is either shorter than 12 hours or
longer than 180 days, this test case fails.

### Special procedural requirements

Test case is only performed if RRSIG RRs are found in the answers.

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
