# Address01 Test Zones Output

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

* A01_ADDR_NOT_GLOBALLY_REACHABLE
* A01_DOCUMENTATION_ADDR
* A01_GLOBALLY_REACHABLE_ADDR
* A01_LOCAL_USE_ADDR
* A01_NO_GLOBALLY_REACHABLE_ADDR
* A01_NO_NAME_SERVERS_FOUND

## All scenarios

| Scenario name        | Zone name                             |
|:---------------------|:--------------------------------------|
| GOOD-1               | good-1.address01.xa                   | 
| MIXED-LOCAL-DOC-1    | mixed-local-doc-1.address01.xa        | 
| MIXED-LOCAL-DOC-2    | mixed-local-doc-2.address01.xa        | 
| MIXED-LOCAL-OTHER-1  | mixed-doc-other-1.address01.xa        | 
| MIXED-LOCAL-OTHER-2  | mixed-doc-other-2.address01.xa        | 
| MIXED-DOC-OTHER-1    | mixed-local-other-1.address01.xa      | 
| MIXED-DOC-OTHER-2    | mixed-local-other-2.address01.xa      | 
| MIXED-ALL-1          | mixed-all-1.address01.xa              | 
| MIXED-ALL-2          | mixed-all-2.address01.xa              | 
| ALL-NON-REACHABLE    | all-non-reachable.address01.xa        | 
| NO-NAME-SERVERS      | no-name-servers.address01.xa          | 


## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with
`--level=info --test=address01`. All commands are run from the same directory as
this file is in.

| Scenario name | Mandatory message tag       | Forbidden message tags |
|:--------------|:----------------------------|:-----------------------|
| GOOD-1        | A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw good-1.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 CRITICAL Address01      A01_NO_NAME_SERVERS_FOUND  
   0.03 INFO     Address01      A01_GLOBALLY_REACHABLE_ADDR  
```
--> Not OK, *A01_NO_NAME_SERVERS_FOUND* unexpected.

| Scenario name     | Mandatory message tag                                                   | Forbidden message tags |
|:------------------|:------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-DOC-1 | A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-doc-1.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.08 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns2.mixed-local-doc-1.address01.xa/2001:db8::127:11:1:32
  20.08 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns1.mixed-local-doc-1.address01.xa/192.168.11.31
```
--> ??

| Scenario name     | Mandatory message tag                                                   | Forbidden message tags |
|:------------------|:------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-DOC-2 | A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-doc-2.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.08 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns1.mixed-local-doc-2.address01.xa/192.0.2.31
  20.08 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns2.mixed-local-doc-2.address01.xa/fc00::127:11:1:32
```
--> ??

| Scenario name       | Mandatory message tag                                                            | Forbidden message tags |
|:--------------------|:---------------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-OTHER-1 | A01_LOCAL_USE_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-other-1.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.07 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns1.mixed-local-other-1.address01.xa/169.254.0.31
  20.07 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns2.mixed-local-other-1.address01.xa/2001:2::127:11:1:32
```
--> ??

| Scenario name       | Mandatory message tag                                                            | Forbidden message tags |
|:--------------------|:---------------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-OTHER-2 | A01_LOCAL_USE_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-other-2.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.07 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns2.mixed-local-other-2.address01.xa/fc00::127:11:1:32
  20.07 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns1.mixed-local-other-2.address01.xa/198.18.0.31
```
--> ??

| Scenario name     | Mandatory message tag                                                                | Forbidden message tags |
|:------------------|:-------------------------------------------------------------------------------------|:-----------------------|
| MIXED-DOC-OTHER-1 | A01_DOCUMENTATION_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-doc-other-1.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.08 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns1.mixed-doc-other-1.address01.xa/198.51.100.31
  20.08 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns2.mixed-doc-other-1.address01.xa/64:ff9b:1:0:127:11:1:32
```
--> ??

| Scenario name     | Mandatory message tag                                                                | Forbidden message tags |
|:------------------|:-------------------------------------------------------------------------------------|:-----------------------|
| MIXED-DOC-OTHER-2 | A01_DOCUMENTATION_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-doc-other-2.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.07 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns2.mixed-doc-other-2.address01.xa/3fff::127:11:1:32
  20.07 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns1.mixed-doc-other-2.address01.xa/240.0.0.31
```
--> ??


| Scenario name | Mandatory message tag                                                                                    | Forbidden message tags |
|:--------------|:---------------------------------------------------------------------------------------------------------|:-----------------------|
| MIXED-ALL-1   | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_DOCUMENTATION_ADDR, A01_LOCAL_USE_ADDR, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-all-1.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  30.08 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns2.mixed-all-1.address01.xa/203.0.113.32
  30.08 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns1.mixed-all-1.address01.xa/172.16.0.31
  30.08 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns2.mixed-all-1.address01.xa/2002::127:11:1:32
```
--> ??


| Scenario name | Mandatory message tag                                                                                    | Forbidden message tags |
|:--------------|:---------------------------------------------------------------------------------------------------------|:-----------------------|
| MIXED-ALL-2   | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_DOCUMENTATION_ADDR, A01_LOCAL_USE_ADDR, A01_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-all-2.address01.xa 
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  30.08 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns2.mixed-all-2.address01.xa/2001:db8::127:11:1:32
  30.08 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns1.mixed-all-2.address01.xa/fe80::127:11:1:31
  30.08 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns1.mixed-all-2.address01.xa/198.18.0.31
```
--> ??

| Scenario name     | Mandatory message tag                                                                                       | Forbidden message tags |
|:------------------|:------------------------------------------------------------------------------------------------------------|:-----------------------|
| ALL-NON-REACHABLE | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR, A01_NO_GLOBALLY_REACHABLE_ADDR | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw all-non-reachable.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  60.12 ERROR    Address01      A01_DOCUMENTATION_ADDR  ns_list=ns2.all-non-reachable.address01.xa/203.0.113.32;ns3.all-non-reachable.address01.xa/3fff::127:11:1:33
  60.12 ERROR    Address01      A01_LOCAL_USE_ADDR  ns_list=ns1.all-non-reachable.address01.xa/10.0.0.31;ns2.all-non-reachable.address01.xa/fc00::127:11:1:32
  60.12 ERROR    Address01      A01_ADDR_NOT_GLOBALLY_REACHABLE  ns_list=ns1.all-non-reachable.address01.xa/2001:2::127:11:1:31;ns3.all-non-reachable.address01.xa/192.0.0.33
```
--> ??


| Scenario name   | Mandatory message tag     | Forbidden message tags |
|:----------------|:--------------------------|:-----------------------|
| NO_NAME_SERVERS | A01_NO_NAME_SERVERS_FOUND | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw no-name-servers.address01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 CRITICAL Address01      A01_NO_NAME_SERVERS_FOUND  
   0.04 INFO     Address01      A01_GLOBALLY_REACHABLE_ADDR  
```
--> Not OK, *A01_GLOBALLY_REACHABLE_ADDR* unexpected.
