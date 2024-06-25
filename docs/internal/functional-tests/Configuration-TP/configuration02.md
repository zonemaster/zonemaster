## CONFIGURATION02: Cyclic Zone Dependency
different

### Test case identifier

**CONFIGURATION02:** Cyclic Zone Dependency

### Objective 
A cyclic zone dependency happens when two or more zones DNS service depends on
each other in a circular way. This scenario is possible due to configuration
errors in either or both of the zones; however in some cases it is also possible
when none of the involved zones has any noticeable configuration error. Thus the
combination of two or more correctly configured zones may also result in cyclic
zone dependency.

The objective here is to verify whether the engine identifies such a dependency.


### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure live zone(s) with cyclic dependencies

```
configuration02-z1.zft-root.rd.nic.fr.
```
2. A standard query for the domain is made
3. If the query don’t receive Error response, the test returns with FAIL

### Results
Verifying the zone with zonemaster CLI does not provide any conclusive errors as
you could see from the appendix

### Appendix
```
zonemaster-cli configuration02-z1.zft-root.rd.nic.fr.
Seconds Level     Message
======= ========= =======
 113.63 NOTICE    Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond to NS
query.
 113.64 NOTICE    Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond to NS
query.
 119.90 NOTICE    Nameserver dns1.configuration02-z1.zft-root.rd.nic.fr has an
IP address (178.33.232.188) with mismatched PTR result
(ns324830.ip-178-33-232.eu.).
 119.90 NOTICE    Nameserver dns2.configuration02-z1.zft-root.rd.nic.fr has an
IP address (46.105.116.200) with mismatched PTR result
(ns334987.ip-46-105-116.eu.).
 119.90 ERROR     Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 not accessible over
UDP on port 53.
 119.94 ERROR     Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 not accessible over
TCP on port 53.
 120.45 WARNING   All nameservers are in the same AS (16276).
 120.45 WARNING   All nameservers IPv4 addresses are in the same AS (16276).
 120.46 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.46 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.47 WARNING   Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 did not respond.
 120.48 NOTICE    176.31.226.223 returned no DS records for
configuration02-z1.zft-root.rd.nic.fr.
 120.49 NOTICE    IP 178.33.232.188 refers to multiple nameservers
(dns1.configuration02-z1.zft-root.rd.nic.fr;ns1.configuration02-z2.zft-root.rd.nic.fr).
 120.49 NOTICE    IP 46.105.116.200 refers to multiple nameservers
(dns2.configuration02-z1.zft-root.rd.nic.fr;ns2.configuration02-z2.zft-root.rd.nic.fr).
 120.52 WARNING   Nameserver dns2.configuration02-z1.zft-root.rd.nic.fr response
is not authoritative on UDP port 53.
 120.53 WARNING   Nameserver dns2.configuration02-z1.zft-root.rd.nic.fr response
is not authoritative on TCP port 53.
 120.53 WARNING   Nameserver ns2.configuration02-z2.zft-root.rd.nic.fr response
is not authoritative on UDP port 53.
 120.53 WARNING   Nameserver ns2.configuration02-z2.zft-root.rd.nic.fr response
is not authoritative on TCP port 53.
 150.68 NOTICE    Nameserver
dns2.configuration02-z1.zft-root.rd.nic.fr/46.105.116.200 dropped AAAA query.
 150.68 NOTICE    Nameserver
ns2.configuration02-z2.zft-root.rd.nic.fr/46.105.116.200 dropped AAAA query. 
