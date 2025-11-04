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
* A01_ADDR_GLOBALLY_REACHABLE
* A01_DOCUMENTATION_ADDR
* A01_LOCAL_USE_ADDR
* A01_NO_GLOBALLY_REACHABLE_ADDR
* A01_NO_NAME_SERVERS_FOUND       

## All scenarios

| Scenario name        | Zone name                             |
|:---------------------|:--------------------------------------|
| ALL-NON-REACHABLE    | all-non-reachable.address01.xa        | 
| GOOD-1               | good-1.address01.xa                   | 
| MIXED-LOCAL-DOC-1    | mixed-local-doc-1.address01.xa        | 
| MIXED-LOCAL-DOC-2    | mixed-local-doc-2.address01.xa        | 
| MIXED-LOCAL-OTHER-1  | mixed-doc-other-1.address01.xa        | 
| MIXED-LOCAL-OTHER-2  | mixed-doc-other-2.address01.xa        | 
| MIXED-DOC-OTHER-1    | mixed-local-other-1.address01.xa      | 
| MIXED-DOC-OTHER-2    | mixed-local-other-2.address01.xa      | 
| MIXED-ALL-1          | mixed-all-1.address01.xa              | 
| MIXED-ALL-2          | mixed-all-2.address01.xa              | 
| NO-NAME-SERVERS      | no-name-servers.address01.xa          | 


## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with
`--level=info --test=address01`. All commands are run from the same directory as
this file is in.

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| GOOD-1                | A01_ADDR_GLOBALLY_REACHABLE                                                   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw good-1.address01.xa

```
--> OK

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-DOC-1     | A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR                                    | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-doc-1.address01.xa

```
--> OK

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-DOC-2     | A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR                                    | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-doc-2.address01.xa

```
--> OK

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-OTHER-1   | A01_LOCAL_USE_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                           | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-other-1.address01.xa

```
--> OK

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-LOCAL-OTHER-2   | A01_LOCAL_USE_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                           | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-local-other-2.address01.xa

```
--> OK

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-DOC-OTHER-1     | A01_DOCUMENTATION_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                       | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-doc-other-1.address01.xa

```
--> OK

| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-DOC-OTHER-2     | A01_DOCUMENTATION_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                       | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-doc-other-2.address01.xa

```
--> OK


| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-ALL-1           | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_DOCUMENTATION_ADDR, A01_LOCAL_USE_ADDR   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-all-1.address01.xa

```
--> OK


| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| MIXED-ALL-2           | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_DOCUMENTATION_ADDR, A01_LOCAL_USE_ADDR   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw mixed-all-2.address01.xa

```
--> OK


| Scenario name         | Mandatory message tag                                                         | Forbidden message tags |
|:----------------------|:------------------------------------------------------------------------------|:-----------------------|
| NO-NAME-SERVERS       | A01_NO_NAME_SERVERS_FOUND   | 2)                     |

* (2) All tags except for those specified as “Mandatory message tags”

```
$ zonemaster-cli --show-testcase --level INFO --test address01 --hints ../../COMMON/hintfile --raw all-non-reachable.address01.xa

```
--> OK






