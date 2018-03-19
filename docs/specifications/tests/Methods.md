# Methods common to Test Case Specifications

This is a list of generic methods used in many Test Case specifications. The
Test Cases that makes use of any of these methods refer directly to
this text.

## Method 1: Parent zone

The method does not exist anymore. It is included 
[BASIC01](Basic-TP/basic01.md) instead.


## Method 2: Delegation name servers

### Method identifier
**METHOD2** Delegation name servers

### Objective

Obtain the name servers names (extracted from the NS records) for 
the given zone (child zone) as defined in the delegation from the parent zone.

### Inputs

The name servers to the parent zone as found in [BASIC01](Basic-TP/basic01.md),
the name of the child zone, the fact if the test type is undelegated test 
or not.

If the test is an undelegated test, then the submitted data for that is also
input to this method.

### Ordered description of steps to be taken to execute the method

1. Normal test. For undelegated test go to 2.

   1. If child zone does not exists then return error.
   2. These steps assume that the servers of the parent zone behaves the
      same way as when [BASIC01](Basic-TP/basic01.md) was run.
   3. Create an SOA query for the child zone and send that to a parent server
      with RD flag unset.
   4. If the response response contains a referal to the child zone:
      1. Extract the RDATA (name server names) from the NS record in
         the authority section.
      2. Return the set of name servers (name server names).
      3. Processing the steps is stopped.
   5. If the response is authoritative (AA bit set) and the answer section
      contains the SOA record of the child zone:
      1. Repeat the query with the next server until a server has responded
         with a referal or no more servers are available.
      2. If a referal was found, follow the steps above when referal was
         found in first server.
      3. If no referal was found, send a query for the NS records instead,
         and use them as if it was a referal.
      4. Return the set of name servers (name server names).
      5. Processing the steps is stopped.

2. Undelegated test.

   1. Collect the name server names provided as indata for the test.
   2. Return the set of name servers (name server names).
   3. Processing the steps is stopped.


### Outcome(s)

Outcome is the set of name servers, unless this method was called
when the test type as normal (non-undelegated test) and child zone does
not exist, for which the outcome is ERROR.

### Special procedural requirements

None.

### Dependencies

Test Case BASIC01 must have been run.


## Method 3: In-zone name servers

### Method identifier
**METHOD3** In-zone name servers


### Objective
Obtain the names of the authoritative name servers for the given zone 
(child zone) as defined in the NS records in the zone itself.

### Inputs

The name of the child zone and the addresses to the name servers of
the child zone, as given by METHOD4. The child zone must exist as
defined by [BASIC01](Basic-TP/basic01.md).

### Ordered description of steps to be taken to execute the method

1. If the child zone does not exist, end with an ERROR.
2. Create an NS query for the child zone with the RD flag unset
   and send that to a name server of the child zone.
3. Ignore response unless AA flag is set.
4. Collect all the unique NS records in the answer sections of the
   responses and extract the name server names.
5. Repeat for all name servers.
6. Create a set of name servers (name server names) as collected
   from the zone.
7. If the set is empty, then return an empty set and an ERROR, else
   return the set of name servers (name server names).

### Outcome(s)

Outcome is a set of nameservers or ERROR.

### Special procedural requirements

None.

### Dependencies

Test Case BASIC01 and METHOS4 must have been run first.



## Method 4: Delegation name server addresses

### Method identifier
**METHOD4** Delegation name server addresses

### Objective

Obtain the addresses of the authoritative name servers for the given
zone as defined in the delegation from the parent zone.

### Inputs

The name of the child zone and the addresses to the name servers of 
the parent zone, unless the test type is undelegated test. The child 
zone must exist as defined by [BASIC01](Basic-TP/basic01.md), unless
the test type is undelegated test.

If the test type is undelegated test, then the input data must be
provided.


### Ordered description of steps to be taken to execute the method

1. Normal test. For undelegated test go to 2.

   1. If child zone does not exists then return error.
   2. These steps assume that the servers of the parent zone behaves the
      same way as when [BASIC01](Basic-TP/basic01.md) was run.
   3. Create an NS query for the child zone and send that to a parent server
      with RD flag unset.
   4. If the response response contains a referal to the child zone:
      1. Extract the RDATA (name server names) from the NS record in
         the authority section.
      2. Extract all A and AAAA records from the additional section.
   5. If the response is authoritative (AA bit set) and the answer section
      contains the NS record of the child zone:
      1. Repeat the query with the next server until a server has responded
         with a referal or no more servers are available.
      2. If a referal was found, follow the steps above when referal was
         found in first server.
      3. If no referal was found, extract the name server names from the
         NS records in the answer section.
      4. For each in-bailiwick name server, query the name server for A and
         AAAA and extract the record in the answer or additional section.
	 Follow any referal to sub-zone if needed.
   6. For each out-of-bailiwick name servers do a normal recursive lookup 
      for those to a resolver by querying for A and AAAA.
   7. Collect all matching A and AAAA records from the responses.
   8. Return a stucture where name server name is connected to its
      address or addresses. If a name server does not have any, that
      name server must be returned with a empty address field.
   9. Processing the steps is stopped.

2. Undelegated test.

   1. For every in-bailiwick name server in input data, collect IPv4 and
      IPv6 address for the server name.
   2. For all out-of-bailiwick name servers in input data, if it has 
      neither IPv4 nor IPv6 data, do a normal recursive lookup for 
      the address to a resolver by querying for A and AAAA. 
   3. If a name server has either IPv4 or IPv6 data, do not query for
      any data.
   4. Return a stucture where name server name is connected to its
      address or addresses. If a name server does not have any, that
      name server must be returned with a empty address field.
   5. Processing the steps is stopped.


### Outcome(s)

Outcome is the set of name servers and for each name server a possibly
emty set of IP addresses. When the test type as normal (non-undelegated 
test) and child zone does not exist, for which the outcome is ERROR.

### Special procedural requirements

None.

### Dependencies

Test Case BASIC01 must have been run.



## Method 5: In-zone addresses records of name servers

### Method identifier
**METHOD5** In-zone addresses records of name servers


### Objective

Obtain the addresses of the in-bailiwick name servers, if any, for 
the child zone as defined in the zone itself. This method will
ignore any addresses of out-of-bailiwick name servers.


### Inputs

* The name of the child zone.
* The addresses to the name servers of the child zone, as given by 
  METHOD4. 
* The name server names defined in the zone as defined by METHOD2.
* Test type (normal/undelegated).

The child zone must exist as defined by 
[BASIC01](Basic-TP/basic01.md) unless the test type is undelegated.


### Ordered description of steps to be taken to execute the method

1. If the child zone does not exist, end with an ERROR unless the
   test type is undelegated.
2. For each name server name in the zone, determine if the name server is
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

### Outcome(s)



### Special procedural requirements

None.

### Dependencies

Test Case BASIC01, METHOS4 and METHOD2 must have been run first.







-------

Copyright (c) 2013-2018 IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
