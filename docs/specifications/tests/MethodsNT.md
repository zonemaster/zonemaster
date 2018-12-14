# Methods common to Test Case Specifications

*Status of this document (MethodsNT): The methods defined in this document are planned to replace the
old (current) methods defined in [Methods] in the Test Case specifications. Before the transistion
all Test Cases still use the old methods ([Methods]). During the transitions it will be given from
the specification if the Test Case uses the old methods or the methods in this document. When the
transition has been completed, the old methods document will be removed.*

This is a list of generic methods directly or indirectly used in many 
Test Case specifications. The Test Cases that makes use of any of 
these methods refer directly to this document.

**Table of contents**

* [Method: Get parent zone](#method-get-parent-zone)
* [Method: Get delegation NS names and IP addresses](#method-get-delegation-ns-names-and-ip-addresses)
* [Method: Get delegation NS names](#method-get-delegation-ns-names)
* [Method: Get delegation NS IP addresses](#method-get-delegation-ns-ip-addresses)
* [Method: Get zone NS names](#method-get-zone-ns-names)
* [Method: Get zone NS names and IP addresses](#method-get-zone-ns-names-and-ip-addresses)
* [Method: Get zone NS IP addresses](#method-get-zone-ns-ip-addresses)
* [Method: Get in-bailiwick address records in zone](#method-get-in-bailiwick-address-records-in-zone)
* [Method: Get delegation](#method-get-delegation)
* [Method: Get out-of-bailiwick ip addresses](#method-get-out-of-bailiwick-ip-addresses)
* [Method: Get data for undelegated test](#method-get-data-for-undelegated-test)
* [Method inter-dependencies](#method-inter-dependencies)
* [Terminology](#terminology)

-------------------------------------------------------------

## Method: Get parent zone

### Method identifier
**Get-Parent-Zone** 

*In general, this method replaces [Method1] in the old [Methods].*

### Objective

Obtain the parent zone of the child zone to be tested and the name server
IP addresses of the parent zone. Determine if it is possible to perform
the testing of the child zone.

This is an external method that can be used by test cases.

This method must, in general, use the same algorithm as Test Case [BASIC01], but
without the messages.

### Inputs

* "Child Zone" - The name of the child zone.
* "Root Name Servers" - The IANA [List of Root Servers].
* "Test Type" - The test type with values "undelegated test" or 
  "normal test".

This method also inherits the inputs of method [Get-Undel-Data].

### Prerequisite

If *Test Type* is "undelegated test", then as specified in method
[Get-Undel-Data].

### Ordered description of steps to be taken to execute the method

1. If the *Child Zone* is the root zone ("."):
   1. Return the following from the method:
      1. The parent zone is set to be itself (".").
      2. The existence of the *Child Zone* is set to be true.
      3. The parent name server IP list is empty.
   2. Exit.

2. Find the parent zone of the *Child Zone* by performing recursive 
   lookup for the SOA record of the *Child Zone* with the RD bit unset.
   Start by using a nameserver from the *Root Name Servers*.

3. Continue, step by step, until the parent zone (of the *Child Zone*) has 
   been reached by using the referrals (delegations) found.

4. If the lookup reaches a name server that responds with a referral 
   (delegation) directly to the requested *Child Zone*:
   1. Return the following from the method:
      1. The parent zone is set to be the name of the zone that returned
         the delegation.
      2. The existence of the *Child Zone* is set to be true.
      3. The parent name server IP list is set to be the available list
         of servers for the parent zone.
   2. Exit.

5. If the lookup reaches a name server that authoritatively responds
   (AA flag set) and either with NXDOMAIN for the *Child Zone* or
   with NOERROR and no record in the answer section (NODATA): 
   1. The zone returning NXDOMAIN or NODATA is defined to be the parent zone.
   2. Repeat the SOA query for the *Child Zone* to all name servers for the
      parent zone.
      1. If any server returns a referral (delegation) directly to the *Child
      	 Zone*, then go back to step 4 with the found delegation.
   3. If *Test Type* is "normal test", then return the following from the 
      method:
      1. The parent zone as defined above.
      2. The existence of the *Child Zone* is set to be false.
      3. The parent name server IP list is set to be the available list
         of servers for the parent zone.
   4. If *Test Type* is "undelegated test", then return the following from 
      the method:
      1. The parent zone as defined above.
      2. The existence of the *Child Zone* is set to be true.
      3. The parent name server IP list is set to be the available list
         of servers for the parent zone.
   5. Exit.

6. If the lookup reaches a name server that non-authoritatively responds
   (AA flag unset) with a CNAME record in the answer section:
   1. A CNAME query with the RD flag unset is sent to the same server.
   2. If the lookup returns an authoritative answer with a CNAME with
      *Child Zone* name as owner name, then continue to step 7, else repeat 
      from step 3 using the next server. 

7. If the lookup reaches a name server that authoritatively responds
   (AA flag set) with a CNAME record in the answer section:
   1. The zone returning authoritative data is defined to be the parent zone. 
   2. Repeat the SOA query for the *Child Zone* to all name servers for the
      parent zone.
      1. If any server returns a referral (delegation) directly to the *Child
      	 Zone*, then go back to step 4 with the found delegation.
   3. If *Test Type* is "normal test", then return the following from the 
      method:
      1. The parent zone as defined above.
      2. The existence of the *Child Zone* is set to be false.
      3. The parent name server IP list is set to be the available list
         of servers for the parent zone.
   4. If *Test Type* is "undelegated test", then return the following from 
      the method:
      1. The parent zone as defined above.
      2. The existence of the *Child Zone* is set to be true.
      3. The parent name server IP list is set to be the available list
         of servers for the parent zone.
   5. Exit.

8. If the lookup reaches a name server that authoritatively responds
   (AA flag set) with an SOA record with owner name child domain in the 
   answer section:
   1. The zone in the previous delegation is defined to be the parent 
      zone.
   2. Return the following from the method:
      1. The parent zone as defined above.
      2. The existence of the *Child Zone* is set to be true.
      3. The parent name server IP list is set to be the available list
         of servers for the parent zone.
   3. Exit.

9. If the server does not respond, the response contains an unexpected 
   RCODE or any other error, repeat from step 3 using the next server. 

10. If delegation to a zone at a higher level than *Child Zone* is returned, 
    then follow the delegation.

11. If all servers above are exhausted, then:
   1. If *Test Type* is "normal test", then return the following from the 
      method:
      1. The parent zone as empty (undefined).
      2. The existence of the *Child Zone* is set to be false.
      3. The parent name server IP list is set to be empty.
   2. If *Test Type* is "undelegated test", then return the following from 
      the method:
      1. The parent zone as empty (undefined).
      2. The existence of the *Child Zone* is set to be true.
      3. The parent name server IP list is set to be empty.
   3. Exit.

### Test Type and existence of parent and child 

Parent zone     | *Child Zone*       | Run normal test? | Run undelegated test?
----------------|--------------------|------------------|---------------------
Determined      | Exists             | Yes              | Yes (1)
Determined      | Does not exist (2) | No               | Yes (3)
Indetermined (4)| Indetermined       | No               | Yes (3)

1. Undelegated tests are run based on the submitted data and not
   the existing zone.
2. Parent zone returns an authoritative NXDOMAIN or NODATA on the 
   *Child Zone* name and SOA record.
3. When *Test Type* is "undelegated test" the *Child Zone* is
   defined to exist even if there is no delegation.
4. Server or zone error prevents determination of parent zone.

### Outputs

* The name of the parent zone (can be empty, i.e. undefined).
* The existence of the *Child Zone* (true or false).
* The set of name server IP address for the parent zone (can be empty,
  i.e. undefined).

### Special procedural requirements

None.

### Dependencies

The *Child Zone* name must be a legal name.

[To top]

-------------------------------------------------------------

## Method: Get delegation NS names and IP addresses

### Method identifier
**Get-Del-NS-Names-and-IPs**

### Objective

Obtain the name server names (from the NS records) and the IP addresses (from 
glue records) from the delegation of the given zone (child zone) from 
the parent zone. [Glue records], if any, are address records for name 
server names. Also obtain the IP addresses for the [out-of-bailiwick] name
server names, if any. If the [glue records] include address records for
[out-of-bailiwick] name servers they will be included twice, unless identical.

This is an external method that can be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

This method also inherits the inputs of methods [Get-Delegation] and
[Get-OOB-IPs].

### Prerequisite

As specified in methods [Get-Delegation] and [Get-OOB-IPs].

### Ordered description of steps to be taken to execute the method

1. Get the name server set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by using method [Get-Delegation].

2. Extract the set of name server names ("Names") from 
   *Name Servers*.

3. Get the IP addresses for any [out-of-bailiwick] name server
   names in *Names* by using method [Get-OOB-IPs] with *Names*
   as input.

4. Merge the set returned with *Name Servers*.

5. Output the *Name Servers*.

### Outputs

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

None.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get delegation NS names 

### Method identifier
**Get-Del-NS-Names**

*In general, this method replaces [Method2] in the old [Methods].*

### Objective

Obtain the name server names for the given zone (child zone) as defined in 
the delegation from parent zone.

This is an external method that can be used by test cases.

### Inputs

This method inherits the inputs of method [Get-Del-NS-Names-and-IPs].

### Prerequisite

As specified in method [Get-Del-NS-Names-and-IPs].

### Ordered description of steps to be taken to execute the method

1. Get the name server set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by using method [Get-Del-NS-Names-and-IPs].

2. Extract the set of name server names from *Name Servers*.

3. Output the set of name server names.

### Outputs

* The set of name server names.

### Special procedural requirements

The method assumes that the servers of the parent zone behaves the
same way as when method [Get-Parent-Zone] was run.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get delegation NS IP addresses

### Method identifier
**Get-Del-NS-IPs**

*In general, this method replaces [Method4] in the old [Methods].*

### Objective

Obtain the IP addresses (from glue records) from the delegation of 
the given zone (child zone) from the parent zone. Glue records are address 
records for [in-bailiwick] name server names, if any. Obtain the IP addresses 
for the [out-of-bailiwick] name server names, if any.

This is an external method that can be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

This method inherits the inputs of method [Get-Del-NS-Names-and-IPs].

### Prerequisite

As specified in method [Get-Del-NS-Names-and-IPs].

### Ordered description of steps to be taken to execute the method

1. Get the name server set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by using method [Get-Del-NS-Names-and-IPs].

2. Extract the IP addresses from *Name Servers* and create a set of 
   unique addresses ("NS IPs").

3. Output *NS IPs*.

### Output

* The set of IP addresses, each assumed to point to an
  authoritative name server of *Child Zone*.

### Special procedural requirements

None.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get zone NS names

### Method identifier
**Get-Zone-NS-Names**

*In general, this method replaces [Method3] in the old [Methods].*

### Objective
Obtain the names of the authoritative name servers for the given zone 
(child zone) as defined in the NS records in the zone itself.

This is an external method that can be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

This method also inherits the inputs of method [Get-Del-NS-IPs].

### Prerequisite

As specified in method [Get-Del-NS-IPs].

### Ordered description of steps to be taken to execute the method

1. Using method [Get-Del-NS-IPs], obtain the IP addresses of the
   name servers ("Name Server IPs").

2. Create an NS query for apex of the Child Zone with the RD flag 
   unset and send that to the *Name Server IPs*.

3. Collect all the unique NS records in the answer sections of the
   responses where the AA flag is set and extract the name server names.

4. Create a set of name server names ("Name Server Names") as 
   collected from zone.

5. Output *Name Server Names*.

### Outputs

* The set of name servers (name server names).

### Special procedural requirements

None.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get zone NS names and IP addresses

### Method identifier
**Get-Zone-NS-Names-and-IPs**

### Objective

Obtain the name server names (extracted from the NS records) from
apex of the child zone. For [in-bailiwick] name server names obtain 
the IP addresses from the child zone. For the [out-of-bailiwick] name 
server names obtain the IP addresses from resolver lookup.

This is an external method that can be used by test cases.

### Inputs

* "Child Zone" - The name of the child zone.

This method also inherits the inputs of methods [Get-Zone-NS-Names],
[Get-IB-Addr-in-Zone] and [Get-OOB-IPs].

### Prerequisite

As specified in methods [Get-Zone-NS-Names], [Get-IB-Addr-in-Zone]
and [Get-OOB-IPs].

### Ordered description of steps to be taken to execute the method

1. Get the name server names for the *Child Zone* as defined in 
   the *Child Zone* by using method [Get-Zone-NS-Names] ("Names").

2. Create a set of name servers ("Name Servers") where each unique 
   name server name in *Names* is linked to an empty set of IP 
   addresses. 

3. Fetch the IP addresses for any [in-bailiwick] name server
   names in *Names* by using method [Get-IB-Addr-in-Zone].

4. Add each fetched IP address to *Name Servers* to the name
   server name it belongs to.

5. Get the IP addresses for any [out-of-bailiwick] name server
   names in *Names* by using method [Get-OOB-IPs] with *Names*
   as input.

6. Merge the set returned with *Name Servers*.

7. Output *Name Servers*.

### Output

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

None.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get zone NS IP addresses

### Method identifier
**Get-Zone-NS-IPs**

*In general, this method replaces [Method5] in the old [Methods].*

### Objective

Obtain the IP addresses of the name servers, as extracted from 
the NS records of apex of the child zone.

This is an external method that can be used by Test Cases.

### Inputs

* "Child Zone" - The name of the child zone.

This method also inherits the inputs of method
[Get-Zone-NS-Names-and-IPs].

### Prerequisite

As specified in method [Get-Zone-NS-Names-and-IPs].

### Ordered description of steps to be taken to execute the method

1. Get the name servers set ("Name Servers") where each unique name 
   server name is linked to a possibly empty set of its IP 
   addresses by using method [Get-Zone-NS-Names-and-IPs].

2. Extract the IP addresses from *Name Servers* and create a
   set of unique IP addresses.

3. Output the set of IP addresses.

### Outputs

* The possibly empty set of IP addresses.

### Special procedural requirements

None.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get in-bailiwick address records in zone

### Method identifier
**Get-IB-Addr-in-Zone**

### Objective

From the child zone, obtain the address records matching the
[in-bailiwick] name server names found in the zone itself.
Extract addresses even if the resolution goes through CNAME. 
It is, however, not permitted for a NS record
to point at a name that has a CNAME, but that test is
covered by Test Case [DELEGATION05].

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.

This method also inherits the inputs of method [Get-Del-NS-IPs].

### Prerequisite

As specified in method [Get-Del-NS-IPs].

### Ordered description of steps to be taken to execute the method

1. Using method [Get-Del-NS-IPs], obtain the IP addresses to the name 
   servers ("Name Server IPs").

2. Using method [Get-Zone-NS-Names], obtain the names of the name servers
   from the *Child Zone* ("Child Zone Name Server Names").

3. If no name in *Child Zone Name Server Names* is an [in-bailiwick] 
   name server name:
   1. Output an empty set.
   2. Exit.

4. Create a set of name servers ("Name Servers") where each unique 
   [in-bailiwick] name server name is linked to an empty set  
   of IP addresses. 

5. For each [in-bailiwick] in *Child Zone Name Server Names*:
   1. Send an A and an AAAA query to all servers in *name server IPs*
      with the RD flag unset.
   2. If a delegation (referral) to a sub-zone of Child Zone is returned, 
      follow that delegation, possibly in several steps, by repeating the
      A and AAAA queries.
   3. If a CNAME is returned, follow that, possibly in several
      steps, to resolve the name to IP addresses, if possible.
   4. Ignore non-referral responses unless AA flag is set (cached data
      is not accepted).
   5. Add found IP addresses for the name server names in *Name Servers*.

6. Output the *Name Servers*.

### Outputs

* The possibly empty set of name server names pointing at possibly
  empty sets of IP addresses.

### Special procedural requirements

None.

### Dependencies

Method [Get-Parent-Zone] must have been run and returned "true"
for the existence of *Child Zone*

[To top]

-------------------------------------------------------------

## Method: Get delegation

### Method identifier
**Get-Delegation**

### Objective

Obtain the name server names (from the NS records) and the IP addresses (from 
glue records) from the delegation of the given zone (child zone) from 
the parent zone. Glue records are address records for [in-bailiwick] name 
server names, if any. Extract addresses even if the resolution goes through 
CNAME. It is, however, not permitted for a NS record to point at a name
that has a CNAME, but that test is covered by Test Case [DELEGATION05].

IP addresses for [out-of-bailiwick] name server names are not extracted
with this method. To get those use method [Get-Del-NS-IPs] or
method [Get-Del-NS-Names-and-IPs].

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.
* "Test Type" - The test type with values "undelegated test" or "normal test".

This method also inherits the inputs of method [Get-Undel-Data] if
*Test Type* is "undelegated test" or else the inputs of method
[Get-Parent-Zone].

### Prerequisite

* Method [Get-Parent-Zone] must have returned that *Child Zone* exists
  (existence is "true").

As specified in method [Get-Undel-Data] if *Test Type* is
"undelegated test" or else as specified in method [Get-Parent-Zone].

### Ordered description of steps to be taken to execute the method

1. If the *Test Type* is "undelegated test", then:
   1. Using method [Get-Undel-Data] get the submitted data for
      *Child Zone* ("Undelegated Data").
   2. Collect the name server names from the *Undelegated Data*.
   3. Create a set of name servers ("Name Servers") where each unique 
      name server name is linked to an empty set of IP addresses. 
   4. For each [in-bailiwick] name server name collect any
      IP addresses from *Undelegated Data* and add that to the
      *Name Servers* set under the name server name.
   5. Output the *Name Servers*.
   6. Exit.

2. Steps below is for *Test Type* "normal test" only.

3. Using method [Get-Parent-Zone] extract the name server IP addresses for
   the parent zone ("Parent NS").

4. Create an NS query for the apex of the *Child Zone* with the RD flag 
   unset.

5. Send the NS query to the first name server in *Parent NS*.

6. If the response contains a referral to the Child Zone:
   1. Extract the name server names from the RDATA of the NS records in
      the authority section.
   2. Extract any A or AAAA record from the additional section if the 
      owner name is identical to a name server name ([glue records]).
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
           3. Update the *Name Servers* if a new name server name or a
              new IP address for any name server name is found.
           4. Output the *Name Servers*.
           5. Processing the method is stopped.

7. If the response is authoritative (AA bit set) and the answer section
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
         specification from previous step, then create an A and a AAAA 
         query for that name:
         1. Send the query to the same *Parent NS*.
         2. If a delegation (referral) to a sub-zone of Child Zone is 
            returned, follow that delegation, possibly in several steps, by 
            repeating the A and AAAA queries.
         3. If a CNAME is returned, follow that, possibly in 
            several steps, to resolve the name to IP addresses, if 
            possible.
         4. Ignore non-referral responses unless AA flag is set (cached 
            data is not accepted).
      4. Create a name servers set ("Name Servers") where each unique 
         name server name is linked to a possibly empty set 
         of its IP addresses. 
      5. Output the *Name Servers*.
      6. Processing the method is stopped.

8. If the server returns unexpected response: 
   1. Send the query to the next server, if available. 
   2. If no more servers remain, output an empty set and stop 
      processing the method.

### Outputs

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

The method assumes that the servers of the parent zone behaves the
same way as when method [Get-Parent-Zone] was run.

### Dependencies

Method [Get-Parent-Zone] must have been run.

[To top]

-------------------------------------------------------------

## Method: Get out-of-bailiwick ip addresses

### Method identifier
**Get-OOB-IPs**

### Objective

Obtain the IP addresses of the out-of-bailiwick name servers for the 
given zone (child zone) and a given set of name server names. Extract 
addresses even if the resolution goes through CNAME. It is,
however, not permitted for a NS record to point at a name that has a
CNAME, but that test is covered by Test Case [DELEGATION05].

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.
* "NS Set" - The names of the *Child Zone* name servers as given by the
  calling method.
* "Test Type" - The test type with values "undelegated test" or 
  "normal test".

This method also inherits the inputs of method [Get-Undel-Data] if
*Test Type* is "undelegated test".

### Prerequisite

As specified in method [Get-Undel-Data] if *Test Type* is
"undelegated test".

### Ordered description of steps to be taken to execute the method

1. Create a set of name servers ("Name Servers") where each unique 
   [out-of-bailiwick] name server name in *NS Set* is linked to an empty 
   set of IP addresses. 

2. If *Test Type* is "undelegated test", then fetch name server name and
   IP address or addresses using method [Get-Undel-Data]
   ("Undelegated Data").

3. For each [out-of-bailiwick] the name server name ("Name") in 
   *NS Set* do:

   1. If *Test Type* is "undelegated test" and if the *Name*
      has IP address specification (IPv4 or IPv6) in *Undelegated Data*, 
      then:
      1. Add the address or addresses to *Name Servers* for *Name*.
      2. Go to next server name server name.

   2. Create one A query and one AAAA query for the *Name*.

   3. Send the two queries doing normal recursive lookup to a resolver.

   4. If CNAME is returned for the *Name*, then follow that,
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

None.

### Dependencies

Method [Get-Parent-Zone] must have been run.

[To top]

-------------------------------------------------------------

## Method: Get data for undelegated test

### Method identifier
**Get-Undel-Data**

### Objective

Provide the data for undelegated tests, i.e. provide data that is
comparable to a delegation from the parent zone, but where the
delegation does not have to exist. The data always includes name
server names for NS records, optionally one or more IP addresses
for one or more name server names and optionally data for one or
more DS records.

This is an internal method to be used by other methods.

### Inputs

* "Child Zone" - The name of the child zone.
* "Undelegated Data" - the submitted delegation data, name server names,
  IP addresses and any DS record data for *Child Zone*

### Prerequisite

* The Test Type of *Child Zone* must be "undelegated test".
* The *Undelegated Data* must include at least one name server name.

### Ordered description of steps to be taken to execute the method

1. Get the *Undelegated Data* from the initiation of the test.

1. Return the set of name servers, where each unique name server name
   links to a possibly empty set of its IP addresses taken from the 
   *Undelegated Data*.

### Outputs

* The set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses.

### Special procedural requirements

None.

### Dependencies

None.

[To top]

-------------------------------------------------------------

## Method inter-dependencies

Method                      | Level | Dependent on method (with level)
----------------------------|-------|-----------------------------------
[Get-Undel-Data]            | 1     | -
[Get-Parent-Zone]           | 2     | [Get-Undel-Data](1)
[Get-OOB-IPs]               | 2     | [Get-Undel-Data](1)
[Get-Delegation]            | 3     | [Get-Undel-Data](1) [Get-Parent-Zone](2)
[Get-Del-NS-Names-and-IPs]  | 4     | [Get-Delegation](3) [Get-OOB-IPs](2)
[Get-Del-NS-Names]          | 5     | [Get-Del-NS-Names-and-Ips](4)
[Get-Del-NS-IPs]            | 5     | [Get-Del-NS-Names-and-IPs](4)
[Get-Zone-NS-Names]         | 6     | [Get-Del-NS-IPs](5)
[Get-IB-Addr-in-Zone]       | 6     | [Get-Del-NS-IPs](5)
[Get-Zone-NS-Names-and-IPs] | 7     | [Get-Zone-NS-Names](6) [Get-IB-Addr-in-Zone](6) [Get-OOB-IPs](2)
[Get-Zone-NS-IPs]           | 8     | [Get-Zone-NS-Names-and-IPs](7)

[To top]

-------------------------------------------------------------

## Terminology

The terms "in-bailiwick", "out-of-bailiwick" and "glue record"
are used as defined in [RFC 7719], section 6, page 15.

[RFC 7719]: https://tools.ietf.org/html/rfc7719

[BASIC01]: Basic-TP/basic01.md

[DELEGATION05]: Delegation-TP/delegation05.md

[To top]: #methods-common-to-test-case-specifications

[Get-Parent-Zone]: #method-get-parent-zone

[Get-Del-NS-Names-and-IPs]: #method-get-delegation-ns-names-and-ip-addresses

[Get-Del-NS-Names]: #method-get-delegation-ns-names

[Get-Del-NS-IPs]: #method-get-delegation-ns-ip-addresses

[Get-Zone-NS-Names]: #method-get-zone-ns-names

[Get-Zone-NS-Names-and-IPs]: #method-get-zone-ns-names-and-ip-addresses

[Get-Zone-NS-IPs]: #method-get-zone-ns-ip-addresses

[Get-IB-Addr-in-Zone]: #method-get-in-bailiwick-address-records-in-zone

[Get-Delegation]: #method-get-delegation

[Get-OOB-IPs]: #method-get-out-of-bailiwick-ip-addresses

[Get-Undel-Data]:#method-get-data-for-undelegated-test

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

[glue records]:     #terminology

[Glue records]:     #terminology

[List of Root Servers]: https://www.iana.org/domains/root/servers


[Method1]: Methods.md#method-1-obtain-the-parent-domain
[Method2]: Methods.md#method-2-obtain-glue-name-records-from-parent
[Method3]: Methods.md#method-3-obtain-name-servers-from-child
[Method4]: Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]: Methods.md

