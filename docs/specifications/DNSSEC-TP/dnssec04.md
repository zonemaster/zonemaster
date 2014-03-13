## DNSSEC04: Check for too short or too long RRSIG lifetimes

### Test case identifier
**DNSSEC04** Check for too short or too long RRSIG lifetimes

### Objective

Having RRSIG signature lifetimes last for too long opens up for DNS replay
attacks. By having too short RRSIG signature lifetimes is likely to have
a major operational impact if the master name server is down for that long.

There is no clear recommendation of the exact validity perionds to use with
DNSSEC. Shorter validity than 12 hours will give a serious operational
problem just in case of temporary network problems, and longer than 180
days will create wide open holes for replay attacks.

The considerations are described in [RFC6781]
(http://wiki.tools.ietf.org/html/rfc6781).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the DNSKEY RR set from the child zone, including RRSIG.
2. Retrieve the SOA RR set from the child zone, including RRSIG.
3. If any RRSIG validity time is shorter than 12 hours (from "now"),
   this test case emits a warning.
4. If any RRSIG validity time is longer than 180 days (from "now"), this
   test case emits a warning.

### Outcome(s)

If any of the signature expirations time is either shorter than 12 hours or
longer than 180 days, this test case emits warning(s).

### Special procedural requirements

Test case is only performed if RRSIG RRs are found in the answers.

### Intercase dependencies

None.
