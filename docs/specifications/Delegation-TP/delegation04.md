## DELEGATION04: Test whether the referrals response at the authoritative and additional section fit into 512 byte UDP packet

### Test case identifier

**DELEGATION04:** Test whether the referrals response at the authoritative and additional section fit into 512 byte UDP packet

### Objective

The Domain Name System defaults to using UDP for queries and replies with a DNS payload limit of 512 bytes.  Larger replies cause an initial truncation indication leading to a subsequent handling via TCP with substantially higher overhead.  EDNS0 is used to permits larger UDP responses thus reducing the need for use of TCP.

But [IANA](https://www.iana.org/help/nameserver-requirements) still maintai
ns that referrals from the parent zonne name servers must fit into a non-ED
NS0 UDP DNS packet. Hence this test is done.

In this test, the authoritaitve and additional section of the referral response from the domain must fit into a 512 byte UDP packet.

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of authoritative name servers for the domain
1.1 A recursive NS-record lookup for the domain name starting at the root domain should be done, and the steps of the process recorded <br/>
1.2 If the recursion reaches a name server that responds with a redirect directly to the requested domain, then the domain through which the name server was found is considered the parent domain <br/>
1.3 Send a query to the parent domain asking for the list of name server authoritative for the domain that is being tested <br/>
1.4 Record the list of name servers obtained from the authority section <br/>
1.5 A NS query is made to all listed name servers obtained from step 1.4 for the domain <br/>
1.6 Record the list of name servers in the answer <br/>
1.7  Send a query to the domain asking for the list of authoritative name servers <br/>
1.8 Record the list of authoritative name servers in the answer <br/>
2. Find the IP addresses corresponding to the list of name servers obtained in step1. In order to do that: <br/>
2.1 send an A query to all distinct name servers obtained in step 1.6 and 1.8 <br/>
2.2 Record the list of IPv4 addreses in the answer section <br/> 
2.3 send an AAAA query to all distinct name servers obtained in step 1.1.6 and 1.2.3 <br/>
2.4 Record the list of IPv6 addresses in the answer section
3. An empty DNS answer packet is generated.
4. All the data from step 2.2 and 2.4 is added to the packet
5. If the size of the packet is more than 512 bytes, then the test fails

### Outcome(s)

If the created packet fits into 512 byte UDP packet, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
