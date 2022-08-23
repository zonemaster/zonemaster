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
B01_PARENT_INDETERMINED    |WARNING| ns_ip_list                            | The parent zone cannot be determined on name servers "{ns_ip_list}".
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
   1. Parent name server IP, parent zone name and DNS response
      ("Parent Name Server IP").
   2. Parent name server IP and parent zone name ("Parent Found").
   3. Parent name server IP and parent zone name ("Delegation Found").
   4. Parent name server IP and parent zone name ("Non-AA Non-Delegation Found")
   5. Parent name server IP and parent zone name ("AA NXDomain Found").
   6. Parent name server IP and parent zone name ("AA SOA Found").
   7. Parent name server IP and parent zone name ("AA CNAME Found").
   8. Parent name server IP, parent zone name and DNAME target
      ("AA DNAME Found").
   9. Parent name server IP and parent zone name ("AA NODATA Found").
   10. Name server IP and zone name ("Remaining Servers").
   11. Name server IP ("Handled Servers").

> *Note that a referral is a DNS response with [RCODE Name] NoError, AA flag
> unset and NS records in the authority section. The answer section is empty
> or with CNAME record or records. If the query type is CNAME, then the answer
> section must be empty. The additional section may contain address records
> (A and AAAA) for the name server names from the NS (glue records).*

4. Insert all addresses from *Root Name Servers* and the root zone name into the
   *Remaining Servers* set.
5. While the *Remaining Servers* is non-empty pick next name server IP address
   and zone name from the set ("Server Address" and "Zone Name") and do:
   1. Remove the IP address from *Remaining Servers*.
   2. Insert *Server Address* into *Handled Servers*
   3. [Send](#terminology) *SOA Child Query* to *Server Address*.
   4. If *Server Address* does not respond at all, with an invalid DNS response
      or with an [RCODE Name] besides NoError and NXDomain, then ignore it.
   5. If *Server Address* responds with a non-referral and the AA bit unset, then
      add the name server IP and its zone name to the
      *Non-AA Non-Delegation Found* set.
   6. If *Server Address* responds with a referral idential to *Zone Name*, then
      ignore it.
   7. If *Server Address* responds with a referral longer than *Zone Name* but
      shorter than *Child Zone* then do:
      1. Extract the NS record set owner name ("Referral Zone Name").
      2. Extract the name server names from the NS records and any glue records.
      3. Do [DNS Lookup](#terminology) of name server names (A and AAAA) not
         already listed as glue record or records.
      4. For each IP address (glue and looked-up) add the IP address and
         *Referral Zone Name* to the *Remaining Servers* set unless the IP
         address is already listed in *Handled Servers*.
   8. If exactly one of the following criteria is met then save the name server
      IP address, zone name for which the server is name server (parent zone) and
      the DNS response to the *SOA Child Query* into the *Parent Name Server IP*
      set. Criteria:
      * The DNS response is a referral to *Child Zone* (owner name of the NS
        records is *Child Zone*), or
      * The DNS response has the AA flag set.

> *Note that the "parent zone name" is the name of the zone that the name server
> in question is NS for (owner name of NS). The name of the name server is
> irrelevant.*

6. For each name server IP and parent zone ("Parent Zone") in the
   *Parent Name Server IP* set, do the following steps, including for any name
   servers added to the set by the steps below.
   1. Send a [DNS Query] with query type NS and *Parent Zone* as query name to
      the name server IP.
   2. If no DNS response, then go to next name server IP.
   3. If the [DNS Response] contains no NS records in the answer section with
      *Parent Zone* as owner name, then go to next name server IP.
   4. Extract the NS records from the answer section with *Parent Zone* as owner
      name from [DNS Response].
   5. For each NS record extract the name server name ("Name Server Name") in
      the RDATA field and do:
      1. Create a [DNS Query] with query type A, *Name Server Name* as query
         name and RD flag set, and do a [DNS Lookup](#terminology).
      2. If the [DNS Response], if any, contains a list of A records (follow
         any CNAME chain) in the answer section then create a set of the IPv4
         addresses from the A records ("NS IPv4 Addresses").
      3. Create a [DNS Query] with query type AAAA, *Name Server Name* as
         query name and RD flag set, and do a [DNS lookup](#terminology).
      4. If the [DNS Response], if any, contains a list of AAAA records
         (follow any CNAME chain) in the answer section then create a set of
         the IPv6 addresses from the AAAA records ("NS IPv6 Addresses").
      5. If the *NS IPv4 Addresses* set or the *NS IPv6 Addresses* set is
         non-empty, then then for each IP address in the two sets do if the
         address is not already listed in the *Parent Name Server IP* set:
         1. [Send](#terminology) *SOA Child Query* to the IP address.
         2. If the [DNS Response], if any, meets exactly one of the
            following two criteria then save the IP address, the parent
            zone name and the DNS response to the *Parent Name Server IP* set.
            Criteria:
            * The [DNS response] is a referral to *Child Zone* (owner name
              of the NS records in authority section is *Child Zone*), or
            * The [DNS response] has the AA flag set and the [RCODE Name]
              NoError.

7. For each name server IP in *Parent Name Server IP* extract
   parent zone name and the DNS response.
   1.  If the response is a referral (delegation) to the requested *Child Zone*:
       1. Save the name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *Delegation Found*
          set.
   2.  If the response has the AA flag set and with the [RCODE Name] NXDomain,
       then
       1. Save the name server IP and parent zone name to the *Parent Found*
          set.
       2. Save the name server IP and parent zone name to the
          *AA NXDomain Found* set.
   3.  If the response has the AA flag set and with an SOA record with
       *Child Zone* as owner name in the answer section, then
       1. If *Child Zone* is a direct subdomain to parent zone name then save the
          name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *AA SOA Found* set.
   4.  If the response has the AA flag set and with a CNAME record with
       *Child Zone* as owner name in the answer section, then
       1. Save the name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *AA CNAME Found*
          set.
   5.  If response has the AA flag set and with an empty answer section (NODATA),
       then
       1. [Send](#terminology) a *DNAME Query* to the name server IP address.
       2. If there is a response with the AA flag set, the [RCODE Name] NoError
          and with a DNAME record with *Child Zone* as owner name in the answer
          section, then
          1. Save the name server IP and parent zone name to the *Parent Found*
            set.
          2. Save the name server IP, parent zone name and the DNAME target
            (RDATA value) to the *AA DNAME Found* set.
       3. Else, if no *DNAME Query* is sent or if there is no response or some
          other response than above then do:
          1. Save the name server IP and parent zone name to the *Parent Found*
             set.
          2. Save the name server IP and parent zone name to the
             *AA NODATA Found* set.

8. If the *Parent Found* set is non-empty, then
   1. For each parent zone name output *[B01_PARENT_FOUND]*, parent zone name
      and the set of name server IP addresses for that name.
   2. If not all members of the set have the same parent zone then output
      *[B01_PARENT_INDETERMINED]* and the whole set of name server IP addresses.

9. If both of the *Parent Found* and the *AA SOA Found* sets are empty, then
   output *[B01_PARENT_INDETERMINED]* and the whole set of name server IP
   addresses from *Parent Name Server IP*.

10. If one or both of the *Delegation Found* and the *AA SOA Found* sets are
    non-empty, then do:
    1. Output *[B01_CHILD_FOUND]* with *Child Zone*.
    2. If one or more of the following sets are also non-empty then output
       *[B01_INCONSISTENT_DELEGATION]* with *Child Zone*, parent zone name and
        the combined set of name server IP addresses from all six sets.
          * *AA NXDomain Found*
          * *AA CNAME Found*
          * *AA DNAME Found*
          * *AA NODATA Found*
    3. Else, if the *Delegation Found* set is empty, then do
       1. For each parent zone name in the *AA SOA Found* set do if *Child Zone*
          is not a direct subdomain to parent zone name then output
          *[B01_PARENT_FOUND]*, parent zone name and the set of name server IP
          addresses for that name.
       2. If not all parent zone name in *AA SOA Found* are not equal then output
          *[B01_PARENT_INDETERMINED]* and the whole set of name server IP
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

If either IPv4 or IPv6 transport is disabled, skip [sending](#terminology)
queries over that transport protocol. A message will be outputted reporting that
the transport protocol has been skipped.

The *Child Zone* must be a valid name meeting
"[Requirements and normalization of domain names in input]".


## Intercase dependencies

None.


## Terminology

* "Send" - The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server.

* "DNS Lookup" - The term is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.


[Argument list]:                                                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[B01_CHILD_FOUND]:                                                #outcomes
[B01_CHILD_IS_ALIAS]:                                             #outcomes
[B01_CHILD_NOT_EXIST]:                                            #outcomes
[B01_INCONSISTENT_ALIAS]:                                         #outcomes
[B01_INCONSISTENT_DELEGATION]:                                    #outcomes
[B01_INCONSISTENT_DELEGATION]:                                    #outcomes
[B01_NO_CHILD]:                                                   #outcomes
[B01_PARENT_FOUND]:                                               #outcomes
[B01_PARENT_INDETERMINED]:                                        #outcomes
[B01_UNEXPECTED_NS_RESPONSE]:                                     #outcomes
[Basic03]:                                                        basic03.md
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:                                ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                      ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                   ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                          ../SeverityLevelDefinitions.md#error
[Get parent zone]:                                                ../MethodsV2.md#method-get-parent-zone
[INFO]:                                                           ../SeverityLevelDefinitions.md#info
[List of Root Servers]:                                           https://www.iana.org/domains/root/servers
[NOTICE]:                                                         ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Requirements and normalization of domain names in input]:        ../RequirementsAndNormalizationOfDomainNames.md
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[Undelegated test]:                                               ../../test-types/undelegated-test.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md

