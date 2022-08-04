# ZONE11: Verify SOA MNAME

## Test case identifier
**ZONE11**

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

The MNAME field from the SOA record of a zone is supposed to contain the master name server for that zone.

[RFC1035], section 3.3.13, specifies that "the *domain-name* of the name server that was the original or primary source of data for this zone".
[RFC1996], section 2, and [RFC2136], section 1, add that "the primary master is named in the zone's SOA MNAME field and optionally by an NS RR. There is by definition only one primary master server per zone".
Finally, [RFC2181], section 7.2, clarifies that "it is quite clear in the specifications, yet seems to have been widely ignored, that the MNAME field of the SOA record should contain the name of the primary (master) server for the zone identified by the SOA. It should not contain the name of the zone itself. That information would be useless, as to discover it, one needs to start with the domain name of the SOA record - that is the name of the zone".
 
This Test Case will check that:
    - the MNAME field contains the master name server.
    - this master name server is authoritative to the zone.
    - the SOA SERIAL of the MNAME is identical or higher than the ones found from the name servers in the delegation.
    - the master name server is listed as part of the delegation of the zone.

The SOA SERIAL comparison must be done following [RFC1982].

## Scope

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                   | Level   | Arguments            | Message ID for message tag
:---------------------------- |:--------|:---------------------|:---------------------------------------------------------------------------------------
Z11_MULTIPLE_MNAME            | WARNING | ns_ip_list           | Distinct MNAMEs found, but only one is expected. Returned from name servers "{ns_ip_list}".
Z11_MNAME_NOT_AUTHORITATIVE   | WARNING | ns                   | MNAME name server points to a non authoritative name server ("{ns}").
Z11_MNAME_NO_RESPONSE         | NOTICE  | ns                   | MNAME name server points to a non responsive name server ("{ns}").
Z11_MNAME_NOT_IN_DELEGATION   | INFO    | nsname               | MNAME name server {nsname} is not listed as NS record for the zone.
Z11_MNAME_NOT_MASTER          | WARNING | ns_ip_list           | MNAME name server doesn't have the highest SERIAL. Returned from name servers "{ns_ip_list}".
Z11_MNAME_IS_MASTER           | DEBUG   | ns_ip_list           | MNAME name server does appear to be master. Returned from name servers "{ns_ip_list}".

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

## Test procedure

In this section and unless otherwise specified below, the terms "[DNS Query]"
follow the specification for DNS queries as specified in [DNS Query and Response Defaults].
The handling of the DNS responses on the DNS queries follow, unless otherwise specified below,
what is specified for [DNS Response] in the same specification.

1. Create a [DNS Query] with query type SOA and query name *Child Zone* ("SOA Query")

2. Obtain the set of name server IP addresses using [Method4] and [Method5] ("Name Server IP").

3. Create the following empty sets:
   1. Name server IP address, MNAME, SERIAL ("MNAME Nameserver")
   1. Name server IP address, SERIAL ("SERIAL Nameservers")
   4. Name server IP address ("MNAME Not Master")
   5. Name server IP address ("MNAME Is Master")

4. For each name server IP in *Name Server IP* do:
   1. Send *SOA Query* to the name server and collect the response.
   2. Go to next name server IP if at least one of the following criteria is met:
      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.
      4. There is no SOA record with owner name matching the query.
   3. From the DNS response, add the MNAME field to the *MNAME Nameserver* set.
   4. From the DNS response, add the SERIAL field and name server IP address to the *SERIAL Nameservers* set.
   5. Go to next name server.

5. If the set *MNAME Nameserver* contains more than one element, then output *[Z11_MULTIPLE_MNAME]*
   with the name server IP addresses from the set, and terminate.

6. Send *SOA Query* to the name server in *MNAME Nameserver*.
   1. If there is an SOA response, with [RCODE Name] "NoError", then:
      1. If the AA flag is not set, then output *[Z11_MNAME_NOT_AUTHORITATIVE]* with name server name and IP address.
      2. Else, add the SERIAL field to the *MNAME Nameserver* set.
   2. Else, output *[Z11_MNAME_NO_RESPONSE]* with name server name and IP.

7. For each SERIAL value in the *SERIAL Nameservers* do:
   1. Compare the value with the one in the *MNAME Nameserver* set.
      1. If it is not higher, then add name server IP address to the *MNAME Is Master* set.
      2. Else, add name server IP address to the *MNAME Not Master* set.

8. If the set *MNAME Not Master* is non-empty, then output *Z11_MNAME_NOT_MASTER*
   with the name server IP addresses from the set.

9. If the set *MNAME Is Master* is non-empty, then:
   1. Output *Z11_MNAME_IS_MASTER* with the name server IP addresses from the set.
   2. Obtain the set of name server IP addresses using [Method3] ("Delegation IP").
      1. If the MNAME in the *MNAME Nameserver* set is not part of the *Delegation IP* set for the zone, then output *[Z11_MNAME_NOT_IN_DELEGATION]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, skip sending queries over that
transport protocol. A message will be outputted reporting that the transport
protocol has been skipped.

## Intercase dependencies

None

## Terminology

No special terminology for this test case.

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                              ../Basic-TP/basic04.md
[CRITICAL]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:      ../DNSQueryAndResponseDefaults.md
[DNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#error
[INFO]:                                 https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#info
[Message Tag Specification]:            MessageTagSpecification.md
[Methods]:                              ../Methods.md
[Method3]:                              ../Methods.md#method-3-obtain-name-servers-from-child
[Method4]:                              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                               https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#notice
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC1035]:                              https://datatracker.ietf.org/doc/html/rfc1035#section-3.3.13
[RFC1982]:                              https://datatracker.ietf.org/doc/html/rfc1982
[RFC1996]:                              https://datatracker.ietf.org/doc/html/rfc1996#section-2
[RFC2136]:                              https://datatracker.ietf.org/doc/html/rfc2136#section-1
[RFC2181]:                              https://datatracker.ietf.org/doc/html/rfc2181#section-7.3
[Severity Level Definitions]:           https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
[Z11_MNAME_NO_RESPONSE]:                #summary
[Z11_MNAME_NOT_AUTHORITATIVE]:          #summary
[Z11_MNAME_NOT_IN_GLUE]:                #summary
[Z11_MNAME_NOT_MASTER]:                 #summary
[Z11_MNAME_IS_MASTER]:                  #summary
[Z11_MNAME_IS_ZONE_NAME]:               #summary
[Z11_NO_MNAME]:                         #summary
[Z11_NO_SERIAL]:                        #summary