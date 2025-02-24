# Address03 Test Zones Output

# Table of contents
* [Introduction](#introduction)
* [All message tags](#all-message-tags)
* [All scenarios](#all-scenarios)
* [zonemaster-cli commands and their output for each test scenario](#zonemaster-cli-command-and-their-output-for-each-test-scenario)

## Introduction

In this file the output of running `zonemaster-cli` for every test zone is
found. This file is created during the development of the test zones and should
be updated as the implementation of the test case or the test scenarios or test
zones are updated or corrected.

During development and any update this document serves as tracking and log tool.
It also serves as a template for future development of test zones for
scenarios for other test cases.

## All message tags

* NAMESERVER\_IP\_PTR\_MATCH
* NAMESERVER\_IP\_PTR\_MISMATCH
* NAMESERVER\_IP\_WITHOUT\_REVERSE
* NO\_RESPONSE\_PTR\_QUERY

## All scenarios

| Scenario name              | Zone name                               |
|:---------------------------|:----------------------------------------|
| ALL-NS-HAVE-PTR-1          | all-ns-have-ptr-1.address03.xa          |
| ALL-NS-HAVE-PTR-2          | all-ns-have-ptr-2.address03.xa          |
| NO-NS-HAVE-PTR             | no-ns-have-ptr.address03.xa             |
| INCOMPLETE-PTR-1           | incomplete-ptr-1.address03.xa           |
| INCOMPLETE-PTR-2           | incomplete-ptr-2.address03.xa           |
| NON-MATCHING-NAMES         | non-matching-names.address03.xa         |
| PTR-IS-GOOD-CNAME-1        | ptr-is-good-cname-1.address03.xa        |
| PTR-IS-GOOD-CNAME-2        | ptr-is-good-cname-2.address03.xa        |
| PTR-IS-DANGLING-CNAME      | ptr-is-dangling-cname.address03.xa      |
| PTR-IS-ILLEGAL-CNAME       | ptr-is-illegal-cname.address03.xa       |
| PTR-RESOLUTION-NO-RESPONSE | ptr-resolution-no-response.address03.xa |
| PTR-RESOLUTION-SERVFAIL    | ptr-resolution-servfail.address03.xa    |


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level. It is only meaningful to test the
test zones with `--test Address03`.

| Scenario name     | Mandatory message tag      | Forbidden message tags |
|:------------------|:---------------------------|:-----------------------|
| ALL-NS-HAVE-PTR-1 | NAMESERVER\_IP\_PTR\_MATCH | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info all-ns-have-ptr-1.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.10 INFO     Address03      NAMESERVER_IP_PTR_MATCH
```
--> OK

| Scenario name     | Mandatory message tag      | Forbidden message tags |
|:------------------|:---------------------------|:-----------------------|
| ALL-NS-HAVE-PTR-2 | NAMESERVER\_IP\_PTR\_MATCH | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info all-ns-have-ptr-2.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.11 INFO     Address03      NAMESERVER_IP_PTR_MATCH
```
--> OK

| Scenario name  | Mandatory message tag            | Forbidden message tags |
|:---------------|:---------------------------------|:-----------------------|
| NO-NS-HAVE-PTR | NAMESERVER\_IP\_WITHOUT\_REVERSE | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info no-ns-have-ptr.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.06 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.34; nsname=ns4.child.address03.xa
   0.07 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:34; nsname=ns4.child.address03.xa
   0.08 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.35; nsname=ns5.child.address03.xa
   0.09 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:35; nsname=ns5.child.address03.xa
```
--> OK

| Scenario name    | Mandatory message tag            | Forbidden message tags |
|:-----------------|:---------------------------------|:-----------------------|
| INCOMPLETE-PTR-1 | NAMESERVER\_IP\_WITHOUT\_REVERSE | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info incomplete-ptr-1.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.08 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.36; nsname=ns6.child.address03.xa
```
--> OK

| Scenario name    | Mandatory message tag            | Forbidden message tags |
|:-----------------|:---------------------------------|:-----------------------|
| INCOMPLETE-PTR-2 | NAMESERVER\_IP\_WITHOUT\_REVERSE | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info incomplete-ptr-2.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.07 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:37; nsname=ns7.child.address03.xa
```
--> OK

| Scenario name      | Mandatory message tag         | Forbidden message tags |
|:-------------------|:------------------------------|:-----------------------|
| NON-MATCHING-NAMES | NAMESERVER\_IP\_PTR\_MISMATCH | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info non-matching-names.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.11 NOTICE   Address03      NAMESERVER_IP_PTR_MISMATCH  names=a-naughty-nameserver.child.address03.xa.; ns_ip=127.11.3.38; nsname=ns8.child.address03.xa
   0.12 NOTICE   Address03      NAMESERVER_IP_PTR_MISMATCH  names=a-naughty-nameserver.child.address03.xa.; ns_ip=fda1:b2:c3:0:127:11:3:38; nsname=ns8.child.address03.xa
   0.13 NOTICE   Address03      NAMESERVER_IP_PTR_MISMATCH  names=non-matching-set-1.child.address03.xa./non-matching-set-2.child.address03.xa.; ns_ip=127.11.3.39; nsname=ns9.child.address03.xa
   0.13 NOTICE   Address03      NAMESERVER_IP_PTR_MISMATCH  names=non-matching-set-1.child.address03.xa./non-matching-set-2.child.address03.xa.; ns_ip=fda1:b2:c3:0:127:11:3:39; nsname=ns9.child.address03.xa
```
--> OK

| Scenario name       | Mandatory message tag      | Forbidden message tags |
|:--------------------|:---------------------------|:-----------------------|
| PTR-IS-GOOD-CNAME-1 | NAMESERVER\_IP\_PTR\_MATCH | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info ptr-is-good-cname-1.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.15 INFO     Address03      NAMESERVER_IP_PTR_MATCH
```
--> OK

| Scenario name       | Mandatory message tag      | Forbidden message tags |
|:--------------------|:---------------------------|:-----------------------|
| PTR-IS-GOOD-CNAME-2 | NAMESERVER\_IP\_PTR\_MATCH | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info ptr-is-good-cname-2.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.14 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.41; nsname=ns11.child.address03.xa
   0.16 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:41; nsname=ns11.child.address03.xa
```

The output is incorrect with Zonemaster-Engine version 7.0.0 due to a bug (<https://github.com/zonemaster/zonemaster/issues/1353>).

--> Not yet OK

| Scenario name         | Mandatory message tag            | Forbidden message tags |
|:----------------------|:---------------------------------|:-----------------------|
| PTR-IS-DANGLING-CNAME | NAMESERVER\_IP\_WITHOUT\_REVERSE | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info ptr-is-dangling-cname.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.07 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.42; nsname=ns12.child.address03.xa
   0.08 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:42; nsname=ns12.child.address03.xa
   0.08 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.35; nsname=ns5.child.address03.xa
   0.09 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:35; nsname=ns5.child.address03.xa
```
--> OK

| Scenario name        | Mandatory message tag            | Forbidden message tags                                    |
|:---------------------|:---------------------------------|:----------------------------------------------------------|
| PTR-IS-ILLEGAL-CNAME | NAMESERVER\_IP\_WITHOUT\_REVERSE | NAMESERVER\_IP\_PTR\_MATCH, NAMESERVER\_IP\_PTR\_MISMATCH |

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info ptr-is-illegal-cname.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.06 ERROR    Address03      CNAME_RECORDS_MULTIPLE_FOR_NAME  name="43.3.11.127.in-addr.arpa"
   0.06 WARNING  Address03      NO_RESPONSE_PTR_QUERY  domain=43.3.11.127.in-addr.arpa.
   0.06 ERROR    Address03      CNAME_RECORDS_MULTIPLE_FOR_NAME  name="3.4.0.0.3.0.0.0.1.1.0.0.7.2.1.0.0.0.0.0.3.c.0.0.2.b.0.0.1.a.d.f.ip6.arpa"
   0.06 WARNING  Address03      NO_RESPONSE_PTR_QUERY  domain=3.4.0.0.3.0.0.0.1.1.0.0.7.2.1.0.0.0.0.0.3.c.0.0.2.b.0.0.1.a.d.f.ip6.arpa.
   0.07 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.34; nsname=ns4.child.address03.xa
   0.07 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:34; nsname=ns4.child.address03.xa
```
--> OK

| Scenario name              | Mandatory message tag    | Forbidden message tags                                    |
|:---------------------------|:-------------------------|:----------------------------------------------------------|
| PTR-RESOLUTION-NO-RESPONSE | NO\_RESPONSE\_PTR\_QUERY | NAMESERVER\_IP\_PTR\_MATCH, NAMESERVER\_IP\_PTR\_MISMATCH |

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info ptr-resolution-no-response.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
  40.12 WARNING  Address03      NO_RESPONSE_PTR_QUERY  domain=44.3.11.127.in-addr.arpa.
  40.12 WARNING  Address03      NO_RESPONSE_PTR_QUERY  domain=4.4.0.0.3.0.0.0.1.1.0.0.7.2.1.0.0.0.0.0.3.c.0.0.2.b.0.0.1.a.d.f.ip6.arpa.
```
--> OK

| Scenario name           | Mandatory message tag    | Forbidden message tags                                    |
|:------------------------|:-------------------------|:----------------------------------------------------------|
| PTR-RESOLUTION-SERVFAIL | NO\_RESPONSE\_PTR\_QUERY | NAMESERVER\_IP\_PTR\_MATCH, NAMESERVER\_IP\_PTR\_MISMATCH |

```
$ zonemaster-cli --raw --show-testcase --test address03 --hints COMMON/hintfile --level info ptr-resolution-servfail.address03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.0.0
   0.07 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=127.11.3.45; nsname=ns15.child.address03.xa
   0.08 WARNING  Address03      NAMESERVER_IP_WITHOUT_REVERSE  ns_ip=fda1:b2:c3:0:127:11:3:45; nsname=ns15.child.address03.xa
```
--> Not yet OK
