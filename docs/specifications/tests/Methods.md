# Methods common to Test Specifications

This is a list of generic methods used in many test specifications. The
test cases that makes use of any of these methods should link directly to
this text.


## Method 1: Parent zone

Obtain the parent zone of the given domain.

1. A recursive SOA-record lookup for the child domain name starting at the
   root domain should be done, and the steps of the process recorded.
2. If the recursion reaches a name server that responds with a redirect
   directly to the requested domain, including functional glue, the test
   succeeds. The domain through which the name server was found is
   considered the parent domain.  
3. If the recursion reaches a name server that authoritatively responds
   with NXDOMAIN for the child domain, the test succeeds. The domain through
   which the name server was found is considered the parent domain.


## Method 2: Delegation name servers

Obtain the authoritative name servers for the given zone as defined in
its delegation in the parent zone.

1. Obtain parent zone using Method 1.
2. Send an NS query for the given domain name to one of the authoritative
   name servers for the parent zone.
3. Record all NS records in the authority section and all glue records.


## Method 3: In-zone name servers

Obtain the authoritative name servers for the given zone as defined in
the zone itself.

1. Obtain name servers using Method 2.
2. Look up addresses for all obtained name servers that are
   out-of-bailiwick.
3. Send an NS query for the given domain to all obtained name servers.
4. Record all the unique NS records in the answer sections of the
   responses in step 3, as well as all unique glue records.


## Method 4: Delegation NS addresses

Obtain the addresses of the authoritative name servers for the given
zone as defined in its delegation in the parent zone.

1. Query the servers in Method 2 for A and AAAA addresses.
2. Record the unique IP addresses from the answers (both A and AAAA) in
   the additional section, which are the glue address records for the
   domain.


## Method 5: In-zone NS addresses

Obtain the addresses of the authoritative name servers for the given
zone as defined in the zone itself.

1. Send an A query to all name servers obtained in Method 3.
2. Record the list of unique IPv4 addreses in the answer section.
3. Send an AAAA query to all name servers obtained in Method 3.
4. Record the list of unique IPv6 addresses in the answer section.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
