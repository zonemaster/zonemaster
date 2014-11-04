## BEHAVIOR06: Timestamps on the test being run 

### Test case identifier

**BEHAVIOR06:** Timestamps on the test being run

### Objective 
This test is to verify whether the engine displays timestamps on the test being
run

### Inputs

The domain to be tested. The domain should not be already delegated in the DNS.

### Ordered description of steps to be taken to execute the test case

1. A valid domain is verified using Zonemaster CLI with appropriate options as
see in the appendix
2. If the query don’t show timestamp on each test run,  the test returns FAIL


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
