## BASIC01: The domain must have a parent domain

### Test case identifier
**BASIC01** The domain must have a parent domain

### Objective

In order for a domain (zone) to work, it must be delegated from a 
zone higher up in the DNS hierarchy (a parent domain/zone). 
This Test Case will determine if parent and child zones exist.

If the zone to be tested is the root zone, it has no parent or
delegation and will always pass this Test Case.

If the child zone does not exist, only BASIC03 will run,
unless the test type is an undelegated test, which can always be 
run.

### Inputs

Input for this Test Case:
* The label of the domain name (zone) to be tested ("child zone").
* The IANA [List of Root Servers] ("root name servers").
* Determination of test type; "undelegated test" or "normal test".

### Ordered description of steps to be taken to execute the test case

1. If the *child zone* is the root zone ("."):
   1. The parent zone is set to the root zone (".") and the zone to be tested
      is assumed to exist.
      Emit the message *[ROOT_HAS_NO_PARENT]*.
   2. Exit the steps.

2. Starting from the root zone, find the parent zone by performing a recursive 
   lookup for the SOA record of the *child zone* with the RD bit unset using the
   *root name servers*.

3. In every step, register all name server addresses connected to the next zone until the
   parent zone (of the *child zone*) has been reached.

4. If the lookup reaches a name server that responds with a redirect (delegation)
   directly to the requested *child zone*:
   1. The zone in which the delegation was found is considered to be the parent 
      zone. Emit the message *[PARENT_FOUND]*.
   2. The existance of the *child zone* has been determined. Emit the message
      *[CHILD_FOUND]*.
   3. Repeat the SOA query for the *child zone* to all name servers for the
      parent zone.
   4. If any server returns NXDOMAIN, NODATA or CNAME/DNAME, emit *[INCONSISTENT_DELEGATION]*. **(Noting relationship to other steps appears irrelevant for this particular sub-step.)**
   3. Exit.

5. If the recursive lookup reaches a name server that authoritatively responds
   (AA flag set) with NXDOMAIN for the child domain (*child zone*): 
   1. The zone returning NXDOMAIN is considered to be the parent zone. Emit the
      message *[PARENT_FOUND]*.
   2. Repeat the SOA query for the *child zone* to all name servers for the
      parent zone.
   3. If any server returns a redirect (delegation) directly to the *child
      zone* then go back to step 4 with that result.
   4. If any server returns NODATA or CNAME/DNAME, emit *[INCONSISTENT_DELEGATION]*.
   5. The non-existance of the *child zone* has been determined. 
   6. If *normal test*, emit the message *[NO_CHILD]*. If *undelegated test*,
      emit the message *[UNDEL_AND_NO_CHILD]*.
   7. Exit.

6. If the recursive lookup reaches an authorititative NOERROR answer (AA flag set), 
   with no record in the answer section (NODATA): **(Reaches? Receives?)**
   1. The zone returning authoritative data is considered to be the parent zone. 
      Emit the message *[PARENT_FOUND]*.
   2. Repeat the SOA query for the *child zone* to all name servers for the
      parent zone.
   3. If any server returns a redirect (delegation) directly to the *child
      zone* then go back to step 4 with that result.
   4. If any server returns NXDOMAIN or CNAME/DNAME, emit *[INCONSISTENT_DELEGATION]*.
   5. The non-existance of the *child zone* has been determined.
   6. If *normal test*, emit the message *[NO_CHILD]*. If *undelegated test*,
      emit the message *[UNDEL_AND_NO_CHILD]*.
   7. Exit.

7. If the recursive lookup reaches a non-authorititative NOERROR answer (AA flag 
   unset), with a CNAME or DNAME record in the answer section: **(Reaches? Receives?)**
   1. A CNAME (DNAME) query with the RD flag unset is sent to the same server.
   2. If the lookup returns an authoritative answer with a CNAME (DNAME) with
      *child zone* name as owner name, then continue to step 8, else continue
      with next server in previous sub-step.

8. If the recursive lookup reaches an authorititative NOERROR answer (AA flag 
   set), with a CNAME or DNAME record in the answer section:
   1. The zone returning authoritative data is considered to be the parent zone. 
      Emit the message *[PARENT_FOUND]*.
   2. Repeat the SOA query for the *child zone* to all name servers for the
      parent zone.
   3. If any server returns a redirect (delegation) directly to the *child
      zone* then go back to step 4 with that result.
   4. If any server returns NXDOMAIN or NODATA, emit *[INCONSISTENT_DELEGATION]*.
   5. The non-existance of the *child zone* has been determined.
   6. If *normal test*, emit the message *[NO_CHILD]*. If *undelegated test*,
      emit the message *[UNDEL_AND_NO_CHILD]*.
   7. Exit.

9. If the recursive lookup reaches an authorititative NOERROR answer (AA flag 
   set), with an SOA record with owner name child domain in the answer section: **(Reaches? Receives?)**
   1. The zone the previous delegation is considered to be the parent zone. Emit the
      message *[PARENT_FOUND]*. **(Word missing? "The zone (...) the previous delegation...")**
   2. The existance of the *child zone* has been determined. Emit the message
      *[CHILD_FOUND]*.
   3. Repeat the SOA query for the *child zone* to all name servers for the
      parent zone.
   4. If any server returns NXDOMAIN, NODATA or CNAME/DNAME emit *[INCONSISTENT_DELEGATION]*.
   5. Exit.

10. If the server does not respond, the response contain an unexpected RCODE or
    any other error, repeat from step 3 using the next server. 

11. If delegation to a zone at a higher level than *child zone* is returned, 
    then follow the delegation.

12. If all tests above are exhausted: 
    1. The parent zone cannot be determined.
    2. The *child zone* cannot be determined.
    3. If *normal test*, emit the messages *[NO_CHILD]* and *[PARENT_INDETERMINED]*.
       If *undelegated test*, emit the messages *[UNDEL_AND_NO_CHILD]* and 
       *[UNDEL_AND_PARENT_INDETERMINED]*.
    4. Exit.


Parent zone     |*child zone*        |Run normal test?|Run undelegated test
----------------|------------------|----------------|---------------------------------
Determined      |Exists            |Yes             |Yes (1)
Determined      |Does not exist (2)|No              |Yes
Indetermined (3)|Indetermined      |No              |Yes

  (1) Ignore delegation data and used provided data. **(Is "used provided data" an accurate term or typo?)**

  (2) Parent zone returns an authoritative NXDOMAIN, SOA record or NODATA on the 
      *child zone* name.
  
  (3) Server or zone error prevents determination of parent zone.


### Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message 
with the severity level ERROR or CRITICAL.

The outcome of this Test Case is "warning" if there is at least one 
message with the severity level WARNING, but no message with severity level 
ERROR or CRITICAL.

In other cases the outcome of this Test Case is "pass".

The name of the parent zone (or empty if it cannot be determined), plus
verification of whether or not the *child zone* exists is returned together with relevant 
messages.

Messege                        |Default severity level (if message is emitted)
-------------------------------|----------------------------------------------
ROOT_HAS_NO_PARENT             |INFO
PARENT_FOUND                   |INFO
PARENT_INDETERMINED            |ERROR
UNDEL_AND_PARENT_INDETERMINED  |NOTICE
CHILD_FOUND                    |INFO
NO_CHILD                       |ERROR
UNDEL_AND_NO_CHILD             |NOTICE
INCONSISTENT_DELEGATION        |ERROR

### Special procedural requirements

None.

### Intercase dependencies

[BASIC00] must have been run with "pass" outcome before this test case
can be run.



[List of Root Servers]: https://www.iana.org/domains/root/servers

[BASIC00]: basic00.md

[BASIC03]: basic03.md

[ROOT_HAS_NO_PARENT]: #outcomes

[PARENT_FOUND]: #outcomes

[PARENT_INDETERMINED]: #outcomes

[UNDEL_AND_PARENT_INDETERMINED]: #outcomes

[CHILD_FOUND]: #outcomes

[NO_CHILD]: #outcomes

[UNDEL_AND_NO_CHILD]: #outcomes

[INCONSISTENT_DELEGATION]: #outcomes
