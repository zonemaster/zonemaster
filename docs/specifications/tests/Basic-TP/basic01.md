## BASIC01: The domain must have a parent domain

### Test case identifier
**BASIC01**

### Objective

In order for a domain (zone) to work, it must be delegated from a 
zone higher up in the DNS hierarchy (a parent domain/zone). 
This Test Case will determine if parent and child zones exist.

If the zone to be tested is the root zone, it has no parent or
delegation and will always pass this Test Case.

If no parent can be determined, there cannot be any delegation.

If the child zone does not exist (is not delegated), the only 
test case to be run after this test case is BASIC03. However, 
if the test type is an undelegated test, then all other test cases 
can be run even if the child zone is not delegated.

### Inputs

Input for this Test Case:
* "Child Zone" - The label of the domain name (zone) to be tested
* "Root Name Servers" - The IANA [List of Root Servers] 
* "Test Type" - The test type with values "undelegated test" or 
  "normal test".

### Ordered description of steps to be taken to execute the test case

1. If the *Child Zone* is the root zone ("."):
   1. The parent zone is set to the root zone (".") and the zone to be 
      tested is assumed to exist. 
   2. Output *[ROOT_HAS_NO_PARENT]* and exit.

2. Find the parent zone of the *Child Zone* by performing recursive 
   lookup for the SOA record of the *Child Zone* with the RD bit unset.
   Start by using a nameserver from the *Root Name Servers*.

3. Continue, step by step, until the parent zone (of the *Child Zone*) has 
   been reached by using the referrals (delegations) found.

4. If the lookup reaches a name server that responds with a referral 
   (delegation) directly to the requested *Child Zone*:
   1. The zone in which the delegation was found is defined to be the 
      parent zone. Output *[PARENT_FOUND]*.
   2. The existence of the *Child Zone* has been determined. Output 
      *[CHILD_FOUND]*.
   3. Repeat the SOA query for the *Child Zone* to the remaining name 
      servers for the parent zone.
      1. If any server returns NXDOMAIN, NODATA or CNAME/DNAME, then
      	 output *[INCONSISTENT_DELEGATION]*. 
   4. Exit.

5. If the lookup reaches a name server that authoritatively responds
   (AA flag set) and either with NXDOMAIN for the *Child Zone* or
   with NOERROR and no record in the answer section (NODATA): 
   1. The zone returning NXDOMAIN or NODATA is defined to be the parent 
      zone. Output *[PARENT_FOUND]*.
   2. Repeat the SOA query for the *Child Zone* to the remaining name 
      servers for the parent zone.
      1. If any server returns a referral (delegation) directly to the *Child
      	 Zone*, then output *[INCONSISTENT_DELEGATION]* and go back to 
         step 4 with the found delegation.
   3. The non-existence of the *Child Zone* has been determined. 
      1. If *Test Type* is "normal test", then output *[NO_CHILD]* 
         and exit.
      2. Or, if *Test Type* is "undelegated test", then output 
         *[CHILD_NOT_DELEGATED]* and exit.

6. If the lookup reaches a name server that non-authoritatively responds
   (AA flag unset) with a CNAME or DNAME record in the answer section:
   1. A CNAME (DNAME) query with the RD flag unset is sent to the same server.
   2. If the lookup returns an authoritative answer with a CNAME (DNAME) with
      *Child Zone* name as owner name, then continue to step 7, else repeat 
      from step 3 using the next server. 

7. If the lookup reaches a name server that authoritatively responds
   (AA flag set) with a CNAME or DNAME record in the answer section:
   1. The zone returning authoritative data is defined to be the parent zone. 
      Output *[PARENT_FOUND]*.
   2. Repeat the SOA query for the *Child Zone* to the remaining name servers 
      for the parent zone.
      1. If any server returns a referral (delegation) directly to the *Child
      	 Zone*, then output *[INCONSISTENT_DELEGATION]* and go back to step 4 
         with the found delegation.
   3. The non-existence of the *Child Zone* has been determined. 
      1. If *Test Type* is "normal test", then output *[NO_CHILD]*
         and exit. 
      2. Or, if *Test Type* is "undelegated test", then output 
         *[CHILD_NOT_DELEGATED]* and exit.

8. If the lookup reaches a name server that authoritatively responds
   (AA flag set) with an SOA record with *Child Zone* as the owner name 
   in the answer section, then:
   1. The zone in the previous delegation is defined to be the parent 
      zone. Output *[PARENT_FOUND]*.
   2. The existence of the *Child Zone* has been determined. Output
      *[CHILD_FOUND]*.
   3. Repeat the SOA query for the *Child Zone* to remaining name servers 
      for the parent zone.
      1. If any server returns a referral (delegation) directly to the *Child
      	 Zone*, then go back to step 4 with the found delegation.
      2. Or, if any server returns NXDOMAIN, NODATA or CNAME/DNAME, then output 
      	 *[INCONSISTENT_DELEGATION]*.
   4. Exit.

9. If the server does not respond, the response contains an unexpected RCODE or
    any other error, repeat from step 3 using the next server. 

10. If delegation to a zone at a higher level than *Child Zone* is returned, 
    then follow the delegation.

11. If all servers above are exhausted: 
    1. Output *[PARENT_INDETERMINED]*.
    1. If *Test Type* is "normal test", output *[NO_CHILD]*.
    2. If *Test Type* is "undelegated test", output *[CHILD_NOT_DELEGATED]*.

### Test Type and existence of parent and child 

Parent zone     | *Child Zone*       | *Test Type* | Run test?
----------------|--------------------|-------------|---------------------
Determined      | Exists             | Normal      | Yes
Determined      | Exists             | Undelegated | Yes
Determined      | Does not exist (1) | Normal      | No
Determined      | Does not exist (1) | Undelegated | N/A (2)
Indetermined (3)| Indetermined       | Normal      | No
Indetermined (3)| Indetermined       | Undelegated | N/A (2)
Indetermined (3)| Exists (2)         | Undelegated | Yes

1. Parent zone returns an authoritative NXDOMAIN or NODATA on the 
   *Child Zone* name.
2. If *Test Type* is "undelegated test" the *Child Zone* is
   defined to exist even if there is no delegation.
3. Server or zone error prevents determination of parent zone.
4. If *Test Type* is "normal test" then it is impossible to find the *Child Zone*
   and the delegation to it when the parent zone cannot be determined.

### Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message 
with the severity level ERROR or CRITICAL.

The outcome of this Test Case is "warning" if there is at least one 
message with the severity level WARNING, but no message with severity level 
ERROR or CRITICAL.

In other cases the outcome of this Test Case is "pass".

The name of the parent zone (or empty if it cannot be determined), plus
verification of whether or not the *Child Zone* exists is returned together 
with relevant messages.

Message                        |Default severity level of message
-------------------------------|----------------------------------------------
ROOT_HAS_NO_PARENT             |INFO
PARENT_FOUND                   |INFO
PARENT_INDETERMINED            |NOTICE
CHILD_FOUND                    |INFO
NO_CHILD                       |ERROR
CHILD_NOT_DELEGATED            |INFO
INCONSISTENT_DELEGATION        |ERROR

### Special procedural requirements

None.

### Intercase dependencies

[BASIC00] must have been run with "pass" outcome before this test case
can be run.

### Special considerations

The Test Case must, in general, use the same algorithm as Method
[Get-Parent-Zone].


[List of Root Servers]: https://www.iana.org/domains/root/servers

[BASIC00]: basic00.md

[BASIC03]: basic03.md

[ROOT_HAS_NO_PARENT]: #outcomes

[PARENT_FOUND]: #outcomes

[PARENT_INDETERMINED]: #outcomes

[UNDEL_AND_PARENT_INDETERMINED]: #outcomes

[CHILD_FOUND]: #outcomes

[NO_CHILD]: #outcomes

[CHILD_NOT_DELEGATED]: #outcomes

[INCONSISTENT_DELEGATION]: #outcomes

[Get-Parent-Zone]: ../Methods.md#method-get-parent-zone

