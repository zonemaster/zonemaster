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

1. Obtain the IP addresses of the name servers from [Method4](../Methods.md)
   and [Method5](../Methods.md).
2. Obtain the list of ASN lookup domains from the configuration of Zonemaster.
3. For obtaining the AS numbers for IPv6 addresses; first reverse its eight
4-character hexadecimal numbers and place dots between each. It is important 
all omitted zeroes are included.  
3.1. At the end of the reversed IPv6 address, concatenate the string (from
step 2)  
3.2 Send a "TXT" query using the string (obtained from Step 3.1)  
3.3 If there is an ANSWER, then go to step 3.4, else go to the next string
in the list (from step 2)  
3.4 The AS number for the IPv6 address is found in the ANSWER for the query 
4. To obtain the AS numbers for IPv4 addresses; first reverse the four numerical
octets and place dots between each.  
4.1. At the end of the reversed IPv4 address concatenate the string (from step 2)  
4.2 Send a "TXT" query using the string (obtained from Step 4.1)  
4.3 If there is an ANSWER, go to step 4.4, else go to the next string
in the list (from step 2)  
4.4 The AS number for the IPv4 address is found in the ANSWER for the query 
5. If all the retrieved AS (obtained from step 3.3 and 4.3) are same, then the test
   fails.

### Outcome(s)

If there is a AS which is different from the other retrieved AS, then the
test succeeds.

### Special procedural requirements

None

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
