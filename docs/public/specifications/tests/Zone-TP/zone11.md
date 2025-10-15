# ZONE11: SPF policy validation

## Test case identifier
**ZONE11**

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

Sender Policy Framework (SPF) version 1, defined in [RFC 7208], is a mechanism
allowing domain name owners to specify which hosts are allowed to send mail
claiming to be from that domain. It is implemented by means of TXT records in
a structured format.

This test case looks up SPF records in the apex of *Child Zone*. It checks
that there is at most one published SPF policy and, if present, also checks
its syntax.

The root zone ("."), [TLD] zones and zones under .ARPA are treated
differently. These zones are not expected to be used as [Email Domains][Email
Domain]. For these zones, this test case generates a message if an [non-null
SPF][Null SPF] policy is found.

The root zone cannot be an [Email Domain] because according to the syntax
rules in [RFC 5321, section 4.1.2][RFC 5321#4.1.2], it is not possible to
construct an email address having the root name (".") as domain part.

Although top-level domains ([TLDs][TLD]) can technically function as [Email
Domains][Email Domain] ([RFC 5321, section 2.3.5][RFC 5321#2.3.5]), they
usually do not have this purpose. The [Internet Architecture Board] concludes
in a report named "[Dotless Domains Considered Harmful]" that domain names
that only consists of one label, e.g. "se", "fr" or "com", should not be used
for various Internet services. This means [TLD] names should not be used as
[Email Domains][Email Domain].

As for .ARPA, [RFC 3172] states that "This domain is termed an 'infrastructure
domain', as its role is to support the operating infrastructure of the
Internet. In particular, the 'arpa' domain is not to be used in the same
manner (e.g., for naming hosts) as other generic Top Level Domains are
commonly used". This means any name under .ARPA should not be used as [Email
Domains][Email Domain].

## Scope

It is assumed that *Child Zone* has been tested and reported by
[Connectivity01]. This test case will just ignore non-responsive name servers
or name servers not giving a correct DNS response for an authoritative name
server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                      | Level   | Arguments       | Message ID for message tag
:--------------------------------|:--------|:----------------|:--------------------------------------------
Z11_DIFFERENT_SPF_POLICIES_FOUND | NOTICE  | ns_list         | The following name servers returned the same SPF policy. Name servers: {ns_list}.
Z11_INCONSISTENT_SPF_POLICIES    | WARNING |                 | One or more name servers do not publish the same SPF policy as the others.
Z11_NO_SPF_FOUND                 | NOTICE  | domain          | No SPF policy was found for {domain}.
Z11_NO_SPF_NON_MAIL_DOMAIN       | INFO    | domain          | No SPF policy was found for {domain}, which is a type of domain (root, TLD or under .ARPA) not expected to be used for email.
Z11_NON_NULL_SPF_NON_MAIL_DOMAIN | NOTICE  | domain          | A non-null SPF policy was found on {domain}, although this type of domain (root, TLD or under .ARPA) is not expected to be used for email.
Z11_NULL_SPF_NON_MAIL_DOMAIN     | INFO    | domain          | A null SPF policy was found on {domain}, which is a type of domain (root, TLD or under .ARPA) not expected to be used for email.
Z11_SPF_MULTIPLE_RECORDS         | WARNING | ns_list         | The following name servers returned more than one SPF policy. Name servers: {ns_list}.
Z11_SPF_SYNTAX_ERROR             | WARNING | domain, ns_list | The SPF policy of {domain} has a syntax error. Policy retrieved from the following nameservers: {ns_list}.
Z11_SPF_SYNTAX_OK                | INFO    | domain          | The SPF policy of {domain} has correct syntax.
Z11_UNABLE_TO_CHECK_FOR_SPF      | WARNING |                 | None of the zone’s name servers responded with an authoritative response to queries for SPF policies.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns_list" even when in the "[Test
procedure]" below it is only referred to the IP address of the name servers.

## Test procedure

In this section and unless otherwise specified below, the term "[DNS Query]"
follows the specification for DNS queries as specified in [DNS Query and
Response Defaults]. The handling of the DNS responses on the DNS queries follow,
unless otherwise specified below, what is specified for [DNS Response] in the
same specification.

1. Create a [DNS Query] with query type TXT and query name *Child Zone* ("TXT
   query").

2. Create an empty set of pairs of (names and IP address) pairs and strings,
   "SPF-Policies".

3. Retrieve all name server names and IP addresses for *Child Zone* using
   methods [Get-Del-NS-Names-and-IPs] and [Get-Zone-NS-Names-and-IPs] ("Name
   Servers").

4. For each distinct name server IP address in *Name Servers* do:

   1. Send *TXT Query* to the name server and collect the [DNS Response].

   2. Go to the next name server if at least one of the following criteria is
      met:

      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.

   3. If the name server responds with no TXT record, then add the pair
      consisting of the *Name Servers* and the empty string to the
      *SPF-Policies* set.

   4. If the name server responds with at least one TXT record and none is an
      [SPF TXT record], then add the pair consisting of the *Name Servers*
      and the empty string to the *SPF-Policies* set.

   5. If the name server responds with at least one TXT record that is an [SPF
      TXT record], then, for each [SPF TXT record] do:

       1. [Concatenate] all strings in the RDATA field.
       2. Lowercase the resulting string.
       3. Add a pair consisting of the *Name Servers* and the lowercase
          string thus derived from the RDATA field to the *SPF-Policies* set.

   6. Go to the next name server.

5. If the *SPF-Policies* set is empty, then output
   *[Z11_UNABLE_TO_CHECK_FOR_SPF]* and terminate the test.

6. If all the pairs in the *SPF-Policies* set contain empty strings, then:

   1. If the *Child Zone* is the root zone ("."), a [TLD] or a zone under
      .ARPA, then output *[Z11_NO_SPF_NON_MAIL_DOMAIN]* and terminate the
      test.

   2. Else, output *[Z11_NO_SPF_FOUND]* and terminate the test.

7. For all messages outputted below, if an IP address in *Name Servers* is
   connected to more than one name server name, then all names should be
   included with the message tag.

8. Compare the set of *SPF-Policies* retrieved from all name servers. If at
   least two different name servers have returned different sets of SPF
   policies, then:

   1. Output *[Z11_INCONSISTENT_SPF_POLICIES]*.
   2. Group *SPF-Policies* by equal sets of SPF policies, such that a set of
      SPF policies is mapped to the list of *Name Servers* that returned it.
   3. For each such group of name servers, output
      *[Z11_DIFFERENT_SPF_POLICIES_FOUND]*.
   4. Terminate the test.

9. If the *SPF-Policies* set contains at least two entries with the same IP
   address, then output *[Z11_SPF_MULTIPLE_RECORDS]* with the list of
   nameservers that returned more than one SPF policy and terminate the test.

10. The following steps assume that all pairs in the *SPF-Policies* set have
    the same string ("SPF policy").

11. If the *SPF Policy* does not [pass the syntax check][passing the syntax
    check] for SPF records, then output *[Z11_SPF_SYNTAX_ERROR]* and terminate
    the test.

12. If the *Child Zone* is the root zone ("."), a [TLD] or a zone under
    .ARPA, then:

   1. If the *SPF Policy* is a [Null SPF] policy, then output
      *[Z11_NULL_SPF_NON_MAIL_DOMAIN]* and terminate the test.

   2. If the *SPF Policy* is not a [Null SPF] policy, then output
      *[Z11_NON_NULL_SPF_NON_MAIL_DOMAIN]* and terminate the test.

13. If no other message was outputted by this test case, then output
    *[Z11_SPF_SYNTAX_OK]*.

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

None.

## Terminology

* "concatenate" - The term is used to refer to the conversion of a TXT
  resource record’s data to a single contiguous string, as specified in [RFC
  7208, section 3.3][RFC 7208#3.3].

* "Email Domain" - the domain name at the right of the at-sign ("@") in an
  email address.

* "passing the syntax check" - The term is used in this document to refer to
  text that is valid according to the ABNF grammar published in [RFC 7208]
  starting from [section 4.5][RFC 7208#4.5]. Alternatively, the reader may use
  an [online SPF syntax validator]; however, such online validators should not
  be used as normative references.

* "Null SPF" - The term is used to refer to a SPF policy record which contains
  a single term, `-all`. It designates no server as permitted sender and
  evaluation of such an SPF policy is therefore guaranteed to return a failure.

* "SPF TXT record" - The term is used to refer to a TXT resource record which,
  after [concatenating][concatenate] all strings within that resource record
  into one string, yields a string either equal to `v=spf1` or starting with
  `v=spf1` followed by a space, irrespective of character case.

* "TLD" - The term is used to refer to a "Top Level Domain", i.e. a zone whose
  name consists of a single label (ignoring the empty label after the final
  dot).

[Argument list]:                        ../ArgumentsForTestCaseMessages.md
[argument]:                             #terminology
[concatenate]:                          #terminology
[Connectivity01]:                       ../Connectivity-TP/connectivity01.md
[CRITICAL]:                             ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:      ../DNSQueryAndResponseDefaults.md
[DNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[Dotless Domains Considered Harmful]:   https://www.iab.org/documents/correspondence-reports-documents/2013-2/iab-statement-dotless-domains-considered-harmful/
[Email Domain]:                         #terminology
[ERROR]:                                ../SeverityLevelDefinitions.md#error
[Get-Del-NS-Names-and-IPs]:             ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:            ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[INFO]:                                 ../SeverityLevelDefinitions.md#info
[Internet Architecture Board]:          https://www.iab.org/
[Message Tag Specification]:            MessageTagSpecification.md
[Null SPF]:                             #terminology
[NOTICE]:                               ../SeverityLevelDefinitions.md#notice
[online SPF syntax validator]:          https://vamsoft.com/support/tools/spf-syntax-validator
[passing the syntax check]:             #terminology
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 3172]:                             https://datatracker.ietf.org/doc/html/rfc3172
[RFC 5321#2.3.5]:                       https://datatracker.ietf.org/doc/html/rfc5321#section-2.3.5
[RFC 5321#4.1.2]:                       https://datatracker.ietf.org/doc/html/rfc5321#section-4.1.2
[RFC 7208#3.3]:                         https://www.rfc-editor.org/rfc/rfc7208#section-3.3
[RFC 7208#4.5]:                         https://www.rfc-editor.org/rfc/rfc7208#section-4.5
[RFC 7208]:                             https://www.rfc-editor.org/rfc/rfc7208
[Severity Level Definitions]:           ../SeverityLevelDefinitions.md
[SPF TXT record]:                       #terminology
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[TLD]:                                  #terminology
[Undelegated test]:                     ../../test-types/undelegated-test.md
[WARNING]:                              ../SeverityLevelDefinitions.md#warning
[Z11_DIFFERENT_SPF_POLICIES_FOUND]:     #summary
[Z11_INCONSISTENT_SPF_POLICIES]:        #summary
[Z11_NO_SPF_FOUND]:                     #summary
[Z11_NO_SPF_NON_MAIL_DOMAIN]:           #summary
[Z11_NON_NULL_SPF_NON_MAIL_DOMAIN]:     #summary
[Z11_NULL_SPF_NON_MAIL_DOMAIN]:         #summary
[Z11_SPF_MULTIPLE_RECORDS]:             #summary
[Z11_SPF_SYNTAX_ERROR]:                 #summary
[Z11_SPF_SYNTAX_OK]:                    #summary
[Z11_UNABLE_TO_CHECK_FOR_SPF]:          #summary
[Zone09 test specification]:            zone09.md
[Zonemaster-Engine profile]:            ../../../configuration/profiles.md
