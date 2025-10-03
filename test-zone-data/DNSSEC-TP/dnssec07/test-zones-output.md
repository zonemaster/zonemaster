# DNSSEC07 Test scenario output

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

* DS07_DS_FOR_SIGNED_ZONE
* DS07_DS_ON_PARENT_SERVER
* DS07_INCONSISTENT_DS
* DS07_INCONSISTENT_SIGNED
* DS07_NON_AUTH_RESPONSE_DNSKEY
* DS07_NOT_SIGNED
* DS07_NOT_SIGNED_ON_SERVER
* DS07_NO_DS_ON_PARENT_SERVER
* DS07_NO_DS_FOR_SIGNED_ZONE
* DS07_NO_RESPONSE_DNSKEY
* DS07_SIGNED
* DS07_SIGNED_ON_SERVER
* DS07_UNEXP_RCODE_RESP_DNSKEY


## All scenarios

| Scenario name              | Zone name                                    |
|:---------------------------|:---------------------------------------------|
| SIGNED-AND-DS-1            | signed-and-ds-1.dnssec07.xa.                 |
| SIGNED-NO-DS-1             | signed-no-ds-1.dnssec07.xa.                  |
| INCONSIST-SIGNED-AND-DS-1  | inconsist-signed-and-ds-1.dnssec07.xa.       |
| INCONSIST-SIGNED-NO-DS-1   | inconsist-signed-no-ds-1.dnssec07.xa.        |
| SIGNED-AND-INCONSIST-DS-1  | child.signed-and-inconsist-ds-1.dnssec07.xa. |
| UNSIGNED-AND-DS-1          | unsigned-and-ds-1.dnssec07.xa.               |
| UNSIGNED-NO-DS-1           | unsigned-no-ds-1.dnssec07.xa.                |
| NON-AUTH-RESPONSE-DNSKEY-1 | non-auth-response-dnskey-1.dnssec07.xa.      |
| NO-RESPONSE-DNSKEY-1       | no-response-dnskey-1.dnssec07.xa.            |
| UNEXP-RCODE-RESP-DNSKEY-1  | unexp-rcode-resp-dnskey-1.dnssec07.xa.       |


## zonemaster-cli commands and their output for each test scenario

All commands are run from the same directory as this file is in. To be meaningful
the `zonemaster-cli` command should be run with the following options:
```
--hints=hintfile.zone --test=dnssec07 --level=info
```

| Scenario name   | Mandatory tags                                                                        | Forbidden tags |
|:----------------|:--------------------------------------------------------------------------------------|:---------------|
| SIGNED-AND-DS-1 | DS07_DS_FOR_SIGNED_ZONE, DS07_DS_ON_PARENT_SERVER, DS07_SIGNED, DS07_SIGNED_ON_SERVER | 2)             |

* (2) All tags except for those specified as "Mandatory tags"

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw SIGNED-AND-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??


| Scenario name  | Mandatory tags                                                                              | Forbidden tags |
|:---------------|:--------------------------------------------------------------------------------------------|:---------------|
| SIGNED-NO-DS-1 | DS07_NO_DS_ON_PARENT_SERVER, DS07_NO_DS_FOR_SIGNED_ZONE, DS07_SIGNED, DS07_SIGNED_ON_SERVER | 2)             |


```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw SIGNED-NO-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 WARNING  DNSSEC07       DNSKEY_BUT_NOT_DS  child=127.15.7.41; parent=127.15.7.21
```
--> ??


| Scenario name             | Mandatory tags                                                                                       | Forbidden tags |
|:--------------------------|:-----------------------------------------------------------------------------------------------------|:---------------|
| INCONSIST-SIGNED-AND-DS-1 | DS07_DS_ON_PARENT_SERVER, DS07_INCONSISTENT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_SIGNED_ON_SERVER | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw INCONSIST-SIGNED-AND-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??


| Scenario name            | Mandatory tags                                                                                          | Forbidden tags |
|:-------------------------|:--------------------------------------------------------------------------------------------------------|:---------------|
| INCONSIST-SIGNED-NO-DS-1 | DS07_INCONSISTENT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_NO_DS_ON_PARENT_SERVER, DS07_SIGNED_ON_SERVER | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw INCONSIST-SIGNED-NO-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 WARNING  DNSSEC07       DNSKEY_BUT_NOT_DS  child=127.15.7.41; parent=127.15.7.21
```
--> ??


| Scenario name             | Mandatory tags                                                                                                  | Forbidden tags |
|:--------------------------|:----------------------------------------------------------------------------------------------------------------|:---------------|
| SIGNED-AND-INCONSIST-DS-1 | DS07_DS_ON_PARENT_SERVER, DS07_INCONSISTENT_DS, DS07_NO_DS_ON_PARENT_SERVER, DS07_SIGNED, DS07_SIGNED_ON_SERVER | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw SIGNED-AND-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??


| Scenario name     | Mandatory tags                             | Forbidden tags |
|:------------------|:-------------------------------------------|:---------------|
| UNSIGNED-AND-DS-1 | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw UNSIGNED-AND-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC07       DS_BUT_NOT_DNSKEY  child=127.15.7.41; parent=127.15.7.21
```
--> ??


| Scenario name    | Mandatory tags                             | Forbidden tags |
|:-----------------|:-------------------------------------------|:---------------|
| UNSIGNED-NO-DS-1 | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw UNSIGNED-NO-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 NOTICE   DNSSEC07       NEITHER_DNSKEY_NOR_DS  child=127.15.7.41; parent=127.15.7.21
   0.03 NOTICE   Unspecified    NOT_SIGNED  zone=unsigned-no-ds-1.dnssec07.xa
```
--> ??


| Scenario name              | Mandatory tags                                                            | Forbidden tags |
|:---------------------------|:--------------------------------------------------------------------------|:---------------|
| NON-AUTH-RESPONSE-DNSKEY-1 | DS07_NON_AUTH_RESPONSE_DNSKEY, DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw NON-AUTH-RESPONSE-DNSKEY-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??


| Scenario name        | Mandatory tags                                                      | Forbidden tags |
|:---------------------|:--------------------------------------------------------------------|:---------------|
| NO-RESPONSE-DNSKEY-1 | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_NO_RESPONSE_DNSKEY | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw NO-RESPONSE-DNSKEY-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
```
--> ??


| Scenario name             | Mandatory tags                                                           | Forbidden tags |
|:--------------------------|:-------------------------------------------------------------------------|:---------------|
| UNEXP-RCODE-RESP-DNSKEY-1 | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_UNEXP_RCODE_RESP_DNSKEY | 2)             |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw UNEXP-RCODE-RESP-DNSKEY-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC07       DS_BUT_NOT_DNSKEY  child=127.15.7.41; parent=127.15.7.21
```
--> ??




