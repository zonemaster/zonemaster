# DNSSEC01 Test scenario output

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

* DS01_DS_ALGO_2_MISSING
* DS01_DS_ALGO_DEPRECATED
* DS01_DS_ALGO_NOT_DS
* DS01_DS_ALGO_OK
* DS01_DS_ALGO_PRIVATE
* DS01_DS_ALGO_RESERVED
* DS01_DS_ALGO_UNASSIGNED
* DS01_NO_RESPONSE
* DS01_PARENT_SERVER_NO_DS
* DS01_PARENT_ZONE_NO_DS
* DS01_ROOT_N_NO_UNDEL_DS
* DS01_UNDEL_N_NO_UNDEL_DS


## All scenarios

| Scenario name         | Zone name                                |
|:----------------------|:-----------------------------------------|
| ALGO-DEPRECATED-1     | algo-deprecated-1.dnssec01.xa.           |
| ALGO-DEPRECATED-3     | algo-deprecated-3.dnssec01.xa.           |
| ALGO-RESERVED-128     | algo-reserved-128.dnssec01.xa.           |
| ALGO-RESERVED-188     | algo-reserved-188.dnssec01.xa.           |
| ALGO-RESERVED-252     | algo-reserved-252.dnssec01.xa.           |
| ALGO-UNASSIGNED-7     | algo-unassigned-7.dnssec01.xa.           |
| ALGO-UNASSIGNED-67    | algo-unassigned-67.dnssec01.xa.          |
| ALGO-UNASSIGNED-127   | algo-unassigned-127.dnssec01.xa.         |
| ALGO-PRIVATE-253      | algo-private-253.dnssec01.xa.            |
| ALGO-PRIVATE-254      | algo-private-254.dnssec01.xa.            |
| ALGO-NOT-DS-0         | algo-not-ds-0.dnssec01.xa.               |
| ALGO-OK-2             | algo-ok-2.dnssec01.xa.                   |
| ALGO-OK-4             | algo-ok-4.dnssec01.xa.                   |
| ALGO-OK-5             | algo-ok-5.dnssec01.xa.                   |
| ALGO-OK-6             | algo-ok-6.dnssec01.xa.                   |
| MIXED-ALGO-1          | mixed-algo-1.dnssec01.xa.                |
| SHARED-IP-1           | child.shared-ip-1.dnssec01.xa.           |
| SHARED-IP-2           | child.shared-ip-2.dnssec01.xa.           |
| NO-RESPONSE-1         | child.no-response-1.dnssec01.xa.         |
| NO-VALID-RESPONSE-1   | child.no-valid-response-1.dnssec01.xa.   |
| PARENT-SERVER-NO-DS-1 | child.parent-server-no-ds-1.dnssec01.xa. |
| PARENT-ZONE-NO-DS-1   | parent-zone-no-ds-1.dnssec01.xa.         |
| UNDEL-NO-UNDEL-DS-1   | undel-no-undel-ds-1.dnssec01.xa.         |
| UNDEL-WITH-UNDEL-DS-1 | undel-with-undel-ds-1.dnssec01.xa.       |
| ROOT-NO-UNDEL-DS-1    | .                                        |
| ROOT-WITH-UNDEL-DS-1  | .                                        |


## zonemaster-cli commands and their output for each test scenario

> **PLEASE NOTE:**
>
> The `zonemaster-cli` output in this section is from before the implementation
> of test DNSSEC01 has been updated. All message tags and the logic for utputting
> them are to be updated. This file has to updated when the implementation
> update is available.


All commands are run from the same directory as this file is in. To be meaningful
the `zonemaster-cli` command should be run with the following options:
```
--hints=hintfile.zone --test=dnssec01 --level=info
```

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-DEPRECATED-1     | DS01_DS_ALGO_DEPRECATED, DS01_DS_ALGO_2_MISSING                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-DEPRECATED-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.02 ERROR    DNSSEC01       DS01_DS_ALGO_DEPRECATED  domain=algo-deprecated-1.dnssec01.xa; ds_algo_mnemo=SHA-1; ds_algo_num=1; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-deprecated-1.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-DEPRECATED-3     | DS01_DS_ALGO_DEPRECATED, DS01_DS_ALGO_2_MISSING                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-DEPRECATED-3.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_DEPRECATED  domain=algo-deprecated-3.dnssec01.xa; ds_algo_mnemo=GOST R 34.11-94; ds_algo_num=3; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-deprecated-3.dnssec01.xa; ds_algo_mnemo=GOST R 34.11-94; ds_algo_num=3; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-deprecated-3.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-NOT-DS-0         | DS01_DS_ALGO_NOT_DS, DS01_DS_ALGO_2_MISSING                    | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-NOT-DS-0.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.02 ERROR    DNSSEC01       DS01_DS_ALGO_NOT_DS  domain=algo-not-ds-0.dnssec01.xa; ds_algo_mnemo=Reserved; ds_algo_num=0; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-not-ds-0.dnssec01.xa; ds_algo_mnemo=Reserved; ds_algo_num=0; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-not-ds-0.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-OK-2             | DS01_DS_ALGO_OK                                                | 2)             |


```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-OK-2.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-OK-4             | DS01_DS_ALGO_OK, DS01_DS_ALGO_2_MISSING                        | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-OK-4.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-ok-4.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-OK-5             | DS01_DS_ALGO_OK, DS01_DS_ALGO_2_MISSING                        | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-OK-5.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-ok-5.dnssec01.xa; ds_algo_num=5; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-ok-5.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=5; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-ok-5.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-OK-6             | DS01_DS_ALGO_OK, DS01_DS_ALGO_2_MISSING                        | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-OK-6.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.02 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-ok-6.dnssec01.xa; ds_algo_num=6; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-ok-6.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=6; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-ok-6.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-PRIVATE-253      | DS01_DS_ALGO_PRIVATE, DS01_DS_ALGO_2_MISSING                   | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-PRIVATE-253.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-private-253.dnssec01.xa; ds_algo_num=253; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-private-253.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=253; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-private-253.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-PRIVATE-254      | DS01_DS_ALGO_PRIVATE, DS01_DS_ALGO_2_MISSING                   | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-PRIVATE-254.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.02 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-private-254.dnssec01.xa; ds_algo_num=254; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-private-254.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=254; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-private-254.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-RESERVED-128     | DS01_DS_ALGO_RESERVED, DS01_DS_ALGO_2_MISSING                  | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-RESERVED-128.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-reserved-128.dnssec01.xa; ds_algo_num=128; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-reserved-128.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=128; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-reserved-128.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-RESERVED-188     | DS01_DS_ALGO_RESERVED, DS01_DS_ALGO_2_MISSING                  | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-RESERVED-188.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-reserved-188.dnssec01.xa; ds_algo_num=188; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-reserved-188.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=188; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-reserved-188.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-RESERVED-252     | DS01_DS_ALGO_RESERVED, DS01_DS_ALGO_2_MISSING                  | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-RESERVED-252.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.02 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-reserved-252.dnssec01.xa; ds_algo_num=252; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-reserved-252.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=252; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.02 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-reserved-252.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-UNASSIGNED-7     | DS01_DS_ALGO_UNASSIGNED, DS01_DS_ALGO_2_MISSING                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-UNASSIGNED-7.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-unassigned-7.dnssec01.xa; ds_algo_num=7; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-unassigned-7.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=7; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-unassigned-7.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-UNASSIGNED-67    | DS01_DS_ALGO_UNASSIGNED, DS01_DS_ALGO_2_MISSING                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-UNASSIGNED-67.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-unassigned-67.dnssec01.xa; ds_algo_num=67; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-unassigned-67.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=67; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-unassigned-67.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-UNASSIGNED-127   | DS01_DS_ALGO_UNASSIGNED, DS01_DS_ALGO_2_MISSING                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw ALGO-UNASSIGNED-127.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=algo-unassigned-127.dnssec01.xa; ds_algo_num=127; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=algo-unassigned-127.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=127; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DS_ALGO_2_MISSING  domain=algo-unassigned-127.dnssec01.xa
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| MIXED-ALGO-1          | DS01_DS_ALGO_DEPRECATED, DS01_DS_ALGO_PRIVATE, DS01_DS_ALGO_OK | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw MIXED-ALGO-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_RESERVED  domain=mixed-algo-1.dnssec01.xa; ds_algo_num=253; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 NOTICE   DNSSEC01       DS01_DIGEST_NOT_SUPPORTED_BY_ZM  domain=mixed-algo-1.dnssec01.xa; ds_algo_mnemo=Unassigned; ds_algo_num=253; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
   0.03 ERROR    DNSSEC01       DS01_DS_ALGO_DEPRECATED  domain=mixed-algo-1.dnssec01.xa; ds_algo_mnemo=SHA-1; ds_algo_num=1; keytag=42581; ns_ip_list=127.15.1.21;127.15.1.22;fda1:b2:c3:0:127:15:1:21;fda1:b2:c3:0:127:15:1:22
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| SHARED-IP-1           | DS01_DS_ALGO_OK                                                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw child.shared-ip-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| SHARED-IP-2           | DS01_DS_ALGO_OK                                                | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw child.shared-ip-2.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| NO-RESPONSE-1         | DS01_NO_RESPONSE                                               | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw child.no-response-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| NO-VALID-RESPONSE-1   | DS01_NO_RESPONSE                                               | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw child.no-valid-response-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| PARENT-SERVER-NO-DS-1 | DS01_PARENT_SERVER_NO_DS, DS01_DS_ALGO_OK                      | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw child.parent-server-no-ds-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| PARENT-ZONE-NO-DS-1   | DS01_PARENT_ZONE_NO_DS                                         | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec01 --level=info --show-testcase --raw PARENT-ZONE-NO-DS-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| UNDEL-NO-UNDEL-DS-1   | DS01_UNDEL_N_NO_UNDEL_DS                                       | 2)             |

* Undelegated data:
  * ns1.undel-no-undel-ds-1.dnssec01.xa/127.15.1.41
  * ns1.undel-no-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:41
  * ns2.undel-no-undel-ds-1.dnssec01.xa/127.15.1.42
  * ns2.undel-no-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:42

```
$ zonemaster-cli --show-testcase --level INFO --test dnssec01 --hints hintfile.zone --raw --ns=ns1.undel-no-undel-ds-1.dnssec01.xa/127.15.1.41 --ns=ns1.undel-no-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:41 --ns=ns2.undel-no-undel-ds-1.dnssec01.xa/127.15.1.42 --ns=ns2.undel-no-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:42 undel-no-undel-ds-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```


| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| UNDEL-WITH-UNDEL-DS-1 | DS01_DS_ALGO_OK                                                | 2)             |

* Undelegated data:
  * ns1.undel-with-undel-ds-1.dnssec01.xa/127.15.1.41
  * ns1.undel-with-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:41
  * ns2.undel-with-undel-ds-1.dnssec01.xa/127.15.1.42
  * ns2.undel-with-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:42

* Undelegated DS:
  * 42581,13,2,F28391C1ED4DC0F151EDD251A3103DCE0B9A5A251ACF6E24073771D71F3C40F9

```
$ zonemaster-cli --show-testcase --level INFO --test dnssec01 --hints hintfile.zone --raw --ns=ns1.undel-with-undel-ds-1.dnssec01.xa/127.15.1.41 --ns=ns1.undel-with-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:41 --ns=ns2.undel-with-undel-ds-1.dnssec01.xa/127.15.1.42 --ns=ns2.undel-with-undel-ds-1.dnssec01.xa/fda1:b2:c3:0:127:15:1:42 --ds=42581,13,2,F28391C1ED4DC0F151EDD251A3103DCE0B9A5A251ACF6E24073771D71F3C40F9 undel-with-undel-ds-1.dnssec01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ROOT-NO-UNDEL-DS-1    | DS01_ROOT_N_NO_UNDEL_DS                                        | 2)             |

```
$ zonemaster-cli --show-testcase --level INFO --test dnssec01 --hints hintfile.zone --raw .
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ROOT-WITH-UNDEL-DS-1  | DS01_DS_ALGO_OK                                                | 2)             |

* Undelegated DS:
  * 42581,13,2,F28391C1ED4DC0F151EDD251A3103DCE0B9A5A251ACF6E24073771D71F3C40F9

```
$ zonemaster-cli --show-testcase --level INFO --test dnssec01 --hints hintfile.zone --raw . --ds=42581,13,2,F28391C1ED4DC0F151EDD251A3103DCE0B9A5A251ACF6E24073771D71F3C40F9
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
