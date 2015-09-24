# Methods common to Test Specifications

This is a list of generic methods used in many test specifications. The
test cases that makes use of any of these methods should link directly to
this text.

### Method 1: Obtain the parent domain

This metod tries to obain the parent domain from the domain used as input
to this method.

1. A recursive SOA-record lookup for the child domain name starting at the
   root domain should be done, and the steps of the process recorded.
2. If the recursion reaches a name server that responds with a redirect
   directly to the requested domain, including functional glue, the test
   succeeds. The domain through which the name server was found is
   considered the parent domain.  
3. If the recursion reaches a name server that authoritatively responds
   with NXDOMAIN for the child domain, the test succeeds. The domain through
   which the name server was found is considered the parent domain.

### Method 2: Obtain "glue Name records" from parent

This method tries to obtain the authoritative name servers from the
delegation of the parent domain.

1. Obtain the parent domain as input from Method 1.
2. Send a query to the parent domain asking for the list of name servers
   authoritative for the domain that is being tested 
3. Record the list of name servers obtained from the authority section 

### Method 3: Obtain name servers from child

Just as in Method 2, this method tries to obtain the name servers configured
for the child zone from the child domain itself.

1. A NS query for the domain is made to all listed name servers obtained
   from Method 2. 
2. Record all the unique name servers from the answers received from the query in 
   step 1.

### Method 4: Obtain "glue address records" from parent

This method tries to obtain any glue address records from the delegation
in the parent zone.

1. Query the servers in Method 2 for A and AAAA addresses.
2. Record the unique IP addresses from the answers (both A and AAAA) in
   the additional section, which are the glue address records for the
   domain.

### Method 5: Obtain the name server address records from child

This method tries to obtain the IP addresses for the name servers used in
the child zone.

1. Send an A query to all name servers obtained in Method 3.
2. Record the list of unique IPv4 addreses in the answer section.
3. Send an AAAA query to all name servers obtained in Method 3.
4. Record the list of unique IPv6 addresses in the answer section.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
