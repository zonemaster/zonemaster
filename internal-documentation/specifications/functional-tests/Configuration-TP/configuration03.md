## CONFIGURATION03: Lame Delegation 

### Test case identifier

**CONFIGURATION03:** Lame delegation

### Objective 

Lame delegation errors happen when a name server that is registered in the DNS
system as authoritative for a zone does not provide authoritative answers for
the zone.


### Inputs

The domain to be tested.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure live zone(s) with lame delegation

```
zft-sandoche.rd.nic.fr
```
2. A standard query for the domain is made
3. If the query don’t receive Error response, the test returns with FAIL

### Results
Verifying the zone with zonemaster CLI does provide conclusive errors as
you could see from the appendix

### Appendix
```
zonemaster-cli zft-sandoche.rd.nic.fr
Seconds Level     Message
======= ========= =======
  10.18 NOTICE    Nameserver ns2.rd.nic.fr has an IP address (192.134.4.81) with
mismatched PTR result (lea.rd.nic.fr.).
  10.18 NOTICE    Nameserver ns2.rd.nic.fr has an IP address
(2001:67c:2218:3::1:7) with mismatched PTR result (dalila.rd.nic.fr.).
  12.12 WARNING   All nameservers IPv6 addresses are in the same AS (2485).
  12.15 NOTICE    192.134.4.81 returned no DS records for
zft-sandoche.rd.nic.fr.
  12.16 WARNING   Nameserver ns2.rd.nic.fr response is not authoritative on UDP
port 53.
  12.16 WARNING   Nameserver ns2.rd.nic.fr response is not authoritative on TCP
port 53.
  12.17 ERROR     A SOA query NOERROR response from ns2.rd.nic.fr was received
empty.
  12.91 NOTICE    SOA 'refresh' value (3600) is less than the recommended one
(14400).
  12.92 NOTICE    SOA 'retry' value (1800) is less than the recommended one
(3600).
  13.56 NOTICE    No target (MX, A or AAAA record) to deliver e-mail for the
domain name.
