# DNS Query and Response Defaults

**Table of contents**
* [Overview](#Overview)
* [Application of this specification](#application-of-this-specification)
* [Default setting in *DNS Query*](#default-setting-in-dns-query)
* [Default setting in *EDNS Query*](#default-setting-in-edns-query)
* [Default setting in *DNSSEC Query*](#default-setting-in-dnssec-query)
* [Default handling of a *DNS Response*](#default-handling-of-a-dns-response)
* [Default handling of an *EDNS Response*](#default-handling-of-an-edns-response)
* [Default handling of a *DNSSEC response*](#default-handling-of-a-dnssec-response)


## Overview

Almost all [test cases] emit DNS queries and react to the responses. This
document defines the default "setting" of a DNS query and the default handling
of "setting" in the DNS response. The meaning of "setting" here will be clear
from the specification below.


## Application of this specification

This specification applies to all [test case specifications][Test Cases] that has
an explicit reference to this document.


## Default setting in *DNS Query*

A *DNS Query* has the following default setting. A test case specification can
refer to a *DNS Query* with one or several changes to the *Parameters*
overriding the default values. If a *Parameter* is specified as "fixed" (with an
"X" in that column) then the default value cannot be overidden.

|Parameter    |Default value |Fixed |Comment                       |
|:------------|:-------------|:-----|:-----------------------------|
|Protocol     | UDP          |      |                              |
|OpCode       | "query"      | X    |                              |
|QR flag      | unset        | X    |                              |
|AA flag      | unset        | X    |                              |
|TC flag      | unset        | X    |                              |
|RD flag      | unset        |      |                              |
|RA flag      | unset        | X    |                              |
|AD flag      | unset        |      |                              |
|CD flag      | unset        |      |                              |
|RCODE        | "NoError"    | X    |                              |
|Query Name   | -            |      | Must be defined in test case |
|Query Type   | -            |      | Must be defined in test case |
|Query Class  | "IN"         |      |                              |
|EDNS         | no           |      | No OPT record is included    |


## Default setting in *EDNS Query*

An *EDNS Query* inherit the default setting from a *DNS Query* except for the
parameters specified below. If a *Parameter* is specified as "fixed" (with an
"X" in that column) then the default value cannot be overidden.

A test case specification can refer to an *EDNS Query* with one or several
changes to the *Parameters*.

|Parameter             |Default value        |Fixed |Comment |
|:---------------------|:--------------------|:-----|:-------|
|EDNS                  | OPT record included | X    |        |
|EDNS UDP Message size | 512                 |      |        |
|EDNS Extended RCODE   | no                  |      |        |
|EDNS Version          | 0                   |      |        |
|EDNS DO flag          | unset               |      |        |
|EDNS Z flag           | unset               |      |        |
|EDNS0 Option          | none                |      |        |


## Default setting in *DNSSEC Query*

A *DNSSEC Query* inherits the default setting from an *EDNS Query* except for the
parameter specified below. If a *Parameter* is specified as "fixed" (with an
"X" in that column) then the default value cannot be overidden.

A test case specification can refer to a *DNSSEC Query* with one or several
changes to the Parameters.

|Parameter             |Default value |Fixed |Comment |
|:---------------------|:-------------|:-----|:-------|
|EDNS DO flag          | set          | X    |        |
|EDNS UDP Message size | 1280         |      |        |


## Default handling of a *DNS Response*

A *DNS Response* is a response to a *DNS Query*. Unless specified in the test
case specification, the items in the response are handled as listed in the table
below. 


### Validation of DNS message

If a *Response Item* is specified as "fixed" (with an "X" in that column) then
the requirement, as specified under "Default handling", must be met for the
response to be considered to be a DNS response.

|Response Item |Default handling                          | Fixed | Comment              |
|:-------------|:-----------------------------------------|:------|:---------------------|
|OpCode        | Require value to be "response"           | X     |                      |
|QR flag       | Require flag to be set                   | X     |                      |
|AA flag       | -                                        |       | Defined in test case |
|TC flag       | Re-query over TCP if set                 |       |                      |
|RD flag       | ignore                                   |       |                      |
|RA flag       | ignore                                   |       |                      |
|AD flag       | ignore                                   |       |                      |
|CD flag       | ignore                                   |       |                      |
|RCODE         | -                                        |       | Defined in test case |
|Query Name    | ignore                                   |       |                      |
|Query Type    | ignore                                   |       |                      |
|Query Class   | Require value to be same as in the query |       | Normally "IN"        |
|EDNS          | ignore                                   |       |                      |


### Extraction of DNS records

* Owner name and record type of a DNS record are compared, by default, against
  *Query Name* and *Query Type* in the question section in the query, not in the
  response.

* When fetching records from the answer section, these are the default criteria:
  * Only records matching *Query Name* and *Query Type* are fetched. Any
    RRSIG records meeting the next criterion are also fetched.
  * RRSIG records matching *Query Name* and covering *Query Type* are
    fetched.
  * CNAME records are ignored unless *Query Type* is CNAME.
  * DNSKEY records are ignored if their public key field does not contain enough
    data to calculate the size of the key.

* When the test case specification states that a CNAME chain is to be followed,
  the default handling is to only follow a CNAME chain, and fetch the records, if
  the CNAME chain is valid.
  * The chain is, by default, considered to be valid if the following criteria
    are met:
    * It must be possible to arrange all CNAME records from the answer section
      into a contiguous logical chain with a possible addition of a non-CNAME
      record whose owner name matches the RDATA of the last CNAME record.
    * The owner name of the first CNAME record in the chain must match
      *Query Name*.
    * The last record in the chain must either be a CNAME or a record matching
      *Query Type*.
    * For each owner name of the CNAME records in the chain there must not be any
      additional records in the answer section with the same owner name besides
      RRSIG and NSEC records (that may exist).
  * CNAME records not part of a valid CNAME chain are by default ignored.

* Authority and additional sections are by default ignored.

The test case specification may prescribe that CNAME records are handled in a
different way than the default above.


## Default handling of an *EDNS Response*

An *EDNS response* is a response to an *EDNS Query*. An *EDNS Response* inherits
the default handling from a *DNS Response* except for the response items
specified below. Unless specified in the test case specification, the items in
the response are handled using the default handling.

|Response Item |Default handling             | Comment                                                        |
|:-------------|:----------------------------|:---------------------------------------------------------------|
|EDNS          | Take note if OPT is missing | Further actions to be specified in the test case specification |


## Default handling of a *DNSSEC response*

A *DNSSEC response* is a response to a *DNSSEC Query*. A *DNSSEC Response*
inherits the default handling from a *EDNS Response* except for the response
items specified below. Unless specified in the test case specification, the items
in the response are handled using the default handling.

|Response Item |Default handling                 | Comment                                                        |
|:-------------|:------------------------------- |:---------------------------------------------------------------|
| EDNS DO flag | Take note if DO flag is missing | Further actions to be specified in the test case specification |



[Test Cases]:                  README.md#list-of-defined-test-cases



