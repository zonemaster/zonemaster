# ZONE13: DMARC policy validation

## Test case identifier
**Zone13**

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

Domain-based Message Authentication, Reporting, and Conformance (DMARC), is a
"mechanism by which a mail-originating organization can express domain-level
policies and preferences for message validation, disposition, and reporting"
([RFC 7489][RFC7489]).

This test checks whether the domain publishes a DMARC policy and, if one exists,
checks if it is valid.

## Scope

It is assumed that *Child Zone* has been tested and reported by
[Connectivity01]. This test case will just ignore non-responsive name servers or
name servers not giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

A DMARC policy may appear either in the zone to be tested or what [RFC 7489,
section 3.2][rfc7489#3.2] calls the "[organizational domain]" of the same
zone. This test case only searches for a DMARC policy in the zone to be
tested.

Message Tag                        | Level   | Arguments                         | Message ID for message tag
:----------------------------------|:--------|:----------------------------------|:--------------------------------------------
Z13_DMARC1_MULTIPLE_RECORDS        | ERROR   | ns_ip_list                        | The *Child Zone* publishes more than one DMARC version 1 policy. Policies retrieved from the following nameservers: {ns_ip_list}.
Z13_DMARC1_SYNTAX_ERROR            | ERROR   | ns_ip_list                        | The *Child Zone*’s DMARC version 1 policy has a syntax error. Policy retrieved from the following nameservers: {ns_ip_list}.
Z13_DMARC_IN_SUBDOMAIN             | NOTICE  | domain_org                        | No DMARC policy found in the *Child Zone*. DMARC validators will use one in {domain_org} if it exists.
Z13_DMARC_REPORTS_TO_THIRD_PARTY   | NOTICE  | domain, ns_ip_list                | The *Child Zone*’s DMARC policy specifies that reports be sent to an e-mail address in {domain}, which is a different organizational domain. Policy retrieved from the following nameservers: {ns_ip_list}.
Z13_INCONSISTENT_DMARC_POLICIES    | WARNING |                                   | The *Child Zone* publishes different DMARC policies on different name servers.
Z13_NO_DMARC_FOUND                 | DEBUG   |                                   | The *Child Zone* does not publish a DMARC policy.
Z13_NO_ZONE_ORG_DOMAIN             | DEBUG   |                                   | No organizational domain can be determined for *Child Zone*; skipping test.
Z13_UNABLE_TO_CHECK_FOR_DMARC      | ERROR   |                                   | Unable to check whether *Child Zone* publishes a DMARC policy.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

## Test procedure

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

1. Attempt to compute the [organizational domain] of the *Child Zone*
   ("Zone-Org-Domain").

2. If *Zone-Org-Domain* cannot be computed for *Child Zone*, then output
   *[Z13_NO_ZONE_ORG_DOMAIN]* and terminate the test.

3. Create a [DNS Query] with query type TXT and query name the `_dmarc`
   subdomain in the *Child Zone* ("DMARC query").

4. Create an empty set of pairs of IP addresses and strings, "DMARC-Policies".

5. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

6. For each name server in *Name Server IP* do:

   1. Send *DMARC Query* to the name server and collect the [DNS Response].

   2. Go to the next name server IP address if at least one of the following
      criteria is met:

      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.

   3. If the name server responds with no TXT record, then add the pair
      consisting of the *Name Server IP* and the empty string to the
      *DMARC-Policies* set.

   4. If the name server responds with at least one TXT record, then, for each
      TXT record:

      1. If the record is a [DMARC TXT record], then add the pair consisting of
         the *Name Server IP* and the [concatenation][concatenate] of all
         strings in the TXT record’s data to the *DMARC-Policies* set.

   5. Go to the next name server.

7. If the *DMARC-Policies* set is empty, then output
   *[Z13_UNABLE_TO_CHECK_FOR_DMARC]* and terminate the test.

8. If all the pairs in the *DMARC-Policies* set contain empty strings, then:

   1. If *Child Zone* is equal to *Zone-Org-Domain*, then output
      *[Z13_NO_DMARC_FOUND]*.

   2. If *Child Zone* is not equal to *Zone-Org-Domain*, then output
      *[Z13_DMARC_IN_SUBDOMAIN]*.

   3. Terminate the test.

9. If the *DMARC-Policies* set contains at least two pairs with the same IP
   address, then output *[Z13_DMARC1_MULTIPLE_RECORDS]* with the list of
   nameservers that returned more than one SPF policy and terminate the test.

10. The following steps assume that all pairs in the *DMARC-Policies* set have
    the same string ("DMARC policy").

11. If the *DMARC policy* does not [pass the syntax check][passing the syntax
    check] for DMARC version 1 records, then output
    *[Z13_DMARC1_SYNTAX_ERROR]* and terminate the test.

12. For each `rua` or `ruf` tag in the *DMARC policy*, do:

   1. If the URI is a `mailto:` URI and the e-mail address has a domain part
      in a different [organizational domain] than *Zone-Org-Domain*, then
      output *[Z13_DMARC1_REPORTS_TO_THIRD_PARTY]*.

13. If no message is output for the *DMARC policy*, then output
   *[Z13_DMARC1_FOUND_AND_VALID]*.

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

The test case shall be skipped if no organizational domain can be deduced from
the *Child Zone* (for example, if *Child Zone* is equal to `co.uk`, `com`,
or `.`).

## Intercase dependencies

None.

## Terminology

* "DMARC TXT record" - The term is used to refer to a DNS TXT record which,
  after [concatenating][concatenate] all the strings within that resource
  record into one string, yields a string starting with a lowercase `v`,
  followed by zero or more spaces or tabs, followed by `=`, followed by zero
  or more spaces or tabs, followed by the uppercase string `DMARC1` (in other
  words: the string must match the Perl regular expression `/\Av[ \t]*=[
  \t]*DMARC1/`).

* "concatenate" - The term is used to refer to the conversion of a TXT
  resource record’s data to a single contiguous string, as specified in [RFC
  7489, section 6.1][RFC7489#6.1].

* "organizational domain" - The term is defined in [RFC 7489, section
  3.2][RFC7489#3.2].

* "passing the syntax check" - The term is used in this document to refer to
  text that is valid according to the ABNF grammar published in [RFC 7489,
  section 6.4][RFC7489#6.4].

* "strict subdomain" - A domain is said to be a "strict subdomain" of another
  domain if both are different and the former is a subdomain of the latter.

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[concatenate]:                          #terminology
[Connectivity01]:                       Connectivity-TP/connectivity01.md
[CRITICAL]:                             ../SeverityLevelDefinitions.md#critical
[DMARC TXT record]:                     #terminology
[DNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                ../SeverityLevelDefinitions.md#error
[INFO]:                                 ../SeverityLevelDefinitions.md#info
[Message Tag Specification]:            MessageTagSpecification.md
[Methods]:                              ../Methods.md
[NOTICE]:                               ../SeverityLevelDefinitions.md#notice
[organizational domain]:                #terminology
[passing the syntax check]:             #terminology
[RFC7489#3.2]:                          https://www.rfc-editor.org/rfc/rfc7489.html#section-3.2
[RFC7489#6.1]:                          https://www.rfc-editor.org/rfc/rfc7489.html#section-6.1
[RFC7489#6.4]:                          https://www.rfc-editor.org/rfc/rfc7489.html#section-6.4
[RFC7489]:                              https://www.rfc-editor.org/rfc/rfc7489.html
[Severity Level Definitions]:           ../SeverityLevelDefinitions.md
[strict subdomain]:                     #terminology
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[Undelegated test]:                     ../../test-types/undelegated-test.md
[WARNING]:                              ../SeverityLevelDefinitions.md#warning
[Z13_DMARC1_MULTIPLE_RECORDS]:          #summary
[Z13_DMARC1_SYNTAX_ERROR]:              #summary
[Z13_DMARC_IN_SUBDOMAIN]:               #summary
[Z13_DMARC_REPORTS_TO_THIRD_PARTY]:     #summary
[Z13_INCONSISTENT_DMARC_POLICIES]:      #summary
[Z13_NO_DMARC_FOUND]:                   #summary
[Z13_NO_ZONE_ORG_DOMAIN]:               #summary
[Z13_UNABLE_TO_CHECK_FOR_DMARC]:        #summary
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
