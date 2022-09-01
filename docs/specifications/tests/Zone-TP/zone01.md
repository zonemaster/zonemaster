## ZONE01: Fully qualified master nameserver in SOA

### Test case identifier
**ZONE01** Fully qualified master nameserver in SOA

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

The MNAME field from the SOA record of a zone is supposed to contain the master name server for that zone. The hostname of the MNAME field may not be listed among the delegated name servers, but should still be authoritative for the zone. MNAME may be used for other services such as DNS NOTIFY described in [RFC1996].

[RFC1035], section 3.3.13, specifies that "the *domain-name* of the name server that was the original or primary source of data for this zone".

[RFC1996], section 2, and [RFC2136], section 1, add that "the primary master is named in the zone's SOA MNAME field and optionally by an NS RR. There is by definition only one primary master server per zone".

Finally, [RFC2181], section 7.2, clarifies that "it is quite clear in the specifications, yet seems to have been widely ignored, that the MNAME field of the SOA record should contain the name of the primary (master) server for the zone identified by the SOA. It should not contain the name of the zone itself. That information would be useless, as to discover it, one needs to start with the domain name of the SOA record - that is the name of the zone".
 
This Test Case will check that:
 - the MNAME field contains the master name server.
 - this master name server is authoritative to the zone.
 - the SOA SERIAL of the MNAME is identical or higher than the ones found from the name servers in the delegation.
 - the master name server is listed as part of the delegation of the zone.

Note that the SOA SERIAL comparison must follow [RFC1982].

## Scope

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                   | Level   | Arguments            | Message ID for message tag
:---------------------------- |:--------|:---------------------|:---------------------------------------------------------------------------------------
Z01_MNAME_NOT_AUTHORITATIVE   | WARNING | ns                   | MNAME name server points to a non-authoritative name server ("{ns}").
Z01_MNAME_NO_RESPONSE         | NOTICE  | ns                   | MNAME name server points to a non-responsive name server ("{ns}").
Z01_MNAME_NOT_IN_ZONE         | INFO    | nsname               | MNAME name server {nsname} is not listed as NS record for the zone.
Z01_MNAME_NOT_MASTER          | WARNING | ns_ip_list           | MNAME name server does not have the highest SERIAL. Returned from name servers "{ns_ip_list}".
Z01_MNAME_IS_MASTER           | DEBUG   | ns_ip_list           | MNAME name server does appear to be master. Returned from name servers "{ns_ip_list}".

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

1. Create the following [DNS Queries][DNS Query]:
   1. Query type SOA and query name *Child Zone* ("SOA Query")
   2. Query type A and query name *Child Zone* ("A Query")
   3. Query type AAAA and query name *Child Zone* ("AAAA Query")

2. Create the following empty sets:
   1. Name server IP address, name, SERIAL ("MNAME Nameservers")
   2. Name server IP address, SERIAL ("SERIAL Nameservers")
   3. Name server IP address ("MNAME Not Master")
   4. Name server IP address ("MNAME Is Master")

3. Obtain the set of name server IP addresses using [Method4] and [Method5] ("Name Server IP").

4. For each name server IP in *Name Server IP* do:
   1. Send *SOA Query* to the name server and collect the response.
   2. Go to next name server IP if at least one of the following criteria is met:
      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.
      4. There is no SOA record with owner name matching the query.
   3. From the DNS response, add the name server name from the MNAME field to the *MNAME Nameservers* set.
   4. From the DNS response, add the SERIAL field and name server IP address to the *SERIAL Nameservers* set.
   5. Go to next name server.

5. If the set *MNAME Nameservers* is empty, then terminate these procedures.

6. Else, for each name server name in *MNAME Nameservers* do:
   1. Make a recursive DNS lookup by sending *A Query*, starting with one of the root servers for the name server name.
      1. If there is a DNS response, with [RCODE Name] "NoError", then add the name server IP address(es) from the A record to the *MNAME Nameservers* set.
      2. Else Make a recursive DNS lookup by sending *AAAA Query*, starting with one of the root servers for the name server name.
         1. If there is a DNS response, with [RCODE Name] "NoError", then add the name server IP address(es) from the AAAA record to the *MNAME Nameservers* set.
   2. If at least one IP address from the previous steps (6.1.1 or 6.1.2.1) was found, then:
      1. For each name server IP for the name server name in *MNAME Nameservers* do: 
         1. Send *SOA Query* to the name server IP in *MNAME Nameservers*.
            1. If there is a DNS response with [RCODE Name] "NoError", then:
               1. If the AA flag is not set, then output *[Z01_MNAME_NOT_AUTHORITATIVE]* with name server name and IP address.
               2. Else, add the SERIAL field to the *MNAME Nameservers* set.
            2. Else, output *[Z01_MNAME_NO_RESPONSE]* with name server name and IP.
         2. Go to next name server.
   3. Go to next name server.

7. If there is no SERIAL in the set *MNAME Nameservers*, then terminate these procedures.

8. For each SERIAL in *SERIAL Nameservers* do:
   1. For each SERIAL in *MNAME Nameservers* do:
      1. Compare both SERIAL values (using the arithmetic in [RFC1982]).
         1. If the one from *SERIAL Nameservers* is not higher, then add name server IP address to the *MNAME Is Master* set.
         2. Else, add name server IP address to the *MNAME Not Master* set.
      2. Go to next SERIAL.

9. If the set *MNAME Not Master* is non-empty, then output *[Z01_MNAME_NOT_MASTER]*
   with the name server IP addresses from the set.

10. If the set *MNAME Is Master* is non-empty, then:
   1. Output *[Z01_MNAME_IS_MASTER]* with the name server IP addresses from the set.
   2. Obtain the set of name server names using [Method3] ("Child Names").
      1. If the MNAME in the *MNAME Nameservers* set is not part of the *Child Names* set, then output *[Z01_MNAME_NOT_IN_ZONE]*.

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

The syntax of the SOA MNAME field is tested in [SYNTAX07].

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
[SYNTAX07]:                             ../Syntax-TP/syntax07.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
[Z01_MNAME_NO_RESPONSE]:                #summary
[Z01_MNAME_NOT_AUTHORITATIVE]:          #summary
[Z01_MNAME_NOT_IN_ZONE]:                #summary
[Z01_MNAME_NOT_MASTER]:                 #summary
[Z01_MNAME_IS_MASTER]:                  #summary