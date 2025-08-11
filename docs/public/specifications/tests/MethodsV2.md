# Methods common to Test Case Specifications (version 2)

## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Internal Methods](#internal-methods)
* [Methods Inputs]
* [Method: Get parent NS names and IP addresses][Get-Parent-NS-Names-and-IPs]
* [Method: Get parent NS IP addresses][Get-Parent-NS-IPs]
* [Method: Get delegation NS names and IP addresses][Get-Del-NS-Names-and-IPs]
* [Method: Get delegation NS names][Get-Del-NS-Names]
* [Method: Get delegation NS IP addresses][Get-Del-NS-IPs]
* [Method: Get zone NS names][Get-Zone-NS-Names]
* [Method: Get zone NS names and IP addresses][Get-Zone-NS-Names-and-IPs]
* [Method: Get zone NS IP addresses][Get-Zone-NS-IPs]
* [Method: Get delegation (Internal)][Get-Delegation]
* [Method: Get in-bailiwick address records in zone (Internal)][Get-IB-Addr-in-Zone]
* [Method: Get out-of-bailiwick ip addresses (Internal)][Get-OOB-IPs]
* [Method inter-dependencies](#method-inter-dependencies)
* [Terminology](#terminology)


## Objective

The Methods are used in, and referred from, the Test Case specifications as
shortcuts for steps shared between Test Cases. A Test Case that makes use of any
of the Methods defined in this document must refer directly to the
specific Method or Methods.

[To top]


## Scope

This document holds version 2 of the set of Methods. Version 1 is defined in
[Methods]. Methods from version 1 will be replaced by Methods from version 2 in
all Test Case specifications.

Before the transition all Test Cases specifications use version 1 ([Methods]).
During the transition it will be stated in each specification if the
Test Case uses Methods from version 1 ([Methods]) or Methods from version 2 (this
document). When the transition is completed, the version 1 document will be
removed.

In these Methods any DS record data in *Undelegated Data* is disregarded. If
with *Child Zone* DS record data is provided, but no name server data, then the
will here be treated as "normal test", not "undelegated test".

[To top]


## Internal methods

Methods, in this document, that are referred to as *Internal* or
*Internal Method* must not be referred to from the Test Case specifications.
*Internal Methods* may only be referred to from Methods in this document. Test
Case specifications can freely refer to the other Methods.

[To top]


## Methods Inputs

The following input units are provided when a Method is executed and are
available to all Methods. All Methods, however, do not use all input units and
it is specified in the Method inputs subsections which units are used for the
specific Method.

* "Child Zone" - Mandatory data. The name of the zone to be tested. It must be
  a [valid domain name].
* "Root Name Servers" - The default data is the IANA [Root Hints File] with
  names and IP addresses of the root name servers, but that can optionally be
  replaced by equivalent information to a private root zone. It must contain at
  least one [valid name server name] with at least one [valid IP address].
* "Undelegated Data" - Optional data. If included it must consist of a set of
  at least one [valid name server name] and for each name server name an optional
  set of at least one [valid IP address]. The name servers and IP addresses
  represent a possible delegation of *Child Zone* from its parent zone (may be
  indetermined).
* "Test Type" - Derived data. It is set to "normal test" if *Undelegated Data* is
  absent (empty) and to "undelegated test" if it is non-empty.

[To top]


## Method: Get parent NS names and IP addresses

### Method identifier
**Get-Parent-NS-Names-and-IPs**

### Objective

This Method will obtain the names and IP addresses of the name servers that
serve the parent zone, i.e. the zone from which the *Child Zone* is delegated
from.

This is done by finding the parent zone and then the name servers that serve the
parent zone. In case there is an inconsistency of which is the parent zone, the
list of name servers will be the gross list, i.e. rather include too much than
too little. Too much is always a result of incorrect configuration in the parent
zone or in a grand parent zone.

If *Child Zone* is the root zone, then there is by definition no parent zone and
no parent name servers.

If the test type is undelegated, then the information that the parent name
servers are supposed to provide included in the input data. In that case a list
of parent name servers has no meaning.

The Method will output a list of parent name server names and IP addresses. If
the zone is the root zone or if the test is an undelegated test, the list is
defined but empty. If the parent zone cannot be determined, then an undefined
list is returned.

Addresses for name servers (RDATA of NS records) are extracted even if the
resolution goes through CNAME. It is, however, not permitted for a NS record
to point at a name that has a CNAME, but that test is covered by Test Case
[Delegation05]. This method should extract as much as possible to find all
possible paths.

This Method must, in general, use the same algorithm as Test Case [Basic01], but
the test case extracts more information and outputs messages.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.
* "Root Name Servers"
* "Test Type" - "[undelegated test]" or "normal test".

### Procedures

1. If the *Child Zone* is the root zone (".") then output empty set and exit
   these procedures.

2. If the *Test Type* is "undelegated test" then output empty set and exit
   these procedures.

3. Create the following empty sets:
   1.  Name server name, name server IP and zone name tuples ("Remaining
       Servers").
   2.  Name server name, name server IP and zone name tuples ("Handled
       Servers").
   3.  Parent name server name and IP address pairs ("Parent Name Servers").

4. Insert all names and addresses from *Root Name Servers* and the root zone
   name into the *Remaining Servers* set.

> In the loop below, the steps tries to capture the name of the parent zone of
> **Child Zone** and the IP addresses of the name servers for that parent zone.
> This is done using a modified version of the "QNAME minimization" technique
> [RFC 9156]. SOA is the query type used for traversing the tree.

5. While the *Remaining Servers* is non-empty pick next name server name, IP
   address and zone name tuple from the set ("Server Name", "Server Address"
   and "Zone Name") and do:

   1.  Extract and remove the *Server Name*, *Server Address* and *Zone Name*
       tuple from *Remaining Servers*.
   2.  Insert the *Server Name*, *Server Address* and *Zone Name* tuple into
       *Handled Servers*.
   3.  If *Handled Servers* contains two or more tuples with the same
       *Server Address* and *Zone Name* (but not necessarily the same *Server
       Name*), then:
       1. If an item exists in *Parent Name Servers* whose IP address equals
          *Server Address*, then add the *Server Name* and *Server Address*
          pair to the *Parent Name Servers* set.
       2. Go to next server in *Remaining Servers*.
   4.  Create [DNS queries][DNS Query]:
       1. Query type SOA and query name *Zone Name* ("Zone Name SOA Query").
       2. Query type NS and query name *Zone Name* ("Zone Name NS Query").
   5.  [Send] *Zone Name SOA Query* to *Server Address*.
   6.  Go to next server in *Remaining Servers* if one or more of the following
       matches:
          * No DNS response.
          * [RCODE Name] different from NoError in response.
          * AA bit not set in response.
          * Not exactly one SOA record in answer section
          * Owner name of SOA record is not *Zone Name*.
   7.  [Send] *Zone Name NS Query* to *Server Address*.
   8.  Go to next server in *Remaining Servers* if one or more of the following
       matches:
          * No DNS response.
          * [RCODE Name] different from NoError in response.
          * AA bit not set in response.
          * No NS records in answer section
          * Owner name of any of the NS records is not *Zone Name*.
   9.  Extract the name server names from the NS records and any address records
       in the additional section.
   10. Do [DNS Lookup] of name server names (A and AAAA) not already listed in
       the additional section of the response. If a CNAME is encountered,
       follow the chain of CNAME records but use the original name as obtained
       from the NS record RDATA when storing the data in the next substep.
       1. For each IP address add the name server name, IP address and *Zone
          Name* tuple to the *Remaining Servers* set, unless such a tuple
          already exists in *Handled Servers*.
       2. Ignore any failing lookups or lookups resulting in NODATA or NXDOMAIN.
   11. Create "Intermediate Query Name" by copying *Zone Name* as start value.
   12. Run a loop processing *Server Name* and *Server Address* (jumps back
       here from the steps below).
       1. Extend *Intermediate Query Name* by adding one more label to the left
          by copying the equivalent label from *Child Zone*. (See "Example 1"
          below.)
       2. Create a [DNS Query] with query name
          *Intermediate Query Name* and [query type] SOA
          ("Intermediate SOA query").
       3. [Send] *Intermediate SOA Query* to *Server Address*. (See "Example 2"
          below.)
       4. Go to next server in *Remaining Servers* if there is no DNS response.
       5. If the response has exactly one SOA record with owner name
          *Intermediate Query Name* in the answer section, with the AA bit
          set and [RCODE Name] NoError then do:
          1. If *Intermediate Query Name* is equal to *Child Zone* then
             1. Save the *Server Name* and *Server Address* pair to the
                *Parent Name Servers* set.
             2. Go to next server in *Remaining Servers*.
          2. Else do:
             1. Create a [DNS query][DNS Query] with query name
                *Intermediate Query Name* and [query type] NS
                ("Intermediate NS query").
             2. [Send] *Intermediate NS Query* to *Server Address*.
             3. Go to next server in *Remaining Servers* if one or more of the
                following matches:
                   * No DNS response.
                   * [RCODE Name] different from NoError in response.
                   * AA bit not set in response.
                   * No NS records in answer section.
                   * Owner name of any of the NS records is not *Intermediate Query Name*.
             4. Extract the name server names from the NS records and any address
                records in the additional section.
             5. Do [DNS Lookup] of name server names (A and AAAA) not already
                listed in the additional section of the response. If a CNAME
                is encountered, follow the chain of CNAME records but use the
                original name as obtained from the NS record RDATA when storing
                the data in the next step.
             6. For each name and IP address add the name, IP address and
                *Intermediate Query Name* tuple to the *Remaining Servers* set,
                unless such a tuple already exists in *Handled Servers*.
             7. Set *Zone Name* to *Intermediate Query Name*.
             8. Go back to the start of the loop.
       6. Else, if the response contains a [Referral] of *Intermediate Query Name*
          then do:
          1. If *Intermediate Query Name* is equal to *Child Zone* then do:
             1. Save the *Server Name* and *Server Address* pair to the
                *Parent Name Servers* set.
          2. Else do:
             1. Extract the name server names from the NS records and any glue
                records.
             2. Do [DNS Lookup] of name server names (A and AAAA) not already
                listed as glue record or records. Follow CNAME if provided.
             3. For each name and IP address add the *Server Name*, *Server
                Address* and *Intermediate Query Name* tuple to the *Remaining
                Servers* set, unless such a tuple already exists in *Handled
                Servers*.
          3. Go to next server in *Remaining Servers*.
       7. Else, if the [RCODE Name] is NoError and the AA is set then do:
          1. If *Intermediate Query Name* is not equal to *Child Zone* then
             go back to the start of the loop.
          2. Else go to next server in *Remaining Servers*.
       8. Else, go to next server in *Remaining Servers*.

> Examples referred to from the steps.
>
> Example 1: If *Child Zone* is "foo.bar.xa" and *Intermediate Query Name* is "."
> (root zone) then *Intermediate Query Name* becomes "xa". If it is "xa", it
> will become "bar.xa" instead.
>
> Example 2: An "bar.xa SOA" query to a name server for "xa".

6. If the *Parent Name Servers* set is non-empty then do:
   1. Extract the list of name server names and IP addresses.
   2. Return the following from the Method:
      1. The extracted list of name server names and IP addresses (parent zone
         name servers).
   3. Exit these procedures.

7. If the *Parent Name Servers* set is empty then do:
   1. Return the following from the Method:
      1. Undefined value. (Parent name severs cannot be determined.)
   2. Exit these procedures.


### Outputs

* A set of name server IP address for the parent zone:
  * Non-empty set: The name servers have been identified.
  * Empty set: Root zone or undelegated test.
  * Undefined set: The name servers cannot be determined due to errors in the
    delegation.

### Dependencies

None.

[To top]



## Method: Get parent NS IP addresses

### Method identifier
**Get-Parent-NS-IPs**

### Objective

This Method will obtain the IP addresses of the name servers that serve the
parent zone, i.e. the zone from which the *Child Zone* is delegated from.

The procedure is identical to the one used by
[Get-Parent-NS-Names-and-IPs], except that this Method only collects and
outputs IP addresses instead of name-IP address pairs.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.
* "Root Name Servers"
* "Test Type" - "[undelegated test]" or "normal test".

### Procedures

1. Get the set of parent name servers by using [Get-Parent-NS-Names-and-IPs]
   ("Parent Name Servers").

2. If the *Parent Name Servers* set is undefined, then output an undefined set and
   exit these procedures.

3. If the *Parent Name Servers* set is empty, then output an empty set and exit these
   procedures.

4. Extract the IP addresses from *Parent Name Servers* and create a set of
   unique addresses ("Parent NS IPs").

5. Output the *Parent NS IPs* set.

### Outputs

* A set of name server IP address for the parent zone:
  * Non-empty set: The name servers have been identified.
  * Empty set: Root zone or undelegated test.
  * Undefined set: The name servers cannot be determined due to errors in the
    delegation.

### Dependencies

This Method depends on [Get-Parent-NS-Names-and-IPs].

[To top]


## Method: Get delegation NS names and IP addresses

### Method identifier
**Get-Del-NS-Names-and-IPs**

### Objective

Obtain the name server names (from the NS records) and the IP addresses (from
Glue Records) from the delegation of the given zone (child zone) from
the parent zone. [Glue Records], if any, are address records for name
server names. Also obtain the IP addresses for the [Out-Of-Bailiwick] name
server names, if any. If the [Glue Records] include address records for
[Out-Of-Bailiwick] name servers they will be included twice, unless identical.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1. Get the set of name servers where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method [Get-Delegation]
   ("Name Servers").

2. If the *Name Servers* set is undefined, then output an undefined set and exit
   these procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit these
   procedures.

4. Extract the set of [Out-Of-Bailiwick] name server names from *Name Servers*
   ("OOB Names").

3. Get the IP addresses for name server names in *OOB Names* by using Method
   [Get-OOB-IPs] with *OOB Names* as input.

4. Merge the set returned from [Get-OOB-IPs] with *Name Servers*.

5. Output the *Name Servers* set.

### Outputs

* A set of delegation name servers, where each unique name server name
  links to a possibly empty set of its IP addresses:
  * Non-empty set: The normal case.
  * Empty set: [Get-Delegation] returned an empty set.
  * Undefined set: [Get-Delegation] returned an undefined set.

### Dependencies

This Method depends on [Get-Delegation] and [Get-OOB-IPs].

[To top]


## Method: Get delegation NS names

### Method identifier
**Get-Del-NS-Names**

### Objective

In general, this Method replaces [Method2] in [Methods], version 1.

Obtain the name server names for *Child Zone* as defined in the delegation from
parent zone.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1. Get the set of name servers where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method
   [Get-Del-NS-Names-and-IPs] ("Name Servers").

2. If the *Name Servers* set is undefined, then output an undefined set and exit
   these procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit these
   procedures.

3. If the set is empty, then output an empty set and exit these test
   procedures.

4. Extract the set of name server names from *Name Servers*.

5. Output the set of name server names.

### Outputs

* The set of delegation name server names:
  * Non-empty set: The normal case.
  * Empty set: [Get-Del-NS-Names-and-IPs] returned an empty set.
  * Undefined set: [Get-Del-NS-Names-and-IPs] returned an undefined set.

### Dependencies

This Method depends on [Get-Del-NS-Names-and-IPs].


[To top]


## Method: Get delegation NS IP addresses

### Method identifier
**Get-Del-NS-IPs**

### Objective

In general, this Method replaces [Method4] in [Methods], version 1.

Obtain the IP addresses (from [Glue Records]) from the delegation of
the given zone (child zone) from the parent zone. [Glue Records] are address
records for [In-Bailiwick] name server names, if any. Obtain the IP addresses
for the [Out-Of-Bailiwick] name server names, if any.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1. Get the set of name servers where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method
   [Get-Del-NS-Names-and-IPs] ("Name Servers").

2. If the *Name Servers* set is undefined, then output an undefined set and exit
   these procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit these
   procedures.

4. Extract the IP addresses from *Name Servers* and create a set of
   unique addresses ("NS IPs").

5. Output the *NS IPs* set.

### Outputs

* The set of delegation name server IP addresses:
  * Non-empty set: The normal case.
  * Empty set: [Get-Del-NS-Names-and-IPs] returned an empty set.
  * Undefined set: [Get-Del-NS-Names-and-IPs] returned an undefined set.

### Dependencies

This Method depends on [Get-Del-NS-Names-and-IPs].

[To top]


## Method: Get zone NS names

### Method identifier
**Get-Zone-NS-Names**

### Objective

In general, this Method replaces [Method3] in [Methods], version 1.

Obtain the names of the authoritative name servers for the given zone
(child zone) as defined in the NS records in the zone itself.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1.  Using Method [Get-Del-NS-IPs], obtain the IP addresses of the
    name servers ("Name Server IPs").

2.  If the *Name Server IPs* set is undefined, then output an undefined set and
    exit these procedures.

3.  If the *Name Server IPs* set is empty, then output an empty set and exit
    these procedures.

4.  Create an empty set of name server names ("Name Server Names").

5.  Create a [DNS Query] with query type NS and query name *Child Zone*
    ("NS Query").

6.  [Send] *NS Query* to every IP address in *Name Server IPs*.

7.  Collect all [DNS Responses][DNS Response] and ignore all non-responses.

8.  Collect all the unique NS records with *Child Zone* as owner name in the
    answer sections of the responses where the AA flag is set. Ignore any other
    response.

9.  Extract the name server names from the RDATA of the NS records and add them
    to the *Name Server Names* set.

10. Output the possibly empty *Name Server Names* set.

### Outputs

* The set of zone name servers (name server names):
  * Non-empty set: The normal case.
  * Empty set: [Get-Del-NS-IPs] returned an empty set or no name server
    names were found.
  * Undefined set: [Get-Del-NS-IPs] returned an undefined set.

### Dependencies

This Method depends on [Get-Del-NS-IPs].

[To top]


## Method: Get zone NS names and IP addresses

### Method identifier
**Get-Zone-NS-Names-and-IPs**

### Objective

Obtain the name server names (extracted from the NS records) from the apex of the
child zone. For [In-Bailiwick] name server names obtain the IP addresses from the
child zone. For the [Out-Of-Bailiwick] name server names obtain the IP addresses
from resolver lookup.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1. Get the name server names for the *Child Zone* as defined in
   the *Child Zone* by using Method [Get-Zone-NS-Names] ("Names").

2. If the *Names* set is undefined, then output an undefined set and
   exit these procedures.

3. If the *Names* set is empty, then output an empty set and exit
   these procedures.

4. Create a set of name servers where each unique name server name in *Names*
   is linked to an empty set of IP addresses ("Name Servers").

5. Fetch the IP addresses for any [In-Bailiwick] name server
   names in *Names* by using Method [Get-IB-Addr-in-Zone].

6. Add each fetched IP address, if any, to *Name Servers* to the name
   server name it belongs to.

7. Extract the set of [Out-Of-Bailiwick] name server names from *Names*
   ("OOB Names").

8. Get the IP addresses for name server names in *OOB Names* by using Method
   [Get-OOB-IPs] with *OOB Names* as input.

9. Merge the set returned from [Get-OOB-IPs] with *Name Servers*.

10. Output the *Name Servers* set.

### Outputs

* The set of zone name servers, where each unique name server name links to a
  possibly empty set of its IP addresses:
  * Non-empty set: The normal case.
  * Empty set: [Get-Zone-NS-Names] returned an empty set.
  * Undefined set: [Get-Zone-NS-Names] returned an undefined set.

### Dependencies

This Method depends on Methods [Get-Zone-NS-Names], [Get-IB-Addr-in-Zone]
and [Get-OOB-IPs].

[To top]


## Method: Get zone NS IP addresses

### Method identifier
**Get-Zone-NS-IPs**

### Objective

In general, this Method replaces [Method5] in [Methods], version 1.

Obtain the IP addresses of the name servers, as extracted from
the NS records of apex of the child zone.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1. Get the name servers set where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method
   [Get-Zone-NS-Names-and-IPs] ("Name Servers");

2. If the *Name Servers* set is undefined, then output an undefined set and
   exit these procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit
   these procedures.

4. Extract the IP addresses from *Name Servers* and create a
   set of unique IP addresses.

5. Output the set of IP addresses.

### Outputs

* The set of zone name server IP addresses:
  * Non-empty set: The normal case.
  * Empty set: [Get-Zone-NS-Names-and-IPs] returned an empty set.
  * Undefined set: [Get-Zone-NS-Names-and-IPs] returned an undefined set.

### Dependencies

This Method depends on Method [Get-Zone-NS-Names-and-IPs].


[To top]


## Method: Get delegation (Internal)

### Method identifier
**Get-Delegation**

### Objective

Obtain the name server names (from the NS records) and the IP addresses (from
[Glue Records]) from the delegation of the given zone (child zone) from
the parent zone. [Glue Records] are address records for [In-Bailiwick] name
server names, if any. Extract addresses even if the resolution goes through
CNAME. It is, however, not permitted for a NS record to point at a name
that has a CNAME, but that test is covered by Test Case [Delegation05].

IP addresses for [Out-Of-Bailiwick] name server names are not extracted
with this Method. To get those use Method [Get-Del-NS-IPs] or
Method [Get-Del-NS-Names-and-IPs].

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.
* "Root Name Servers"
* "Undelegated Data" -  The name servers and IP addresses representing a
  possible delegation of *Child Zone*.
* "Test Type" - "undelegated test" or "normal test".


### Procedures

1. If the *Test Type* is "undelegated test", then:
   1. Use *Undelegated Data*.
   2. Create an empty set of name servers where each unique name server name is
      linked to an empty set of IP addresses ("Name Servers").
   3. Extract all name server names from the *Undelegated Data* set and add to
      the *Name Servers* set.
   4. For each [In-Bailiwick] name server name collect any
      IP addresses from *Undelegated Data* and add that to the
      *Name Servers* set under the name server name.
   5. For any [Out-Of-Bailiwick] name server name the IP address should be
      ignored.
   6. Output the *Name Servers* set.
   7. Exit these procedures.

2. If *Child Zone* is the root zone ".", then output the set of name server names
   and IP addresses from *Root Name Servers* and exit these procedures.

3. Using Method [Get-Parent-NS-IPs] extract the name server IP addresses for
   the parent zone ("Parent NS").

4. If *Parent NS* is empty, then output the undefined set and exit these test
   procedures.

5. Create [DNS Query] with query type NS and query name *Child Zone*
   ("NS Query").

6. Create empty sets:
   1. Unique name server names where each name can be linked to a possibly empty
      set of IP addresses ("Delegation Name Servers").
   1. Unique name server names where each name can be linked to a possibly empty
      set of IP addresses ("AA Name Servers").

7. For each parent name server in *Parent NS* do:

   1. [Send] *NS query* to to the parent name server.
   2. Go to next parent name server if:
      1. Does not respond at all, or
      2. Responds with an invalid DNS response, or
      3. Responds with an [RCODE Name] besides NoError.
   3. If the [DNS Response] is a [Referral] to the Child Zone:
      1. Extract the name server names from the RDATA of the NS records in
         the authority section.
      2. Extract any A or AAAA record from the additional section if the owner
         name is an [In-Bailiwick] name server name matching an NS record
         from the same response.
      3. Update *Delegation Name Servers* with unique name server names and with
         a possibly empty set of IP addresses.
         1. If the name already exists in the set and additional IP addresses
            exists, add those to the name in the set.
   4. If the [DNS response] has the AA bit set and the answer section contains
      the NS record of the Child Zone do:
      1. Extract the name server names from the RDATA of the NS records.
      2. Extract any A or AAAA record from the additional section if the owner
         name is an [In-Bailiwick] name server name matching an NS record
         from the same response.
      3. Update *AA Name Servers* with unique name server names and with
         a possibly empty set of IP addresses.
         1. If the name already exists in the set and additional IP addresses
            exists, add those to the name in the set.
      4. If any [In-Bailiwick] name server name from the NS records lacks IP
         address, then:
         1. [Send] two [DNS Queries][DNS Query] with that name server name as
            query name to the parent name server, query type A and AAAA,
            respectively.
         2. If the [DNS Response] is a [Referral] to a sub-zone of *Child Zone*,
            follow that delegation, possibly in several steps, by repeating the
            A and AAAA queries.
         3. If a CNAME is returned, follow that, possibly in several steps, to
            resolve the name to IP addresses, if possible.
         4. Update *AA Name Servers* with captured IP addresses, if any.

8. If the *Delegation Name Servers* set is non-empty output that and exit these
   procedures.

9. Else, if the *AA Name Servers* set is non-empty output that and exit these
   procedures.

10. Else, if both *Delegation Name Servers* and *AA Name Servers* sets are empty
    then output an empty set.

### Outputs

* The set of name servers, the delegation, where each unique name server name
  links to a possibly empty set of its IP addresses:
  * Non-empty set: The normal case.
  * Empty set: No delegation was found.
  * Undefined set: [Get-Parent-NS-IPs] returned undefined set of parent
    name server IPs.

### Dependencies

This Method depends on the output from [Get-Parent-NS-IPs] if test type is a
"normal test".

[To top]


## Method: Get in-bailiwick address records in zone (Internal)

### Method identifier
**Get-IB-Addr-in-Zone**

### Objective

From the child zone, obtain the address records matching the
[In-Bailiwick] name server names found in the zone itself.
Extract addresses even if the resolution goes through CNAME.
It is, however, not permitted for a NS record
to point at a name that has a CNAME, but that test is
covered by Test Case [Delegation05].

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.


### Procedures

1. Using Method [Get-Del-NS-IPs], obtain the IP addresses to the name
   servers ("Name Server IPs").

2. Using Method [Get-Zone-NS-Names], obtain the names of the name servers
   from the *Child Zone* ("Child Zone Name Server Names").

3. If the *Name Server IPs* set or the *Child Zone Name Server Names* set is
   empty or undefined, then output an undefined set and exit these test
   procedures.

3. If no name in *Child Zone Name Server Names* is an [In-Bailiwick]
   name server name:
   1. Output an empty set.
   2. Exit these procedures.

4. Create an empty set the [In-Bailiwick] name server names from the
   *Child Zone Name Server Names* set, where each name is linked to an empty set
   of IP addresses ("Name Servers").

5. For name in *Name Servers* do:
   1. Create the following two [DNS queries][DNS Query]:
      1. Query type A and the [In-Bailiwick] name as the query name ("A Query").
      2. Query type AAAA and the [In-Bailiwick] name as the query name
         ("AAAA Query").
   2. [Send] *A Query* and *AAAA Query* to all servers in *Name Server IPs*
      and process the [DNS Responses][DNS Response] from each of them.
   3. If a [Referral] to a sub-zone of Child Zone is returned,
      follow that delegation, possibly in several steps, by repeating
      *A Query* and *AAAA Query*.
   4. If a CNAME is returned, follow that, possibly in several
      steps, to resolve the name to IP addresses, if possible.
   5. Ignore non-referral responses [see [Referral] unless AA flag is set (cached
      data is not accepted) and ignore response with any other [RCODE Name] than
      NoError.
   6. Add found IP addresses for the name server names in *Name Servers*.

6. Output the possibly empty *Name Servers* set.

### Outputs

* A set of name server names pointing at possibly empty sets of IP addresses:
  * Non-empty set: The normal case.
  * Empty set: There are no [In-Bailiwick] names or those are not defined in
    *Child Zone*, also a normal case.
  * Undefined set: [Get-Del-NS-IPs] returned an empty or undefined set.

### Dependencies

This Method depends on [Get-Zone-NS-Names] and [Get-Del-NS-IPs].

[To top]


## Method: Get out-of-bailiwick ip addresses (Internal)

### Method identifier
**Get-OOB-IPs**

### Objective

Obtain the IP addresses of the [Out-Of-Bailiwick] name servers for the
given zone (child zone) and a given set of name server names.

Extract addresses even if the resolution goes through CNAME, here ignoring that
it is not permitted for a NS record to point at a name that has a CNAME record.
See Test Case [Delegation05] for a test of NS records pointing at names that
holds CNAME records.

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

This Method uses the following input units defined in section [Methods Inputs]:

* "Child Zone" - The name of the child zone to be tested.
* "Undelegated Data" -  The name servers and IP addresses representing a
  possible delegation of *Child Zone*.
* "Test Type" - "undelegated test" or "normal test".

This Method also used the following input unit from the calling Method:

* "NS Set" - Name servers names to be looked up.


### Procedures

1. If *NS Set* is empty then output an empty set and exit these procedures.

2. Create a set of name servers where each unique name server name in *NS Set*
   is linked to an empty set of IP addresses ("Name Servers").

3. For each name server name ("Name") in *NS Set* do:

   1. If *Test Type* is "undelegated test" and if the *Name*
      has IP address specification (IPv4 or IPv6) in *Undelegated Data*,
      then:
      1. Add the address or addresses to *Name Servers* for *Name*.
      2. Go to next server name server name.

   2. Create the following two [DNS queries][DNS Query]:
      1. Query type A and *Name* as the query name and the RD flag set true
         ("A Query").
      2. Query type AAAA and *Name* as the query name and the RD flag set
         true ("AAAA Query").

   3. Do [DNS Lookup] of the two queries.

   4. If the [DNS Responses][DNS Response], if any, contains a list of A or AAAA
      records (follow any CNAME chain) in the answer section then remember the IP
      addresses for next step.

   5. Collect all IP addresses for the *Name* and add the address or addresses to
      *Name Servers* for that *Name* and go to next *Name*.

5. Output the *Name Servers* set.

### Outputs

* A set of name servers, where each unique name server name links to a possibly
  empty set of its IP addresses:
  * Non-empty set: The normal case.
  * Empty set: No addresses were available.

### Dependencies

None.

[To top]


## Method inter-dependencies

| Method                        | Level | Dependent on Method           | Level |
|-------------------------------|-------|-------------------------------|-------|
| [Get-Parent-NS-Names-and-IPs] | 1     | -                             |       |
| [Get-Parent-NS-IPs]           | 2     | [Get-Parent-NS-Names-and-IPs] | 1     |
| [Get-OOB-IPs]                 | 1     | -                             |       |
| [Get-Delegation]              | 3     | [Get-Parent-NS-IPs]           | 2     |
| [Get-Del-NS-Names-and-IPs]    | 4     | [Get-Delegation]              | 3     |
|                               |       | [Get-OOB-IPs]                 | 1     |
| [Get-Del-NS-Names]            | 5     | [Get-Del-NS-Names-and-IPs]    | 4     |
| [Get-Del-NS-IPs]              | 5     | [Get-Del-NS-Names-and-IPs]    | 4     |
| [Get-Zone-NS-Names]           | 6     | [Get-Del-NS-IPs]              | 5     |
| [Get-IB-Addr-in-Zone]         | 7     | [Get-Del-NS-IPs]              | 5     |
|                               |       | [Get-Zone-NS-Names]           | 6     |
| [Get-Zone-NS-Names-and-IPs]   | 8     | [Get-Zone-NS-Names]           | 6     |
|                               |       | [Get-IB-Addr-in-Zone]         | 7     |
|                               |       | [Get-OOB-IPs]                 | 1     |
| [Get-Zone-NS-IPs]             | 9     | [Get-Zone-NS-Names-and-IPs]   | 8     |

[To top]


## Terminology

* "Glue Record" - The term is used as defined in [RFC 8499], section 7, pages
  24-25.

* "DNS Lookup" - The term is used when a recursive lookup is used, though any
  changes to the DNS tree introduced by an [undelegated test] must be respected.

* "DNS Query" - The term is used for a DNS query that is to follow the
  specification for DNS queries in
  [DNS Query and Response Defaults][DNS Query and Response Defaults#Query].

* "DNS Response" - The term is used when the DNS response is to be handled as
  defined in
  [DNS Query and Response Defaults][DNS Query and Response Defaults#Response].

* "In-Bailiwick" - The term is used as defined in [RFC 8499], section 7,
  pages 24-25. In this document it is limited to the meaning "in domain" in the
  RFC.

* "Out-Of-Bailiwick" - The terms means, in this document, what is not
  "In-Bailiwick, in domain". [RFC 8499], section 7,  pages 24-25.

* "Referral" - The term means a DNS response with [RCODE Name] NoError, AA flag
  unset and NS records in the authority section.
  * The answer section is empty or with CNAME record or records. If the query
    type is CNAME, then the answer section must be empty.
  * The additional section may contain address (glue) records (A and AAAA) for
    the name server names from the RCODE of the NS records.
  * The referral refers the zone identical to the owner name of the NS records
    to the name servers specified by the RDATA in the NS records.

* "Send" - The terms are used when a DNS query is sent to a specific name server
  (name server IP address).

* "Valid Domain Name" -- The term stands for a non-empty domain name string that
  has successfully passed the tests and normalizations in the
  [Requirements and normalization] specification.

* "Valid IP Address" -- The term stands for either an [IPv4] address or an [IPv6]
  address in any address range.

* "Valid Name Server Name" -- The term stands for a [Valid Domain Name] that
  functions as the name of a name server.

[To top]


[Basic01]:                                           Basic-TP/basic01.md
[Delegation05]:                                      Delegation-TP/delegation05.md
[DNS Lookup]:                                        #terminology
[DNS Query and Response Defaults]:                   DNSQueryAndResponseDefaults.md
[DNS Query and Response Defaults#Query]:             DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Query and Response Defaults#Response]:          DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[DNS Query]:                                         #terminology
[DNS Response]:                                      #terminology
[Get-Del-NS-IPs]:                                    #method-get-delegation-ns-ip-addresses
[Get-Del-NS-Names-and-IPs]:                          #method-get-delegation-ns-names-and-ip-addresses
[Get-Del-NS-Names]:                                  #method-get-delegation-ns-names
[Get-Delegation]:                                    #method-get-delegation-internal
[Get-IB-Addr-in-Zone]:                               #method-get-in-bailiwick-address-records-in-zone-internal
[Get-OOB-IPs]:                                       #method-get-out-of-bailiwick-ip-addresses-internal
[Get-Parent-NS-IPs]:                                 #method-get-parent-ns-ip-addresses
[Get-Parent-NS-Names-and-IPs]:                       #method-get-parent-ns-names-and-ip-addresses
[Get-Zone-NS-IPs]:                                   #method-get-zone-ns-ip-addresses
[Get-Zone-NS-Names-and-IPs]:                         #method-get-zone-ns-names-and-ip-addresses
[Get-Zone-NS-Names]:                                 #method-get-zone-ns-names
[Glue Records]:                                      #terminology
[In-Bailiwick]:                                      #terminology
[Internal Methods]:                                  #internal-methods
[IPv4]:                                              https://en.wikipedia.org/wiki/IPv4
[IPv6]:                                              https://en.wikipedia.org/wiki/IPv6
[Root Hints File]:                                   https://www.internic.net/domain/named.root
[Method1]:                                           Methods.md#method-1-obtain-the-parent-domain
[Method2]:                                           Methods.md#method-2-obtain-glue-name-records-from-parent
[Method3]:                                           Methods.md#method-3-obtain-name-servers-from-child
[Method4]:                                           Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                           Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                                           Methods.md
[Methods Inputs]:                                    #methods-inputs
[Out-Of-Bailiwick]:                                  #terminology
[Query type]:                                        https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[RCODE Name]:                                        https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 8499]:                                          https://www.rfc-editor.org/rfc/rfc8499.html#section-7
[RFC 9156]:                                          https://www.rfc-editor.org/rfc/rfc9156.html
[Referral]:                                          #terminology
[Requirements and normalization]:                    RequirementsAndNormalizationOfDomainNames.md
[Send]:                                              #terminology
[undelegated test]:                                  ../test-types/undelegated-test.md
[Valid Domain Name]:                                 #terminology
[Valid Name Server Name]:                            #terminology
[Valid IP Address]:                                  #terminology
[To top]:                                            #methods-common-to-test-case-specifications-version-2
