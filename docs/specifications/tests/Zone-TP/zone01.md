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

[RFC2181], section 7.2, clarifies that "it is quite clear in the specifications, yet seems to have been widely ignored, that the MNAME field of the SOA record should contain the name of the primary (master) server for the zone identified by the SOA. It should not contain the name of the zone itself. That information would be useless, as to discover it, one needs to start with the domain name of the SOA record - that is the name of the zone".

There exists an unstandardized practice to set the SOA MNAME to "." to mean no server at all, indicating that there is no default server for dynamic updates. There is at least one old and expired Internet-Draft that attempted to standardize that behavior, i.e. [draft-jabley-dnsop-missing-mname]. If the SOA MNAME is an empty name (".") this Test Case will not try to connect to a server
behind it since there will never be a server behind that name, as the purpose is most definitely to follow that practice. Instead, a special message will be outputted.
 
This Test Case will check that:
 - the SOA MNAME contains the master name server.
 - this master name server is authoritative to the zone.
 - the SOA SERIAL of the MNAME is identical or higher than the ones found from the name servers in the delegation.
 - the master name server is listed as part of the delegation of the zone.

Note that the SOA SERIAL comparison must follow [RFC1982].

## Scope

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
Test Case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server, except if the name server is listed in the SOA MNAME.

The syntax of the SOA MNAME for *Child Zone* is not tested in this Test
Case, see [SYNTAX07].

The consistency of the SOA MNAME between different servers of *Child Zone*
is not tested by this Test Case, see [CONSISTENCY06].

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                   | Level   | Arguments            | Message ID for message tag
:---------------------------- |:--------|:---------------------|:---------------------------------------------------------------------------------------
Z01_MNAME_NO_RESPONSE         | WARNING | ns                   | SOA MNAME name server "{ns}" does not respond to an SOA query.
Z01_MNAME_NOT_AUTHORITATIVE   | WARNING | ns                   | SOA MNAME name server "{ns}" is not authoritative for the zone.
Z01_MNAME_NOT_IN_NS_LIST      | INFO    | nsname               | SOA MNAME name server "{nsname}" is not listed as NS record for the zone.
Z01_MNAME_NOT_MASTER          | WARNING | ns, ns_ip_list       | SOA MNAME name server "{ns}" does not have the highest SERIAL. Fetched from name servers "{ns_ip_list}".
Z01_MNAME_NOT_RESOLVE         | WARNING | nsname               | SOA MNAME name server "{nsname}" cannot be resolved into an IP address.
Z01_MNAME_IS_DOT              | NOTICE  | ns_ip_list           | SOA MNAME is specified as "." which usually means "no server". Fetched from name servers "{ns_ip_list}".
Z01_MNAME_IS_LOCALHOST        | WARNING | ns_ip_list           | SOA MNAME name server is "localhost", which is invalid. Fetched from name servers "{ns_ip_list}".
Z01_MNAME_IS_MASTER           | DEBUG   | ns, ns_ip_list       | SOA MNAME name server "{ns}" does appear to be master. Fetched from name servers "{ns_ip_list}".
Z01_MNAME_UNEXPECTED_RCODE    | WARNING | ns, rcode            | SOA MNAME name server "{ns}" gives unexpected RCODE name ("{rcode}") in response to an SOA query.

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

1. Create a [DNS Query] with query type SOA and query name *Child Zone* ("SOA Query").

2. Create the following empty sets:
   1. Name server IP address, name, SERIAL ("MNAME Nameservers")
   2. Name server IP address, SERIAL ("SERIAL Nameservers")
   3. Name server IP address ("MNAME Not Master")
   4. Name server IP address ("MNAME Is Master")
   5. Name server IP address ("MNAME Is Localhost")
   6. Name server IP address ("MNAME Is Dot")

3. Obtain the set of name server IP addresses using [Method4] and [Method5] ("Name Server IP").

4. For each name server IP address in *Name Server IP* do:
   1. Send *SOA Query* to the name server and collect the response.
   2. Go to next name server IP address if at least one of the following criteria is met:
      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.
      4. There is no SOA record with owner name matching the query.
   3. From the DNS response, extract the name server name from the MNAME field:
      1. If the name is "localhost", then add name server IP address to the *MNAME Is Localhost* set and go to next name server.
      2. Else if the name is ".", then add name server IP address to the *MNAME Is Dot* set and go to next name server.
      3. Else, add name server name to the *MNAME Nameservers* set.
   4. From the DNS response, add the SERIAL field and name server IP address to the *SERIAL Nameservers* set.
   5. Go to next name server.

5. If the set *MNAME Is Localhost* is non-empty, then output *[Z01_MNAME_IS_LOCALHOST]* with name servers IP address(es).

6. If the set *MNAME Is Dot* is non-empty, then output *[Z01_MNAME_IS_DOT]* with name servers IP address(es).

7. If the set *MNAME Nameservers* is empty, then terminate these procedures.

8. Else, for each name server name in *MNAME Nameservers* do:
   1. Do a [DNS Lookup] of name server name (A and AAAA) and add the name server IP address(es) found to the *MNAME Nameservers* set.
   2. If at least one IP address from the previous step was found, then:
      1. For each name server IP for the name server name do: 
         1. Send *SOA Query* to the name server and collect the response.
            1. If there is a DNS response with [RCODE Name] "NoError", then:
               1. If the AA flag is not set, then output *[Z01_MNAME_NOT_AUTHORITATIVE]* with name server name and IP address.
               2. Else, add the SERIAL field to the *MNAME Nameservers* set.
            2. Else if there is a DNS response with [RCODE Name] other than "NoError", then output *[Z01_MNAME_UNEXPECTED_RCODE]* with [RCODE Name], name server name and IP address.
            3. Else, output *[Z01_MNAME_NO_RESPONSE]* with name server name and IP address.
         2. Go to next name server IP.
   3. Else, output *[Z01_MNAME_NOT_RESOLVE]* with name server name.
   4. Go to next name server name.

9. If there is no SERIAL in the set *MNAME Nameservers*, then terminate these procedures.

10. For each SERIAL in *SERIAL Nameservers* do:
   1. For each SERIAL in *MNAME Nameservers* do:
      1. Compare both SERIAL values (using the arithmetic in [RFC1982]).
         1. If the one from *SERIAL Nameservers* is not higher, then add name server IP address to the *MNAME Is Master* set.
         2. Else, add name server IP address to the *MNAME Not Master* set.
      2. Go to next SERIAL.

11. If the set *MNAME Not Master* is non-empty, then output *[Z01_MNAME_NOT_MASTER]*
   with the name server IP addresses from the set.

12. If the set *MNAME Is Master* is non-empty, then:
   1. Output *[Z01_MNAME_IS_MASTER]* with the name server IP addresses from the set.
   2. Obtain the set of name server names using [Method3] ("Child Names").
      1. If the SOA MNAME in the *MNAME Nameservers* set is not part of the *Child Names* set, then output *[Z01_MNAME_NOT_IN_NS_LIST]* with name server name.

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

There are no intercase dependencies for this Test Case.

## Terminology

* "DNS Lookup" - The term is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                              ../Basic-TP/basic04.md
[CONSISTENCY06]:                        ../Consistency-TP/consistency06.md
[CRITICAL]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#critical
[DNS Lookup]:                           #terminology
[DNS Query and Response Defaults]:      ../DNSQueryAndResponseDefaults.md
[DNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[draft-jabley-dnsop-missing-mname]:     https://www.ietf.org/archive/id/draft-jabley-dnsop-missing-mname-00.html
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
[Undelegated test]:                     ../../test-types/undelegated-test.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
[Z01_MNAME_NO_RESPONSE]:                #summary
[Z01_MNAME_NOT_AUTHORITATIVE]:          #summary
[Z01_MNAME_NOT_IN_NS_LIST]:             #summary
[Z01_MNAME_NOT_MASTER]:                 #summary
[Z01_MNAME_NOT_RESOLVE]:                #summary
[Z01_MNAME_IS_DOT]:                     #summary
[Z01_MNAME_IS_LOCALHOST]:               #summary
[Z01_MNAME_IS_MASTER]:                  #summary
[Z01_MNAME_UNEXPECTED_RCODE]:           #summary