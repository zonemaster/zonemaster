# Methods common to Test Case Specifications

This is a list of generic methods used in many Test Case specifications. The
Test Cases that makes use of any of these methods refer directly to
this text.

## Method 1: Parent zone

The method has been removed. The function is integrated in [BASIC01] instead.

-------------------------------------------------------------

## Method: Get delegation NS names and IP addresses

### Method identifier
**get-del-ns-names-and-ips**

### Objective

Obtain the name server names (from the NS records) and the IP addresses (from 
glue records) from from the delegation of the given zone (child zone) from 
the parent zone. Glue records are address records for [in-bailiwick] name 
server names, if any. Obtain the IP addresses for the [out-of-bailiwick] 
name server names, if any.

This is an external method to be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

* As specified in [get-delegation].

### Ordered description of steps to be taken to execute the method

1. Get the name server set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by running [get-delegation].

2. Extract the set of name server names ("Names") from 
   *Name Servers*.

3. Get the IP addresses for any [out-of-bailiwick] name server
   names in *Names* by running [get-oob-ips] with *Names*
   as input.

4. Merge the set returned with *Name Servers*.

5. Output the *Name Servers*.

### Outputs

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

None.

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Method: Get delegation NS names

### Method identifier
**get-del-ns-names**

### Objective

Obtain the name server names for the given zone (child zone) as defined in 
the delegation from parent zone.

This is an external method to be used by test cases.

### Inputs

* As specified in [get-delegation].

### Prerequisite

* As specified in [get-delegation].

### Ordered description of steps to be taken to execute the method

1. Get the name server set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by running [get-del-ns-names-and-ips].

2. Extract the set of name server names from *Name Servers*.

3. Output the set of name server names.

### Outputs

* The set of name server names.

### Special procedural requirements

The method assumes that the servers of the parent zone behaves the
same way as when [BASIC01] was run.

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Method: Get delegation NS IP addresses

### Method identifier
**get-del-ns-ips**

### Objective

Obtain the IP addresses (from glue records) from from the delegation of 
the given zone (child zone) from the parent zone. Glue records are address 
records for [in-bailiwick] name server names, if any. Obtain the IP addresses 
for the [out-of-bailiwick] name server names, if any.

This is an external method to be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

* As specified in [get-del-ns-names-and-ips].


### Ordered description of steps to be taken to execute the method

1. Get the name server set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by running [get-del-ns-names-and-ips].

2. Extract the IP addresses from *Name Servers* and create a set of 
   unique addresses ("NS IPs").

3. Output *NS IPs*.

### Output

* The set of IP addresses, each assumed to point to an
  authoritative name server of *Child Zone*.

### Special procedural requirements

None.

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Method: Get zone NS names

### Method identifier
**get-zone-ns-names**

### Objective
Obtain the names of the authoritative name servers for the given zone 
(child zone) as defined in the NS records in the zone itself.

This is an external method to be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

* As specified in [get-del-ns-ips].

### Ordered description of steps to be taken to execute the method

1. Using [get-del-ns-ips] get the IP addresses to the
   name servers ("Name Server IPs").

2. Create an NS query for apex of the Child Zone with the RD flag 
   unset and send that to the *Name Server IPs*.

3. Ignore response unless AA flag is set.

4. Collect all the unique NS records in the answer sections of the
   responses and extract the name server names.

5. Create a set of name server names ("Name Server Names") as 
   collected from zone.

6. Output *Name Server Names*.

### Outputs

* The set of name servers (name server names).

### Special procedural requirements

None.

### Dependencies

Test Case [BASIC01] must have been run first.

-------------------------------------------------------------

## Method: Get zone NS names and IP addresses

### Method identifier
**get-zone-ns-names-and-ips**

### Objective

Obtain the name server names (extracted from the NS records) from
apex of the child zone. For [in-bailiwick] name server names obtain 
the IP addresses from the child zone. For the [out-of-bailiwick] name 
server names obtain the IP addreses from resolver lookup.

This is an external method to be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

* As specified in [get-delegation].

### Ordered description of steps to be taken to execute the method

1. Get the name server names for the *Child Zone* as defined in 
   the *Child Zone* by running [get-zone-ns-names] ("Names").

2. Create a set of name servers ("Name Servers") where each unique 
   name server name in *Names* is linked to an empty set of IP 
   addresses. 

3. Fetch the IP addresses for any [in-bailiwick] name server
   names in *Names* by running [get-ib-addr-in-zone].

4. Add each fetched IP addresses to *Name Servers* to the name
   server name it belongs to.

5. Get the IP addresses for any [out-of-bailiwick] name server
   names in *Names* by running [get-oob-ips] with *Names*
   as input.

6. Merge the set returned with *Name Servers*.

7. Output *Name Servers*.

### Output

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

None.

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Method: Get zone NS IP addresses

### Method identifier
**get-zone-ns-ips**

### Objective

Obtain the IP addresses of the name servers, as extracted from 
the NS records of apex of the child zone.

This is an external method to be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

* As specified in [get-zone-ns-names-and-ips].

### Ordered description of steps to be taken to execute the method

1. Get the name servers set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by running [get-zone-ns-names-and-ips].

2. Extract the IP addresses from *Name Servers* and create a
   set of unique IP addresses.

3. Output the set of IP addresses.

### Outputs

* The possibly empty set of IP addresses.

### Special procedural requirements

None.

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Method: Get in-bailiwick address records in zone

### Method identifier
**get-ib-addr-in-zone**

### Objective

From the child zone, obtain the address records matching the
[in-bailiwick] name server names found in the zone itself.
Extract addresses even if the resolution goes through CNAME or
DNAME.

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

* As specified in [get-del-ns-ips].

### Ordered description of steps to be taken to execute the method

1. Using [get-del-ns-ips] get the IP addresses to the name servers 
   ("Name Server IPs").

2. Using [get-zone-ns-names] get the names of the name servers according 
   to *Child Zone* itself ("Child Zone name server name").

3. If none of the *Child Zone name server name* is an [in-bailiwick] 
   name server name, stop running this method and output an empty set.

4. Create a set of name servers ("Name Servers") where each unique 
   [in-bailiwick] name server name is linked to an empty set  
   of IP addresses. 

5. For each [in-bailiwick] *Child Zone name server name*:
   1. Send an A and an AAAA query to all servers in *name server IPs*
      with the RD flag unset.
   2. If a delegation (referral) to a sub-zone of Child Zone is returned, 
      follow that delegation, possibly in several steps, by repeating the
      A and AAAA queries.
   3. If a CNAME or DNAME is returned, follow that, possibly in several
      steps, to resolve the name to IP addresses, if possible.
   4. Ignore non-referral responses unless AA flag is set (cached data
      is not accepted).
   5. Add found IP addresses for the name server names in *Name Servers*.

6. Output the *Name Servers*.

### Outputs

* The possiblyt empty set of name server names pointing at possibly
  empty sets of IP addresses.

### Special procedural requirements

If a name server name points at a CNAME or DNAME follow that to extract
an IP address, if possible. It is, however, not permitted for a NS record
to point at a name that has a CNAME or DNAME, but that test iS covered by
Test Case [DELEGATION05].

### Dependencies

Test Cases [BASIC01] must have been run first.

-------------------------------------------------------------

## Method: Get delegation

### Method identifier
**get-delegation**

### Objective

Obtain the name server names (from the NS records) and the IP addresses (from 
glue records) from from the delegation of the given zone (child zone) from 
the parent zone. Glue records are address records for [in-bailiwick] name 
server names, if any. Extract addresses even if the resolution goes through 
CNAME or DNAME.


IP addresses for [out-of-bailiwick] name server names are not extracted
with this method. To get those see [get-del-ns-ips] or
[get-del-ns-names-and-ips].

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.
* The fact if the child zone exists from [BASIC01].
* "Test Type" - The test type with values "undelegate test" or "normal test".
* "Parent NS" - the name server IP addresses to the parent zone as captured
   in [BASIC01] (only if *Test Type* is "normal test").
* "Undelegated Data" - the submitted delegation data, name server names
  and IP addresses for *Child Zone* (only if *Test Type* is "undelegated 
  test").

### Prerequisite

* If the *Test Type* is "normal test" then the *Child Zone* must exist.
* If the *Test Type* is "undelegated test" then "Undelegated Data" must
  at least contain one name server name.

### Ordered description of steps to be taken to execute the method

1. If the *Test Type* is "undelegated test" then:
   1. Collect the name server names from the *Undelegated Data*.
   2. Create a set of name servers ("Name Servers") where each unique 
      name server name is linked to an empty set of IP addresses. 
   2. For each [in-bailiwick] name server name collect any IP
      IP addresses from *Undelegated Data* and add that to the
      *Name Servers* set under the name server name.
   4. Output the *Name Servers*.
   5. Processing the method is stopped.

2. Steps below is for *Test Type* "normal test" only.

3. Create an NS query for the apex of the *Child Zone* with the RD flag 
   unset.

4. Send the NS query to the first name server in *Parent NS*.

5. If the response contains a referral to the Child Zone:
   1. Extract the name server names from the RDATA of the NS records in
      the authority section.
   2. Extract any A or AAAA record from the additional section if the 
      owner name is an [in-bailiwick] name server name (glue records).
   3. Create a set of name servers ("Name Servers") where each unique name 
      server name is linked to a set of its possibly empty set of IP 
      addresses. 
   4. Repeat the NS query for *Child Zone* to the other name servers in 
      "Parent NS":
       1. If the response from a server has the AA bit set, ignore that
         response.
       2. If the response is a referral to *Child Zone*:
           1. Extract the name server names from the NS records in the 
              authority section.
           2. Extract any A or AAAA record from the additional section 
              if the owner name is an [in-bailiwick] name server name.
           3. Update the *Name Servers* if new a name server name or a
              new IP address for any name server name is found.
           4. Output the *Name Servers*.
           5. Processing the method is stopped.

6. If the response is authoritative (AA bit set) and the answer section
   contains the NS record of the Child Zone:
   1. Repeat the query to the next server of *Parent NS* until a 
      server has responded with a referral or no more servers are 
      available.
   2. If a referral is found, go to step above for referral responses.
   3. If no referral is found for *Child Zone*, use the last response 
      where the AA bit set and the answer section contained NS records:
      1. Extract the name server names from the RDATA of the NS records 
         in the answer section.
      2. Extract any A or AAAA record from the additional section if the
         owner name is an [in-bailiwick] name server name.
      3. If any [in-bailiwick] name server name lacks IP address 
         specification from previous step then create an A and a AAAA 
         query for that name:
         1. Send the query to the same *Parent NS*.
         2. If a delegation (referral) to a sub-zone of Child Zone is 
            returned, follow that delegation, possibly in several steps, by 
            repeating the A and AAAA queries.
         3. If a CNAME or DNAME is returned, follow that, possibly in 
            several steps, to resolve the name to IP addresses, if 
            possible.
         4. Ignore non-referral responses unless AA flag is set (cached 
            data is not accepted).
      4. Create a set name servers ("Name Servers") where each unique 
         name server name is linked to a possibly empty set 
         of IP its addresses. 
      5. Output the *Name Servers*.
      6. Processing the method is stopped.

7. If the server returns unexpected response: 
   1. Send the query to the next server, if available. 
   2. If no more servers remain, output an empty set and stop 
      processing the method.

### Outputs

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

If a name server name points at a CNAME or DNAME follow that to extract
an IP address, if possible. It is, however, not permitted for a NS record
to point at a name that has a CNAME or DNAME, but that test iS covered by
Test Case [DELEGATION05].

The method assumes that the servers of the parent zone behaves the
same way as when [BASIC01] was run.

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Method: Get out-of-bailiwick ip addresses

### Method identifier
**get-oob-ips**

### Objective

Obtain the IP addresses of the out-of-bailiwick name servers for the 
given zone (child zone) and a given set of name server names. Extract 
addresses even if the resolution goes through CNAME or DNAME.

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.
* "NS Set" - The names of the *Child Zone* name servers as given by the
  calling method or test case.
* "Test Type" - The test type with values "undelegate test" or 
  "normal test".
* "Undelegated Data" - the submitted delegation data, name server names
  and IP addresses for *Child Zone* (only if *Test Type* is "undelegated 
  test").

### Ordered description of steps to be taken to execute the method

2. Create a set of name servers ("Name Servers") where each unique 
   [out-of-bailiwick] name server name in *NS Set* is linked to an empty 
   set of IP addresses. 

3. For each [out-of-bailiwick] the name server name ("Name") in 
   *NS Set* do:

   1. If *Test Type* is "undelegated test" then if the *Name*
      has IP address specification (IPv4 or IPv6) in *Undelegated Data* 
      then add the address or addresses to *Name Servers* and go to
      next server.

   2. Create one A query and one AAAA query for the *Name*.

   3. Send the two queries doing normal recursive lookup to a resolver.

   4. If CNAME or DNAME is returned for the *Name* then follow that,
      possibly in several steps, and use the resulting IP address or
      addresses.

   4. Collect all IP addresses for the *Name* and add the 
      address or addresses to *Name Servers* for that *Name*
      and go to next *Name*.

4. Output the *Name Servers*.

### Outputs

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

If a name server name points at a CNAME or DNAME follow that to extract
an IP address, if possible. It is, however, not permitted for a NS record
to point at a name that has a CNAME or DNAME, but that test is covered by
Test Case [DELEGATION05].

### Dependencies

Test Case [BASIC01] must have been run.

-------------------------------------------------------------

## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.


[RFC 7719]: https://tools.ietf.org/html/rfc7719

[BASIC01]: Basic-TP/basic01.md

[DELEGATION05]: Delegation-TP/delegation05.md

[get-del-ns-names-and-ips]: #method-get-delegation-ns-names-and-ip-addresses

[get-del-ns-names]: #method-get-delegation-ns-names

[get-del-ns-ips]: #method-get-delegation-ns-ip-addresses

[get-zone-ns-names]: #method-get-zone-ns-names

[get-zone-ns-names-and-ips]: #method-get-zone-ns-names-and-ip-addresses

[get-zone-ns-ips]: #method-get-zone-ns-ip-addresses

[get-ib-addr-in-zone]: #method-get-in-bailiwick-address-records-in-zone

[get-delegation]: #method-get-delegation

[get-oob-ips]: #method-get-out-of-bailiwick-ip-addresses

[Method2]: #method-2-delegation-name-servers

[Method3]: #method-3-in-zone-name-servers

[Method4]: #method-4-delegation-name-server-addresses

[Method5]: #method-5-in-zone-addresses-records-of-name-servers

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

