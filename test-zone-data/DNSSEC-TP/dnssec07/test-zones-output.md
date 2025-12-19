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

> **PLEASE NOTE:**
>
> The `zonemaster-cli` output in this section is from before the implementation
> of test DNSSEC07 has been updated. All message tags and the logic for utputting
> them are to be updated. This file has to updated when the implementation
> update is available.


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
   0.09 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns1.signed-and-ds-1.dnssec07.xa/127.15.7.41;ns1.signed-and-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41;ns2.signed-and-ds-1.dnssec07.xa/127.15.7.42;ns2.signed-and-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.09 INFO     DNSSEC07       DS07_SIGNED
   0.09 INFO     DNSSEC07       DS07_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
   0.09 INFO     DNSSEC07       DS07_DS_FOR_SIGNED_ZONE
```
--> OK

| Scenario name  | Mandatory tags                                                                              | Forbidden tags |
|:---------------|:--------------------------------------------------------------------------------------------|:---------------|
| SIGNED-NO-DS-1 | DS07_NO_DS_ON_PARENT_SERVER, DS07_NO_DS_FOR_SIGNED_ZONE, DS07_SIGNED, DS07_SIGNED_ON_SERVER | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw SIGNED-NO-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.07 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns1.signed-no-ds-1.dnssec07.xa/127.15.7.41;ns1.signed-no-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41;ns2.signed-no-ds-1.dnssec07.xa/127.15.7.42;ns2.signed-no-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.07 INFO     DNSSEC07       DS07_SIGNED
   0.07 WARNING  DNSSEC07       DS07_NO_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
   0.07 WARNING  DNSSEC07       DS07_NO_DS_FOR_SIGNED_ZONE
```
--> OK

| Scenario name             | Mandatory tags                                                                                       | Forbidden tags |
|:--------------------------|:-----------------------------------------------------------------------------------------------------|:---------------|
| INCONSIST-SIGNED-AND-DS-1 | DS07_DS_ON_PARENT_SERVER, DS07_INCONSISTENT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_SIGNED_ON_SERVER | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw INCONSIST-SIGNED-AND-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.08 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns1.inconsist-signed-and-ds-1.dnssec07.xa/127.15.7.41;ns1.inconsist-signed-and-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41
   0.08 WARNING  DNSSEC07       DS07_NOT_SIGNED_ON_SERVER  ns_list=ns2.inconsist-signed-and-ds-1.dnssec07.xa/127.15.7.42;ns2.inconsist-signed-and-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.08 ERROR    DNSSEC07       DS07_INCONSISTENT_SIGNED
   0.08 INFO     DNSSEC07       DS07_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
```
--> OK

| Scenario name            | Mandatory tags                                                                                          | Forbidden tags |
|:-------------------------|:--------------------------------------------------------------------------------------------------------|:---------------|
| INCONSIST-SIGNED-NO-DS-1 | DS07_INCONSISTENT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_NO_DS_ON_PARENT_SERVER, DS07_SIGNED_ON_SERVER | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw INCONSIST-SIGNED-NO-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.07 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns1.inconsist-signed-no-ds-1.dnssec07.xa/127.15.7.41;ns1.inconsist-signed-no-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41
   0.07 WARNING  DNSSEC07       DS07_NOT_SIGNED_ON_SERVER  ns_list=ns2.inconsist-signed-no-ds-1.dnssec07.xa/127.15.7.42;ns2.inconsist-signed-no-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.07 ERROR    DNSSEC07       DS07_INCONSISTENT_SIGNED
   0.07 WARNING  DNSSEC07       DS07_NO_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
```
--> OK

| Scenario name             | Mandatory tags                                                                                                  | Forbidden tags |
|:--------------------------|:----------------------------------------------------------------------------------------------------------------|:---------------|
| SIGNED-AND-INCONSIST-DS-1 | DS07_DS_ON_PARENT_SERVER, DS07_INCONSISTENT_DS, DS07_NO_DS_ON_PARENT_SERVER, DS07_SIGNED, DS07_SIGNED_ON_SERVER | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw child.signed-and-inconsist-ds-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.11 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns1.child.signed-and-inconsist-ds-1.dnssec07.xa/127.15.7.41;ns1.child.signed-and-inconsist-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41;ns2.child.signed-and-inconsist-ds-1.dnssec07.xa/127.15.7.42;ns2.child.signed-and-inconsist-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.11 INFO     DNSSEC07       DS07_SIGNED
   0.11 WARNING  DNSSEC07       DS07_NO_DS_ON_PARENT_SERVER  ns_list=ns2.signed-and-inconsist-ds-1.dnssec07.xa/127.15.7.32;ns2.signed-and-inconsist-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:32
   0.11 INFO     DNSSEC07       DS07_DS_ON_PARENT_SERVER  ns_list=ns1.signed-and-inconsist-ds-1.dnssec07.xa/127.15.7.31;ns1.signed-and-inconsist-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:31
   0.11 ERROR    DNSSEC07       DS07_INCONSISTENT_DS
```
--> OK

| Scenario name     | Mandatory tags                             | Forbidden tags |
|:------------------|:-------------------------------------------|:---------------|
| UNSIGNED-AND-DS-1 | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw UNSIGNED-AND-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.08 WARNING  DNSSEC07       DS07_NOT_SIGNED_ON_SERVER  ns_list=ns1.unsigned-and-ds-1.dnssec07.xa/127.15.7.41;ns1.unsigned-and-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41;ns2.unsigned-and-ds-1.dnssec07.xa/127.15.7.42;ns2.unsigned-and-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.08 WARNING  DNSSEC07       DS07_NOT_SIGNED
```
--> OK

| Scenario name    | Mandatory tags                             | Forbidden tags |
|:-----------------|:-------------------------------------------|:---------------|
| UNSIGNED-NO-DS-1 | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw UNSIGNED-NO-DS-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.08 WARNING  DNSSEC07       DS07_NOT_SIGNED_ON_SERVER  ns_list=ns1.unsigned-no-ds-1.dnssec07.xa/127.15.7.41;ns1.unsigned-no-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41;ns2.unsigned-no-ds-1.dnssec07.xa/127.15.7.42;ns2.unsigned-no-ds-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.08 WARNING  DNSSEC07       DS07_NOT_SIGNED
```
--> OK

| Scenario name              | Mandatory tags                                                                                                       | Forbidden tags |
|:---------------------------|:---------------------------------------------------------------------------------------------------------------------|:---------------|
| NON-AUTH-RESPONSE-DNSKEY-1 | DS07_NON_AUTH_RESPONSE_DNSKEY, DS07_SIGNED, DS07_SIGNED_ON_SERVER, DS07_DS_ON_PARENT_SERVER, DS07_DS_FOR_SIGNED_ZONE | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw NON-AUTH-RESPONSE-DNSKEY-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.08 WARNING  DNSSEC07       DS07_NON_AUTH_RESPONSE_DNSKEY  ns_list=ns1.non-auth-response-dnskey-1.dnssec07.xa/127.15.7.41;ns1.non-auth-response-dnskey-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41
   0.08 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns2.non-auth-response-dnskey-1.dnssec07.xa/127.15.7.42;ns2.non-auth-response-dnskey-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.08 INFO     DNSSEC07       DS07_SIGNED
   0.08 INFO     DNSSEC07       DS07_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
   0.08 INFO     DNSSEC07       DS07_DS_FOR_SIGNED_ZONE
```
--> OK

| Scenario name        | Mandatory tags                                                                                                 | Forbidden tags |
|:---------------------|:---------------------------------------------------------------------------------------------------------------|:---------------|
| NO-RESPONSE-DNSKEY-1 | DS07_SIGNED, DS07_SIGNED_ON_SERVER, DS07_NO_RESPONSE_DNSKEY, DS07_DS_ON_PARENT_SERVER, DS07_DS_FOR_SIGNED_ZONE | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw NO-RESPONSE-DNSKEY-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.09 WARNING  DNSSEC07       DS07_NO_RESPONSE_DNSKEY  ns_list=ns1.no-response-dnskey-1.dnssec07.xa/127.15.7.41;ns1.no-response-dnskey-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41
  20.09 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns2.no-response-dnskey-1.dnssec07.xa/127.15.7.42;ns2.no-response-dnskey-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
  20.09 INFO     DNSSEC07       DS07_SIGNED
  20.09 INFO     DNSSEC07       DS07_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
  20.09 INFO     DNSSEC07       DS07_DS_FOR_SIGNED_ZONE
```
--> OK

| Scenario name             | Mandatory tags                                                                                                      | Forbidden tags |
|:--------------------------|:--------------------------------------------------------------------------------------------------------------------|:---------------|
| UNEXP-RCODE-RESP-DNSKEY-1 | DS07_SIGNED, DS07_SIGNED_ON_SERVER, DS07_UNEXP_RCODE_RESP_DNSKEY, DS07_DS_ON_PARENT_SERVER, DS07_DS_FOR_SIGNED_ZONE | 2)             |
```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec07 --level=info --show-testcase --raw UNEXP-RCODE-RESP-DNSKEY-1.dnssec07.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.07 WARNING  DNSSEC07       DS07_UNEXP_RCODE_RESP_DNSKEY  ns_list=ns1.unexp-rcode-resp-dnskey-1.dnssec07.xa/127.15.7.41;ns1.unexp-rcode-resp-dnskey-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:41; rcode=REFUSED
   0.07 INFO     DNSSEC07       DS07_SIGNED_ON_SERVER  ns_list=ns2.unexp-rcode-resp-dnskey-1.dnssec07.xa/127.15.7.42;ns2.unexp-rcode-resp-dnskey-1.dnssec07.xa/fda1:b2:c3:0:127:15:7:42
   0.08 INFO     DNSSEC07       DS07_SIGNED
   0.08 INFO     DNSSEC07       DS07_DS_ON_PARENT_SERVER  ns_list=ns1.dnssec07.xa/127.15.7.21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:21;ns1.dnssec07.xa/fda1:b2:c3:0:127:15:7:22;ns2.dnssec07.xa/127.15.7.22
   0.08 INFO     DNSSEC07       DS07_DS_FOR_SIGNED_ZONE
```
--> OK
