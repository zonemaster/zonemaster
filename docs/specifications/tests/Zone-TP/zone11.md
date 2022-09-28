# ZONE11: SPF policy validation

## Test case identifier
**Zone11**

## Table of contents

* [Objective](#objective)
* [Caveat](#caveat)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)

## Objective

Sender Policy Framework (SPF), described in [RFC 7208][RFC7208], is a mechanism
allowing domain name owners to specify which hosts are allowed to send mail
claiming to be from that domain. It is implemented by means of TXT records in a
structured format.

This test case looks up SPF records in the domain to be tested. It checks that
there is at most one published SPF version 1 policy and, if present, also checks
the following:

 * the policy has correct syntax;
 * the policy uses no deprecated [terms][SPF term] nor deprecated [macros][macro].

## Caveat

In order to avoid any denial-of-service attacks, SPF imposes limits on the
number of recursive DNS lookups an SPF validator may carry out when evaluating a
policy. This test case will generate an error if it can be certain that a policy
would generate more than 10 recursive DNS queries by a validator. A policy may
also use `include` mechanisms or `redirect` modifiers for indirection, but in
order to keep the test case simple, Zonemaster will not follow these terms.

For that reason, if the published SPF policy contains `include` mechanisms or
a `redirect` modifier, Zonemaster not raising an error about a too complex
policy does not mean that the policy will never exceed DNS processing limits
specified in [RFC 7208, section 4.6.4][RFC7208#4.6.4]. Due to the macro
expansion facilities of SPF, such problems may only be restricted to certain
sender domains.

A true SPF validator would need, as inputs, the IPv4 or IPv6 address of the
sending mail host along with the domain to test. Consequently, Zonemaster will
not attempt to evaluate the published SPF policy.

## Scope

It is assumed that *Child Zone* has been tested and reported by
[Connectivity01]. This test case will just ignore non-responsive name servers
or name servers not giving a correct DNS response for an authoritative name
server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                     | Level   | Arguments                | Message ID for message tag
:-------------------------------|:--------|:-------------------------|:--------------------------------------------
Z11_INCONSISTENT_SPF_POLICIES   | WARNING |                          | The *Child Zone* publishes different SPF policies on different name servers.
Z11_NO_SPF_FOUND                | DEBUG   |                          | The *Child Zone* does not publish an SPF policy.
Z11_SPF1_DUPLICATE_MODIFIER     | ERROR   | ns_ip_list, spf_modifier | The *Child Zone*’s SPF version 1 policy contains more than one {spf_modifier} modifier. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_HAS_P_MACRO            | WARNING | ns_ip_list               | The *Child Zone*’s SPF version 1 policy contains a %{p} macro, which should no longer be used. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_HAS_PTR                | WARNING | ns_ip_list               | The *Child Zone*’s SPF version 1 policy contains a ptr mechanism, which should no longer be used. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_MULTIPLE_RECORDS       | ERROR   | ns_ip_list               | The *Child Zone* publishes more than one SPF version 1 policy. Policies retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_RECURSIVE              | NOTICE  | ns_ip_list               | The *Child Zone*’s SPF version 1 policy uses "include" or "redirect". Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_REDIRECT_AND_ALL       | WARNING | ns_ip_list               | The *Child Zone*’s SPF version 1 policy contains both the "all" keyword and a redirect modifier, which will cause "all" to be ignored. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_REDIRECT_NOT_AT_END    | WARNING | ns_ip_list               | The *Child Zone*’s SPF version 1 policy contains a redirect modifier, but it does not appear at the end of the string. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_SYNTAX_ERROR           | ERROR   | ns_ip_list               | The *Child Zone*’s SPF version 1 policy has a syntax error. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_SPF1_SYNTAX_OK              | INFO    |                          | The *Child Zone*’s SPF version 1 policy has correct syntax.
Z11_SPF1_TOO_COMPLEX            | ERROR   | ns_ip_list, count        | Evaluating the *Child Zone*’s SPF version 1 policy would require {count} recursive DNS lookups by an SPF validator, exceeding the limit of 10. Policy retrieved from the following nameservers: {ns_ip_list}.
Z11_UNABLE_TO_CHECK_FOR_SPF     | ERROR   |                          | Unable to check whether *Child Zone* publishes an SPF policy.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

## Test procedure

In this section and unless otherwise specified below, the term "[DNS Query]"
follows the specification for DNS queries as specified in [DNS Query and
Response Defaults]. The handling of the DNS responses on the DNS queries follow,
unless otherwise specified below, what is specified for [DNS Response] in the
same specification.

1. Create a [DNS Query] with query type TXT and query name *Child Zone* ("TXT
   query").

2. Create an empty set of pairs of IP addresses and strings, "SPF-Policies".

3. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

4. For each name server in *Name Server IP* do:

   1. Send *TXT Query* to the name server and collect the [DNS Response].

   2. Go to the next name server IP address if at least one of the following
      criteria is met:

      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.

   3. If the name server responds with no TXT record, then add the pair
      consisting of the *Name Server IP* and the empty string to the
      *SPF-Policies* set.

   4. If the name server responds with at least one TXT record and none is an
      [SPF TXT record], then add the pair consisting of the *Name Server IP*
      and the empty string to the *SPF-Policies* set.

   5. If the name server responds with at least one TXT record that is an [SPF
      TXT record], then, for each [SPF TXT record], add the pair consisting of
      the *Name Server IP* and the lowercased [concatenation][concatenate] of
      all strings in the TXT record’s data to the *SPF-Policies* set.

   6. Go to the next name server.

5. If the *SPF-Policies* set is empty, then output
   *[Z11_UNABLE_TO_CHECK_FOR_SPF]* and terminate the test.

6. If all the pairs in the *SPF-Policies* set contain empty strings, then
   output *[Z11_NO_SPF_FOUND]* and terminate the test.

7. Compare the set of *SPF-Policies* retrieved from all name servers. If at
   least two different name servers have returned different sets of SPF
   policies, then output *[Z11_INCONSISTENT_SPF_POLICIES]*.

8. If the *SPF-Policies* set contains at least two pairs with the same IP
   address, then output *[Z11_SPF1_MULTIPLE_RECORDS]* with the list of
   nameservers that returned more than one SPF policy and terminate the test.

9. The following steps assume that all pairs in the *SPF-Policies* set have
   the same string ("SPF policy").

10. If the *SPF Policy* does not [pass the syntax check][passing the syntax
    check] for SPF version 1 records, then output *[Z11_SPF1_SYNTAX_ERROR]* and
    terminate the test.

11. If the *SPF Policy* contains more than one `redirect` modifier, or more than
    one `exp` modifier, then output *[Z11_SPF1_DUPLICATE_MODIFIER]*.

12. If the *SPF Policy* contains exactly one `redirect` modifier anywhere except
    at the end of the policy text, then output *[Z11_SPF1_REDIRECT_NOT_AT_END]*.

13. If the *SPF Policy* contains both a `redirect` modifier and an `all`
    mechanism, then output *[Z11_SPF1_REDIRECT_AND_ALL]*.

14. If the *SPF Policy* contains at least one `ptr` mechanism, then output
    *[Z11_SPF1_HAS_PTR]*.

15. Count the total number of terms in the *SPF Policy* that is either a
    mechanism of type `include`, `a`, `mx`, `ptr`, `exists` or a modifier of
    type `redirect` ("DNS Lookup count").

16. If the `%{p}` [macro] appears as a domain-spec for an [SPF term] in the
    *SPF Policy*, then:

    1. Output *[Z11_SPF1_HAS_P_MACRO]*.

    2. If the same policy contains no `ptr` mechanism, then increment the *DNS
    Lookup count*.

17. If the *DNS Lookup count* is greater than 10, then output
    *[Z11_SPF1_TOO_COMPLEX]*.

18. If the *DNS Lookup count* is less than or equal to 10 and the *SPF Policy*
    contains a `redirect` modifier or at least one `include` mechanism, then
    output *[Z11_SPF1_RECURSIVE]*.

19. If no other message was outputted by this test case, then output
    *[Z11_SPF1_SYNTAX_OK]*.

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

* "SPF TXT record" - The term is used to refer to a TXT resource record which,
  after [concatenating][concatenate] all strings within that resource record
  into one string, yields a string either equal to `v=spf1` or starting with
  `v=spf1` followed by a space, irrespective of character case.

* "concatenate" - The term is used to refer to the conversion of a TXT
  resource record’s data to a single contiguous string, as specified in [RFC
  7208, section 3.3][RFC7208#3.3].

* "macro" - The term is used to refer to the macros permissible in SPF
  domain-specs, as specified in [RFC 7208, section 7][RFC7208#7].

* "passing the syntax check" - The term is used in this document to refer to
  text that is valid according to the ABNF grammar published in [RFC
  7208][RFC7208] starting from [section 4.5][RFC7208#4.5].

* "using Method" - The term is used when data is fetched using the defined
  [Method][Methods].

* "SPF term" - The term is used to refer to either an SPF mechanism as defined
  in [RFC 7208, section 5][RFC7208#5] or an SPF modifier as defined in [RFC
  7208, section 6][RFC7208#6].

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[argument]:                             #terminology
[concatenate]:                          #terminology
[Connectivity01]:                       ../Connectivity-TP/connectivity01.md
[CRITICAL]:                             ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:      ../DNSQueryAndResponseDefaults.md
[DNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                ../SeverityLevelDefinitions.md#error
[INFO]:                                 ../SeverityLevelDefinitions.md#info
[macro]:                                #terminology
[Message Tag Specification]:            MessageTagSpecification.md
[Method4]:                              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                              ../Methods.md
[NOTICE]:                               ../SeverityLevelDefinitions.md#notice
[passing the syntax check]:             #terminology
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC7208#3.3]:                          https://www.rfc-editor.org/rfc/rfc7208#section-3.3
[RFC7208#4.5]:                          https://www.rfc-editor.org/rfc/rfc7208#section-4.5
[RFC7208#4.6.4]:                        https://www.rfc-editor.org/rfc/rfc7208#section-4.6.4
[RFC7208#4]:                            https://www.rfc-editor.org/rfc/rfc7208#section-4
[RFC7208#5]:                            https://www.rfc-editor.org/rfc/rfc7208#section-5
[RFC7208#6]:                            https://www.rfc-editor.org/rfc/rfc7208#section-6
[RFC7208#7]:                            https://www.rfc-editor.org/rfc/rfc7208#section-7
[RFC7208]:                              https://www.rfc-editor.org/rfc/rfc7208
[Severity Level Definitions]:           ../SeverityLevelDefinitions.md
[SPF term]:                             #terminology
[SPF TXT record]:                       #terminology
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[Undelegated test]:                     ../../test-types/undelegated-test.md
[WARNING]:                              ../SeverityLevelDefinitions.md#warning
[Z11_INCONSISTENT_SPF_POLICIES]:        #summary
[Z11_NO_SPF_FOUND]:                     #summary
[Z11_SPF1_DUPLICATE_MODIFIER]:          #summary
[Z11_SPF1_HAS_P_MACRO]:                 #summary
[Z11_SPF1_HAS_PTR]:                     #summary
[Z11_SPF1_MULTIPLE_RECORDS]:            #summary
[Z11_SPF1_RECURSIVE]:                   #summary
[Z11_SPF1_REDIRECT_AND_ALL]:            #summary
[Z11_SPF1_REDIRECT_NOT_AT_END]:         #summary
[Z11_SPF1_SYNTAX_ERROR]:                #summary
[Z11_SPF1_SYNTAX_OK]:                   #summary
[Z11_SPF1_TOO_COMPLEX]:                 #summary
[Z11_UNABLE_TO_CHECK_FOR_SPF]:          #summary
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
