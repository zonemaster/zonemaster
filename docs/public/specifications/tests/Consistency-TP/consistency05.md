# CONSISTENCY05: Consistency between delegation and zone data


## Test case identifier
**CONSISTENCY05**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

The delegation of the *Child Zone* may contain so called
[glue records][glue record]. On the wire, any [glue records][glue record] are
found in the [referral] sent from the name servers of the parent zone.

If the name server name in the NS record is [in-domain] there must be at least
one [glue record] in the delegation and in the [referral]. For each such glue
record the equivalent [address record] must exist as an athoritative record in
the child zone, or below, and the the two (glue record and authoritative record)
must have the same [IP address].

The other alternative is that the name server name is [Out-Of-Domain], and in
that case there can be a [glue record], and it must also match an address
record with the same IP address in the authoritative zone. In this case that
authoritative zone is not the *Child Zone* since the name is [Out-Of-Domain].

It is an IANA [name server requirement] that [glue records][glue record] matches
authoritative data.

This test case will test the following:

* The the [referral] (delegation) is identical on all parent name servers.
* That the [referral] (delegation) contains at least one [glue record] for each
  [in-domain] name server name.
* That each [glue record] matches an authoritative [address record] with the
  same IP address:
  * In the *Child Zone* if the [glue record] is [in-domain].
  * In another zone if the [glue record] is [out-of-zone].
* If the *Child Zone* contains additional [address records][address record]
  with the same name as the glue record, but different IP addresses.


## Scope

It is assumed that *Child Zone* is tested and reported by [Connectivity01]. This
test case will just ignore non-responsive name servers or name servers not giving
a correct DNS response for an authoritative name server. However, if there is no
working name sever for *Child Zone* then this test case will report that.


## Inputs

* "Child Zone" - The name of the zone to be tested. It must be a [valid domain name].
* "Undelegated Data" - Optional data. If included it must consist of a set of
  at least one [valid name server name] and for each name server name a set of zero or
  more [IP addresses][IP address].


## Summary

| Message Tag                    | Level    | Arguments                                 | Message ID for message tag                                                                                                                                 |
|:-------------------------------|:---------|:------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| CS05_CHILD_ZONE_LAME           | CRITICAL | ns_list                                   | There is no working name server for the child zone. Tested name servers are "{ns_list}".                                                                   |
| CS05_DELEGATION                | INFO     | ns_deleg_list, ns_list                    | Delegation of the child zone as provided by the parent name servers listed: "{ns_deleg_list}". Parent name servers: "{ns_list}".                           |
| CS05_EXTRA_ADDR_CHILD          | NOTICE   | ns_list                                   | There is one or more extra address records found in the child zone that are not present as glue in the delegation: "{ns_list}".                            |
| CS05_NO_MISMATCH_GLUE_ZONE     | INFO     |                                           | There is no mismatch between delegation from parent and authoritative data in the child zone.                                                              |
| CS05_ID_ADDR_MISMATCH          | ERROR    | nsname, ns_ip_list_glue, ns_ip_list_zone  | For name server {nsname} the glue record in the delegation "{ns_ip_list_glue}" is different from the address record in the child zone "{ns_ip_list_zone}". |
| CS05_ID_ADDR_MISSING           | NOTICE   | nsname                                    | Address record for {nsname}, used as glue record in delegation, is missing in the child zone.                                                              |
| CS05_INCONSISTENT_DELEGATION   | WARNING  |                                           | The delegation is inconsistent between the parent nameservers.                                                                                             |
| CS05_MISSING_GLUE_FOR_NS       | WARNING  | nsname, ns_list                           | Expected glue record for {nsname} is missing in the delegation. Found in the parent name servers "{ns_list}".                                              |
| CS05_MISSING_GLUE_FOR_NS_UNDEL | WARNING  | nsname                                    | IP address (glue record) is expected but missing for {nsname} in the undelegated data.                                                                     |
| CS05_NO_NS_ADDR_CHILD          | CRITICAL |                                           | Child zone cannot be tested since there are no name server IP addresses for that zone.                                                                     |
| CS05_OOD_ADDR_MISMATCH         | WARNING  | nsname, ns_ip_list_ref, ns_ip_list_lookup | For name server {nsname} the glue record in the delegation "{ns_ip_list_glue}" is different from the address record in the child zone "{ns_ip_list_zone}". |

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns" or "ns_list" even when in the
"[Test procedure]" below it is only referred to the IP address of the name
servers.


## Test procedure

In this section and unless otherwise specified below, the terms "[DNS Query]"
follow the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNS Response] in the same specification.

1.  Create the following sets from fetched or derived data:

    1. Fetch the parent name servers with IP addresses using method
       [Get-Parent-NS-Names-and-IPs] ("Parent NS").
    2. Fetch the parent name server IPs using method [Get-Parent-NS-IPs]
       ("Parent NS IPs").
    3. Fetch the child name server IPs using methods [Get-Del-NS-IPs] and
       [Get-Zone-NS-IPs] and create a unique set ("Child NS IPs").

    *Note:* If the *Undelegated Data* set (from input) is non-empty then
    the *Parent NS* and *Parent NS IPs* sets were created as empty sets.

2.  Create [DNS Queries][DNS Query]:

    1. Query type SOA and query name *Child Zone* ("SOA Query").
    2. Query type NS and query name *Child Zone* ("NS Query").

3.  Create the following empty sets:

    1.  IP address (parent) and a sorted list of name server name or name/IP
        pairs ("Delegation").
    2.  IP address (child) and set of name server names ("Child Zone NS").
    3.  NS name and IP address(es) ("Delegation ID NS").
    4.  NS name and IP address(es) ("Delegation OOD NS").
    5.  IP address (parent) and NS name ("Missing Glue").
    6.  IP address (child), name server name and list of IP addresses (if any)
        ("Auth Addr Records In Child").

4.  If the *Parent NS IPs* is non-empty, then for each name server IP in the set
    do:

    1. [Send] *SOA Query* over UDP to the name server IP and fetch the response
       (if any).
    2. If the response (if any) contains a [Referral] of *Child Zone* then do:
       1. Extract the name server names from delegation NS records in authority
          section.
       2. Downcase any uppercase letters in the names.
       3. Create a sorted list of unique name server names (sorted in ascending order
          on the name).
       4. For each [glue record] in the additional section (if any) do:
          1. Form an name/IP pair from the owner named and the IP address in
             [RDATA].
          2. Only unique name/IP pairs are created.
          3. Add the pair to sorted list of name server names.
          4. Sort the name/IP pair by IP address, in ascending order, with IPv4
             addresses sorted before IPv6 addresses.
          5. The name/IP pair will replace any "name" where the name server name
             is the same.
       5. Add the name server IP (to which the *SOA Query* was sent) and the name
          server list created above to the *Delegation* set.

    *Note:* If the *Undelegated Data* set is non-empty then the
    *Delegation* set is empty.

5.  If the *Delegation* set is non-empty, then for each parent name server IP in
    the set do:
    1. For each element (name or name/IP pair) in the set do:
       1. If the name in the element is [In-Domain] then do:
          1. If element is a name and not a name/IP pair then add the name server
             IP address and the name to the *Missing Glue* set.
          2. Add the element (name or name/IP pair) to the *Delegation ID NS*
             set.
             1. Do not create duplicates in the set.
             2. Elements just consiting of a name is not added if there already
                is a name/IP pair with the same name.
             3. A name/IP pair will overwrite an element consisting just of
                the same name.
       2. If name in the element (name or name/IP pair) is [Out-Of-Domain] then
          add the element (name or name/IP pair) to the *Delegation OOD NS* set.
          1. Do not create duplicates in the set.
          2. Elements just consiting of a name is not added if there already is a
             name/IP pair with the same name.
          3. A name/IP pair will overwrite an element consisting just of the
             same name.

6. If the *Delegation* set is non-empty, do:
   1. Compare the name server lists (of names or name/IP pairs) between all
      parent name server IPs.
   2. If not all name server lists are equal then do:
      1. For each found name server list output *[CS05_DELEGATION]* with the name
      server list and the list of parent name server IPs from which the list
      came.
      2. Output *[CS05_INCONSISTENT_DELEGATION]*.

7.  If the *Undelegated Data* set is non-empty then for each name server name
    in the set do:
    1. If the name server name is [In-Domain] then do:
       1. If no glue (address) data is present for the name server name, then
          output *[CS05_MISSING_GLUE_FOR_NS_UNDEL]* with the name server name.
       2. Else, add the name server name with IP addresses as one or several
          name/IP pairs to *Delegation ID NS* set.
    2. Else (the name server name is [Out-Of-Domain]) then do:
       1. If there is no IP address for that name, add the name to the
          *Delegation OOD NS* set.
       2. Else, add the name and IP address or addresses as name/IP pairs to the
          *Delegation OOD NS* set.

8. If *Child Zone* is the root zone (".") and the *Undelegated Data* set is
    empty, then do:

    1. Fetch the root hint information using method [Get-Del-NS-Names-and-IPs]
       ("Hint NS").
    2. The information in *Hint NS* is assumed to be as single name server names
       ("name") or as name/IP pairs.
    3. The hint information is always [In-Domain] by definition.
    4. For each element (name or name/IP pair) in the *Hint NS* set do:
       1. If element is a name and not a name/IP pair then add the name server
          IP address and the name to the *Missing Glue* set.
       2. Add the element (name or name/IP pair) to the *Delegation ID NS* set.
          1. Do not create duplicates in the set.
          2. Elements just consiting of a name is not added if there already is a
             name/IP pair with the same name.
          3. A name/IP pair will overwrite an element consisting just of of the
             same name.

9. If the *Missing Glue* set is non-empty, then for each name server name output
    *[CS05_MISSING_GLUE_FOR_NS]* with the name server name and the list of parent
    IP addresses.

10. If *Child NS IP* is empty then output *[CS05_NO_NS_ADDR_CHILD]* and exit
    these test procedures.

11. For each name server IP in *Child NS IPs* do:

    1. [Send] *NS Query* over UDP to the name server IP and fetch the response
       (if any).
    2. If the response (if any) contains the following add the name server
       IP and the name server names extracted from the NS RRset to the
       *Child Zone NS* set:
       * An NS RRset of *Child Zone* in the answer section.
       * An [RCODE Name] of "NoError".
       * The AA flag is set.
    3. Else, go to the next name server IP.
    4. Extract the [In-Domain] NS name server namns from the NS RRset extracted
       above and extract the name server names from *Delegation ID NS*.
    5. Create a unique set and for each [In-Domain] name server name do:
       1.  Create a [DNS Query] with query type A and query name the NS name
           server name ("A Query").
       2.  [Send] *A Query* over UDP to the name server IP and fetch the
           response (if any).
       3.  If the response (if any) contains a [Referral] covering the NS name
           server name then repeat *A Query* (recursively, if needed) to the
           name servers in the referral until an A RRset is returned or the
           querying is stopped by e.g. NXDOMAIN or no response.
           1. If an A RRset is return, then use it in next step as if was a
              response on the first query.
       4.  If any query was not responded to or returned an [RCODE Name] not
           being "NoError" then go to next NS name server name.
       5.  If the response (if any) contains the following then for each
           unique A record add one name/IP pair to the
           *Auth Addr Records In Child* set.
           * An A RRset with the NS name server name as owner name in the
             answer section.
           * An [RCODE Name] of "NoError".
           * The AA flag is set.
       6.  Create a [DNS Query] with query type AAAA and query name the NS
           name server name ("AAAA Query").
       7.  [Send] *A Query* over UDP to the name server IP and fetch the
           response (if any).
       8.  If the response (if any) contains a [Referral] covering the NS name
           server name then repeat *AAAA Query* as was done with the *A Query*
           above.
       9.  If the response (if any) contains the following then update the
           *Auth Addr Records In Child* set with the IP address(es) for the NS
           name server name.
           * An AAAA RRset with the NS name server name as owner name in the
             answer section.
           * An [RCODE Name] of "NoError".
           * The AA flag is set.
       10. If the *Auth Addr Records In Child* set does not contain any name/IP
           pairs with name server name as name, then add name server name to
           the set, unless it already exists.
       11. If the *Auth Addr Records In Child* set both contains name server
           name as name only and as part of name/IP pairs, then remove the single
           name.

12. If the *Child Zone NS* set is empty then output *[CS05_CHILD_ZONE_LAME]* with
    the IP addresses from the *Child NS IPs* set and exit these procedures.

13. If the *Delegation ID NS* set is non-empty then for each name server name in
    the set do:
    1. Extract all name/IP pairs in the set with that name server name
       ("Parent Glue").
    2. If no name/IP pairs were extracted, then go to next name server name in
       the set.
    3. Extract all name/IP pairs in the *Auth Addr Records In Child* set
       ("Child Auth").
    4. If *Child Auth* is empty, then output *[CS05_ID_ADDR_MISSING]* with the
       the name server name.
    5. Else, if any of the name/IP pairs in *Parent Glue* set are missing in the
       *Child Auth* set then output *[CS05_ID_ADDR_MISMATCH]* with the name
       server name, the IP addresses extracted from *Parent Glue* and the IP
       addresses extracted from *Child Auth*.
    6. Else, if the *Parent Glue* set is not equal to the *Child Auth* set then
       output *[CS05_EXTRA_ADDR_CHILD]* with the list of name/IP pairs from
       the *Child Auth* set not present in the *Parent Glue* set.

14. If the the *Delegation OOD NS* set is non-empty then for each name server
    name in the set do:
    1. Extract all name/IP pairs with that name server name.
    2. Go to next name server name if there are no name/IP pairs for the name.
    3. Do [Address Records Lookup] of the name server name. Ignore any failing
       lookups (such as response with SERVFAIL or no response) or lookups giving
       response with NODATA or NXDOMAIN.
    4. If any IP address is returned from the lookup, then do:
       1. Compare the IP address(es) with the address(es) in the extracted
          name/IP pairs.
       2. If the comparison did not give an exact match, then output
          *[CS05_OOD_ADDR_MISMATCH]* with the name server name, the address(es)
          from the extracted name/IP pairs and the the addresses from the
          lookup.

15. If this test procedure has not outputted any message tag then output
    *[CS05_NO_MISMATCH_GLUE_ZONE]*.



## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.


## Intercase dependencies

None


## Terminology

* "Address Record" - The term is used for a DNS record of type A or AAAA. The
  term is used as defined in [RFC 9499][RFC 9499#section5], section 5.

* "Address Records Lookup" - The term is used when two [DNS Lookups][DNS Lookup]
  are done and the query types are A and AAAA, respectively.

* "DNS Lookup" - The term is used when a recursive lookup is used, though any
  changes to the DNS tree introduced by an [undelegated test] must be respected.

* "DNS Response" - The term is used when the DNS response is to be handled as
  defined in [DNS Query and Response Defaults][DNS Response].

* "DNS Query" - The term is used for a DNS query that is to follow the
  specification for DNS queries in [DNS Query and Response Defaults][DNS Query].

* "Glue Record" - [Address records][address record] in the [Referral]
  whose owner name is equal to the [RDATA] in one of the NS record in the same
  referral. The term is used as defined in [RFC 9499][RFC 9499#section7],
  section 7.

* "In-Domain" - The term is used as defined in [RFC 9499][RFC 9499#section7],
  section 7, in the subsection on "Glue Records", for name server names in the
  referral of a zone. The name server name is on or below the zone cut of the
  zone for which it is name server for. Previously the term "In-Bailiwick" was
  used.

* "IP Address" -- In this document the term stands for either an [IPv4] address or
  an [IPv6] address in any address range.

* "Out-Of-Domain" - The term refers to a name server name that is not
  "In-Domain". It is either "sibling domain" or "unrelated" as defined in
  [RFC 9499][RFC 9499#section7], section 7, in the subsection on "Glue Records",
  for name server names in the referral of a zone. The name server name is
  neither on or below the zone cut of the zone for which it is name server.
  The name server name belongs to another zone. It is above or at aside the
  delegated zone. Previously the term "Out-Of-Bailiwick" was used.

* "RDATA" - "Resource record data as defined in [RFC 1034][RFC 1034#section3.6],
  section 3.6.

* "Referral" - The term means a DNS response with [RCODE Name] NoError, AA flag
  unset and NS records in the authority section. It is used to signal a
  delegation.
  * The answer section is empty or with CNAME record or records. If the query
    type is CNAME, then the answer section must be empty.
  * The additional section may contain address (glue) records (A and AAAA) for
    the name server names from the [RDATA] of the NS records.
  * The referral refers the zone identical to the owner name of the NS records
    to the name servers specified by the [RDATA] in the NS records.

* "Send" - The terms are used when a DNS query is sent to a specific name server
  (name server IP address).

* "Valid Domain Name" -- The term stands for a non-empty domain name string that
  has successfully passed the tests and normalizations in the
  [Requirements and normalization] specification.

* "Valid Name Server Name" -- The term stands for a [Valid Domain Name] that
  functions as the name of a name server.


[Address Record]:                          #terminology
[Argument list]:                           ../ArgumentsForTestCaseMessages.md
[CRITICAL]:                                ../SeverityLevelDefinitions.md#critical
[CS05_CHILD_ZONE_LAME]:                    #summary
[CS05_DELEGATION]:                         #summary
[CS05_EXTRA_ADDR_CHILD]:                   #summary
[CS05_ID_ADDR_MISMATCH]:                   #summary
[CS05_ID_ADDR_MISSING]:                    #summary
[CS05_INCONSISTENT_DELEGATION]:            #summary
[CS05_MISSING_GLUE_FOR_NS]:                #summary
[CS05_MISSING_GLUE_FOR_NS_UNDEL]:          #summary
[CS05_NO_MISMATCH_GLUE_ZONE]:              #summary
[CS05_NO_NS_ADDR_CHILD]:                   #summary
[CS05_OOD_ADDR_MISMATCH]:                  #summary
[Connectivity01]:                          ../Connectivity-TP/connectivity01.md
[DNS Lookup]:                              #terminology
[DNS Query and Response Defaults]:         ../DNSQueryAndResponseDefaults.md
[DNS Query]:                               ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                            ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                   ../SeverityLevelDefinitions.md#error
[Get-Del-NS-IPs]:                          ../MethodsV2.md#method-get-delegation-ns-ip-addresses
[Get-Del-NS-Names-and-IPs]:                ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Parent-NS-IPs]:                       ../MethodsV2.md#method-get-parent-ns-ip-addresses
[Get-Parent-NS-Names-and-IPs]:             ../MethodsV2.md#method-get-parent-ns-names-and-ip-addresses
[Get-Zone-NS-IPs]:                         ../MethodsV2.md#method-get-zone-ns-ip-addresses
[Get-Zone-NS-Names-and-IPs]:               ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[Glue Record]:                             #terminology
[In-Domain]:                               #terminology
[INFO]:                                    ../SeverityLevelDefinitions.md#info
[IP Address]:                              #terminology
[IPv4]:                                    https://en.wikipedia.org/wiki/IPv4
[IPv6]:                                    https://en.wikipedia.org/wiki/IPv6
[NOTICE]:                                  ../SeverityLevelDefinitions.md#notice
[Out-Of-Domain]:                           #terminology
[RCODE Name]:                              https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RDATA]:                                   #terminology
[RFC 1034#section3.6]:                     https://datatracker.ietf.org/doc/html/rfc1034#section-3.6
[RFC 9499#section5]:                       https://datatracker.ietf.org/doc/html/rfc9499#section-5
[RFC 9499#section7]:                       https://datatracker.ietf.org/doc/html/rfc9499#section-7
[Referral]:                                #terminology
[Requirements and normalization]:          ../RequirementsAndNormalizationOfDomainNames.md
[Send]:                                    #terminology
[Severity Level Definitions]:              ../SeverityLevelDefinitions.md
[Test procedure]:                          #test-procedure
[Valid Domain Name]:                       #terminology
[Valid Name Server Name]:                  #terminology
[WARNING]:                                 ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:               ../../../configuration/profiles.md
[name server requirement]:                 https://www.iana.org/help/nameserver-requirements
[undelegated test]:                        ../../test-types/undelegated-test.md
