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

Almost all [test cases] emit DNS queries and react on the responses. This
document defines the default "setting" of a DNS query and the default handling
of "setting" in the DNS response. The meaning of "setting" here will be clear
from the specification below.


## Application of this specification

This specification applies to all [test case specifications][Test Cases] that has
an explicit reference to this document.


## Default setting in *DNS Query*

A *DNS Query* has the following default setting. A test case specification can
refer to a *DNS Query* with one or several changes to the setting items.
Specifically, the test case specification must always specify query name and
query type.

|Setting Item |Default value |Comment                         |
|:------------|:-------------|:-------------------------------|
|Protocol     | UDP          |                                |
|OpCode       | "query"      | Always "query" in a query      |
|QR flag      | unset        | Always unset in a query        |
|AA flag      | unset        |                                |
|TC flag      | unset        |                                |
|RD flag      | unset        |                                |
|RA flag      | unset        |                                |
|AD flag      | unset        |                                |
|CD flag      | unset        |                                |
|RCODE        | "NoError"    | Always "NoError" in a query    |
|Query name   | -            | Must be defined in test case   |
|Query type   | -            | Must be defined in test case   |
|Query class  | "IN"         | Always "IN" in the query       |
|ENDS         | no           | No OPT record is included      |


## Default setting in *EDNS Query*

An *EDNS Query* inherit the default setting from a *DNS Query* except for the
setting items specified below.

A test case specification can refer to an *EDNS Query* with one or several
changes to the setting items.

|Setting Item          |Default value |Comment                   |
|:---------------------|:-------|:-------------------------------|
|ENDS                  | yes    | OPT record is included         |
|EDNS UDP Message size | 512    |                                |
|ENDS Extended RCODE   | no     |                                |
|ENDS Version          | 0      |                                |
|ENDS DO flag          | unset  |                                |
|EDNS Z lag            | unset  |                                |
|EDNS0 Option          | none   |                                |


## Default setting in *DNSSEC Query*

An *DNSSEC Query* inherit the default setting from an *EDNS Query* except for the
setting items specified below.

A test case specification can refer to an *DNSSEC Query* with one or several
changes to the setting items.

|Setting               |Default value |Comment                   |
|:---------------------|:-------|:-------------------------------|
|ENDS DO flag          | set    |                                |


## Default handling of a *DNS Response*

A *DNS Response* is a response to a *DNS Query*. Unless specified in the test
case specification, the items in the response is handled as listed.

|Response Item |Default handling    | Comment                         |
|:-------------|:-------------------|:--------------------------------|
|OpCode        | Must be "response" | Always "response" in a response |
|QR flag       | Must be set        | Always set in a response        |
|AA flag       | -                  | Defined in test case            |
|TC flag       | Re-query over TCP  |                                 |
|RD flag       | ignore             |                                 |
|RA flag       | ignore             |                                 |
|AD flag       | ignore             |                                 |
|CD flag       | ignore             |                                 |
|RCODE         | -                  | Defined in test case            |
|Query name    | ignore             |                                 |
|Query type    | ignore             |                                 |
|Query class   | ignore             | Must be "IN" in the response    |
|ENDS          | ignore             |                                 |


* Check against query name and query type is, by default, done against the values
  in the query, not in the response.
  
* When fetching records from the answer section, these are the default criteria:
  * Only records matching the query name and the query type are fetched. Any
    RRSIG records meeting the next criterium are also fetched.
  * RRSIG records with the same query name and covering the query type are
    fetched.
  * CNAME records are ignored unless the query type is CNAME.

* When CNAME chains are followed (by specification) and fetch from the answer
  section, these are the default criteria:
  * The first CNAME in the chain must match the query name.
  * The last record in the chain must either be a CNAME or a record matching the
    query type.

* Authority and additional sections are by default ignored.


## Default handling of an *EDNS Response*

An *EDNS response* is a response to an *EDNS Query*. An *EDNS Response* inherits
the default handling from a *DNS Response* except for the response items
specified below. Unless specified in the test case specification, the items in
the response is handled using the default handling.

|Response Item |Default handling | Comment                            |
|:-------------|:----------------|:-----------------------------------|
|ENDS          | -               | Defined in test case specification |


## Default handling of a *DNSSEC response*

A *DNSSEC response* is a response to an *DNSSEC Query*. A *DNSSEC Response*
inherits the default handling from a *EDNS Response* except for the response
items specified below. Unless specified in the test case specification, the items
in the response is handled using the default handling.

|Response Item |Default handling | Comment                            |
|:-------------|:----------------|:-----------------------------------|
| EDNS DO flag | ignore          |                                    |



[Test Cases]:                  README.md#list-of-defined-test-cases



