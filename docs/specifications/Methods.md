Methods 
=======

### Method 1 : Obtain the parent domain

1. A recursive SOA-record lookup for the child domain name starting at the root
domain should be done, and the steps of the process recorded.
2. If the recursion reaches a name server that responds with a redirect directly 
to the requested domain, including functional glue, the test succeeds. The 
domain through which the name server was found is considered the parent domain.  
3. If the recursion reaches a name server that authoritatively responds with 
NXDOMAIN for the child domain, the test succeeds. The domain through which the 
name server was found is considered the parent domain.

### Method 2 : Obtain the name servers authoritative for the domain from its parent 

1. Obtain the parent domain as input from "Method 1" 
2. Send a query to the parent domain asking for the list of name servers 
authoritative for the domain that is being tested 
3. Record the list of name servers obtained from the authority section 

### Method 3 : Obtain the name servers authoritative for the domain from the child zone

1. A NS query for the domain is made to all listed name servers obtained from
"Method 2" 
2. Record all the unique names from the answers received from the query in 
step 1

### Method 4 : Obtain the glue records for the domain from the parent

1. Order the result of "Method 2" in alphabetical order 
2. Query the servers in step 1 one-by-one 
3. Record the unique IP addresses (both A and AAAA) in the additional 
section (which are the glue records for the domain)


### Method 5 : Obtain the IP address records from the child zone

1. Send an A query to all name servers obtained in "Method 3" 
2. Record the list of unique IPv4 addreses in the answer section 
3. Send an AAAA query to all name servers obtained in "Method 3" 
4. Record the list of unique IPv6 addresses in the answer section 

### Method 6 : Obtain the SOA record from the child zone

1. An SOA query is sent using the hostname of the domain 
2. If there is a response, record the ANSWER section in the response


