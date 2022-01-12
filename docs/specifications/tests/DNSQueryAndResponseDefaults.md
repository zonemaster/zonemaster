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
|QR flag      | unset        | X    | Always unset in a query      |
|AA flag      | unset        | X    |                              |
|TC flag      | unset        | X    |                              |
|RD flag      | unset        |      |                              |
|RA flag      | unset        | X    |                              |
|AD flag      | unset        |      |                              |
|CD flag      | unset        |      |                              |
|RCODE        | "NoError"    | X    |                              |
|Query name   | -            |      | Must be defined in test case |
|Query type   | -            |      | Must be defined in test case |
|Query class  | "IN"         |      |                              |
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


## Default handling of a *DNS Response*

A *DNS Response* is a response to a *DNS Query*. Unless specified in the test
case specification, the items in the response are handled as listed. If a
*Response Item* is specified as "fixed" (with an "X" in that column) then the
requirement, as specified under "Default handling", must be successful for the
response to be considered to be a valid DNS response.

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
|Query name    | ignore                                   |       |                      |
|Query type    | ignore                                   |       |                      |
|Query class   | Require value to be same as in the query |       | Normally "IN"        |
|EDNS          | ignore                                   |       |                      |

* Check against query name and query type is, by default, done against the values
  in the query section in the query, not in the response.
  
* When fetching records from the answer section, these are the default criteria:
  * Only records matching the query name and the query type are fetched. Any
    RRSIG records meeting the next criterium are also fetched.
  * RRSIG records with the same query name and covering the query type are
    fetched.
  * CNAME records are ignored unless the query type is CNAME.

* When the test case specification states that CNAME chains are to be followed in
  the the answer section, these are the default criteria for the chain to be
  fetched:
  * The first CNAME in the chain must match the query name.
  * The last record in the chain must either be a CNAME or a record matching the
    query type.
  * For each owner name of the CNAME records in the chain there must not be any
    additional CNAME records in the answer section (only one CNAME record per
    owner name).

* Authority and additional sections are by default ignored.


## Default handling of an *EDNS Response*

An *EDNS response* is a response to an *EDNS Query*. An *EDNS Response* inherits
the default handling from a *DNS Response* except for the response items
specified below. Unless specified in the test case specification, the items in
the response are handled using the default handling.

|Response Item |Default handling             | Comment                                                        |
|:-------------|:----------------------------|:----------------------- ---------------------------------------|
|EDNS          | Take note if OPT is missing | Further actions to be specified in the test case specification |


## Default handling of a *DNSSEC response*

A *DNSSEC response* is a response to a *DNSSEC Query*. A *DNSSEC Response*
inherits the default handling from a *EDNS Response* except for the response
items specified below. Unless specified in the test case specification, the items
in the response are handled using the default handling.

|Response Item |Default handlin                  | Comment                                                        |
|:-------------|:------------------------------- |:---------------------------------------------------------------|
| EDNS DO flag | Take note if DO flag is missing | Further actions to be specified in the test case specification |



[Test Cases]:                  README.md#list-of-defined-test-cases



