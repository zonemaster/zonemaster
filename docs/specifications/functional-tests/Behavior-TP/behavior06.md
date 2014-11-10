## BEHAVIOR06: Timestamps display

### Test case identifier

**BEHAVIOR06:** Timestamps display

### Objective 
This test is to verify whether the engine displays timestamps on the test being
run

### Inputs

The domain to be tested. 

### Ordered description of steps to be taken to execute the test case

1. A valid domain is verified using Zonemaster CLI with appropriate options as
see in the appendix
2. If the query don’t show timestamp in the results,  the test returns FAIL

### Results

### Appendix
```
zonemaster-cli --time afnic.fr
Seconds Level     Message
======= ========= =======
  17.89 NOTICE    SOA 'mname' nameserver (dnsmaster.nic.fr) is not listed in
"parent" NS records for tested zone (ns1.nic.fr;ns2.nic.fr;ns3.nic.fr).
  17.90 NOTICE    SOA 'refresh' value (7200) is less than the recommended one
(14400).
  17.90 NOTICE    SOA 'retry' value (1800) is less than the recommended one
(3600).
sandoche@eryx:~$ zonemaster-cli afnic.fr
Seconds Level     Message
======= ========= =======
   8.16 NOTICE    SOA 'mname' nameserver (dnsmaster.nic.fr) is not listed in
"parent" NS records for tested zone (ns1.nic.fr;ns2.nic.fr;ns3.nic.fr).
   8.16 NOTICE    SOA 'refresh' value (7200) is less than the recommended one
(14400).
   8.17 NOTICE    SOA 'retry' value (1800) is less than the recommended one
(3600).
```
