# BASIC01: Check for the parent zone and the zone itself

## Test case identifier
**BASIC01**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure]
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

In order for a domain (zone) to work, it must be delegated from a
zone higher up in the DNS hierarchy (a parent domain or zone).
This Test Case will determine if parent zone and child zones,
respectively, exist.

If the test is an [undelegated test], however, it can be tested even it is not
delegated. Parent zone for [undelegated test] is disregarded.

If the zone to be tested is the root zone, it has no parent or
delegation and will always pass this Test Case.

If no parent can be determined, there cannot be any delegation.


## Scope

The algorithm in this test case should match the algorithm in method
[Get parent zone].

If the child zone does not exist (is not delegated), the only
test case to be run after this test case is [BASIC03]. However,
if the test type is an [undelegated test], then all other test cases
can be run even if the child zone is not delegated.


## Inputs

Input for this Test Case:
* "Child Zone" - The label of the domain name (zone) to be tested
* "Root Name Servers" - The IANA [List of Root Servers]
* "Test Type" - The test type with values "[undelegated test]" or
  "normal test".


## Summary

Message Tag                | Level | Arguments                          | Message ID for message tag
:--------------------------|:------|:-----------------------------------|:--------------------------
B01_CHILD_FOUND            |INFO   | domain                             | The zone "{domain}" is found.
B01_CHILD_IS_ALIAS         |NOTICE |domain_child, domain_target, ns_list| "{domain_child}" is not a zone. It is an alias for "{domain_target}". Run a test for "{domain_target}" instead. Returned from name servers "{ns_list}".
B01_INCONSISTENT_ALIAS     |ERROR  | domain                             | The alias for "{domain}" is inconsistent between name servers.
B01_INCONSISTENT_DELEGATION|ERROR  |domain_child, domain_parent, ns_list| The name servers for parent zone "{domain_parent}" give inconsistent delegation of "{domain_child}". Returned from name servers "{ns_list}".
B01_NO_CHILD               |ERROR  | domain_child, domain_super         | "{domain_child}" does not exist as a DNS zone. Try to test "{domain_super}" instead.
B01_PARENT_DISREGARDED     |INFO   |                                    | This is a test of an undelegated domain and finding the parent zone is disregarded.
B01_PARENT_FOUND           |INFO   | domain, ns_list                    | The parent zone is "{domain}" as returned from name servers "{ns_list}".
B01_PARENT_NOT_FOUND       |WARNING|                                    | The parent zone cannot be found.
B01_PARENT_UNDETERMINED    |WARNING| ns_list                            | The parent zone cannot be determined on name servers "{ns_list}".
B01_ROOT_HAS_NO_PARENT     |INFO   |                                    | This is a test of the root zone which has no parent zone.
B01_SERVER_ZONE_ERROR      |DEBUG  | query_name, rrtype, ns             | Unexpected response on query for "{query_name}" with query type "{rrtype}" to "{ns}".


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
[DNS Query and Response Defaults]. The handling of the DNS responses on the
DNS queries follow, unless otherwise specified below, what is specified for
[DNS Response] in the same specification.

1. If the *Child Zone* is the root zone (".") then:
   1. Output *[B01_CHILD_FOUND]* with zone name (".").
   2. Output *[B01_ROOT_HAS_NO_PARENT]*.
   3. Exit the test case.

2. If *Test Type* is "[undelegated test]", then:
   1. Output *[B01_CHILD_FOUND]* with zone name equal to *Child Zone*.
   2. Output *[B01_PARENT_DISREGARDED]*.
   3. Exit the test case.

3. Create [DNS queries][DNS Query]:
   1. Query type DNAME and query name *Child Zone* ("DNAME Child Query").

4. Create the following empty sets:
   1.  Name server IP and zone name ("Remaining Servers").
   2.  Name server IP and query name ("Handled Servers").
   3.  Parent name server IP and parent zone name ("Parent Found").
   4.  Parent name server IP and parent zone name ("Delegation Found").
   5.  Parent name server IP and parent zone name ("AA NXDomain Found").
   6.  Parent name server IP and parent zone name ("AA SOA Found").
   7.  Parent name server IP and parent zone name ("AA CNAME Found").
   8.  Parent name server IP and parent zone name ("CNAME with Referral Found").
   9.  Parent name server IP, parent zone name and DNAME target
       ("AA DNAME Found").
   10. Parent name server IP and parent zone name ("AA NODATA Found").

5. Insert all addresses from *Root Name Servers* and the root zone name into the
   *Remaining Servers* set.

> In the loop below, the steps tries to capture the name of the parent zone of
> **Child Zone** and the IP addresses of the name servers for that parent zone.
> This is done using a modified version of the "QNAME minimization" technique
> [RFC 9156]. SOA is the query type used for traversing the tree.

6. While the *Remaining Servers* is non-empty pick next name server IP address
   and zone name from the set ("Server Address" and "Zone Name") and do:

   1.  Extract and remove *Server Address* including its *Zone Name* from
       *Remaining Servers*.
   2.  Insert *Server Address* and *Zone Name* into *Handled Servers*.
   3.  Create [DNS queries][DNS Query]:
       1. Query type SOA and query name *Zone Name* ("Zone Name SOA Query").
       2. Query type NS and query name *Zone Name* ("Zone Name NS Query").
   4.  [Send] *Zone Name SOA Query* to *Server Address*.
   5.  Output [B01_SERVER_ZONE_ERROR] with query name *Zone Name*, [query type]
       SOA and name server IP *Server Address* and go to next server in
       *Remaining Servers* if one or more of the following matches:
          * No DNS response.
          * [RCODE Name] different from NoError in response.
          * AA bit not set in response.
          * Not exactly one SOA record in answer section
          * Owner name of SOA record is not *Zone Name*.
   6.  [Send] *Zone Name NS Query* to *Server Address*.
   7.  Output [B01_SERVER_ZONE_ERROR] with query name *Zone Name*, [query type]
       NS and name server IP *Server Address* and go to next server in
       *Remaining Servers* if one or more of the following matches:
          * No DNS response.
          * [RCODE Name] different from NoError in response.
          * AA bit not set in response.
          * No NS records in answer section
          * Owner name of any of the NS records is not *Zone Name*.
   8.  Extract the name server names from the NS records and any address records
       in the additional section.
   9.  Do [DNS Lookup] of name server names (A and AAAA) not already listed in the
       additional section of the response.
       1. For each IP address add the IP address and *Zone Name* to the
          *Remaining Servers* set unless the IP address is already listed in
          *Handled Servers* together with *Zone Name*.
       2. Ignore any failing lookups or lookups resulting in NODATA or NXDOMAIN.
   10. Create "Intermediate Query Name" by copying *Zone name* as start value.
   11. Run a loop processing *Server Address* (jumps back here from the steps
       below).
       1. Extend "Intermediate Query Name" by adding one more label to the left
          by copying the equivalent label from *Child Zone*. (See "Example 1"
          below.)
       2. Create a [DNS queries][DNS Query] with query name
          *Intermediate Query Name* and [query type] SOA
          ("Intermediate SOA query").
       3. [Send] *Intermediate SOA Query* to *Server Address*. (See "Example 2"
          below.)
       4. Output [B01_SERVER_ZONE_ERROR] with query name *Intermediate Query Name*
          and [query type] SOA and name server IP *Server Address* and go to next
          server in *Remaining Servers* if there is no DNS response.
       5. If the response has exactly one SOA record with owner name
          *Intermediate Query Name* in the answer section, with the AA bit
          set and [RCODE Name] NoError then do:
          1. If *Intermediate Query Name* is equal to *Child Zone* then
             1. Save *Server Address* and *Zone Name* to the *Parent Found* set
                and to the *AA SOA Found* set.
             2. Go to next server in *Remaining Servers*.
          2. Else do:
             1. Create a [DNS query][DNS Query] with query name
                *Intermediate Query Name* and [query type] NS
                ("Intermediate NS query").
             2. [Send] *Intermediate NS Query* to *Server Address*.
             3. Output [B01_SERVER_ZONE_ERROR] with query name
                *Intermediate NS Query* and [query type] NS and name server IP
                *Server Address* and go to next server in *Remaining Servers* if
                one or more of the following matches:
                   * No DNS response.
                   * [RCODE Name] different from NoError in response.
                   * AA bit not set in response.
                   * No NS records in answer section.
                   * Owner name of any of the NS records is not *Intermediate Query Name*.
             4. Extract the name server names from the NS records and any address
                records in the additional section.
             5. Do [DNS Lookup] of name server names (A and AAAA) not already
                listed in the additional section of the response.
             6. For each IP address add the IP address and *Intermediate Query Name*
                to the *Remaining Servers* set unless the IP address is already
                listed in *Handled Servers* together with *Intermediate Query Name*.
             7. Set *Zone Name* to *Intermediate Query Name*.
             8. Go back to the start of the loop.
       6. Else, if the [RCODE Name] is NXDomain and the AA is set then do:
          1. Save *Server Address* and *Zone Name* to the *AA NXDomain Found* set
             and the *Parent Found* set.
          2. Go to next server in *Remaining Servers*.
       7. Else, if the response contains a [Referral] of *Intermediate Query Name*
          then do:
          1. If *Intermediate Query Name* is equal to *Child Zone* then do:
             1. Save *Server Address* and *Zone Name* to the *Parent Found* set
                and to the *Delegation Found* set.
          2. Else do:
             1. Extract the name server names from the NS records and any glue
                records.
             2. Do [DNS Lookup] of name server names (A and AAAA) not already
                listed as glue record or records.
             3. For each IP address add *Server Address* and
                *Intermediate Query Name* to the *Remaining Servers* set unless
                *Server Address* is already listed in *Handled Servers* together
                with *Intermediate Query Name*.
          3. Go to next server in *Remaining Servers*.
       8. Else, if the [RCODE Name] is NoError and the AA is set then do:
          1. If *Intermediate Query Name* is not equal to *Child Zone* then
             go back to the start of the loop.
          2. Else do:
             1. If the response has a CNAME record with *Child Zone* as owner
                name in the answer section, then do:
                1. Save *Server Address* and *Zone Name* to the *Parent Found*
                   set and to the *AA CNAME Found* set.
                2. Go to next server in *Remaining Servers*.
             2. Else do:
                1. [Send] a *DNAME Child Query* to the name server IP address.
                2. If there is a response with the AA flag set, the [RCODE Name]
                   NoError and a DNAME record with *Child Zone* as owner name in
                   the answer section, then
                   1. Save *Server Address* and *Zone Name* to the *Parent Found*
                      set.
                   2. Save *Server Address*, *Zone Name* and the DNAME target
                      (RDATA value) to the *AA DNAME Found* set.
                3. Else (no response or some other response than above) save the
                   *Server Address* and *Zone Name* to the *Parent Found* set
                   and to the *AA NODATA Found* set.
                4. Go to next server in *Remaining Servers*.
       9. Else, if the response is a [Referral] with a CNAME record with
          *Child Zone* as owner name in the answer section, then
          1. Save *Server Address* and *Zone Name* to the *Parent Found* set and
             to the *CNAME with Referral Found* set.
          2. Go to next server in *Remaining Servers*.
       10. Else, output [B01_SERVER_ZONE_ERROR] with query name
          *Intermediate NS Query*, [query type] SOA and name server IP
          *Server Address* and go to next server in *Remaining Servers*.


7. If the *Parent Found* set is non-empty, then
   1. For each parent zone name output *[B01_PARENT_FOUND]*, parent zone name
      and the set of name server IP addresses for that name.
   2. If not all members of the set have the same parent zone then output
      *[B01_PARENT_UNDETERMINED]* and the whole set of name server IP addresses.

8. If the *Parent Found* set is empty, then output *[B01_PARENT_NOT_FOUND]*.

9. If one or both of the *Delegation Found* and the *AA SOA Found* sets are
    non-empty, then do:
    1. Output *[B01_CHILD_FOUND]* with *Child Zone*.
    2. If one or more of the following five sets are also non-empty then output
       *[B01_INCONSISTENT_DELEGATION]* with *Child Zone*, parent zone name and
       the combined set of name server IP addresses from all five sets.
          * *AA NXDomain Found*
          * *AA CNAME Found*
          * *CNAME with Referral Found*
          * *AA DNAME Found*
          * *AA NODATA Found*

10. If both of the *Delegation Found* and the *AA SOA Found* sets are empty, then
    do:
       1. Create "Superdomain" as a copy of *Child Zone* with the first label
          removed.
       2. Output *[B01_NO_CHILD]* with *Child zone* and *Superdomain*.

11. If the *AA DNAME Found* set is non-empty then do:
    1. For each DNAME target in the set output *[B01_CHILD_IS_ALIAS]* with name
       server IP list, *Child Zone* and the DNAME target.
    2. If not all members of the set have the same DNAME target, output
       *[B01_INCONSISTENT_ALIAS]* with *Child Zone*.

> Examples referred to from the steps.
>
> Example 1: If *Child Zone* is "foo.bar.xa" and *Intermediate Query Name* is "."
> (root zone) then *Intermediate Query Name* becomes "xa". If it is "xa", it
> will become "bar.xa" instead.
>
> Example 2: An "bar.xa SOA" query to a name server for "xa".


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message with
the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level *[INFO]* or
*[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, skip [Sending][Send]
queries over that transport protocol. A message will be outputted reporting that
the transport protocol has been skipped.

The *Child Zone* must be a valid name meeting
"[Requirements and normalization of domain names in input]".


## Intercase dependencies

None.


## Terminology

* "Direct Subdomain" - Domain A is considered to be a "direct Subdomain" to
  domain B if domain A is just the addition of one label at the least significant
  (left) side, e.g. "foo.domain.com" is a direct subdomain to "domain.com".

* "DNS Lookup" - The term is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected. Compare with "[Send]".

* "Non-Referral" - See "[Referral]".

* "Referral" - A DNS response with [RCODE Name] NoError, AA flag unset and NS
records in the authority section. The answer section is empty or with CNAME
record or records. If the query type is CNAME, then the answer section must be
empty (does not apply to this test case). The additional section may contain
address records (A and AAAA) for the name server names from the NS (glue
records).

* "Send" - The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server. Compare with "[DNS Lookup]".


[Argument list]:                                                  ../ArgumentsForTestCaseMessages.md
[B01_CHILD_FOUND]:                                                #Summary
[B01_CHILD_IS_ALIAS]:                                             #Summary
[B01_INCONSISTENT_ALIAS]:                                         #Summary
[B01_INCONSISTENT_DELEGATION]:                                    #Summary
[B01_NO_CHILD]:                                                   #Summary
[B01_PARENT_DISREGARDED]:                                         #Summary
[B01_PARENT_FOUND]:                                               #Summary
[B01_PARENT_NOT_FOUND]:                                           #Summary
[B01_PARENT_UNDETERMINED]:                                        #Summary
[B01_ROOT_HAS_NO_PARENT]:                                         #Summary
[B01_SERVER_ZONE_ERROR]:                                          #Summary
[Basic03]:                                                        basic03.md
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[Direct Subdomain]:                                               #terminology
[DNS Lookup]:                                                     #terminology
[DNS Query and Response Defaults]:                                ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                      ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                   ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                          ../SeverityLevelDefinitions.md#error
[Get parent zone]:                                                ../MethodsV2.md#method-get-parent-ns-ip-addresses
[INFO]:                                                           ../SeverityLevelDefinitions.md#info
[List of Root Servers]:                                           https://www.iana.org/domains/root/servers
[NOTICE]:                                                         ../SeverityLevelDefinitions.md#notice
[Non-referral]:                                                   #terminology
[Query type]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Referral]:                                                       #terminology
[Requirements and normalization of domain names in input]:        ../RequirementsAndNormalizationOfDomainNames.md
[RFC 9156]:                                                       https://www.rfc-editor.org/rfc/rfc9156.html
[Send]:                                                           #terminology
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[Test procedure]:                                                 #test-procedure
[Undelegated test]:                                               ../../test-types/undelegated-test.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      ../../../configuration/profiles.md
