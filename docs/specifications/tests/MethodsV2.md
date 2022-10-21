# Methods common to Test Case Specifications (version 2)

## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Internal Methods]
* [Method: Get parent NS IP addresses][Get-Parent-NS-IP]
* [Method: Get delegation NS names and IP addresses][Get-Del-NS-Names-and-IPs]
* [Method: Get delegation NS names][Get-Del-NS-Names]
* [Method: Get delegation NS IP addresses][Get-Del-NS-IPs]
* [Method: Get zone NS names][Get-Zone-NS-Names]
* [Method: Get zone NS names and IP addresses][Get-Zone-NS-Names-and-IPs]
* [Method: Get zone NS IP addresses][Get-Zone-NS-IPs]
* [Method: Get delegation (Internal)][Get-Delegation]
* [Method: Get in-bailiwick address records in zone (Internal)][Get-IB-Addr-in-Zone]
* [Method: Get out-of-bailiwick ip addresses (Internal)][Get-OOB-IPs]
* [Method: Get data for undelegated test (Internal)][Get-Undel-Data]
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


## Method: Get parent NS IP addresses

### Method identifier
**Get-Parent-NS-IP**

### Objective

This Method will obtain the name servers that serves the parent zone, i.e. the
zone from which the *Child Zone* is delegated from.

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

The Method will output a list of parent name server IP addresses. If the zone is
the root zone or if the test is an undelegated test, the list is defined but
empty. If the parent zone cannot be determined, then an undefined list is
returned.

This Method must, in general, use the similar algorithm as Test Case [BASIC01],
but the test case extracts more information.

### Inputs

* "Child Zone" - The name of the child zone.
* "Root Name Servers" - The IANA [Root Hints File] with names and IP addresses
  of the root name servers.
* "Test Type" - The test type with values "undelegated test" or
  "normal test".

### Prerequisite

The *Child Zone* name must be a valid name according to
"[Requirements and normalization of domain names in input][Requirements
and normalization]".

### Test procedure

1. If the *Child Zone* is the root zone (".") then output empty set and exit
   these test procedures.

2. If the *Test Type* is "undelegated test" then output empty set and exit
   these test procedures.

3. Create a [DNS Query] with query type SOA and query name *Child Zone*
   ("SOA Child Query").

4. Create the following empty set:
   1. Parent name server IP and the parent zone name ("Parent Name Server IP").

5. Find the parent zone of the *Child Zone* by iteratively
   [sending] *SOA Child Query* to all name servers found. Start by using
   the nameservers from *Root Name Servers*.
   1. Follow all paths from root and downwards by using the referrals (non-AA
      response with empty answer section and NS records in the authority
      section).
   2. When one of the following criteria is met (not both), then stop the lookup
      up in that branch and save the name server IP address and zone name for
      which the server is name server (parent zone) to the *Parent Name Server IP* set.
      Criteria:
      * The [DNS response] is a referral to *Child Zone* (owner name of the NS
        records in authority section is *Child Zone*), or
      * The [DNS response] has the AA flag set.
   3. If the lookup reaches a name server that meet at least one of the following
      criteria, then ignore it.
      1. Does not respond at all.
      2. Responds with an invalid DNS response.
      3. Responds with an [RCODE Name] besides NoError and NXDomain.
      4. Responds with a non-referral and the AA bit unset.
   5. Continue until all paths are exhausted.

> *Note that the "parent zone name" is the name of the zone that the name server
> in question is NS for (owner name of NS). The name of the name server is
> irrelevant.*

6. For each name server IP and parent zone ("Parent Zone") in the
   *Parent Name Server IP* set, do the following steps, including for any name
   servers added to the set by the steps below.
   1. [Send] a [DNS Query] with query type NS and *Parent Zone* as query name to
      the name server IP.
   2. If the [DNS Response], if any, contains a list of NS records in the answer
      section with *Parent Zone* as owner name then do:
      1. For each NS record extract the name server name ("Name Server Name") in
         the RDATA field and do:
         1. Create [DNS Query] with query type A, *Name Server Name* as query
            name and do a [DNS lookup].
         2. If the [DNS Response], if any, contains a list of A records (follow
            any CNAME chain) in the answer section then remember the IP
            addresses from the A records for three steps down.
         3. Create [DNS Query] with query type AAAA, *Name Server Name* as
            query name and do a [DNS lookup].
         3. If the [DNS Response], if any, contains a list of AAAA records
            (follow any CNAME chain) in the answer section then remember the IP
            addresses from the AAAA records for next step.
         4. If any IP address was captured in the two lookup steps, then for each
            IP address do if the address is not listed in *Parent Name Server IP*
            set:
            1. [Send] *SOA Child Query* to the IP address.
            2. If the [DNS Response], if any, meets exactly one of the following
               criteria then save the IP address and the parent zone name to the
               *Parent Name Server IP* set. Criteria:
               * The [DNS response] is a referral to *Child Zone* (owner name
                 of the NS records in authority section is *Child Zone*), or
               * The [DNS response] has the AA flag set.

7. If the *Parent Name Server IP* set is non-empty then do:
   1. Extract the name server IP list.
   2. Return the following from the Method:
      1. The extracted list of name server IP addresses (parent zone name servers).
   3. Exit these test procedures.

8. If the *Parent Name Server IP* set is empty then do:
   1. Return the following from the Method:
      1. Undefined value. (Parent name severs cannot be determined.)
   3. Exit these test procedures.


### Outputs

* A set of name server IP address for the parent zone:
  * Non-empty set: The name servers have been identified.
  * Empty set: Root zone or undelegated test.
  * Undefined set: The name servers cannot be determined due to errors.

### Dependencies

None.

[To top]


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

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1. Get the set of name servers where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method [Get-Delegation]
   ("Name Servers").

2. If the *Name Servers* set is undefined, then output an undefined set and exit
   these test procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit these
   test procedures.

4. Extract the set of [out-of-bailiwick] name server names from *Name Servers*
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

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1. Get the set of name servers where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method
   [Get-Del-NS-Names-and-IPs] ("Name Servers").

2. If the *Name Servers* set is undefined, then output an undefined set and exit
   these test procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit these
   test procedures.

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

Obtain the IP addresses (from glue records) from the delegation of
the given zone (child zone) from the parent zone. Glue records are address
records for [in-bailiwick] name server names, if any. Obtain the IP addresses
for the [out-of-bailiwick] name server names, if any.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1. Get the set of name servers where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method
   [Get-Del-NS-Names-and-IPs] ("Name Servers").

2. If the *Name Servers* set is undefined, then output an undefined set and exit
   these test procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit these
   test procedures.

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

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1.  Using Method [Get-Del-NS-IPs], obtain the IP addresses of the
    name servers ("Name Server IPs").

2.  If the *Name Server IPs* set is undefined, then output an undefined set and
    exit these test procedures.

3.  If the *Name Server IPs* set is empty, then output an empty set and exit
    these test procedures.

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

Obtain the name server names (extracted from the NS records) from
apex of the child zone. For [in-bailiwick] name server names obtain
the IP addresses from the child zone. For the [out-of-bailiwick] name
server names obtain the IP addresses from resolver lookup.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1. Get the name server names for the *Child Zone* as defined in
   the *Child Zone* by using Method [Get-Zone-NS-Names] ("Names").

2. If the *Names* set is undefined, then output an undefined set and
   exit these test procedures.

3. If the *Names* set is empty, then output an empty set and exit
   these test procedures.

4. Create a set of name servers where each unique name server name in *Names*
   is linked to an empty set of IP addresses ("Name Servers").

5. Fetch the IP addresses for any [in-bailiwick] name server
   names in *Names* by using Method [Get-IB-Addr-in-Zone].

6. Add each fetched IP address, if any, to *Name Servers* to the name
   server name it belongs to.

7. Extract the set of [out-of-bailiwick] name server names from *Names*
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

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1. Get the name servers set where each unique name server name is linked to a
   possibly empty set of its IP addresses by using Method
   [Get-Zone-NS-Names-and-IPs] ("Name Servers");

2. If the *Name Servers* set is undefined, then output an undefined set and
   exit these test procedures.

3. If the *Name Servers* set is empty, then output an empty set and exit
   these test procedures.

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
glue records) from the delegation of the given zone (child zone) from
the parent zone. Glue records are address records for [in-bailiwick] name
server names, if any. Extract addresses even if the resolution goes through
CNAME. It is, however, not permitted for a NS record to point at a name
that has a CNAME, but that test is covered by Test Case [DELEGATION05].

IP addresses for [out-of-bailiwick] name server names are not extracted
with this Method. To get those use Method [Get-Del-NS-IPs] or
Method [Get-Del-NS-Names-and-IPs].

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

* "Child Zone" - The name of the child zone.
* "Test Type" - The test type with values "undelegated test" or "normal test".
* "Root Name Servers" - The IANA [Root Hints File] with names and IP addresses
  of the root name servers.

### Prerequisite

None.

### Test procedure

1. If the *Test Type* is "undelegated test", then:
   1. Using Method [Get-Undel-Data] get the submitted data for
      *Child Zone* ("Undelegated Data").
   2. Create an empty set of name servers where each unique name server name is
      linked to an empty set of IP addresses ("Name Servers").
   3. Extract all name server names from the *Undelegated Data* set and add to
      the *Name Servers* set.
   4. For each [in-bailiwick] name server name collect any
      IP addresses from *Undelegated Data* and add that to the
      *Name Servers* set under the name server name.
   5. For any [out-of-bailiwick] name server name the IP address should be
      ignored.
   6. Output the *Name Servers* set.
   7. Exit these test procedures.

2. If *Child Zone* is the root zone ".", then output the set of name server names
   and IP addresses from *Root Name Servers* and exit these test procedures.

3. Using Method [Get-Parent-NS-IP] extract the name server IP addresses for
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
   3. If the [DNS Response] contains a referral to the Child Zone:
      1. Extract the name server names from the RDATA of the NS records in
         the authority section.
      2. Extract any A or AAAA record from the additional section if the owner
         name is an [in-bailiwick] name server name matching an NS record
         from the same response.
      3. Update *Delegation Name Servers* with unique name server names and with
         a possibly empty set of IP addresses.
         1. If the name already exists in the set and additional IP addresses
            exists, add those to the name in the set.
   4. If the [DNS response] has the AA bit set and the answer section contains
      the NS record of the Child Zone do:
      1. Extract the name server names from the RDATA of the NS records.
      2. Extract any A or AAAA record from the additional section if the owner
         name is an [in-bailiwick] name server name matching an NS record
         from the same response.
      3. Update *AA Name Servers* with unique name server names and with
         a possibly empty set of IP addresses.
         1. If the name already exists in the set and additional IP addresses
            exists, add those to the name in the set.
      4. If any [in-bailiwick] name server name from the NS records lacks IP
         address, then:
         1. [Send] two [DNS Queries][DNS Query] with that name server name as
            query name to the parent name server, query type A and AAAA,
            respectively.
         2. If the [DNS Response] has a delegation (referral) to a sub-zone of
            Child Zone, follow that delegation, possibly in several steps, by
            repeating the A and AAAA queries.
         3. If a CNAME is returned, follow that, possibly in several steps, to
            resolve the name to IP addresses, if possible.
         4. Update *AA Name Servers* with captured IP addresses, if any.

8. If the *Delegation Name Servers* set is non-empty output that and exit these
   test procedures.

9. Else, if the *AA Name Servers* set is non-empty output that and exit these
   test procedures.

10. Else, if both *Delegation Name Servers* and *AA Name Servers* sets are empty
    then output an empty set.

### Outputs

* The set of name servers, the delegation, where each unique name server name
  links to a possibly empty set of its IP addresses:
  * Non-empty set: The normal case.
  * Empty set: No delegation was found.
  * Undefined set: [Get-Parent-NS-IP] returned undefined set of parent
    name server IPs.

### Dependencies

This Method depends on the output from either [Get-Parent-NS-IP] (normal test
type) or [Get-Undel-Data] (undelegated test).

[To top]


## Method: Get in-bailiwick address records in zone (Internal)

### Method identifier
**Get-IB-Addr-in-Zone**

### Objective

From the child zone, obtain the address records matching the
[in-bailiwick] name server names found in the zone itself.
Extract addresses even if the resolution goes through CNAME.
It is, however, not permitted for a NS record
to point at a name that has a CNAME, but that test is
covered by Test Case [DELEGATION05].

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

* "Child Zone" - The name of the child zone.

### Prerequisite

None.

### Test procedure

1. Using Method [Get-Del-NS-IPs], obtain the IP addresses to the name
   servers ("Name Server IPs").

2. Using Method [Get-Zone-NS-Names], obtain the names of the name servers
   from the *Child Zone* ("Child Zone Name Server Names").

3. If the *Name Server IPs* set or the *Child Zone Name Server Names* set is
   empty or undefined, then output an undefined set and exit these test
   procedures.

3. If no name in *Child Zone Name Server Names* is an [in-bailiwick]
   name server name:
   1. Output an empty set.
   2. Exit these test procedures.

4. Create an empty set the [in-bailiwick] name server names from the
   *Child Zone Name Server Names* set, where each name is linked to an empty set
   of IP addresses ("Name Servers").

5. For name in *Name Servers* do:
   1. Create the following two [DNS queries][DNS Query]:
      1. Query type A and the [in-bailiwick] name as the query name ("A Query").
      2. Query type AAAA and the [in-bailiwick] name as the query name
         ("AAAA Query").
   2. [Send] *A Query* and *AAAA Query* to all servers in *Name Server IPs*
      and process the [DNS Responses][DNS Response] from each of them.
   3. If a delegation (referral) to a sub-zone of Child Zone is returned,
      follow that delegation, possibly in several steps, by repeating
      *A Query* and *AAAA Query*.
   4. If a CNAME is returned, follow that, possibly in several
      steps, to resolve the name to IP addresses, if possible.
   5. Ignore non-referral responses unless AA flag is set (cached data
      is not accepted) and ignore response with any other [RCODE Name] than
      NoError.
   6. Add found IP addresses for the name server names in *Name Servers*.

6. Output the possibly empty *Name Servers* set.

### Outputs

* A set of name server names pointing at possibly empty sets of IP addresses:
  * Non-empty set: The normal case.
  * Empty set: There are no [in-bailiwick] names or those are not defined in
    *Child Zone*, also a normal case.
  * Undefined set: [Get-Del-NS-IPs] returned an empty or undefined set.

### Dependencies

This Method depends on [Get-Zone-NS-Names] and [Get-Del-NS-IPs].

[To top]


## Method: Get out-of-bailiwick ip addresses (Internal)

### Method identifier
**Get-OOB-IPs**

### Objective

Obtain the IP addresses of the out-of-bailiwick name servers for the
given zone (child zone) and a given set of name server names.

Extract addresses even if the resolution goes through CNAME, here ignoring that
it is not permitted for a NS record to point at a name that has a CNAME record.
See Test Case [DELEGATION05] for a test of NS records pointing at names that
holds CNAME records.

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

* "Child Zone" - The name of the child zone.
* "NS Set" - The name servers names as given by the calling Method.
* "Test Type" - The test type with values "undelegated test" or
  "normal test".

### Prerequisite

None.

### Test procedure

1. If *NS Set* is empty then output an empty set and exit these test procedures.

2. Create a set of name servers where each unique name server name in *NS Set*
   is linked to an empty set of IP addresses ("Name Servers").

3. If *Test Type* is "undelegated test", then do:
   1. Fetch name server name and IP address or addresses using Method
      [Get-Undel-Data] ("Undelegated Data").

4. For each name server name ("Name") in *NS Set* do:

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

This Method depends on Method [Get-Undel-Data].


[To top]


## Method: Get data for undelegated test (Internal)

### Method identifier
**Get-Undel-Data**

### Objective

Provide the data for undelegated tests, i.e. provide data that is
comparable to a delegation from the parent zone, but where the
delegation does not have to exist.

This is an [Internal Method][Internal Methods] that can be referred to by other
Methods in this document, but not by Test Case specifications.

### Inputs

* "Child Zone" - The name of the child zone.
* "Undelegated Data" - the submitted delegation data, name server names for
  *Child Zone*, and any IP addresses for the name server names.

### Prerequisite

* The Test Type of *Child Zone* must be "undelegated test".
* The *Undelegated Data* must include at least one name server name or else this
  Method cannot be run.

### Test procedure

1. Get the *Undelegated Data* from the initiation of the test.

2. Return the set of name servers, where each unique name server name
   links to a possibly empty set of its IP addresses taken from the
   *Undelegated Data*.

### Outputs

* A set of name servers, where each unique name server name
  links to a possibly empty set of its IP addresses:
  * Non-empty set: The only case.

### Dependencies

None.

[To top]

## Method inter-dependencies

| Method                      | Level | Dependent on Method        | Level
|-----------------------------|-------|----------------------------|-------------
| [Get-Undel-Data]            | 1     | -                          |
| [Get-Parent-NS-IP]          | 1     | -                          |
| [Get-OOB-IPs]               | 2     | [Get-Undel-Data]           | 1
| [Get-Delegation]            | 2     | [Get-Undel-Data]           | 1
|                             |       | [Get-Parent-NS-IP]         | 1
| [Get-Del-NS-Names-and-IPs]  | 3     | [Get-Delegation]           | 2
|                             |       | [Get-OOB-IPs]              | 2
| [Get-Del-NS-Names]          | 4     | [Get-Del-NS-Names-and-IPs] | 3
| [Get-Del-NS-IPs]            | 4     | [Get-Del-NS-Names-and-IPs] | 3
| [Get-Zone-NS-Names]         | 5     | [Get-Del-NS-IPs]           | 4
| [Get-IB-Addr-in-Zone]       | 6     | [Get-Del-NS-IPs]           | 4
|                             |       | [Get-Zone-NS-Names]        | 5
| [Get-Zone-NS-Names-and-IPs] | 7     | [Get-Zone-NS-Names]        | 5
|                             |       | [Get-IB-Addr-in-Zone]      | 6
|                             |       | [Get-OOB-IPs]              | 2
| [Get-Zone-NS-IPs]           | 8     | [Get-Zone-NS-Names-and-IPs]| 7




[To top]


## Terminology

* "In-bailiwick", "out-of-bailiwick" and "glue record" - The terms are used as
defined in [RFC 8499], section 7, pages 24-25. In this document, the term
"in-bailiwick" is limited to the meaning "in domain" in the RFC. The term
"out-of-bailiwick" here means what is not "in-bailiwick, in domain".

* "Send" and "Sending" - The terms are used when a DNS query is sent to a
specific name server (name sever IP address).

* "DNS Lookup" - The term is used when a recursive lookup is used, though any
changes to the DNS tree introduced by an [undelegated test] must be respected.

* "DNS Query" - The term is used for a DNS query that is to follow the
  specification for DNS queries in
  [DNS Query and Response Defaults][DNS Query and Response Defaults#Query].

* "DNS Response" - The term is used when the DNS response is to be handled as
  defined in
  [DNS Query and Response Defaults][DNS Query and Response Defaults#Response].


[BASIC01]:                                           Basic-TP/basic01.md
[DELEGATION05]:                                      Delegation-TP/delegation05.md
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
[Get-Parent-NS-IP]:                                  #method-get-parent-ns-ip-addresses
[Get-Undel-Data]:                                    #method-get-data-for-undelegated-test-internal
[Get-Zone-NS-IPs]:                                   #method-get-zone-ns-ip-addresses
[Get-Zone-NS-Names-and-IPs]:                         #method-get-zone-ns-names-and-ip-addresses
[Get-Zone-NS-Names]:                                 #method-get-zone-ns-names
[Glue records]:                                      #terminology
[Glue records]:                                      #terminology
[In-bailiwick]:                                      #terminology
[Internal Methods]:                                  #internal-methods
[Root Hints File]:                                   https://www.internic.net/domain/named.root
[Method1]:                                           Methods.md#method-1-obtain-the-parent-domain
[Method2]:                                           Methods.md#method-2-obtain-glue-name-records-from-parent
[Method3]:                                           Methods.md#method-3-obtain-name-servers-from-child
[Method4]:                                           Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                           Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                                           Methods.md
[Out-of-bailiwick]:                                  #terminology
[RCODE Name]:                                        https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 8499]:                                          https://datatracker.ietf.org/doc/html/rfc8499#section-7
[Requirements and normalization]:                    RequirementsAndNormalizationOfDomainNames.md
[Send]:                                              #terminology
[Sending]:                                           #terminology
[To top]:                                            #methods-common-to-test-case-specifications-version-2
