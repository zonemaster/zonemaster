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

The SOA MNAME record must be a fully qualified master nameserver.
 
The purpose of this test is to test:
    - that the server is authoritative to the zone.
    - that the MNAME is not the zone name.
    - that the SOA serial is identical to the zone name servers.

## Scope

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                   | Level   | Arguments            | Message ID for message tag
:---------------------------- |:--------|:---------------------|:---------------------------------------------------------------------------------------
Z11_NO_MNAME_RECORD           | WARNING | ns_ip_list           | No MNAME records found from name servers "{ns_ip_list}".
Z11_NO_SERIAL_RECORD          | WARNING | ns_ip_list           | No SERIAL records found from name servers "{ns_ip_list}".
Z11_MNAME_IS_ZONE_NAME        | WARNING | ns_ip_list           | MNAME name server points to the zone tested. Returned from name servers "{ns_ip_list}".
Z11_MNAME_NOT_AUTHORITATIVE   | WARNING | ns                   | MNAME name server points to a non authoritative name server ("{ns}").
Z11_MNAME_NO_RESPONSE         | NOTICE  | ns                   | MNAME name server points to a non responsive name server ("{ns}").
Z11_MNAME_NOT_IN_GLUE         | NOTICE  |                      | MNAME name server could not be found in the parent zone name servers.
Z11_MNAME_NOT_MASTER          | WARNING | ns_ip_list           | MNAME name server has a mis-matching SERIAL. Returned from name servers "{ns_ip_list}".
Z11_MNAME_IS_MASTER           | INFO    | ns_ip_list           | MNAME name server is master. Returned from name servers "{ns_ip_list}".

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

2. Obtain the set of name server IP addresses using [Method5]
   ("Name Server IP").

3. Create the following empty sets:
   1. Name server IP address ("No MNAME Record")
   2. Name server IP address ("No Serial Record")
   3. Name server IP address ("MNAME Is Zone Name")
   4. Name server IP address ("MNAME Not Master")
   5. Name server IP address ("MNAME Is Master")

4. For each name server IP in *Name Server IP* do:
   1. Send *SOA Query* to the name server and collect the response.
   2. Go to next name server IP if at least one of the following criteria is met:
      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.
      4. There is no SOA record with owner name matching the query.
   3. From the DNS response, store the MNAME and its associated SERIAL.
      1. Go to next name server IP if at least one of the following criteria is met:
         1. If there is no MNAME record, then add name server IP to the *No MNAME Record* set. 
         2. If there is no SERIAL record, then add name server IP to the *No SERIAL Record* set. 
         3. If the name in the MNAME record is the same as *Child Zone*, then add name server IP to the *MNAME Is Zone Name* set.
   4. Send *SOA Query* to the name server in the MNAME ("MNAME Nameserver").
      1. If the SOA response has [RCODE Name] "NoError" then:
         1. If the AA flag is not set, then output *Z11_MNAME_NOT_AUTHORITATIVE* with name server name and IP.
      2. Else, output *Z11_MNAME_NO_RESPONSE* with name server name and IP and go to next name server IP.
   5. Obtain the set of name server IP addresses using [Method5] ("NS IP").
   6. For each name server in *NS IP*, send *SOA Query* to the name server and collect the response.
      1. If there is a response, compare the SERIAL of that name server to the one from *MNAME Nameserver*.
         1. If they match, then add name server IP to the *MNAME Is Master* set.
         2. Else, then add name server IP to the *MNAME Not Master* set.
   7. Obtain the set of name server IP names using [Method2] ("Glue Names").
      1. If *MNAME Nameserver* is not part of the *Glue Names* set for the zone, then output *Z11_MNAME_NOT_IN_GLUE*.

5. If the set *No MNAME Record* is non-empty, then output *Z11_NO_MNAME_RECORD*
   with the name server IP addresses from the set.

6. If the set *No Serial Record* is non-empty, then output *Z11_NO_SERIAL_RECORD*
   with the name server IP addresses from the set.

7. If the set *MNAME Is Zone Name* is non-empty, then output *Z11_MNAME_IS_ZONE_NAME*
   with the name server IP addresses from the set.

8. If the set *MNAME Not Master* is non-empty, then output *Z11_MNAME_NOT_MASTER*
   with the name server IP addresses from the set.

9. If the set *MNAME Is Master* is non-empty, then output *Z11_MNAME_IS_MASTER*
   with the name server IP addresses from the set.

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
[Method2]:                              ../Methods.md#method-2-obtain-glue-name-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                               https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#notice
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
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
[Z11_NO_MNAME_RECORD]:                  #summary
[Z11_NO_SERIAL_RECORD]:                 #summary