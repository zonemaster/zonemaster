# BASIC02: The domain must have at least one working name server

## Test case identifier
**BASIC02**

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

In order for the domain to work, it must have at least one name server that can
answer queries about the domain. This test case will verify that.


## Scope

If this test fails, it is not meaningful to continue Zonemaster testing and the
whole testing process, except for the [Basic03] test, is aborted.


## Inputs

* The domain name to be tested ("Child Zone").
* "Test Type" - The test type with values "[undelegated test]" or
  "normal test".
* If undelegated test:
  * The list of name servers for *the child zone* ("Undelegated NS").
  * Any IP addresses of the [in-bailiwick] *undelegated NS*
    ("Undelegated Glue IP").
  * Any IP addresses of the [out-of-bailiwick]  *undelegated NS*
   ("Undelegated Non-Glue IP").


## Summary

Message Tag          | Level    | Arguments     | Message ID for message tag
:--------------------|:---------|:--------------|:--------------------------
B02_AUTH_RESPONSE_SOA| INFO     |ns_list, domain| Authoritative answer on SOA query for "{domain}" is returned by name servers "{ns_list}".
B02_NO_DELEGATION    | CRITICAL | domain        | There is no delegation (name servers) for "{domain}" which means it does not exist as a zone.
B02_NO_WORKING_NS    | CRITICAL | domain        | There is no working name server for "{domain}" so it is unreachable.
B02_NS_BROKEN        | ERROR    | ns            | Broken response from name server "{ns}" on an SOA query.
B02_NS_NOT_AUTH      | ERROR    | ns            | Name server "{ns}" does not give an authoritative answer on an SOA query.
B02_NS_NO_IP_ADDR    | ERROR    | nsname        | Name server "{nsname}" cannot be resolved into an IP address.
B02_NS_NO_RESPONSE   | WARNING  | ns            | No response received from name server "{ns}" to SOA query.
B02_UNEXPECTED_RCODE | ERROR    | ns, rcode     | Name server "{ns}" responds with an unexpected RCODE name ("{rcode}") on an SOA query.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

In this section and unless otherwise specified below, the terms "[DNS Query]"
follow the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNS Response] in the same specification.


1. Create a [DNS Query] with query type SOA and query name *Child Zone*
   ("SOA Query").

2. Create the following empty sets:
   1. Name server name and IP address ("Auth Response on SOA Query").
   2. Name server name and IP address ("Broken NS").
   3. Name server name and IP address ("NS not auth").
   4. Name server name ("NS Cannot Resolve Into IP").
   5. Name server name and IP address ("No Response From NS").
   6. Name server name, IP address and [RCODE Name] ("Unexpected RCODE").
   7. Name server name with IP address set ("Delegation NS").

3. Populate the set *Delegation NS* with name and the set of IP addresses for
   each name from the name servers of the delegation of *Child Zone*.
   1. If the test is an undelegated test, then:
      1. Use *Undelegated NS*, *Undelegated Glue IP* and
      *Undelegated Non-Glue IP*.
      2. If any [out-of-bailiwick] name server name in the set has no IP address
         then do a recursive lookup for address records (both IPv4 and IPv6) for
         that name and add resolved addresses, if any, to the set.
   2. Else, do:
      1. Retrieve the NS records for *Child Zone* using [Method 2] and the IP
         addresses ([glue records][glue record]) for any [in-bailiwick] name
         servers using [Method 4].
      2. Retrieve the IP addresses for any [out-of-bailiwick] name servers
         using recursive lookup for address records (both IPv4 and IPv6) for
         that name and add resolved addresses, if any, to the set.

4. If the *Delegation NS* set is empty, then do:
   1. Output *[B02_NO_DELEGATION]* with *Child Zone* name.
   2. Exit these test procedures.

5. Else, for each name server name in the *Delegation NS* set do:
   1. If the name server name has no IP address then add the name server name to
      the *NS Cannot Resolve Into IP* set.
   2. Else, for each IP address for the name server name do:
      1. Send *SOA Query* to the name server IP.
      2. If there is no [DNS Response], then add the name server name and IP
         address to the *No Response From NS* set.
      3. Else, if the [RCODE Name] is not "NoError" in the [DNS Response], then
         add the name server name, IP address and the [RCODE Name] to the
         *Unexpected RCODE* set.
      4. Else, if the AA flag is not set in the [DNS Response], then add the name
         server name and IP address to the *NS not auth* set.
      5. Else do:
         1. If the answer section in the [DNS Response] contains an SOA record
            with *Child Zone* as owner name, then add the name server name and IP
            address to the *Auth Response on SOA Query* set.
         2. Else, add the name server name and IP address to the *Broken NS* set.

6. If the *Auth Response on SOA Query* set is non-empty, then:
   1. Output *[B02_AUTH_RESPONSE_SOA]* with a list of name server name and IP
      address pairs derived from the set and with *Child Zone* name.
   2. Exit these test procedures.

7. Else do:
   1. Output *[B02_NO_WORKING_NS]* with *Child Zone* name.
   2. If the *Broken NS* set is non-empty then for each name server name and IP
      address pair from the set output *[B02_NS_BROKEN]* with the pair.
   3. If the *NS not auth* set is non-empty then for each name server name and IP
      address pair from the set output *[B02_NS_NOT_AUTH]* with the pair.
   4. If the *NS Cannot Resolve Into IP* set is non-empty then for each name
      server name output *[B02_NS_NO_IP_ADDR]* with the name server name.
   5. If the *No Response From NS* set is non-empty then for each name server name
      and IP address pair from the set output *[B02_NS_NO_RESPONSE]* with the
      pair.
   6. If the *Unexpected RCODE* set is non-empty then for each name server name
      and IP address pair from the set output *[B02_UNEXPECTED_RCODE]* with the
      pair and the [RCODE Name] for that pair in the set.


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

The *Child Zone* must be a valid name meeting
"[Requirements and normalization of domain names in input]".


## Terminology

The terms "in-bailiwick", "out-of-bailiwick" and "glue record" are defined in
[RFC 8499], section 7, pages 24-25. In this document, the term "in-bailiwick"
is limited to the meaning "in domain" in [RFC 8499]. The term "out-of-bailiwick"
means what is not "in-bailiwick, in domain", in this document.

## Intercase dependencies

None.


[Argument list]:                                                  ../ArgumentsForTestCaseMessages.md
[B02_AUTH_RESPONSE_SOA]:                                          #outcomes
[B02_NO_DELEGATION]:                                              #outcomes
[B02_NO_WORKING_NS]:                                              #outcomes
[B02_NS_BROKEN]:                                                  #outcomes
[B02_NS_NOT_AUTH]:                                                #outcomes
[B02_NS_NO_IP_ADDR]:                                              #outcomes
[B02_NS_NO_RESPONSE]:                                             #outcomes
[B02_UNEXPECTED_RCODE]:                                           #outcomes
[Basic03]:                                                        basic03.md
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:                                ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                      ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                   ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                          ../SeverityLevelDefinitions.md#error
[Glue record]:                                                    #terminology
[INFO]:                                                           ../SeverityLevelDefinitions.md#info
[In-bailiwick]:                                                   #terminology
[Method 2]:                                                       ../Methods.md#method-2-obtain-glue-name-records-from-parent
[Method 4]:                                                       ../Methods.md#method-4-obtain-glue-address-records-from-parent
[NOTICE]:                                                         ../SeverityLevelDefinitions.md#notice
[Out-of-bailiwick]:                                               #terminology
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 8499]:                                                       https://datatracker.ietf.org/doc/html/rfc8499#section-7
[Requirements and normalization of domain names in input]:        ../RequirementsAndNormalizationOfDomainNames.md
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[Undelegated test]:                                               ../../test-types/undelegated-test.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      ../../../configuration/profiles.md
