# Zone11 Test Zones Output

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

* Z11_DIFFERENT_SPF_POLICIES_FOUND
* Z11_INCONSISTENT_SPF_POLICIES
* Z11_NO_SPF_FOUND
* Z11_NO_SPF_NON_MAIL_DOMAIN
* Z11_NON_NULL_SPF_NON_MAIL_DOMAIN
* Z11_NULL_SPF_NON_MAIL_DOMAIN
* Z11_SPF_MULTIPLE_RECORDS
* Z11_SPF_SYNTAX_ERROR
* Z11_SPF_SYNTAX_OK
* Z11_UNABLE_TO_CHECK_FOR_SPF


## All scenarios

| Scenario name          | Zone name                          |
|:-----------------------|:-----------------------------------|
| GOOD-SPF-1             | good-spf-1.zone11.xa               |
| GOOD-SPF-2             | good-spf-2.zone11.xa               |
| SAME-SPF-DIFFERENT-TXT | same-spf-different-txt.zone11.xa   |
| NO-TXT                 | no-txt.zone11.xa                   |
| NO-SPF-TXT             | no-spf-txt.zone11.xa               |
| NO-SPF-ROOT-ZONE       | .                                  |
| NO-SPF-TLD-ZONE        | no-spf-zone11                      |
| NO-SPF-ARPA-ZONE       | no-spf-arpa-zone.zone11.arpa       |
| NULL-SPF-ROOT-ZONE     | .                                  |
| NULL-SPF-TLD-ZONE      | null-spf-zone11                    |
| NULL-SPF-ARPA-ZONE     | null-spf-arpa-zone.zone11.arpa     |
| NON-NULL-SPF-ROOT-ZONE | .                                  |
| NON-NULL-SPF-TLD-ZONE  | non-null-spf-zone11                |
| NON-NULL-SPF-ARPA-ZONE | non-null-spf-arpa-zone.zone11.arpa |
| INVALID-SYNTAX-1       | invalid-syntax-1.zone11.xa         |
| INVALID-SYNTAX-2       | invalid-syntax-2.zone11.xa         |
| INVALID-SYNTAX-3       | invalid-syntax-3.zone11.xa         |
| NON-AUTH-TXT           | non-auth-txt.zone11.xa             |
| SERVFAIL               | servfail.zone11.xa                 |
| INCONSISTENT-SPF       | inconsistent-spf.zone11.xa         |
| SPF-MISSING-ON-ONE     | spf-missing-on-one.zone11.xa       |
| ALL-DIFFERENT-SPF      | all-different-spf.zone11.xa        |
| MULTIPLE-SPF-RECORDS   | multiple-spf-records.zone11.xa     |


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level. It is only meaningful to test the
test zones with `--test Zone11`.

| Scenario name | Mandatory message tags | Forbidden message tags |
|:--------------|:-----------------------|:-----------------------|
| GOOD-SPF-1    | Z11_SPF_SYNTAX_OK      | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info good-spf-1.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.07 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="good-spf-1.zone11.xa"
```
--> OK

| Scenario name | Mandatory message tags | Forbidden message tags |
|:--------------|:-----------------------|:-----------------------|
| GOOD-SPF-2    | Z11_SPF_SYNTAX_OK      | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info good-spf-2.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.08 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="good-spf-2.zone11.xa"
```
--> OK

| Scenario name          | Mandatory message tags | Forbidden message tags |
|:-----------------------|:-----------------------|:-----------------------|
| SAME-SPF-DIFFERENT-TXT | Z11_SPF_SYNTAX_OK      | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info same-spf-different-txt.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.05 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="same-spf-different-txt.zone11.xa"
```
--> OK

| Scenario name | Mandatory message tags | Forbidden message tags |
|:--------------|:-----------------------|:-----------------------|
| NO-TXT        | Z11_NO_SPF_FOUND       | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info no-txt.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.06 NOTICE   Zone11         Z11_NO_SPF_FOUND  domain="no-txt.zone11.xa"
```
--> OK

| Scenario name | Mandatory message tags | Forbidden message tags |
|:--------------|:-----------------------|:-----------------------|
| NO-SPF-TXT    | Z11_NO_SPF_FOUND       | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info no-spf-txt.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.05 NOTICE   Zone11         Z11_NO_SPF_FOUND  domain="no-spf-txt.zone11.xa"
```
--> OK

| Scenario name    | Mandatory message tags     | Forbidden message tags |
|:-----------------|:---------------------------|:-----------------------|
| NO-SPF-ROOT-ZONE | Z11_NO_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints Zone-TP/zone11/no-spf.hintfile --level info .
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.01 NOTICE   Zone11         Z11_NO_SPF_FOUND  domain="."
```
--> Not OK.

| Scenario name   | Mandatory message tags     | Forbidden message tags |
|:----------------|:---------------------------|:-----------------------|
| NO-SPF-TLD-ZONE | Z11_NO_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info no-spf-zone11
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 NOTICE   Zone11         Z11_NO_SPF_FOUND  domain="no-spf-zone11"
```
--> Not OK.

| Scenario name    | Mandatory message tags     | Forbidden message tags |
|:-----------------|:---------------------------|:-----------------------|
| NO-SPF-ARPA-ZONE | Z11_NO_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info no-spf-arpa-zone.zone11.arpa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.06 NOTICE   Zone11         Z11_NO_SPF_FOUND  domain="no-spf-arpa-zone.zone11.arpa"
```
--> Not OK.

| Scenario name      | Mandatory message tags       | Forbidden message tags |
|:-------------------|:-----------------------------|:-----------------------|
| NULL-SPF-ROOT-ZONE | Z11_NULL_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints Zone-TP/zone11/null-spf.hintfile --level info .
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.01 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="."
```
--> Not OK.

| Scenario name     | Mandatory message tags       | Forbidden message tags |
|:------------------|:-----------------------------|:-----------------------|
| NULL-SPF-TLD-ZONE | Z11_NULL_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info null-spf-zone11
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="null-spf-zone11"
```
--> Not OK.

| Scenario name      | Mandatory message tags       | Forbidden message tags |
|:-------------------|:-----------------------------|:-----------------------|
| NULL-SPF-ARPA-ZONE | Z11_NULL_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info null-spf-arpa-zone.zone11.arpa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.06 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="null-spf-arpa-zone.zone11.arpa"
```
--> Not OK.

| Scenario name          | Mandatory message tags           | Forbidden message tags |
|:-----------------------|:---------------------------------|:-----------------------|
| NON-NULL-SPF-ROOT-ZONE | Z11_NON_NULL_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints Zone-TP/zone11/non-null-spf.hintfile --level info .
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.01 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="."
```
--> Not OK.

| Scenario name         | Mandatory message tags           | Forbidden message tags |
|:----------------------|:---------------------------------|:-----------------------|
| NON-NULL-SPF-TLD-ZONE | Z11_NON_NULL_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info non-null-spf-zone11
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="non-null-spf-zone11"
```
--> Not OK.

| Scenario name          | Mandatory message tags           | Forbidden message tags |
|:-----------------------|:---------------------------------|:-----------------------|
| NON-NULL-SPF-ARPA-ZONE | Z11_NON_NULL_SPF_NON_MAIL_DOMAIN | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info non-null-spf-arpa-zone.zone11.arpa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.06 INFO     Zone11         Z11_SPF1_SYNTAX_OK  domain="non-null-spf-arpa-zone.zone11.arpa"
```
--> Not OK.

| Scenario name    | Mandatory message tags | Forbidden message tags |
|:-----------------|:-----------------------|:-----------------------|
| INVALID-SYNTAX-1 | Z11_SPF_SYNTAX_ERROR   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info invalid-syntax-1.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.09 ERROR    Zone11         Z11_SPF1_SYNTAX_ERROR  domain="invalid-syntax-1.zone11.xa"; ns_ip_list=127.19.11.31;127.19.11.32;fda1:b2:c3:0:127:19:11:31;fda1:b2:c3:0:127:19:11:32
```
--> Not OK (expected argument "ns_list" for Z11_SPF1_SYNTAX_ERROR, got "ns_ip_list" instead).

| Scenario name    | Mandatory message tags | Forbidden message tags |
|:-----------------|:-----------------------|:-----------------------|
| INVALID-SYNTAX-2 | Z11_SPF_SYNTAX_ERROR   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info invalid-syntax-2.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.11 ERROR    Zone11         Z11_SPF1_SYNTAX_ERROR  domain="invalid-syntax-2.zone11.xa"; ns_ip_list=127.19.11.31;127.19.11.32;fda1:b2:c3:0:127:19:11:31;fda1:b2:c3:0:127:19:11:32
```
--> Not OK (expected argument "ns_list" for Z11_SPF1_SYNTAX_ERROR, got "ns_ip_list" instead).

| Scenario name    | Mandatory message tags | Forbidden message tags |
|:-----------------|:-----------------------|:-----------------------|
| INVALID-SYNTAX-3 | Z11_SPF_SYNTAX_ERROR   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info invalid-syntax-3.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.05 ERROR    Zone11         Z11_SPF1_SYNTAX_ERROR  domain="invalid-syntax-3.zone11.xa"; ns_ip_list=127.19.11.31;127.19.11.32;fda1:b2:c3:0:127:19:11:31;fda1:b2:c3:0:127:19:11:32
```
--> Not OK (expected argument "ns_list" for Z11_SPF1_SYNTAX_ERROR, got "ns_ip_list" instead).

| Scenario name | Mandatory message tags      | Forbidden message tags |
|:--------------|:----------------------------|:-----------------------|
| NON-AUTH-TXT  | Z11_UNABLE_TO_CHECK_FOR_SPF | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info non-auth-txt.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    Zone11         Z11_UNABLE_TO_CHECK_FOR_SPF
```
--> OK

| Scenario name | Mandatory message tags      | Forbidden message tags |
|:--------------|:----------------------------|:-----------------------|
| SERVFAIL      | Z11_UNABLE_TO_CHECK_FOR_SPF | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info servfail.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.07 ERROR    Zone11         Z11_UNABLE_TO_CHECK_FOR_SPF
```
--> OK

| Scenario name    | Mandatory message tags                                          | Forbidden message tags |
|:-----------------|:----------------------------------------------------------------|:-----------------------|
| INCONSISTENT-SPF | Z11_INCONSISTENT_SPF_POLICIES, Z11_DIFFERENT_SPF_POLICIES_FOUND | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info inconsistent-spf.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.07 WARNING  Zone11         Z11_INCONSISTENT_SPF_POLICIES
   0.07 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.32;fda1:b2:c3:0:127:19:11:32
   0.07 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.31;fda1:b2:c3:0:127:19:11:31
```
--> Not OK (expected argument "ns_list" for Z11_DIFFERENT_SPF_POLICIES_FOUND, got "ns_ip_list" instead).

| Scenario name      | Mandatory message tags                                          | Forbidden message tags |
|:-------------------|:----------------------------------------------------------------|:-----------------------|
| SPF-MISSING-ON-ONE | Z11_INCONSISTENT_SPF_POLICIES, Z11_DIFFERENT_SPF_POLICIES_FOUND | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info spf-missing-on-one.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.10 WARNING  Zone11         Z11_INCONSISTENT_SPF_POLICIES
   0.10 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.31;fda1:b2:c3:0:127:19:11:31
   0.10 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.32;127.19.11.33;fda1:b2:c3:0:127:19:11:32;fda1:b2:c3:0:127:19:11:33
```
--> Not OK (expected argument "ns_list" for Z11_DIFFERENT_SPF_POLICIES_FOUND, got "ns_ip_list" instead).

| Scenario name     | Mandatory message tags                                          | Forbidden message tags |
|:------------------|:----------------------------------------------------------------|:-----------------------|
| ALL-DIFFERENT-SPF | Z11_INCONSISTENT_SPF_POLICIES, Z11_DIFFERENT_SPF_POLICIES_FOUND | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info all-different-spf.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.06 WARNING  Zone11         Z11_INCONSISTENT_SPF_POLICIES
   0.06 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.33;fda1:b2:c3:0:127:19:11:33
   0.06 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.32;fda1:b2:c3:0:127:19:11:32
   0.06 NOTICE   Zone11         Z11_DIFFERENT_SPF_POLICIES_FOUND  ns_ip_list=127.19.11.31;fda1:b2:c3:0:127:19:11:31
```
--> Not OK (expected argument "ns_list" for Z11_DIFFERENT_SPF_POLICIES_FOUND, got "ns_ip_list" instead).

| Scenario name        | Mandatory message tags   | Forbidden message tags |
|:---------------------|:-------------------------|:-----------------------|
| MULTIPLE-SPF-RECORDS | Z11_SPF_MULTIPLE_RECORDS | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --raw --show-testcase --test zone11 --hints COMMON/hintfile --level info multiple-spf-records.zone11.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.08 ERROR    Zone11         Z11_SPF1_MULTIPLE_RECORDS  ns_ip_list=127.19.11.31;127.19.11.32;fda1:b2:c3:0:127:19:11:31;fda1:b2:c3:0:127:19:11:32
```
--> Not OK (expected argument "ns_list" for Z11_SPF1_MULTIPLE_RECORDS, got "ns_ip_list" instead).

