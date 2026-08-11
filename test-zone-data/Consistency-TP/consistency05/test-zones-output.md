# CONSISTENCY05 Test Zones Output

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

* CS05_CHILD_ZONE_LAME
* CS05_DELEGATION
* CS05_EXTRA_ADDR_CHILD
* CS05_ID_ADDR_MISMATCH
* CS05_ID_ADDR_MISSING
* CS05_INCONSISTENT_DELEGATION
* CS05_MISSING_GLUE_FOR_NS
* CS05_MISSING_GLUE_FOR_NS_UNDEL
* CS05_NO_MISMATCH_GLUE_ZONE
* CS05_NO_NS_ADDR_CHILD
* CS05_OOD_ADDR_MISMATCH


## All scenarios

| Scenario name             | Zone name                                        | Hint file | Undelegated |
|:--------------------------|:-------------------------------------------------|-----------|:------------|
| ADDR-MATCH-DEL-UNDEL-1    | addr-match-del-undel-1.consistency05.xa          |           | yes         |
| ADDR-MATCH-DEL-UNDEL-2    | addr-match-del-undel-2.consistency05.xa          |           | yes         |
| ADDR-MATCH-NO-DEL-UNDEL-1 | addr-match-no-del-undel-1.consistency05.xa       |           | yes         |
| ADDR-MATCH-NO-DEL-UNDEL-2 | addr-match-no-del-undel-2.consistency05.xa       |           | yes         |
| ADDRESSES-MATCH-1         | addresses-match-1.consistency05.xa               |           |             |
| ADDRESSES-MATCH-2         | addresses-match-2.consistency05.xa               |           |             |
| ADDRESSES-MATCH-3         | addresses-match-3.consistency05.xa               |           |             |
| ADDRESSES-MATCH-4         | addresses-match-4.consistency05.xa               |           |             |
| ADDRESSES-MATCH-5         | addresses-match-5.consistency05.xa               |           |             |
| ADDRESSES-MATCH-6         | child.addresses-match-6.consistency05.xa         |           |             |
| ADDRESSES-MATCH-7         | addresses-match-7.consistency05.xa               |           |             |
| ADDRESSES-MATCH-8         | child.a.b.addresses-match-8.consistency05.xa     |           |             |
| ADDRESSES-MATCH-9         | child.addresses-match-9.consistency05.xa         |           |             |
| CHILD-ZONE-LAME-1         | child-zone-lame-1.consistency05.xa               |           |             |
| CHILD-ZONE-LAME-2         | child-zone-lame-2.consistency05.xa               |           |             |
| CHILD-ZONE-LAME-3         | child-zone-lame-3.consistency05.xa               |           |             |
| EXTRA-ADDRESS-CHILD       | extra-address-child.consistency05.xa             |           |             |
| ID-ADDR-MISMATCH-1        | id-addr-mismatch-1.consistency05.xa              |           |             |
| ID-ADDR-MISSING-1         | id-addr-missing-1.consistency05.xa               |           |             |
| ID-ADDR-MISSING-2         | id-addr-missing-2.consistency05.xa               |           |             |
| INCONSISTENT-DELEGATION-1 | child.inconsistent-delegation-1.consistency05.xa |           |             |
| INCONSISTENT-DELEGATION-2 | child.inconsistent-delegation-2.consistency05.xa |           |             |
| MISSING-GLUE-FOR-NS-1     | child.missing-glue-for-ns-1.consistency05.xa     |           |             |
| MISSING-GLUE-FOR-NS-2     | missing-glue-for-ns-2.consistency05.xa           |           | yes         |
| NO-NS-ADDR-CHILD-1        | child.no-ns-addr-child-1.consistency05.xa        |           |             |
| NO-NS-ADDR-CHILD-2        | child.no-ns-addr-child-2.consistency05.xa        |           |             |
| OOD-ADDR-MISMATCH         | child.ood-addr-mismatch.consistency05.xa         |           |             |
| ROOT-MATCH-1              | . (root)                                         |           |             |
| ROOT-MISSING-GLUE-UNDEL-1 | . (root)                                         |           | yes         |
| Z-ROOT-MATCH-1            | . (root)                                         | 1)        | yes         |
| Z-ROOT-INCOMPLETE-HINT    | . (root)                                         | 2)        |             |

Default hintfile, `Consistency-TP/consistency05/hintfile.zone`, is used for all scenarios
unless another hintfile is specified:

1. `Consistency-TP/consistency05/Z-ROOT-MATCH-1-hintfile.zone`
2. `Consistency-TP/consistency05/Z-ROOT-INCOMPLETE-HINT-hintfile.zone`

If `yes` in column `Undelegated` the undelegated data is used for the scenario.


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags for the
test case. For this test case `INFO` is the lowest level. It is only meaningful
to test the test zones with `--test Consistency05`.

The commands below are assumed to be run from the
`test-zone-data/Consistency-TP/consistency05` directory, i.e. the same directory
as this file resides in.

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDR-MATCH-DEL-UNDEL-1    | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addr-match-del-undel-1.consistency05.xa --ns ns3.addr-match-del-undel-1.consistency05.xa/127.14.5.33 --ns ns3.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:33 --ns ns4.addr-match-del-undel-1.consistency05.xa/127.14.5.34 --ns ns4.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:34 zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addr-match-del-undel-1.consistency05.xa --ns ns3.addr-match-del-undel-1.consistency05.xa/127.14.5.33 --ns ns3.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:33 --ns ns4.addr-match-del-undel-1.consistency05.xa/127.14.5.34 --ns ns4.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:34
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.04 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
* Undelegated data:
  * ns3.addr-match-del-undel-1.consistency05.xa/127.14.5.33
  * ns3.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:33
  * ns4.addr-match-del-undel-1.consistency05.xa/127.14.5.34
  * ns4.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:34

--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDR-MATCH-DEL-UNDEL-2    | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addr-match-del-undel-2.consistency05.xa --ns ns3.addr-match-del-undel-2.consistency05.xb --ns ns4.addr-match-del-undel-2.consistency05.xb zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addr-match-del-undel-2.consistency05.xa --ns ns3.addr-match-del-undel-2.consistency05.xb --ns ns4.addr-match-del-undel-2.consistency05.xb
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.01 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
* Undelegated data:
  * ns3.addr-match-del-undel-2.consistency05.xb
  * ns4.addr-match-del-undel-2.consistency05.xb

--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDR-MATCH-NO-DEL-UNDEL-1 | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addr-match-no-del-undel-1.consistency05.xa --ns ns1.addr-match-no-del-undel-1.consistency05.xa/127.14.5.31 --ns ns1.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31 --ns ns2.addr-match-no-del-undel-1.consistency05.xa/127.14.5.32 --ns ns2.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32 zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addr-match-no-del-undel-1.consistency05.xa --ns ns1.addr-match-no-del-undel-1.consistency05.xa/127.14.5.31 --ns ns1.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31 --ns ns2.addr-match-no-del-undel-1.consistency05.xa/127.14.5.32 --ns ns2.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.04 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
* Undelegated data:
  * ns1.addr-match-no-del-undel-1.consistency05.xa/127.14.5.31
  * ns1.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  * ns2.addr-match-no-del-undel-1.consistency05.xa/127.14.5.32
  * ns2.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32

--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDR-MATCH-NO-DEL-UNDEL-2 | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addr-match-no-del-undel-2.consistency05.xa --ns ns3.addr-match-no-del-undel-2.consistency05.xb --ns ns4.addr-match-no-del-undel-2.consistency05.xb zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addr-match-no-del-undel-2.consistency05.xa --ns ns3.addr-match-no-del-undel-2.consistency05.xb --ns ns4.addr-match-no-del-undel-2.consistency05.xb
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.01 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
* Undelegated data:
  * ns3.addr-match-no-del-undel-2.consistency05.xb
  * ns4.addr-match-no-del-undel-2.consistency05.xb

--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-1         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addresses-match-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addresses-match-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.11 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-2         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addresses-match-2.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addresses-match-2.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-3         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addresses-match-3.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addresses-match-3.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.08 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-4         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addresses-match-4.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addresses-match-4.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.09 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-5         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addresses-match-5.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addresses-match-5.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
 100.24 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-6         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.addresses-match-6.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.addresses-match-6.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.09 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-7         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info addresses-match-7.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info addresses-match-7.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.12 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-8         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.a.b.addresses-match-8.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.a.b.addresses-match-8.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.16 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDRESSES-MATCH-9         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.addresses-match-9.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.addresses-match-9.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.15 INFO     CS05_NO_MISMATCH_GLUE_ZONE  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| CHILD-ZONE-LAME-1         | CS05_CHILD_ZONE_LAME                            | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child-zone-lame-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child-zone-lame-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
  40.08 CRITICAL CS05_CHILD_ZONE_LAME  ns_list=ns1.child-zone-lame-1.consistency05.xa/127.14.5.31;ns1.child-zone-lame-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns2.child-zone-lame-1.consistency05.xa/127.14.5.32;ns2.child-zone-lame-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| CHILD-ZONE-LAME-2         | CS05_CHILD_ZONE_LAME                            | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child-zone-lame-2.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child-zone-lame-2.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.04 CRITICAL CS05_CHILD_ZONE_LAME  ns_list=ns1.child-zone-lame-2.consistency05.xa/127.14.5.31;ns1.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns2.child-zone-lame-2.consistency05.xa/127.14.5.32;ns2.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| CHILD-ZONE-LAME-3         | CS05_CHILD_ZONE_LAME                            | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child-zone-lame-3.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child-zone-lame-3.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.06 CRITICAL CS05_CHILD_ZONE_LAME  ns_list=ns1.child-zone-lame-3.consistency05.xa/127.14.5.31;ns1.child-zone-lame-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns2.child-zone-lame-3.consistency05.xa/127.14.5.32;ns2.child-zone-lame-3.consistency05.xa/fda1:b2:c3:0:127:14:5:32
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| EXTRA-ADDRESS-CHILD       | CS05_EXTRA_ADDR_CHILD                           | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info extra-address-child.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info extra-address-child.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.09 NOTICE   CS05_EXTRA_ADDR_CHILD  ns_list=127.14.5.35;fda1:b2:c3:0:127:14:5:35
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ID-ADDR-MISMATCH-1        | CS05_ID_ADDR_MISMATCH                           | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info id-addr-mismatch-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info id-addr-mismatch-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.08 ERROR    CS05_ID_ADDR_MISMATCH  ns_ip_list_glue=127.14.5.39;fda1:b2:c3:0:127:14:5:39; ns_ip_list_zone=127.14.5.32;fda1:b2:c3:0:127:14:5:32; nsname="ns2.id-addr-mismatch-1.consistency05.xa"
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ID-ADDR-MISSING-1         | CS05_ID_ADDR_MISSING                            | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info id-addr-missing-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info id-addr-missing-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.09 NOTICE   CS05_ID_ADDR_MISSING  nsname="ns1.id-addr-missing-1.consistency05.xa"
   0.09 NOTICE   CS05_ID_ADDR_MISSING  nsname="ns2.id-addr-missing-1.consistency05.xa"
```
--> OK

| Scenario name     | Mandatory message tag | Forbidden message tags |
|:------------------|:----------------------|:-----------------------|
| ID-ADDR-MISSING-2 | CS05_ID_ADDR_MISSING  | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info id-addr-missing-2.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info id-addr-missing-2.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
 100.20 NOTICE   CS05_ID_ADDR_MISSING  nsname="ns2.id-addr-missing-2.consistency05.xa"
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| INCONSISTENT-DELEGATION-1 | CS05_INCONSISTENT_DELEGATION, CS05_DELEGATION   | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.inconsistent-delegation-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.inconsistent-delegation-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.11 WARNING  CS05_INCONSISTENT_DELEGATION  
   0.11 INFO     CS05_DELEGATION  ns_deleg_list=ns41.child.inconsistent-delegation-1.consistency05.xa/127.14.5.41;ns41.child.inconsistent-delegation-1.consistency05.xa/fda1:b2:c3:0:127:14:5:41;ns42.child.inconsistent-delegation-1.consistency05.xa/127.14.5.42;ns42.child.inconsistent-delegation-1.consistency05.xa/fda1:b2:c3:0:127:14:5:42; ns_list=ns1.inconsistent-delegation-1.consistency05.xa/127.14.5.31;ns1.inconsistent-delegation-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.11 INFO     CS05_DELEGATION  ns_deleg_list=ns41.child.inconsistent-delegation-1.consistency05.xa/127.14.5.41;ns41.child.inconsistent-delegation-1.consistency05.xa/fda1:b2:c3:0:127:14:5:41;ns43.child.inconsistent-delegation-1.consistency05.xa/127.14.5.43;ns43.child.inconsistent-delegation-1.consistency05.xa/fda1:b2:c3:0:127:14:5:43; ns_list=ns2.inconsistent-delegation-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32;ns2.inconsistent-delegation-1.consistency05.xa/127.14.5.32
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| INCONSISTENT-DELEGATION-2 | CS05_INCONSISTENT_DELEGATION, CS05_DELEGATION   | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.inconsistent-delegation-2.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.inconsistent-delegation-2.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.08 WARNING  CS05_INCONSISTENT_DELEGATION  
   0.08 INFO     CS05_DELEGATION  ns_deleg_list=ns41.inconsistent-delegation-2.consistency05.xb;ns42.inconsistent-delegation-2.consistency05.xb; ns_list=ns1.inconsistent-delegation-2.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns1.inconsistent-delegation-2.consistency05.xa/127.14.5.31
   0.08 INFO     CS05_DELEGATION  ns_deleg_list=ns41.inconsistent-delegation-2.consistency05.xb;ns43.inconsistent-delegation-2.consistency05.xb; ns_list=ns2.inconsistent-delegation-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32;ns2.inconsistent-delegation-2.consistency05.xa/127.14.5.32
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| MISSING-GLUE-FOR-NS-1     | CS05_MISSING_GLUE_FOR_NS                        | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.missing-glue-for-ns-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.missing-glue-for-ns-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.09 WARNING  CS05_MISSING_GLUE_FOR_NS  ns_list=ns1.missing-glue-for-ns-1.consistency05.xa/127.14.5.31;ns1.missing-glue-for-ns-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns2.missing-glue-for-ns-1.consistency05.xa/127.14.5.32;ns2.missing-glue-for-ns-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32; nsname=ns41.child.missing-glue-for-ns-1.consistency05.xa
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| MISSING-GLUE-FOR-NS-2     | CS05_MISSING_GLUE_FOR_NS_UNDEL                  | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info missing-glue-for-ns-2.consistency05.xa --ns ns1.missing-glue-for-ns-2.consistency05.xa --ns ns1.missing-glue-for-ns-2.consistency05.xa --ns ns2.missing-glue-for-ns-2.consistency05.xa/127.14.5.32 --ns ns2.missing-glue-for-ns-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32 zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info missing-glue-for-ns-2.consistency05.xa --ns ns1.missing-glue-for-ns-2.consistency05.xa --ns ns1.missing-glue-for-ns-2.consistency05.xa --ns ns2.missing-glue-for-ns-2.consistency05.xa/127.14.5.32 --ns ns2.missing-glue-for-ns-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32
   0.21 ERROR    FAKE_DELEGATION_NO_IP  domain=missing-glue-for-ns-2.consistency05.xa; nsname=ns1.missing-glue-for-ns-2.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.03 WARNING  CS05_MISSING_GLUE_FOR_NS_UNDEL  nsname="ns1.missing-glue-for-ns-2.consistency05.xa"
```
* Undelegated data:
  * ns1.missing-glue-for-ns-2.consistency05.xa
  * ns1.missing-glue-for-ns-2.consistency05.xa
  * ns2.missing-glue-for-ns-2.consistency05.xa/127.14.5.32
  * ns2.missing-glue-for-ns-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32

--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| NO-NS-ADDR-CHILD-1        | CS05_NO_NS_ADDR_CHILD, CS05_MISSING_GLUE_FOR_NS | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.no-ns-addr-child-1.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.no-ns-addr-child-1.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.05 WARNING  CS05_MISSING_GLUE_FOR_NS  ns_list=ns1.no-ns-addr-child-1.consistency05.xa/127.14.5.31;ns1.no-ns-addr-child-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns2.no-ns-addr-child-1.consistency05.xa/127.14.5.32;ns2.no-ns-addr-child-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32; nsname=ns1.child.no-ns-addr-child-1.consistency05.xa
   0.05 WARNING  CS05_MISSING_GLUE_FOR_NS  ns_list=ns1.no-ns-addr-child-1.consistency05.xa/127.14.5.31;ns1.no-ns-addr-child-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31;ns2.no-ns-addr-child-1.consistency05.xa/127.14.5.32;ns2.no-ns-addr-child-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32; nsname=ns2.child.no-ns-addr-child-1.consistency05.xa
   0.05 CRITICAL CS05_NO_NS_ADDR_CHILD  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| NO-NS-ADDR-CHILD-2        | CS05_NO_NS_ADDR_CHILD                           | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.no-ns-addr-child-2.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.no-ns-addr-child-2.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.06 CRITICAL CS05_NO_NS_ADDR_CHILD  
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| OOD-ADDR-MISMATCH         | CS05_OOD_ADDR_MISMATCH                          | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info child.ood-addr-mismatch.consistency05.xa zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info child.ood-addr-mismatch.consistency05.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.09 WARNING  CS05_OOD_ADDR_MISMATCH  ns_ip_list_lookup=3;3; ns_ip_list_ref=3;3; nsname="ns1.sibbling.ood-addr-mismatch.consistency05.xa"
```
--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ROOT-MATCH-1              | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info .
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.03 ERROR    CS05_ID_ADDR_MISMATCH  ns_ip_list_glue=fda1:b2:c3:0:127:14:5:62; ns_ip_list_zone=127.14.5.62; nsname="ns2"
```
--> Not OK

| Scenario name             | Mandatory message tag         | Forbidden message tags |
|:--------------------------|:------------------------------|:-----------------------|
| ROOT-MISSING-GLUE-UNDEL-1 | CS05_MISSING_GLUE_FOR_ROOT_NS | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints hintfile.zone --level info . --ns ns1 --ns ns1 --ns ns2/127.14.5.66 --ns ns2/fda1:b2:c3:0:127:14:5:66
   0.21 ERROR    FAKE_DELEGATION_NO_IP  domain=.; nsname=ns1
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.02 WARNING  CS05_MISSING_GLUE_FOR_ROOT_NS  nsname="ns1"
```
* Undelegated data:
  * ns1
  * ns2/127.14.5.66
  * ns2/fda1:b2:c3:0:127:14:5:66

--> OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| Z-ROOT-MATCH-1            | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints Z-ROOT-MATCH-1-hintfile.zone --level info . --ns ns1/127.14.5.61 --ns ns1/fda1:b2:c3:0:127:14:5:61 --ns ns2/127.14.5.62 --ns ns2/fda1:b2:c3:0:127:14:5:62
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.03 ERROR    CS05_ID_ADDR_MISMATCH  ns_ip_list_glue=fda1:b2:c3:0:127:14:5:62; ns_ip_list_zone=127.14.5.62; nsname="ns2"
```
* Undelegated data:
  * ns1/127.14.5.61
  * ns1/fda1:b2:c3:0:127:14:5:61
  * ns2/127.14.5.62
  * ns2/fda1:b2:c3:0:127:14:5:62

--> Not OK

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| Z-ROOT-INCOMPLETE-HINT    | CS05_MISSING_GLUE_FOR_NS                        | 2)                     |
```
$ zonemaster-cli --raw  --test consistency05 --hints Z-ROOT-INCOMPLETE-HINT-hintfile.zone --level info . zonemaster-cli --raw --test consistency05 --hints hintfile.zone --level info .

Error loading hints file: No address record found for NS ns1
```
--> Not OK
