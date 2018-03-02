# Methods common to Test Case Specifications

This is a list of generic methods used in many test case specifications. The
test cases that makes use of any of these methods should link directly to
this text.

For all methods, take note if name server does not respond (time out), if
it responds with any other RCODE than NXDOMAIN and NOERROR or if it responds
with an expected or illegal format.


## Method 1: Parent zone

Obtain the parent zone of the given domain (zone).

1. The given domain is assumed to be apex of a zone with the same
   name, and is here refered to as the _child zone_.
2. A recursive lookup for the SOA record of the child zone starting from the
   root zone is done, and the steps of the process are recorded.
3. If the lookup reaches a name server that responds with a redirect (delegation)
   directly to the requested child zone:

   3.1 The method succeeds.
   
   3.2 The zone in which the delegation was found is considered to be the parent zone.
   
   3.3 Collect all NS records in the authority section and store them 
       in a cache that method 2 can use.

   3.4 Collect all A and AAAA records in the additional section and store them 
       in a cache that method 4 can use.

   3.5 The existance of the child zone has been determined.
   
   3.6 Return the name of the parent zone and the fact that the child zone exists.

4. If the recursive lookup reaches a name server that authoritatively responds
   (AA flag set) with NXDOMAIN for the child domain (child zone): 
   
   4.1 The method succeeds.
   
   4.2 The zone returning NXDOMAIN is considered to be the parent zone.
   
   4.3 The non-existance of the child zone has been determined.

   4.4 Return the name of the parent zone and the fact that the child zone does not exist.

5. If the recursive lookup reaches authorititative NOERROR answer (AA flag set), 
   with or without records in the answer section:
   
   5.1 The method succeeds.
   
   5.2 The zone returning authoritative data is considered to be the parent zone.
   
   4.3 The non-existance of the child zone has been determined.

   4.4 Return the name of the parent zone and the fact that the child zone does not exist.
   
6. If the recurse lookup ends with server or zone error or in a loop, then the method fails
   and no parent zone is found.

Parent zone     |Child zone        |Run normal test?|Run undelegated test
----------------|------------------|----------------|---------------------------------
Determined      |Exists            |Yes             |Yes (1)
Determined      |Does not exist (2)|No              |Yes
Indetermined (3)|Indetermined      |No              |Yes

  (1) Ignore delegation data and used provided data.

  (2) Parent zone returns an authoritative NXDOMAIN, data or nodata on the child zone name.
  
  (3) Server or zone error prevents the existence of parent zone to be determined.


## Method 2: Delegation name servers

Obtain the name servers names (extracted from the NS records) for 
the given zone (child zone) as defined in the delegation from the parent zone.

1. Obtain parent zone and existence of child zone using Method 1.

A. Normal test. For undelegated test go to B.

2. If parent zone could not be determined, method fails.

3. If no child zone exists, method fails.

4. Fetch the name server names for child zone from the cache provided by method 1.
   Return the name server names.

B. Undelegated test.

2. Ignore if parent zone or child zone does not exist or cannot be determined.

3. Ignore any name servers provided by delegation from parent zone.

4. Collect the name server names provided as indata for the test.

3. Collect all IPv4 and IPv6 addresses in the input to the undelegated test and 
   store in a cache where the connection between name server name and IP address
   is kept. The cache overwrites the cache from method 1 and is to be used by method 4.

## Method 3: In-zone name servers

Obtain the names of the authoritative name servers for the given zone 
(child zone) as defined in the NS records in the zone itself.

1. Obtain name server addresses using Method 4.
2. Send an NS query for the given zone to all obtained name server addresses.
3. Ignore response unless AA flag is set.
4. Collect all the unique NS records in the answer sections of the
   responses.
5. Return all name server names from the NS records.


## Method 4: Delegation name server addresses

Obtain the addresses of the authoritative name servers for the given
zone as defined in the delegation from the parent zone.

1. Obtain the NS records from method 2. This method fails if method
   2 failed.
2. For all in-bailiwick name servers, find the matching A and AAAA
   records in the cache created by method 1 or 2. For in-bailiwick name
   servers, recursive lookup must not be done.

A. Normal test. For undelegated test go to B.

3. For all out-of-bailiwick name servers, first look in the cache
   created by mothod 1. If any name server does not have both A and
   AAAA records, then do a recursive lookup for those.
4. Return a stucture where name server name is connected to its
   address or addresses. If a name server does not have any, that
   name server must be returned with a empty address field.

B. Undelegated test.

3. For all out-of-bailiwick name servers, first look in the cache
   created by mothod 2. If any name server exists in the cache,
   use that data, and do not do any recursive lookup of those names.
   For other out-of-bailiwick do a recursive lookup for for A and
   AAAA records.
4. Return a stucture where name server name is connected to its
   address or addresses. If a name server does not have any, that
   name server must be returned with a empty address field.



## Method 5: In-zone addresses records of name servers

Obtain the addresses of the in-bailiwick name servers for the given
zone as defined in the zone itself.

1. Obtain all the name server names using method 2. This method fails
   if method 2 failed.
2. Obtain all the name server IP addresses using method 4.
3. For each name server name, determine if the name server is
   in-biliwick or out-of-bailiwick. If it is out-of-bailiwick,
   go to next server.
4. Send an A and an AAAA query to all name server addresses.
5. If a delegation (referal) to a sub-zone of child zone is returned, 
   follow that delegation, possibly in several steps, by repeating the
   A and AAAA queries.
6. Ignore non-referal responses unless AA flag is set. Cached data
   is not accepted.
7. Create a list of unique IPv4 addreses and unique IPv6 addresses,
   respectively, found in the answer sections of the responses for
   each name server name.
8. Return a stucture where name server name is connected to its
   address or addresses. If a name server does not have any, that
   name server must be returned with a empty address field.



-------

Copyright (c) 2013-2018 IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
