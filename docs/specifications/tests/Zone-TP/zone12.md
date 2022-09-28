# ZONE12: No use of the deprecated SPF resource record type

## Test case identifier
**Zone12**

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

Sender Policy Framework (SPF) was first specified by [RFC 4408][RFC4408],
which was then obsoleted by [RFC 7208][RFC7208].

[RFC 4408, section 3.1.1][RFC4408#3.1.1] proposed a dedicated resource record
type named “SPF”, to be used for publishing SPF policies. The same RFC
recommended to publish the same SPF policy twice, with one copy using the SPF
resource record type and the other using the more generic TXT type.

However, [RFC 7208, section 3.1][RFC7208#3.1] deprecates this dual publication
practice, stating that SPF policies must be published in TXT resource records
only. SPF resource records should therefore no longer be used.

This test case checks for the presence of any SPF resource records at the apex
of the domain being tested and emits a warning if any such resource record is
found. No further validation of any kind is performed on the data contained in
any SPF resource records that are found.

## Scope

It is assumed that *Child Zone* has been tested and reported by
[Connectivity01]. This test case will just ignore non-responsive name servers or
name servers not giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                     | Level   | Arguments            | Message ID for message tag
:-------------------------------|:--------|:---------------------|:--------------------------------------------
Z12_SPF_RECORD_FOUND            | WARNING | ns_ip_list           | The *Child Zone* publishes an SPF policy with SPF resource records, which are deprecated in favor of TXT. Policy retrieved from the following nameservers: {ns_ip_list}.
Z12_NO_SPF_RECORDS              | INFO    |                      | The *Child Zone* does not publish any SPF policies using the deprecated SPF resource record type.
Z12_UNABLE_TO_CHECK             | ERROR   |                      | Unable to check whether *Child Zone* uses resource records of type SPF.

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

1. Create a [DNS Query] with query type SPF and query name *Child Zone* ("SPF
   query").

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. Create two empty sets of IP addresses, "Name Servers returning SPF records"
   and "Name Servers returning no error".

4. For each name server in *Name Server IP* do:

   1. Send *SPF Query* to the name server and collect the [DNS Response].

   2. Go to the next name server IP address if at least one of the following
      criteria is met:

      1. There is no DNS response.
      2. [RCODE Name] of the response is not "NoError".
      3. The AA flag is not set in the response.

   3. Add the name server’s IP address to the *Name Servers returning no
      error* set.

   4. If the name server responds with at least one SPF record, then add the
      name server’s IP address to the *Name Servers returning SPF records* set.

5. If the *Name Servers returning no error* set is empty, then output
   *[Z12_UNABLE_TO_CHECK]* and terminate the test.

6. Else, if the *Name Servers returning SPF records* set is not empty, then
   output *[Z12_SPF_RECORD_FOUND]*.

7. Else, if the *Name Servers returning SPF records* set is empty, then output
   *[Z12_NO_SPF_RECORDS]*.

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

* "using Method" - The term is used when data is fetched using the defined
  [Method][Methods].

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Connectivity01]:                       Connectivity-TP/connectivity01.md
[CRITICAL]:                             ../SeverityLevelDefinitions.md#critical
[DNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                ../SeverityLevelDefinitions.md#error
[INFO]:                                 ../SeverityLevelDefinitions.md#info
[Message Tag Specification]:            MessageTagSpecification.md
[Method4]:                              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                              ../Methods.md
[NOTICE]:                               ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC4408#3.1.1]:                        https://www.rfc-editor.org/rfc/rfc4408#section-3.1.1
[RFC4408]:                              https://www.rfc-editor.org/rfc/rfc4408
[RFC7208#3.1]:                          https://www.rfc-editor.org/rfc/rfc7208#section-3.1
[RFC7208]:                              https://www.rfc-editor.org/rfc/rfc7208
[Severity Level Definitions]:           ../SeverityLevelDefinitions.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[Undelegated test]:                     ../../test-types/undelegated-test.md
[WARNING]:                              ../SeverityLevelDefinitions.md#warning
[Z12_NO_SPF_RECORDS]:                   #summary
[Z12_SPF_RECORD_FOUND]:                 #summary
[Z12_UNABLE_TO_CHECK]:                  #summary
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
