# NAMESERVER15: Checking for revealed software version

## Test case identifier
**NAMESERVER15**

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

This Test Case verifies if a name server responds to TXT queries in the CHAOS
[DNS Class], specifically about its software version as it may sometimes be
desirable not to reveal that information. The CHAOS class identifier is usually
abbreviated as "CH".

A list of DNS classes and references for those are found in the
[IANA DNS Class database][DNS Class].


## Scope

It is assumed that *Child Zone* is also tested and reported by [Connectivity01].
This Test Case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                | Level   | Arguments                   | Message ID for message tag
:--------------------------|:--------|:----------------------------|:----------------------------------------------------------------------------------------------------------------------------
N15_ERROR_ON_VERSION_QUERY | NOTICE  | ns_list, query_name         | The following name server(s) do not respond or respond with SERVFAIL to software version query "{query_name}". Returned from name servers: "{ns_list}"
N15_NO_VERSION_REVEALED    | INFO    | ns_list                     | The following name server(s) do not reveal the software version. Returned from name servers: "{ns_list}"
N15_SOFTWARE_VERSION       | NOTICE  | ns_list, query_name, string | The following name server(s) respond to software version query "{query_name}" with string "{string}". Returned from name servers: "{ns_list}"
N15_WRONG_CLASS            | WARNING | ns_list                     | The following name server(s) do not return CH class record(s) on CH class query. Returned from name servers: "{ns_list}"


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine Profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [Argument List].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns" or "ns_list" even when in the
"[Test procedure]" below it is only referred to the IP address of the name
servers.

## Test procedure

1.  Create the following empty sets:
    1. Name server IP, query name and string ("TXT Data")
    2. Name server IP and query name ("Error On Version Query")
    3. Name server IP ("Sending Version Query")
    4. Name server IP ("Wrong Record Class")

2.  Create a [DNS Query] with query type SOA and query name *Child Zone*
    ("SOA Query").

3.  Create a [DNS Query] with query type TXT and [query class][DNS Class] CH
    ("TXT Query").

4.  Create the set of query names with values "version.bind"
    and "version.server" ("Query Names").

5.  Obtain the set of name server IP addresses using [Method4] and
    [Method5] ("Name Server IP").

6.  For each name server in *Name Server IP* do:
    1. Send *SOA Query* to the name server IP.
    2. If there is no DNS response, then go to next name server IP.
    3. Add the name server IP to the *Sending Version Query* set.
    4. For each query name in *Query Names* do:
       1. [Send] *TXT Query* with query name to the name server and collect the
          response.
       2. If there is no DNS response or the response has the [RCODE Name]
          ServFail, add name server and query name to the
          *Error On Version Query* set and go to next query name.
       3. If the [DNS Response] does not have any TXT record in the answer
          section with query name as owner name, go to next query name.
       4. For each TXT record in the answer section of the [DNS Response] do:
          1. If [DNS Class] of the TXT record is not CH, then add name server
             to the *Wrong Record Class* set.
          2. Extract and [concatenate] the string(s) from the RDATA of the
             record.
          3. Remove any leading or trailing [SPACE] (U+0020) or
             [CHARACTER TABULATION] (horizontal tab, U+0009) characters from the
             concatenated string.
          4. If the extracted string is non-empty, add name server, query name
             and the string to the *TXT Data* set.

7.  If the *TXT Data* set is non-empty, then, for each unique string and query
    name pair in the set, output *[N15_SOFTWARE_VERSION]* with name server IP
    list, query name and string.

8.  If the *Error On Version Query* set is non-empty, then for each query name
    in the set output *[N15_ERROR_ON_VERSION_QUERY]* with the query name
    and the list of name server IP addresses.

9.  For each name server IP in the *Sending Version Query* set, remove that name
    server IP from the set if the name server IP is also a member of the
    *TXT Data* set.

10. If the *Sending Version Query* set is non-empty then output
    *[N15_NO_VERSION_REVEALED]* with the list of the name servers in the
    *Sending Version Query* set.

11. If the *Wrong Record Class* set is non-empty then output
    *[N15_WRONG_CLASS]* with the list of the name servers in the
    *Wrong Record Class* set.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*[ERROR]* or *[CRITICAL]*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

The *Child Zone* must be a valid name meeting
"[Requirements and normalization of domain names in input]".


## Intercase dependencies

None


## Terminology

* "Concatenate" - The term is used to refer to the conversion of a TXT
  resource record’s data to a single contiguous string, as specified in [RFC
  7208, section 3.3][RFC7208#3.3].

* "Send" - The term is used when a DNS query is sent to
  a specific name server (name server IP address).

[Argument List]:                                                ../ArgumentsForTestCaseMessages.md
[CRITICAL]:                                                     ../SeverityLevelDefinitions.md#critical
[CHARACTER TABULATION]:                                         https://codepoints.net/U+0009
[Concatenate]:                                                  #terminology
[Connectivity01]:                                               ../Connectivity-TP/connectivity01.md
[DEBUG]:                                                        ../SeverityLevelDefinitions.md#notice
[DNS Class]:                                                    https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-2
[DNS Query and Response Defaults]:                              ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                    ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                 ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                        ../SeverityLevelDefinitions.md#error
[INFO]:                                                         ../SeverityLevelDefinitions.md#info
[Message Tag Specification]:                                    ../../../../internal/templates/specifications/tests/MessageTagSpecification.md
[Method4]:                                                      ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                                      ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                                                      ../Methods.md
[N15_ERROR_ON_VERSION_QUERY]:                                   #summary
[N15_NO_VERSION_REVEALED]:                                      #summary
[N15_SOFTWARE_VERSION]:                                         #summary
[N15_WRONG_CLASS]:                                              #summary
[NOTICE]:                                                       ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                                                   https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC2929]:                                                      https://datatracker.ietf.org/doc/html/rfc2929#section-3.2
[RFC7208#3.3]:                                                  https://datatracker.ietf.org/doc/html/rfc7208#section-3.3
[Requirements and normalization of domain names in input]:      ../RequirementsAndNormalizationOfDomainNames.md
[SPACE]:                                                        https://codepoints.net/U+0020
[Send]:                                                         #terminology
[Severity Level Definitions]:                                   ../SeverityLevelDefinitions.md
[Test Case Identifier Specification]:                           ../../../../internal/templates/specifications/tests/TestCaseIdentifierSpecification.md
[Test procedure]:                                               #test-procedure
[WARNING]:                                                      ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine Profile]:                                    ../../../configuration/profiles.md
