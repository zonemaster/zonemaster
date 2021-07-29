# DNSSEC11: Must be signed if DS in delegation


## Test case identifier
**DNSSEC11**


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

If the delegation of the zone contains DS records, i.e. if the parent
zone has DS records with the same owner name as the apex of the zone,
then the zone must be signed. If not, a DNSSEC aware resolver should
consider the zone to be "bogus" (see [RFC 4033][RFC 4033#section-5], section 5),
and the zone will be unavailable.

This test case will verify that a zone with DS in delegation from
parent is also signed. Here we just verify that it has DNSKEY in apex.

## Scope

It is assumed that *Child Zone* is tested and reported by other test cases:

* This test case will just ignore non-responsive name servers or name servers
  not giving a correct DNS response for an authoritative name server, covered
  by [Basic04].
* This test case will ignore any irregularities in fetching the DS record from
  parent zone, covered by [DNSSEC02].
* This test case will ignore if the DNSKEY and SOA RRsets are unsigned, covered
  by [DNSSEC08] and [DNSSEC09], respectively.

## Inputs

* "Child Zone" - The domain name to be tested.
* "Test Type" - The test type with value "[undelegated]" or "normal".
* "Undelegated DS" - The DS record or records submitted
  (only if *Test Type* is [undelegated]).


## Summary

* If there are no DS records in the parent zone, this test case will terminate
  without outputting any message.

Message Tag outputted         | Level   | Arguments  | Description of when message tag is outputted
:-----------------------------|:--------|:-----------|:--------------------------------------------
DS11_INCONSISTENT_DS          | WARNING |            | Parent name servers are inconsistent on the existence of DS.
DS11_INCONSISTENT_SIGNED_ZONE | ERROR   |            | Name servers for the child zone are inconsistent on whether the zone is signed or not.
DS11_UNDETERMINED_DS          | ERROR   |            | It cannot be determined if the parent zone has DS for the child zone or not.
DS11_UNDETERMINED_SIGNED_ZONE | ERROR   |            | It cannot be determined if the child zone is signed or not.
DS11_PARENT_WITHOUT_DS        | NOTICE  | ns_ip_list | List of parent name servers without DS for the child zone.
DS11_PARENT_WITH_DS           | NOTICE  | ns_ip_list | List of parent name servers with DS for the child zone.
DS11_NS_WITH_SIGNED_ZONE      | NOTICE  | ns_ip_list | List of child name servers with signed child zone.
DS11_NS_WITH_UNSIGNED_ZONE    | WARNING | ns_ip_list | List of child name servers with unsigned child zone.
DS11_DS_BUT_UNSIGNED_ZONE     | ERROR   |            | The child zone is unsigned, but the parent zone has DS record.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create the following empty sets:
    1. Parent name server IP address ("Undetermined DS").
    2. Parent name server IP address ("No DS Record").
    3. Parent name server IP address ("Has DS Record").
    4. Child name server IP address ("Undetermined DNSKEY")
    5. Child name server IP address ("No DNSKEY Record").
    6. Child name server IP address ("Has DNSKEY Record").

2.  If the *Test Type* is "[undelegated]" and if *Undelegated DS* is empty,
    then do exit this test case.

3.  If *Test Type* is "normal", then:

    1. Create a DS query with the DO flag set for the name of the *Child Zone*
       ("DS Query").

    2. Retrieve all name server IP addresses for the parent zone of
       *Child Zone* using [Method1] ("Parent NS IP").

    3. For each name server IP in *Parent NS IP* do:

       1. Send *DS Query* to the name server IP.
       2. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       3. If there is no DNS response, then add the name server (IP) to the
          *Undetermined DS* set.
       4. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
          then add the name server (IP) to the *Undetermined DS* set.
       5. Else, if the AA flag is not set in the response, then add the name
          server (IP) to the *Undetermined DS* set.
       6. Else, if there is no DS record with matching owner name in the
          answer section, then add the name server (IP) to the
          *No DS Record* set.
       7. Else add the name server (IP) to the *Has DS Record* set.

    4. If the *Undetermined DS* set is non-empty and both the
       *No DS Record* and *Has DS Record* sets are empty then do:
       1. Output *[DS11_UNDETERMINED_DS]*.
       2. Exit this test case.

    5. If the *No DS Record* set is non-empty and the *Has DS Record* set is
       empty then exit this test case.

    6. If both the *No DS Record* and *Has DS Record* sets are non-empty,
       then do:
       1. Output *[DS11_INCONSISTENT_DS]*.
       2. Output *[DS11_PARENT_WITHOUT_DS]* and list parent name servers in
          *No DS Record*.
       3. Output *[DS11_PARENT_WITH_DS]* and list parent name servers in
          *Has DS Record*.

4.  Create DNS queries for the child zone:

    1.  SOA query for the *Child Zone* without any OPT record (no EDNS)
        ("SOA Query").
    2.  DNSKEY query for the *Child Zone* with the DO flag set ("DNSKEY Query").

5.  Obtain the set of child name server IP addresses using [Method4] and
    [Method5] ("Child NS IP").

7.  For each name server IP in *Child NS IP* do:

    1. Send *SOA Query* over UDP to the name server IP and collect the response.
    2. Go to next name server if
       1. there is no DNS response on the SOA query, or
       2. the RCODE of the response is not "NoError" ([IANA RCODE List]), or
       3. the AA flag is not set in the response, or
       4. there is no SOA record with owner name matching the query in the 
          answer section.

    3. Send *DNSKEY Query* over UDP to the name server IP and collect the
       response.
    4. If the response has the TC flag set, re-query over TCP and use that
       response instead.
    5. If there is no DNS response, then add the name server (IP) to the
       *Undetermined DNSKEY* set.
    6. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
       then add the name server (IP) to the *Undetermined DNSKEY* set.
    7. Else, if the AA flag is not set in the response, then add the name server
       IP to the *Undetermined DNSKEY* set.
    8. Else, if there is no DNSKEY record with matching owner name in the answer
       section, then add the name server (IP) to the *No DNSKEY Record* set.
    9. Else add the name server (IP) to the *Has DNSKEY Record* set.

8.  If the *Undetermined DNSKEY* set is non-empty and both the
    *No DNSKEY Record* and *Has DNSKEY Record* sets are empty then output
    *[DS11_UNDETERMINED_SIGNED_ZONE]*.

9.  Else, if the *No DNSKEY Record* set is non-empty and the
    *Has DNSKEY Record* set is empty then output
    *[DS11_DS_BUT_UNSIGNED_ZONE]*.

10. Else, if both the *No DNSKEY Record* and *Has DNSKEY Record* sets
    are non-empty, then do:
    1. Output *[DS11_INCONSISTENT_SIGNED_ZONE]*.
    2. Output *[DS11_NS_WITH_UNSIGNED_ZONE]* and list name servers in
       *No DNSKEY Record*.
    3. Output *[DS11_NS_WITH_SIGNED_ZONE]* and list name servers in
       *Has DNSKEY Record*.



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
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

This test case is always performed.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                              https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                                    ../Basic-TP/basic014.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNSSEC README]:                              README.md
[DNSSEC02]:                                   dnssec02.md
[DNSSEC08]:                                   dnssec08.md
[DNSSEC09]:                                   dnssec09.md
[DS11_DS_BUT_UNSIGNED_ZONE]:                  #Summary
[DS11_INCONSISTENT_DS]:                       #Summary
[DS11_INCONSISTENT_SIGNED_ZONE]:              #Summary
[DS11_UNDETERMINED_DS]:                       #Summary
[DS11_UNDETERMINED_SIGNED_ZONE]:              #Summary
[DS11_NS_WITH_SIGNED_ZONE]:                   #Summary
[DS11_NS_WITH_UNSIGNED_ZONE]:                 #Summary
[DS11_PARENT_WITHOUT_DS]:                     #Summary
[DS11_PARENT_WITH_DS]:                        #Summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method1]:                                    ../Methods.md#method-1-obtain-the-parent-domain
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 4033#section-5]:                         https://tools.ietf.org/html/rfc4033#section-5
[RFC 8499#section-11]:                        https://tools.ietf.org/html/rfc8499#section-11
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[Severity Level]:                             ../SeverityLevelDefinitions.md
[Terminology]:                                #terminology
[Undelegated]:                                ../../test-types/undelegated-test.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md


