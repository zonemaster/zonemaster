## BEHAVIOR09: Appropriate error code when the zone is misconfigured

### Test case identifier

**BEHAVIOR09:** Appropriate error code when the zone is misconfigured

### Objective 

The objective of this test is to verify that the engine catches the zone
mis-configurations appropriately

### Inputs

The broken domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. A standard query for the domain is made using the zonemaster CLI
2. If the output from the CLI does not catch the expected errors, then the test
returns FAIL

### Results
Even though exhaustive tests are not run, for the tests being run the eingine
seems to capture the errors.


### Appendix
``` 
zonemaster-cli broken.dnssec.ee
Seconds Level     Message
======= ========= =======
   6.12 WARNING   All nameservers are in the same AS (51349).
   6.12 WARNING   All nameservers IPv4 addresses are in the same AS (51349).
   6.23 ERROR     DS record with keytag 57307 does not match the DNSKEY with the
same tag.
   6.24 ERROR     No DS record with a matching DNSKEY record was found.
   6.34 ERROR     RRSIG with keytag 57307 and covering type(s) DNSKEY has
already expired (expiration is: 1393471638).
   6.34 ERROR     RRSIG with keytag 48381 and covering type(s) SOA has already
expired (expiration is: 1393882163).
   6.41 ERROR     Signature for DNSKEY with tag 57307 failed to verify with
error 'Bogus DNSSEC signature'.
   6.41 ERROR     The apex DNSKEY RRset was not correctly signed.
   6.41 ERROR     Trying to verify SOA RRset with signature 48381 gave error
'Bogus DNSSEC signature'.
   6.41 ERROR     No RRSIG correctly signed the SOA RRset.
   6.47 ERROR     Trying to verify NSEC3 RRset with RRSIG 48381 gave error
'Bogus DNSSEC signature'.
   7.33 NOTICE    SOA 'refresh' value (10800) is less than the recommended one
(14400).

``` 


