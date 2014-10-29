## BEHAVIOR09: IDN Verification 

### Test case identifier

**BEHAVIOR07:** IDN Verification 

### Objective 

The objective of this test is to verify the engine verfies IDN domains

### Inputs

The IDN domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. A standard query for the domain is made using the zonemaster CLI
2. If the output from the CLI does not verify the IDN domain as in the case of
normal domain names, then the test fails 

### Outcome(s)

If the test returns FAIL, then the engine is not capable of verifying IDN 2.0
domains

### Results
``` 
zonemaster-cli café.fr
Seconds Level     Message
======= ========= =======
  25.67 WARNING   All nameservers are in the same AS (16509).
  25.67 WARNING   All nameservers IPv4 addresses are in the same AS (16509).
  25.70 NOTICE    192.5.4.2 returned no DS records for xn--caf-dma.fr.


