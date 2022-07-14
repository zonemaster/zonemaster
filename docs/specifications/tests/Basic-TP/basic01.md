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

If the zone to be tested is the root zone, it has no parent or
delegation and will always pass this Test Case.

If no parent can be determined, there cannot be any delegation.

If the child zone does not exist (is not delegated), the only
test case to be run after this test case is [BASIC03]. However,
if the test type is an [undelegated test], then all other test cases
can be run even if the child zone is not delegated.


## Scope

The algorithm in this test case must match the argorithm in method
[Get parent zone].


## Inputs

Input for this Test Case:
* "Child Zone" - The label of the domain name (zone) to be tested
* "Root Name Servers" - The IANA [List of Root Servers]
* "Test Type" - The test type with values "[undelegated test]" or
  "normal test".



## Summary

Message Tag                | Level | Arguments                    | Message ID for message tag
:--------------------------|:------|:-----------------------------|:--------------------------
B01_CHILD_IS_ALIAS         |NOTICE |domain_c, domain_t, ns_ip_list| "{domain_c}" is not a zone. It is an alias for "{domain_t}". Run a test of "{domain_t}" instead. Found on name server "{ns_ip_list}.
B01_CHILD_FOUND            |INFO   | domain                       | The zone "{domain}" is found.
B01_CHILD_NOT_DELEGATED    |INFO   | domain                       | "{domain}" is not delegated and the zone does not exist.
B01_INCONSISTENT_ALIAS     |ERROR  | domain                       | The alias for "{domain}" is inconsistent between name servers.
B01_INCONSISTENT_DELEGATION|ERROR  |domain_c, domain_p, ns_ip_list| The name servers for parent zone "{domain_p}" gives inconsistent delegation of "{domain_c}". Name serververs: "{ns_ip_list}".
B01_NO_CHILD               |ERROR  | domain_c, domain_s           | "{domain_c}" does not exist as a DNS zone. Try to test "{domain_s}" instead.
B01_PARENT_FOUND           |INFO   | domain, ns_ip_list           | The parent zone is "{domain}" as found on name servers "{ns_ip_list}".
B01_PARENT_INDETERMINED    |WARNING| ns_ip_list                   | The parent zone cannot be determined on name servers "{ns_ip_list}".
B01_UNEXPECTED_NS_RESPONSE |WARNING|domain_c, domain_p, ns_ip_list| Name servers for parent domain "{domain_p}" gives an incorrect response on SOA query for "{domain_c}". Name server IP addresses are {ns_ip_list}.


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
   1. Query type SOA and query name *Child Zone* ("SOA Query").
   2. Query type DNAME and query name *Child Zone* ("DNAME Query").

3. Create the following empty set:
   1. Parent name server IP and parent zone name ("Parent Name Server IP").
   2. Parent name server IP and parent zone name ("Parent Found").
   3. Parent name server IP and parent zone name ("Delegation Found").
   4. Parent name server IP and parent zone name ("Non-AA Non-Delegation Found")
   5. Parent name server IP and parent zone name ("AA NXDOMAIN Found").
   6. Parent name server IP and parent zone name ("AA SOA Found").
   7. Parent name server IP and parent zone name ("AA CNAME Found").
   8. Parent name server IP, parent zone name and DNAME target
      ("AA DNAME Found").
   9. Parent name server IP and parent zone name ("AA NODATA Found").

4. Find the parent zone of the *Child Zone* by iteratively
   [sending](#terminology) *SOA Query* to all name servers found. Start by using
   the nameservers from the *Root Name Servers*.
   1. Follow all paths from root and downwards by following the referrals
      (non-AA response with empty answer section and NS records in the authority
      section).
   2. When one of the following criteria is met (not both), then stop the lookup
      up in that branch and save the name server IP address, zone name for which
      the server is name server (parent zone) and the DNS response to the
      *SOA Query* to the *Parent Name Server IP* set. Criteria:
      * The DNS response is a referral to *Child Zone* (owner name of the NS
        records is *Child Zone*), or
      * The DNS response has the AA flag set.
   3. If the lookup reaches a name server that does not responds at all, with
      an invalid DNS response or with an RCODE besides NOERROR and NXDOMAIN, then
      ignore it.
   4. If the lookup reaches a name server that responds with a
      non-referral and the AA bit unset, then add the name server IP and its
      zone name to the *Non-AA Non-Delegation Found* set.
   5. Continue until all paths are exhausted.

> *Note that the "parent zone name" is the name of the zone that the name server
> in question is NS for (owner name of NS). The name of the name server is
> irrelevant.*


5. For each name server IP in *Parent Name Server IP* extract
   parent zone name and the DNS response.

   1.  If the response is a referral (delegation) to the requested *Child Zone*:
       1. Save the name server IP and parent zone name to the *Parent Found* set.
       2. Save the name server IP and parent zone name to the *Delegation Found*
          set.
   2.  If the response has the AA flag set and with RCODE NXDOMAIN, then
       1. Save the name server IP and parent zone name to the *Parent Found*
          set.
       2. Save the name server IP and parent zone name to the
          *AA NXDOMAIN Found* set.
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
       2. If there is a response with the AA flag set, RCODE NOERROR and with a
          DNAME record with *Child Zone* as owner name in the answer section,
          then
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

6. If the *Parent Found* set is non-empty, then
   1. For each parent zone name output *[B01_PARENT_FOUND]*, parent zone name
      and the set of name server IP addresses for that name.
   2. If not all members of the set have the same parent zone then output
      *[B01_PARENT_INDETERMINED]* and the whole set of name server IP addresses.

7. If both of the *Parent Found* and the *AA SOA Found* sets are empty, then
   output *[B01_PARENT_INDETERMINED]* and the whole set of name server IP
   addresses from *Parent Name Server IP*.

8. If one or both of the *Delegation Found* and the *AA SOA Found* sets are
   non-empty, then do:
   1. Output *[B01_CHILD_FOUND]* with *Child Zone*.
   2. If one or more of the following sets are also non-empty then output
      *[B01_INCONSISTENT_DELEGATION]* with *Child Zone*, parent zone name and
      the combined set of name server IP addresses from all six sets.
         * *AA NXDOMAIN Found*
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

9. If both of the *Delegation Found* and the *AA SOA Found* sets are empty, then
   do:
    1. If *Test Type* is "normal test" then do:
       1. Create "Superdomain" as the domain just above *Child Zone*.
       2. Output *[B01_NO_CHILD]* with *Child zone* and *Superdomain*.
    2. If *Test Type* is "[undelegated test]", output *[B01_CHILD_NOT_DELEGATED]*
       with *Child Zone*.

10. If the *AA DNAME Found* set is non-empty then do:
    1. For each DNAME target in the set output *[B01_CHILD_IS_ALIAS]* with name
       server IP list, *Child Zone* and the DNAME target.
    2. If not all members of the set have the same DNAME target, output
       *[B01_INCONSISTENT_ALIAS]* with *Child Zone*.

11. If the *Non-AA Non-Delegation Found* set is non-empty then for each parent
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

The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server.


[Argument list]:                                                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[B01_CHILD_FOUND]:                                                #outcomes
[B01_CHILD_IS_ALIAS]:                                             #outcomes
[B01_CHILD_NOT_DELEGATED]:                                        #outcomes
[B01_INCONSISTENT_ALIAS]:                                         #outcomes
[B01_INCONSISTENT_DELEGATION]:                                    #outcomes
[B01_INCONSISTENT_DELEGATION]:                                    #outcomes
[B01_NO_CHILD]:                                                   #outcomes
[B01_PARENT_FOUND]:                                               #outcomes
[B01_PARENT_INDETERMINED]:                                        #outcomes
[B01_UNEXPECTED_NS_RESPONSE]:                                     #outcomes
[Basci03]:                                                        basic03.md
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:                                ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                      ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                   ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                          ../SeverityLevelDefinitions.md#error
[Get parent zone]:                                                ../MethodsV2.md#method-get-parent-zone
[INFO]:                                                           ../SeverityLevelDefinitions.md#info
[List of Root Servers]:                                           https://www.iana.org/domains/root/servers
[NOTICE]:                                                         ../SeverityLevelDefinitions.md#notice
[Requirements and normalization of domain names in input]:        ../RequirementsAndNormalizationOfDomainNames.md
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[Undelegated test]:                                               ../../test-types/undelegated-test.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md

