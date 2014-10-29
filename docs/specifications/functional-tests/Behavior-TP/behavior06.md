## BEHAVIOR06: Able to test un delegated domains
displayed

### Test case identifier

**BEHAVIOR07:** Able to test un delegated domains

### Objective 

Testing un-delegated domains is a functionality that is available both in ZC and
DC. 

Ths objective of this test is to verify whether ZM is having this functionality.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. A standard query for the domain is made with appropriate NS and IP as inputs. 
a. A delegated domain, but with NS/IP as inputs
```
zonemaster-cli --ns i.ns.se/194.146.106.22 --ns
i.ns.se/2001:67c:1010:5::53 --ns ns.nic.se/212.247.7.228 --ns
ns.nic.se/2a00:801:f0:53::53 --ns ns3.nic.se/212.247.8.152 --ns
ns3.nic.se/2a00:801:f0:211::152 iis.se
```
b. An un-delegated domain with NS/IP as inputs
```
zonemaster-cli motounit.de --ns sdns2.ovh.net/213.251.188.141 --ns
ns3000952.ovh.net/37.59.47.185
```

2. If the output from the CLI does not contain appropriate results for each test being run,
then the test fails 

### Outcome(s)

If the test returns FAIL, then the engine does not provide the functionality of
testing un-delegated domains

