## BEHAVIOR05: Capable of running the test when the delegation parameters are specified

### Test case identifier

**BEHAVIOR05:** Capable of running the test when the delegation parameters arie specified

### Objective 
This test is to verify whether the engine is capable of running an undelegated
test

### Inputs

The domain to be tested with NS and IP addresses. It could be either a delegated
or un delegated domain

### Ordered description of steps to be taken to execute the test case

1. A valid domain is verified using Zonemaster CLI with appropriate options as
seen in the appendix
2. If the query don’t receive a CRITICAL or ERROR notice, the test returns PASS


### Appendix
```
zonemaster-cli iis.se  --ns i.ns.se/194.146.106.22 --ns
i.ns.se/2001:67c:1010:5::53 --ns ns.nic.se/212.247.7.228 --ns
ns.nic.se/2a00:801:f0:53::53 --ns ns3.nic.se/212.247.8.152 --ns
ns3.nic.se/2a00:801:f0:211::152  IIS.SE
Seconds Level     Message
======= ========= =======
   6.20 WARNING   Nameserver ns3.nic.se has an IP address (212.247.8.152)
without PTR configured.
  10.45 NOTICE    192.36.144.107 returned no DS records for iis.se.
  11.51 NOTICE    SOA 'refresh' value (10800) is less than the recommended one
(14400).

```
