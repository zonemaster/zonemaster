## CONNECTIVITY03: AS Diversity

### Test case identifier

**CONNECTIVITY03:** AS Diversity

### Objective

[RFC 2182](https://tools.ietf.org/html/rfc2182), section 3.1
clearly specifies that distinct authoritative name servers for a child
domain should be placed in different topological and geographical locations.
The objective is to minimise the likelihood of a single failure disabling
all of them. 

The objective in this test is to check that all IP addresses of the domain's
authoritative name servers does not belong to the same AS.

[missing references to AS numbers, RFC 1930?]

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
   [Method3](../Methods.md).
2. Obtain the IP addresss of the name servers from [Method4](../Methods.md)
   and [Method5](../Methods.md).
   the following methods:
3. For obtaining the AS numbers for IPv6 addresses; first reverse the nibbles of 
   the IPv6 address and place dots between each nibble. It is important all omitted 
   zeroes in the IPv6 address are included. <br />
3.1. At the end of the reversed IPv6 address (obtained from step 3), concatenate
     the string ".origin6.asn.cymru.com.". <br/>
3.2 Send a "TXT" query using the string (obtained from Step 3.1) <br/>
3.3 The AS number for the IPv6 address is found in the ANSWER for the query 
4. For obtaining the AS numbers for IPv4 addresses; first reverse the nibbles 
   of the IPv4 address and  place dots between each nibble. <br/>
4.1. At the end of the reversed IPv4 address (obtained from step 4), concatenate 
     the string ".origin.asn.cymru.com.". <br/> 
4.2 Send a "TXT" query using the string (obtained from Step 4.1) <br/>
4.3 The AS number for the IPv6 address is found in the ANSWER for the query 
5. If all the retrieved AS (obtained from step3.3 and 4.3) are same, then the test
   fails.

### Outcome(s)

If there is a AS which is different from the other retrieved AS, then the
test succeeds.

### Special procedural requirements

None

### Intercase dependencies

None
