> > Limit all lines to 80 characters with the possible exception of tables
> > such as the one in the summary section.

# Template01: This is a test specification template

> > Replace "Template01" with test case ID. Replace the text with a short
> > description

## Test case identifier
**Template01**

> > Replace with correct test case ID as specified in the
> > [Test Case Identifier Specification].

## Table of contents

> > If the specification contains extra sections, or if some section is not
> > included, update the list. In the normal case, keep the following sections.

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

> > Write a description of what this test case tests, i.e. the details that are
> > considered to be right and wrong. Include references to RFCs and other
> > documents.
> >
> > Do not include full links here (in the source). Put them at the end of the
> > specification document instead, as in this template.
> >
> > Do have deep links, but keep the display text short if possible. E.g.:

...described in [RFC 4035][RFC 4035#section-3.1.3], section 3.1.3, ...

## Scope

> > If this test case assumes, but not depends on, another test case then specify
> > it. Dependency would mean that the test case is affected by the other test
> > case, or even cannot be run if the other has not been run. Assuming that
> > another test case has been run is just to make it possible to ignore certain
> > errors. E.g.:

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.


## Inputs

> > Input data to the test case. Always include the Child zone, but it can also
> > be other data units, such as current time, if that is relevant.
> >
> > The input data name is put in quote marks '""', then a hyphen '-' as a
> > separator, and finally a description.

* "Child Zone" - The domain name to be tested.

## Summary

> > First we can have bullets, if applicable, that state notable things about
> > the execution or the messages. E.g.
* If no CDS record is found, the test case will terminate early
  with no message tag outputted.
* If a CDS record is of "delete" type, then it can by definition not
  match or point at any DNSKEY record.

> > Here is a table of all message tags referred to in the steps. The tag in the
> > first column, the default severity level in the second, and a statement on
> > when the message is outputted in the fourth.
> >
> > If data from the test, e.g. list of name server IP addresses, is to be
> > outputted with the message, then the datatypes are listed in the third
> > column, "arguments". The third column is left empty when no arguments are
> > used for the message.
> >
> > Always use the same table set-up, but with the correct tags. Keep the table
> > sorted by message tag. Here is an example:

Message Tag outputted         | Level   | Arguments            | Description of when message tag is outputted
:-----------------------------|:--------|:---------------------|:--------------------------------------------
T01_ALGO_NOT_SUPPORTED_BY_ZM  | NOTICE  | algo_descr, algo_num | The algorithm used is not supported by the Zonemaster implementation.
T01_BROKEN_DNSSEC             | ERROR   | ns_ip_list           | Replies do not follow the standard.
T01_HAS_NSEC                  | INFO    |                      | The *Child Zone* uses NSEC.
T01_HAS_NSEC3                 | INFO    |                      | The *Child Zone* uses NSEC3.
T01_INCONSISTENT_DNSSEC       | ERROR   | keytag               | The configuration of the zone is inconsistent with respect to DNSSEC.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


> > The message tags should be formed following the [Message Tag Specification].
> >
> > The default severity level is selected from the [Severity Level Definitions].

## Test procedure

> > This section contains the detailed steps to execute the test case. The steps
> > should be as explicit as possible to avoid that different implementations or
> > executions make different interpretations or assumptions.
> >
> > The steps should be written in such a way that it is reasonably possible to
> > use them to execute the test case manually using tools such as [`dig`]. It
> > can be assumed that the reader of the text has good understanding of DNS.
> >
> > The steps should state what messages (message tags) to be outputted when.
> > Only messages with default severity level DEBUG or higher can be included.
> >
> > All messages with level INFO or higher must be included. I.e. the
> > implementation should not include messages with default level INFO or higher
> > unless included in the specification.
> >
> > Messages DEBUG or lower can be added in the implementation as needed without
> > being included in the specification.
> >
> > Also include statement on what other information to be accompanied
> > with the message (included as parameter to the message tag). Example of such
> > information is IP adresses to name servers.
> >
> > When refering to the data defined in **Inputs** then use the name in
> > *italic*, e.g.:

2. Create a DNSKEY query with DO flag set for *Child Zone*.

> > If data sets are created, then defined them in quote marks. E.g.:

4. Create three empty sets, "NSEC-Zone", "NSEC3-Zone", and
   "No-DNSSEC-Zone".

> > When used (referred to) in the steps, make the name italic. E.g.:

6. Add the name server IP to the *NSEC-Zone* set (*NSEC3-Zone*
         set).

> > When a message is outputted in the steps, it is done by outputting
> > the message tag, "T01_HAS_NSEC3" in the example below. Make the tag as a link
> > name in italic. What the link name points at is to be defined at the bottom
> > of the document. E.g.:

8. If the NSEC (NSEC3) records do not "cover" the
   *Non-Existent Query Name*, then output *[T01_HAS_NSEC3]*

## Outcome(s)
> > First we have standard text that should normally be the same in all
> > test case specifications.

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".

> > Then there could be statements about data being outputted from the test case
> > for use as input data for other test cases.

## Special procedural requirements

> > First we have standard text that should normally be the same in all
> > test case specifications.

If either IPv4 or IPv6 transport is disabled, skip sending queries over that
transport protocol. A message will be outputted reporting that the transport
protocol has been skipped.

> > Then there could be some other limitations or specialties of how or when
> > this test case is run. E.g.:

The test case is only performed if some DNSKEY record is found in the
*Child Zone*.

## Intercase dependencies

> > Either the following text if there is no formal dependencies on other test
> > cases...

None.

> > ...or specification on the outcome that this test case depend on, e.g.:

Example of formal dependency to be added.

> > Also see the text under **Objective** about test cases that are assumed to be
> > run, but that this test case does not depend on. I.e. not dependencies in a
> > formal sense.


## Terminology

> > If there is no terminology to be explained, then this section should contain
> > the following text:

No special terminology for this test case.

> > Following are examples of terminology that are candidates to be included
> > in the section.

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 8499][RFC 8499#page-25], section 7, page 25.

The term "glue records" is defined in [RFC 8499][RFC 8499#page-24], section 7,
page 24.

When the term "using Method" is used, names and IP addresses are fetched
using the defined [Methods].

The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server.

The term "DNS Lookup" is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.





> > ----
> > The links listed below are not visible when rendered by Github.
> >
> > All link names are listed below to the left with the link target to the
> > right. They are only visible when viewing the source of this document.
> >
> > All message tags are linked to section **Summary**

[T01_ALGO_NOT_SUPPORTED_BY_ZM]:         #summary
[T01_HAS_NSEC]:                         #summary
[T01_HAS_NSEC3]:                        #summary
[T01_INCONSISTENT_DNSSEC]:              #summary

> > All links in the template are absolute, but in the specification they should
> > be relative if the link target is in the zonemaster/zonemaster repository.

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/Basic-TP/basic04.md
[CRITICAL]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#critical
[ERROR]:                                https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#error
[INFO]:                                 https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#info
[Message Tag Specification]:            MessageTagSpecification.md
[Methods]:                              ../Methods.md
[NOTICE]:                               https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#notice
[RFC 4035#section-3.1.3]:               https://tools.ietf.org/html/rfc4035#section-3.1.3
[RFC 8499#page-24]:                     https://datatracker.ietf.org/doc/html/rfc8499#page-24
[RFC 8499#page-25]:                     https://datatracker.ietf.org/doc/html/rfc8499#page-25
[Severity Level Definitions]:           https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[Undelegated test]:                     ../../test-types/undelegated-test.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
[`dig`]:                                https://en.wikipedia.org/wiki/Dig_(command)


> > Keep all links sorted, and make a straight column of the link targets.


