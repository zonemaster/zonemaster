# Connectivity04 Test Zones Output

# Table of contents
* [Introduction](#introduction)
* [All message tags](#all-message-tags)
* [All scenarios](#all-scenarios)
* [zonemaster-cli commands and their output for each test scenario](#zonemaster-cli-commands-and-their-output-for-each-test-scenario)

## Introduction

In this file the output of running `zonemaster-cli` for every test zone is
found. This file is created during the development of the test zones and should
be updated as the implementation of the test case or the test scenarios or test
zones are updated or corrected.

During development and any update this document serves as tracking and log tool.
It also serves as a template for future development of test zones for
scenarios for other test cases.

## All message tags

* CN04_EMPTY_PREFIX_SET
* CN04_ERROR_PREFIX_DATABASE
* CN04_IPV4_DIFFERENT_PREFIX
* CN04_IPV4_SAME_PREFIX
* CN04_IPV4_SINGLE_PREFIX
* CN04_IPV6_DIFFERENT_PREFIX
* CN04_IPV6_SAME_PREFIX
* CN04_IPV6_SINGLE_PREFIX

## All scenarios

Scenario name             | Zone name
:-------------------------|:---------------------------------------------
GOOD-1                    | good-1.connectivity04.xa
GOOD-2                    | good-2.connectivity04.xa
GOOD-3                    | good-3.connectivity04.xa
EMPTY-PREFIX-SET-1        | empty-prefix-set-1.connectivity04.xa
EMPTY-PREFIX-SET-2        | empty-prefix-set-2.connectivity04.xa
ERROR-PREFIX-DATABASE-1   | error-prefix-database-1.connectivity04.xa
ERROR-PREFIX-DATABASE-2   | error-prefix-database-2.connectivity04.xa
ERROR-PREFIX-DATABASE-3   | error-prefix-database-3.connectivity04.xa
ERROR-PREFIX-DATABASE-6   | error-prefix-database-6.connectivity04.xa
ERROR-PREFIX-DATABASE-7   | error-prefix-database-7.connectivity04.xa
ERROR-PREFIX-DATABASE-8   | error-prefix-database-8.connectivity04.xa
HAS-NON-ASN-TXT-1         | has-non-asn-txt-1.connectivity04.xa
HAS-NON-ASN-TXT-2         | has-non-asn-txt-2.connectivity04.xa
IPV4-ONE-PREFIX-1         | ipv4-one-prefix-1.connectivity04.xa
IPV4-TWO-PREFIXES-1       | ipv4-two-prefixes-1.connectivity04.xa
IPV6-ONE-PREFIX-1         | ipv6-one-prefix-1.connectivity04.xa
IPV6-TWO-PREFIXES-1       | ipv6-two-prefixes-1.connectivity04.xa
IPV4-SINGLE-NS-1          | ipv4-single-ns-1.connectivity04.xa
IPV6-SINGLE-NS-1          | ipv6-single-ns-1.connectivity04.xa
DOUBLE-PREFIX-1           | double-prefix-1.connectivity04.xa
DOUBLE-PREFIX-2           | double-prefix-2.connectivity04.xa


## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with `--level=info
--test=connetivity04`.

The test zones for these scenarios have a dedicated root zone, which means that
the hint files in the commands below must be used.

All commands are run from the same directory as this file is in.

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-1                   | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw GOOD-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.23 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns0.connectivity04.xa/127.100.100.1;dns1.connectivity04.xa/127.100.101.1
   0.23 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns0.connectivity04.xa/fda1:b2:c3:0:127:100:100:1;dns1.connectivity04.xa/fda1:b2:c3:0:127:100:101:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-2                   | CN04_IPV4_DIFFERENT_PREFIX                               | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw GOOD-2.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.11 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns2.connectivity04.xa/127.100.102.1;dns3.connectivity04.xa/127.100.103.1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-3                   | CN04_IPV6_DIFFERENT_PREFIX                               | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw GOOD-3.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.12 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns4.connectivity04.xa/fda1:b2:c3:0:127:100:104:1;dns5.connectivity04.xa/fda1:b2:c3:0:127:100:105:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
EMPTY-PREFIX-SET-1       | CN04_EMPTY_PREFIX_SET                                    | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw EMPTY-PREFIX-SET-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.12 NOTICE   Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=127.100.107.1
   0.13 NOTICE   Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=fda1:b2:c3:0:127:100:107:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
EMPTY-PREFIX-SET-2       | CN04_EMPTY_PREFIX_SET                                    | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw EMPTY-PREFIX-SET-2.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.12 NOTICE   Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=127.100.108.1
   0.12 NOTICE   Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=fda1:b2:c3:0:127:100:108:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-1  | CN04_ERROR_PREFIX_DATABASE                               | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw ERROR-PREFIX-DATABASE-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.11 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.110.1
   0.13 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:110:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-2  | CN04_ERROR_PREFIX_DATABASE                               | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw ERROR-PREFIX-DATABASE-2.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.10 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.111.1
   0.12 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:111:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-3  | CN04_ERROR_PREFIX_DATABASE                               | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw ERROR-PREFIX-DATABASE-3.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
  40.14 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.112.1
  40.17 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:112:1
```
--> OK

Scenario name            | Mandatory message tag                                                             | Forbidden message tags
:------------------------|:----------------------------------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-6  | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX, CN04_ERROR_PREFIX_DATABASE| 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw ERROR-PREFIX-DATABASE-6.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.15 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns1.connectivity04.xa/127.100.101.1;dns25.connectivity04.xa/127.100.125.1
   0.15 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns1.connectivity04.xa/fda1:b2:c3:0:127:100:101:1;dns25.connectivity04.xa/fda1:b2:c3:0:127:100:125:1
```
--> Unexpected

Scenario name            | Mandatory message tag                                                             | Forbidden message tags
:------------------------|:----------------------------------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-7  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw ERROR-PREFIX-DATABASE-7.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.15 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.126.1
   0.16 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:126:1
```
--> OK

Scenario name            | Mandatory message tag                                                             | Forbidden message tags
:------------------------|:----------------------------------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-8  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw ERROR-PREFIX-DATABASE-8.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.11 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.127.1
   0.12 NOTICE   Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:127:1
```
--> OK

Scenario name            | Mandatory message tag                                                             | Forbidden message tags
:------------------------|:----------------------------------------------------------------------------------|:--------------------
HAS-NON-ASN-TXT-1        | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw HAS-NON-ASN-TXT-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.17 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns1.connectivity04.xa/127.100.101.1;dns6.connectivity04.xa/127.100.106.1
   0.18 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns1.connectivity04.xa/fda1:b2:c3:0:127:100:101:1;dns6.connectivity04.xa/fda1:b2:c3:0:127:100:106:1
```
--> OK

Scenario name            | Mandatory message tag                                                             | Forbidden message tags
:------------------------|:----------------------------------------------------------------------------------|:--------------------
HAS-NON-ASN-TXT-2        | CN04_EMPTY_PREFIX_SET                                                       | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw HAS-NON-ASN-TXT-2.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.09 NOTICE   Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=127.100.109.1
   0.10 NOTICE   Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=fda1:b2:c3:0:127:100:109:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV4-ONE-PREFIX-1        | CN04_IPV4_SAME_PREFIX, CN04_IPV4_SINGLE_PREFIX           | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw IPV4-ONE-PREFIX-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.20 NOTICE   Connectivity04 CN04_IPV4_SAME_PREFIX  ip_prefix=127.100.113.0/24; ns_list=dns13-1.connectivity04.xa/127.100.113.1;dns13-2.connectivity04.xa/127.100.113.2
   0.20 WARNING  Connectivity04 CN04_IPV4_SINGLE_PREFIX  
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV4-TWO-PREFIXES-1      | CN04_IPV4_SAME_PREFIX, CN04_IPV4_DIFFERENT_PREFIX        | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw IPV4-TWO-PREFIXES-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.13 NOTICE   Connectivity04 CN04_IPV4_SAME_PREFIX  ip_prefix=127.100.114.0/24; ns_list=dns14-1.connectivity04.xa/127.100.114.1;dns14-2.connectivity04.xa/127.100.114.2
   0.13 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns15.connectivity04.xa/127.100.115.1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV6-ONE-PREFIX-1        | CN04_IPV6_SAME_PREFIX, CN04_IPV6_SINGLE_PREFIX           | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw IPV6-ONE-PREFIX-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.13 NOTICE   Connectivity04 CN04_IPV6_SAME_PREFIX  ip_prefix=fda1:b2:c3:0:127:100:116:0/112; ns_list=dns16-1.connectivity04.xa/fda1:b2:c3:0:127:100:116:1;dns16-2.connectivity04.xa/fda1:b2:c3:0:127:100:116:2
   0.13 WARNING  Connectivity04 CN04_IPV6_SINGLE_PREFIX  
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV6-TWO-PREFIXES-1      | CN04_IPV6_SAME_PREFIX, CN04_IPV6_SINGLE_PREFIX           | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw IPV6-TWO-PREFIXES-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.13 NOTICE   Connectivity04 CN04_IPV6_SAME_PREFIX  ip_prefix=fda1:b2:c3:0:127:100:117:0/112; ns_list=dns17-1.connectivity04.xa/fda1:b2:c3:0:127:100:117:1;dns17-2.connectivity04.xa/fda1:b2:c3:0:127:100:117:2
   0.13 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns18.connectivity04.xa/fda1:b2:c3:0:127:100:118:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV4-SINGLE-NS-1         | CN04_IPV4_SINGLE_PREFIX, CN04_IPV4_DIFFERENT_PREFIX      | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw IPV4-SINGLE-NS-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.15 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns19.connectivity04.xa/127.100.119.1
   0.15 WARNING  Connectivity04 CN04_IPV4_SINGLE_PREFIX  
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV6-SINGLE-NS-1         | CN04_IPV6_SINGLE_PREFIX, CN04_IPV6_DIFFERENT_PREFIX      | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw IPV6-SINGLE-NS-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.11 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns20.connectivity04.xa/fda1:b2:c3:0:127:100:120:1
   0.11 WARNING  Connectivity04 CN04_IPV6_SINGLE_PREFIX  
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
DOUBLE-PREFIX-1          | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw DOUBLE-PREFIX-1.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.15 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns21.connectivity04.xa/127.100.121.1;dns22.connectivity04.xa/127.100.122.1
   0.15 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns21.connectivity04.xa/fda1:b2:c3:0:127:100:121:1;dns22.connectivity04.xa/fda1:b2:c3:0:127:100:122:1
```
--> OK

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
DOUBLE-PREFIX-2          | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=connectivity04 --level=info --show-testcase --raw DOUBLE-PREFIX-2.connectivity04.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.15 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns23.connectivity04.xa/127.100.123.1;dns24.connectivity04.xa/127.100.124.1
   0.15 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns23.connectivity04.xa/fda1:b2:c3:0:127:100:123:1;dns24.connectivity04.xa/fda1:b2:c3:0:127:100:124:1
```
--> OK
