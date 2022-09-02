# BASIC01: Check for the parent zone and the zone itself

## Test case identifier
**BASIC01**


## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Terminology](#terminology)


## Objective

In order for a domain (zone) to work, it must be delegated from a
zone higher up in the DNS hierarchy (a parent domain or zone).
This Test Case will determine if parent zone and child zones,
respectively, exist.

If the test is an [undelegated test], however, it can be tested even it is not
delegated or even if the parent zone can not be determined.

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

Message Tag                | Level | Arguments                             | Message ID for message tag
:--------------------------|:------|:--------------------------------------|:--------------------------
B01_CHILD_IS_ALIAS         |NOTICE |domain_child, domain_target, ns_ip_list| "{domain_child}" is not a zone. It is an alias for "{domain_target}". Run a test for "{domain_target}" instead. Returned from name servers "{ns_ip_list}.
B01_CHILD_FOUND            |INFO   | domain                                | The zone "{domain}" is found.
B01_CHILD_NOT_EXIST        |INFO   | domain                                | "{domain}" does not exist as it is not delegated.
B01_INCONSISTENT_ALIAS     |ERROR  | domain                                | The alias for "{domain}" is inconsistent between name servers.
B01_INCONSISTENT_DELEGATION|ERROR  |domain_child, domain_parent, ns_ip_list| The name servers for parent zone "{domain_parent}" give inconsistent delegation of "{domain_child}". Returned from name serververs "{ns_ip_list}".
B01_NO_CHILD               |ERROR  | domain_child, domain_super            | "{domain_child}" does not exist as a DNS zone. Try to test "{domain_super}" instead.
B01_PARENT_FOUND           |INFO   | domain, ns_ip_list                    | The parent zone is "{domain}" as returned from name servers "{ns_ip_list}".
B01_PARENT_UNDETERMINED    |WARNING| ns_ip_list                            | The parent zone cannot be determined on name servers "{ns_ip_list}".
B01_UNEXPECTED_NS_RESPONSE |WARNING|domain_child, domain_parent, ns_ip_list| Name servers for parent domain "{domain_parent}" give an incorrect response on SOA query for "{domain_child}". Returned from name servers {ns_ip_list}.


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

In this section and unless otherwise specified below, the terms "[DNS Query]"
follow the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the
DNS queries follow, unless otherwise specified below, what is specified for
[DNS Response] in the same specification.

1. If the *Child Zone* is the root zone (".") then:
   1. Output *[B01_CHILD_FOUND]* with zone name (".").
   2. Exit the test case.

2. Create [DNS queries][DNS Query]:
   1. Query type SOA and query name *Child Zone* ("SOA Child Query").
   2. Query type DNAME and query name *Child Zone* ("DNAME Query").

3. Create the following empty sets:
   1.  Name server IP and zone name ("Remaining Servers").
   2.  Name server IP ("Handled Servers").
   3.  Parent name server IP, parent zone name and DNS response
       ("Parent Information").
   4.  Parent name server IP and parent zone name ("Parent Found").
   5.  Parent name server IP and parent zone name ("Delegation Found").
   6.  Parent name server IP and parent zone name ("Non-AA Non-Delegation Found")
   7.  Parent name server IP and parent zone name ("AA NXDomain Found").
   8.  Parent name server IP and parent zone name ("AA SOA Found").
   9.  Parent name server IP and parent zone name ("AA CNAME Found").
   10. Parent name server IP and parent zone name ("CNAME with Referral Found").
   11. Parent name server IP, parent zone name and DNAME target
       ("AA DNAME Found").
   12. Parent name server IP and parent zone name ("AA NODATA Found").

4. Insert all addresses from *Root Name Servers* and the root zone name into the
   *Remaining Servers* set.

> *In the loop below the steps tries to capture the name of the parent zone of
> of **Child Zone** and the IP addresses of the name servers for that parent zone
> by collecting those IP addresses and the parent zone name that the server is
> name server for. Here collection is done, further down (below the loop) the
> steps will check and compare the found parent zone names.*

> *Note that the "parent zone name" is the name of the zone that the name server
> in question is NS for (owner name of NS). The name of the name server is
> irrelevant.*


5. While the *Remaining Servers* is non-empty pick next name server IP address
   and zone name from the set ("Server Address" and "Zone Name") and do:
   1. Remove *Server Address* including its *Zone Name* from *Remaining Servers*.
   2. Insert *Server Address* into *Handled Servers*
   3. [Send] *SOA Child Query* to *Server Address*.
   4. If *Server Address* does not respond with a DNS response or with an
      [RCODE Name] besides NoError and NXDomain, then ignore it.
   5. If *Server Address* responds with a [Non-Referral] and the AA
      bit unset, then add *Server Address* and *Zone Name* to the
      *Non-AA Non-Delegation Found* set.
   6. If *Server Address* responds with a [Referral] then ignore it unless the
      two requirements are met:
      * The referral must be to a domain name that is a subdomain of *Zone Name*.
      * The referral must be  to a domain name that is identical to or a
        superdomain of *Child Zone*.
   7. If *Server Address* responds with a [Referral] to a name that is
      a superdomain (one or several steps) of *Child Zone* then do:
      1. Extract the NS record set owner name ("Referral Zone Name").
      2. Extract the name server names from the NS records and any glue records.
      3. Do [DNS Lookup] of name server names (A and AAAA) not
         already listed as glue record or records.
      4. For each IP address (glue and looked-up) add the IP address and
         *Referral Zone Name* to the *Remaining Servers* set unless the IP
         address is already listed in *Handled Servers*.
   8. If exactly one of the following criteria is met then save *Server Address*,
      *Zone Name* (i.e. parent zone) and the DNS response to the
      *SOA Child Query* into the *Parent Information* set. Criteria:
      * The DNS response is a [Referral] to *Child Zone* (owner name of the NS
        records is *Child Zone*), or
      * The DNS response is a [Referral] with at least one CNAME record in the
        answer section where one CNAME record has *Child Zone* as owner name.
      * The DNS response has the AA flag set.

> *In the loop below the steps tries to capture additional name servers by IP
> address for the parent zone by querying the parent zone for NS records.*

6. For each name server IP and parent zone ("Parent Server Address" and
   "Parent Zone", respectively) in the *Parent Information* set, do the following
   steps, including for any name servers added to the set by the steps below.
   1. Send a [DNS Query] with query type NS and *Parent Zone* as query name to
      *Parent Server Address*.
   2. If no DNS response, then go to next *Parent Server Address*.
   3. If the [DNS Response] contains no NS records in the answer section with
      *Parent Zone* as owner name, then go to next *Parent Server Address*.
   4. Extract the NS records from the answer section with *Parent Zone* as owner
      name from [DNS Response].
   5. For each NS record extract the name server name ("Name Server Name") in
      the RDATA field and do:
      1. Create a [DNS Query] with query type A, *Name Server Name* as query
         name and RD flag set, and do a [DNS Lookup].
      2. If the [DNS Response], if any, contains a list of A records (follow
         any CNAME chain) in the answer section then create a set of the IPv4
         addresses from the A records ("NS IPv4 Addresses").
      3. Create a [DNS Query] with query type AAAA, *Name Server Name* as
         query name and RD flag set, and do a [DNS lookup].
      4. If the [DNS Response], if any, contains a list of AAAA records
         (follow any CNAME chain) in the answer section then create a set of
         the IPv6 addresses from the AAAA records ("NS IPv6 Addresses").
      5. For each IP address ("IP Address") in the combined
         *NS IPv4 Addresses* and *NS IPv6 Addresses* sets do (can be empty):
         1. If *IP Address* is in the *Parent Information* set, then go to
            next *IP Address*.
         2. [Send] *SOA Child Query* to the IP address.
         3. If the [DNS Response], if any, meets exactly one of the following two
            criteria then save *IP Address*, *Parent Zone* and the DNS response
            to the *Parent Information* set. Criteria:
            * The [DNS response] is a [Referral] to *Child Zone* (owner name
              of the NS records in authority section is *Child Zone*), or
            * The [DNS response] has the AA flag set and the [RCODE Name]
              NoError.

> *In the loops above the name server IP addresses and parent zone name were
> collected, but also the DNS response from the queries sent. In the loop below
> the responses are examined to determine if there really is any delegation
> for **Child Zone**.*

7. For each name server IP in the *Parent Information* set extract
   parent zone name and the DNS response.
   1.  If the response is a [Referral] to the requested *Child Zone*:
       1. Save the name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *Delegation Found*
          set.
   2.  If the response has the AA flag set and with the [RCODE Name] NXDomain,
       then
       1. Save the name server IP and parent zone name to the *Parent Found*
          set.
       2. Save the name server IP and parent zone name to the
          *AA NXDomain Found* set.
   3.  If the response has the AA flag set and an SOA record with
       *Child Zone* as owner name in the answer section, then
       1. If *Child Zone* is a [Direct Subdomain] to parent zone name then save the
          name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *AA SOA Found* set.
   4.  If the response has the AA flag set and a CNAME record with
       *Child Zone* as owner name in the answer section, then
       1. Save the name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *AA CNAME Found*
          set.
   5.  If the response is a [Referral] with a CNAME record with *Child Zone* as
       owner name in the answer section, then
       1. Save the name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the
          *CNAME with Referral Found* set.
   6.  If the response has the AA flag set and an empty answer section (NODATA),
       then
       1. [Send] a *DNAME Query* to the name server IP address.
       2. If there is a response with the AA flag set, the [RCODE Name] NoError
          and a DNAME record with *Child Zone* as owner name in the answer
          section, then
          1. Save the name server IP and parent zone name to the *Parent Found*
            set.
          2. Save the name server IP, parent zone name and the DNAME target
            (RDATA value) to the *AA DNAME Found* set.
       3. Else (no response or some other response than above), then do:
          1. Save the name server IP and parent zone name to the *Parent Found*
             set.
          2. Save the name server IP and parent zone name to the
             *AA NODATA Found* set.

8. If the *Parent Found* set is non-empty, then
   1. For each parent zone name output *[B01_PARENT_FOUND]*, parent zone name
      and the set of name server IP addresses for that name.
   2. If not all members of the set have the same parent zone then output
      *[B01_PARENT_UNDETERMINED]* and the whole set of name server IP addresses.

9. If both of the *Parent Found* and the *AA SOA Found* sets are empty, then
   output *[B01_PARENT_UNDETERMINED]* and the whole set of name server IP
   addresses from the *Parent Information* set.

10. If one or both of the *Delegation Found* and the *AA SOA Found* sets are
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
    3. Else, if the *Delegation Found* set is empty, then do
       1. For each parent zone name in the *AA SOA Found* set do if *Child Zone*
          is not a [Direct Subdomain] to parent zone name then output
          *[B01_PARENT_FOUND]*, parent zone name and the set of name server IP
          addresses for that name.
       2. If not all parent zone name in *AA SOA Found* are not equal then output
          *[B01_PARENT_UNDETERMINED]* and the whole set of name server IP
          addresses from the *AA SOA Found* set,

11. If both of the *Delegation Found* and the *AA SOA Found* sets are empty, then
    do:
    1. If *Test Type* is "normal test" then do:
       1. Create "Superdomain" as the domain just above *Child Zone*.
       2. Output *[B01_NO_CHILD]* with *Child zone* and *Superdomain*.
    2. If *Test Type* is "[undelegated test]", output *[B01_CHILD_NOT_EXIST]*
       with *Child Zone*.

12. If the *AA DNAME Found* set is non-empty then do:
    1. For each DNAME target in the set output *[B01_CHILD_IS_ALIAS]* with name
       server IP list, *Child Zone* and the DNAME target.
    2. If not all members of the set have the same DNAME target, output
       *[B01_INCONSISTENT_ALIAS]* with *Child Zone*.

13. If the *Non-AA Non-Delegation Found* set is non-empty then for each parent
    zone name from the set do:
    1. Output *[B01_UNEXPECTED_NS_RESPONSE]* with parent zone name, *Child Zone*
       and list of name server IP addresses.


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


[Argument list]:                                                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[B01_CHILD_FOUND]:                                                #Summary
[B01_CHILD_IS_ALIAS]:                                             #Summary
[B01_CHILD_NOT_EXIST]:                                            #Summary
[B01_INCONSISTENT_ALIAS]:                                         #Summary
[B01_INCONSISTENT_DELEGATION]:                                    #Summary
[B01_INCONSISTENT_DELEGATION]:                                    #Summary
[B01_NO_CHILD]:                                                   #Summary
[B01_PARENT_FOUND]:                                               #Summary
[B01_PARENT_UNDETERMINED]:                                        #Summary
[B01_UNEXPECTED_NS_RESPONSE]:                                     #Summary
[Basic03]:                                                        basic03.md
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[Direct Subdomain]:                                               #terminology
[DNS Lookup]:                                                     #terminology
[DNS Query and Response Defaults]:                                ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                      ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                   ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                          ../SeverityLevelDefinitions.md#error
[Get parent zone]:                                                ../MethodsV2.md#method-get-parent-zone
[INFO]:                                                           ../SeverityLevelDefinitions.md#info
[List of Root Servers]:                                           https://www.iana.org/domains/root/servers
[NOTICE]:                                                         ../SeverityLevelDefinitions.md#notice
[Non-referral]:                                                   #terminology
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Referral]:                                                       #terminology
[Requirements and normalization of domain names in input]:        ../RequirementsAndNormalizationOfDomainNames.md
[Send]:                                                           #terminology
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[Undelegated test]:                                               ../../test-types/undelegated-test.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
