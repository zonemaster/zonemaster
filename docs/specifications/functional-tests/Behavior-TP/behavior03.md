## BEHAVIOR03: The behavior of the engine when IPv6 or IPv4 is disabled

### Test case identifier

**BEHAVIOR03:** The behavior of the engine when IPv6 or IPv4 is disabled

### Objective 
This test is to verify whether appropriate results are displayed when
querying a domain name from the CLI with IPv6 or IPv4 disabled.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. A valid domain is verified using Zonemaster CLI
2. If the query don’t receive a CRITICAL or ERROR notice, the test returns PASS


### Appendix
```
zonemaster-cli --no-ipv6 afnic.fr
Seconds Level     Message
======= ========= =======
   2.30 NOTICE    IPv6 is disabled, not sending "NS" query to
ns1.nic.fr/2001:660:3003:2::4:1.
   2.30 NOTICE    IPv6 is disabled, not sending "NS" query to
ns2.nic.fr/2001:660:3005:1::1:2.
   2.31 NOTICE    IPv6 is disabled, not sending "NS" query to
ns3.nic.fr/2001:660:3006:1::1:1.
   7.65 NOTICE    SOA 'mname' nameserver (dnsmaster.nic.fr) is not listed in
"parent" NS records for tested zone (ns1.nic.fr;ns2.nic.fr;ns3.nic.fr).
   7.65 NOTICE    SOA 'refresh' value (7200) is less than the recommended one
(14400).
   7.65 NOTICE    SOA 'retry' value (1800) is less than the recommended one
(3600).

```
