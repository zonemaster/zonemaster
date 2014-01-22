## DELEGATION04: Test whether referral response fit into a 512 byte UDP packet

### Test case identifier
**DELEGATION04:** Test whether referral response fit into a 512 byt
e UDP packet

### Objective
Referral response from the zone's name servers must fit into a 512 byte UDP packet.

### Inputs
1. The FQDN of the authoritative name servers
2. All IPv4 or IPv6 address for the authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. An empty DNS answer packet is generated. 
2. All the data from the input is added to the packet. 
3. If the size of the packet is more than 512 bytes, then the test fails

### Outcome(s)
If the created packet fits into 512 byte UDP packet, then the test succeeds

### Special procedural requirements
None

### Intercase dependencies
None
