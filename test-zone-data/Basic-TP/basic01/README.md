# Basic01

[This directory](.), i.e. the same directory as this README file, holds
zone files and `coredns` configuration files for scenarios for test case Basic01.

## All message tags

* B01_CHILD_FOUND
* B01_CHILD_IS_ALIAS
* B01_INCONSISTENT_ALIAS
* B01_INCONSISTENT_DELEGATION
* B01_NO_CHILD
* B01_PARENT_DISREGARDED
* B01_PARENT_FOUND
* B01_PARENT_NOT_FOUND
* B01_PARENT_UNDETERMINED
* B01_ROOT_HAS_NO_PARENT
* B01_SERVER_ZONE_ERROR

## All scenarios

Scenario name             | Zone name
:-------------------------|:---------------------------------------------
GOOD-1                    | child.parent.good-1.basic01.xa
GOOD-MIXED-1              | child.parent.good-mixed-1.basic01.xa
GOOD-MIXED-2              | child.parent.good-mixed-2.basic01.xa
GOOD-PARENT-HOST-1        | child.parent.good-parent-host-1.basic01.xa
GOOD-GRANDPARENT-HOST-1   | child.parent.good-grandparent-host-1.basic01.xa
GOOD-UNDEL-1              | child.parent.good-undel-1.basic01.xa
GOOD-MIXED-UNDEL-1        | child.parent.good-mixed-undel-1.basic01.xa
GOOD-MIXED-UNDEL-2        | child.parent.good-mixed-undel-2.basic01.xa
NO-DEL-UNDEL-1            | child.parent.no-del-undel-1.basic01.xa
NO-DEL-MIXED-UNDEL-1      | child.parent.no-del-mixed-undel-1.basic01.xa
NO-DEL-MIXED-UNDEL-2      | child.parent.no-del-mixed-undel-2.basic01.xa
NO-CHILD-1                | child.parent.no-child-1.basic01.xa
NO-CHILD-2                | child.parent.no-child-2.basic01.xa
NO-CHLD-PAR-UNDETER-1     | child.parent.no-chld-par-undeter-1.basic01.xa
CHLD-FOUND-PAR-UNDET-1    | child.parent.chld-found-par-undet-1.basic01.xa
CHLD-FOUND-INCONSIST-1    | child.parent.chld-found-inconsist-1.basic01.xa
CHLD-FOUND-INCONSIST-2    | child.parent.chld-found-inconsist-2.basic01.xa
CHLD-FOUND-INCONSIST-3    | child.parent.chld-found-inconsist-3.basic01.xa
CHLD-FOUND-INCONSIST-4    | child.parent.chld-found-inconsist-4.basic01.xa
CHLD-FOUND-INCONSIST-5    | child.parent.chld-found-inconsist-5.basic01.xa
CHLD-FOUND-INCONSIST-6    | child.parent.chld-found-inconsist-6.basic01.xa
CHLD-FOUND-INCONSIST-7    | child.parent.chld-found-inconsist-7.basic01.xa
CHLD-FOUND-INCONSIST-8    | child.parent.chld-found-inconsist-8.basic01.xa
CHLD-FOUND-INCONSIST-9    | child.parent.chld-found-inconsist-9.basic01.xa
CHLD-FOUND-INCONSIST-10   | child.parent.chld-found-inconsist-10.basic01.xa
NO-DEL-UNDEL-NO-PAR-1     | child.parent.no-del-undel-no-par-1.basic01.xa
NO-DEL-UNDEL-PAR-UND-1    | child.parent.no-del-undel-par-und-1.basic01.xa
NO-CHLD-NO-PAR-1          | child.parent.no-chld-no-par-1.basic01.xa
CHILD-ALIAS-1             | child.parent.child-alias-1.basic01.xa
CHILD-ALIAS-2             | child.parent.child-alias-2.basic01.xa
ZONE-ERR-GRANDPARENT-1    | child.parent.zone-err-grandparent-1.basic01.xa
ZONE-ERR-GRANDPARENT-2    | child.parent.zone-err-grandparent-2.basic01.xa
ZONE-ERR-GRANDPARENT-3    | child.parent.zone-err-grandparent-3.basic01.xa


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `DEBUG` is the lowest level. `--level DEBUG` gives too much extra
so it is better to create a profile where `B01_SERVER_ZONE_ERROR` is raised from
`DEBUG` to `INFO`. It is only meaningful to test the test zones with
`--test Basic01`.

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-1                    | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw --show-testcase --test basic01 --hints COMMON/hintfile --level info child.parent.good-1.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.13 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-1.basic01.xa; ns_list=ns1.parent.good-1.basic01.xa/127.12.1.41;ns1.parent.good-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-1.basic01.xa/127.12.1.42;ns2.parent.good-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.13 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-1.basic01.xa
```
--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-1              | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info child.parent.good-mixed-1.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.17 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-mixed-1.basic01.xa; ns_list=ns1.parent.good-mixed-1.basic01.xa/127.12.1.41;ns1.parent.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-mixed-1.basic01.xa/127.12.1.42;ns2.parent.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:42;ns4.good-mixed-1.basic01.xa/127.12.1.34;ns4.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.17 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-mixed-1.basic01.xa
```

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-2              | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw --show-testcase  --test basic01 --hints COMMON/hintfile --level info child.parent.good-mixed-2.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.12 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-mixed-2.basic01.xa; ns_list=ns1.parent.good-mixed-2.basic01.xa/127.12.1.41;ns1.parent.good-mixed-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns4.parent.good-mixed-2.basic01.xa/127.12.1.44;ns4.parent.good-mixed-2.basic01.xa/fda1:b2:c3:0:127:12:1:44
   0.12 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-mixed-2.basic01.xa
```

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-PARENT-HOST-1        | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw --show-testcase --test basic01 --hints COMMON/hintfile --level info child.parent.good-parent-host-1.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-parent-host-1.basic01.xa; ns_list=ns1.parent.good-parent-host-1.basic01.xa/127.12.1.41;ns1.parent.good-parent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-parent-host-1.basic01.xa/127.12.1.42;ns2.parent.good-parent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-parent-host-1.basic01.xa
```

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-GRANDPARENT-HOST-1   | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw --show-testcase --test basic01 --hints COMMON/hintfile --level info child.parent.good-grandparent-host-1.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.13 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-grandparent-host-1.basic01.xa; ns_list=ns1.parent.good-grandparent-host-1.basic01.xa/127.12.1.41;ns1.parent.good-grandparent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-grandparent-host-1.basic01.xa/127.12.1.42;ns2.parent.good-grandparent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.13 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-grandparent-host-1.basic01.xa

```

[#######]


--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-UNDEL-1              | B01_CHILD_FOUND, B01_PARENT_DISREGARDED          | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.good-undel-1.basic01.xa
   0.37 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.37 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.06 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-undel-1.basic01.xa; ns_ip_list=ns1.parent.good-undel-1.basic01.xa/127.12.1.41;ns1.parent.good-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-undel-1.basic01.xa/127.12.1.42;ns2.parent.good-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.06 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-undel-1.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not yet OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-UNDEL-1        | B01_CHILD_FOUND, B01_PARENT_DISREGARDED          | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.good-mixed-undel-1.basic01.xa
   0.29 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-mixed-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.29 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-mixed-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.07 INFO     Basic01        B01_PARENT_FOUND  domain=good-mixed-undel-1.basic01.xa; ns_ip_list=ns4.good-mixed-undel-1.basic01.xa/127.12.1.34;ns4.good-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.07 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-mixed-undel-1.basic01.xa; ns_ip_list=ns1.parent.good-mixed-undel-1.basic01.xa/127.12.1.41;ns1.parent.good-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-mixed-undel-1.basic01.xa/127.12.1.42;ns2.parent.good-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.07 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=ns1.parent.good-mixed-undel-1.basic01.xa/127.12.1.41;ns1.parent.good-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-mixed-undel-1.basic01.xa/127.12.1.42;ns2.parent.good-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42;ns4.good-mixed-undel-1.basic01.xa/127.12.1.34;ns4.good-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.07 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-mixed-undel-1.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not yet OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-UNDEL-2        | B01_CHILD_FOUND, B01_PARENT_DISREGARDED          | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.good-mixed-undel-2.basic01.xa
   0.40 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-mixed-undel-2.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.40 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-mixed-undel-2.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-mixed-undel-2.basic01.xa; ns_ip_list=ns1.parent.good-mixed-undel-2.basic01.xa/127.12.1.41;ns1.parent.good-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns6.parent.good-mixed-undel-2.basic01.xa/127.12.1.46;ns6.parent.good-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:46
   0.11 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-mixed-undel-2.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not yet OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-DEL-UNDEL-1            | B01_CHILD_FOUND, B01_PARENT_DISREGARDED          | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.no-del-undel-1.basic01.xa
   0.39 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.39 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.03 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-del-undel-1.basic01.xa; ns_ip_list=ns1.parent.no-del-undel-1.basic01.xa/127.12.1.41;ns1.parent.no-del-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-undel-1.basic01.xa/127.12.1.42;ns2.parent.no-del-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.03 INFO     Basic01        B01_CHILD_NOT_EXIST  domain=child.parent.no-del-undel-1.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not yet OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-DEL-MIXED-UNDEL-1      | B01_CHILD_FOUND, B01_PARENT_DISREGARDED          | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json  --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.no-del-mixed-undel-1.basic01.xa 
Loading profile from COMMON/custom-profile.json.
   0.40 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.40 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.05 INFO     Basic01        B01_PARENT_FOUND  domain=no-del-mixed-undel-1.basic01.xa; ns_ip_list=ns1.no-del-mixed-undel-1.basic01.xa/127.12.1.31;ns1.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns4.no-del-mixed-undel-1.basic01.xa/127.12.1.34;ns4.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.05 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.no-del-mixed-undel-1.basic01.xa
   0.05 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not yet OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-DEL-MIXED-UNDEL-2      | B01_CHILD_FOUND, B01_PARENT_DISREGARDED          | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.no-del-mixed-undel-2.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.34 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-2.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.35 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-2.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.04 INFO     Basic01        B01_PARENT_FOUND  domain=no-del-mixed-undel-2.basic01.xa; ns_ip_list=ns1.no-del-mixed-undel-2.basic01.xa/127.12.1.31;ns1.no-del-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns4.no-del-mixed-undel-2.basic01.xa/127.12.1.34;ns4.no-del-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.04 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.no-del-mixed-undel-2.basic01.xa
   0.04 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not yet OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-CHILD-1                | B01_NO_CHILD, B01_PARENT_FOUND                   | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info child.parent.no-child-1.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-child-1.basic01.xa; ns_ip_list=ns1.parent.no-child-1.basic01.xa/127.12.1.41;ns1.parent.no-child-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-child-1.basic01.xa/127.12.1.42;ns2.parent.no-child-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 ERROR    Basic01        B01_NO_CHILD  domain_child=child.parent.no-child-1.basic01.xa; domain_super="parent.no-child-1.basic01.xa"
```

--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
NO-CHILD-2                | B01_NO_CHILD, B01_PARENT_FOUND                                                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.no-child-2.basic01.xa 
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-child-2.basic01.xa; ns_ip_list=ns1.parent.no-child-2.basic01.xa/127.12.1.41;ns1.parent.no-child-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-child-2.basic01.xa/127.12.1.42;ns2.parent.no-child-2.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 ERROR    Basic01        B01_NO_CHILD  domain_child=child.parent.no-child-2.basic01.xa; domain_super="parent.no-child-2.basic01.xa"
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```

--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
NO-CHLD-PAR-UNDETER-1     | B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED                           | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.no-chld-par-undeter-1.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=no-chld-par-undeter-1.basic01.xa; ns_ip_list=ns1.no-chld-par-undeter-1.basic01.xa/127.12.1.31;ns1.no-chld-par-undeter-1.basic01.xa/fda1:b2:c3:0:127:12:1:31
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-chld-par-undeter-1.basic01.xa; ns_ip_list=ns1.parent.no-chld-par-undeter-1.basic01.xa/127.12.1.41;ns1.parent.no-chld-par-undeter-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-chld-par-undeter-1.basic01.xa/127.12.1.42;ns2.parent.no-chld-par-undeter-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=ns1.no-chld-par-undeter-1.basic01.xa/127.12.1.31;ns1.no-chld-par-undeter-1.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns1.parent.no-chld-par-undeter-1.basic01.xa/127.12.1.41;ns1.parent.no-chld-par-undeter-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-chld-par-undeter-1.basic01.xa/127.12.1.42;ns2.parent.no-chld-par-undeter-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 ERROR    Basic01        B01_NO_CHILD  domain_child=child.parent.no-chld-par-undeter-1.basic01.xa; domain_super="parent.no-chld-par-undeter-1.basic01.xa"
   0.11 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-PAR-UNDET-1    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED                        | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.chld-found-par-undet-1.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.10 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-par-undet-1.basic01.xa; ns_ip_list=ns1.parent.chld-found-par-undet-1.basic01.xa/127.12.1.41;ns1.parent.chld-found-par-undet-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-par-undet-1.basic01.xa/127.12.1.42;ns2.parent.chld-found-par-undet-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.10 INFO     Basic01        B01_PARENT_FOUND  domain=chld-found-par-undet-1.basic01.xa; ns_ip_list=ns1.chld-found-par-undet-1.basic01.xa/127.12.1.31;ns1.chld-found-par-undet-1.basic01.xa/fda1:b2:c3:0:127:12:1:31
   0.10 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=ns1.chld-found-par-undet-1.basic01.xa/127.12.1.31;ns1.chld-found-par-undet-1.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns1.parent.chld-found-par-undet-1.basic01.xa/127.12.1.41;ns1.parent.chld-found-par-undet-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-par-undet-1.basic01.xa/127.12.1.42;ns2.parent.chld-found-par-undet-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.10 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-par-undet-1.basic01.xa
   0.10 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-1    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-1.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.12 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-1.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-1.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-1.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.12 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-1.basic01.xa
   0.12 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-1.basic01.xa; domain_parent=parent.chld-found-inconsist-1.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-1.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-1.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.12 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-2    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-2.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.07 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-2.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-2.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-2.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-2.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.07 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-2.basic01.xa
   0.08 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-2.basic01.xa; domain_parent=parent.chld-found-inconsist-2.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-2.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-2.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-2.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-3    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-3.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.07 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-3.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-3.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-3.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-3.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-3.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.07 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-3.basic01.xa
   0.07 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-3.basic01.xa; domain_parent=parent.chld-found-inconsist-3.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-3.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-3.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-3.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-3.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.07 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-4    | B01_PARENT_FOUND, B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION                  | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-4.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-4.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-4.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-4.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-4.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-4.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-4.basic01.xa
   0.09 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-4.basic01.xa; domain_parent=sister.parent.chld-found-inconsist-4.basic01.xa.; ns_ip_list=ns1.parent.chld-found-inconsist-4.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-4.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-4.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-4.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 NOTICE   Basic01        B01_CHILD_IS_ALIAS  domain_child=child.parent.chld-found-inconsist-4.basic01.xa; domain_target=sister.parent.chld-found-inconsist-4.basic01.xa.; ns_ip_list=ns2.parent.chld-found-inconsist-4.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-4.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-5    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-5.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-5.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-5.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-5.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-5.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-5.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-5.basic01.xa
   0.11 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-5.basic01.xa; domain_parent=parent.chld-found-inconsist-5.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-5.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-5.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-5.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-5.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-6    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-6.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-6.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-6.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-6.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-6.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-6.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-6.basic01.xa
   0.08 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-6.basic01.xa; domain_parent=parent.chld-found-inconsist-6.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-6.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-6.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-6.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-6.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-7    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-7.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-7.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-7.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-7.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-7.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-7.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-7.basic01.xa
   0.11 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-7.basic01.xa; domain_parent=parent.chld-found-inconsist-7.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-7.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-7.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-7.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-7.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-8    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-8.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-8.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-8.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-8.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-8.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-8.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-8.basic01.xa
   0.08 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-8.basic01.xa; domain_parent=parent.chld-found-inconsist-8.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-8.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-8.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-8.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-8.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                               | Forbidden message tags
:-------------------------|:------------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-9    | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND  | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-9.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.09 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-9.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-9.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-9.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-9.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-9.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-9.basic01.xa
   0.09 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-9.basic01.xa; domain_parent=sister.parent.chld-found-inconsist-9.basic01.xa.; ns_ip_list=ns1.parent.chld-found-inconsist-9.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-9.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-9.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-9.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 NOTICE   Basic01        B01_CHILD_IS_ALIAS  domain_child=child.parent.chld-found-inconsist-9.basic01.xa; domain_target=sister.parent.chld-found-inconsist-9.basic01.xa.; ns_ip_list=ns2.parent.chld-found-inconsist-9.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-9.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHLD-FOUND-INCONSIST-10   | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.CHLD-FOUND-INCONSIST-10.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.chld-found-inconsist-10.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-10.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-10.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-10.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-10.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.chld-found-inconsist-10.basic01.xa
   0.08 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.chld-found-inconsist-10.basic01.xa; domain_parent=parent.chld-found-inconsist-10.basic01.xa; ns_ip_list=ns1.parent.chld-found-inconsist-10.basic01.xa/127.12.1.41;ns1.parent.chld-found-inconsist-10.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.chld-found-inconsist-10.basic01.xa/127.12.1.42;ns2.parent.chld-found-inconsist-10.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
NO-DEL-UNDEL-NO-PAR-1     | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)

* Undelgated data:
  * ns3-undelegated-child.basic01.xa
  * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.no-del-undel-no-par-1.basic01.xa --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.33 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-no-par-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.33 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-no-par-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.02 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=
   0.02 INFO     Basic01        B01_CHILD_NOT_EXIST  domain=child.parent.no-del-undel-no-par-1.basic01.xa
   0.02 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> Not yet OK.

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
NO-DEL-UNDEL-PAR-UND-1    | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)

* Undelgated data:
  * ns3-undelegated-child.basic01.xa
  * ns4-undelegated-child.basic01.xa

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json  child.parent.no-del-undel-par-und-1.basic01.xa  --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.34 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-par-und-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.34 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-par-und-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=no-del-undel-par-und-1.basic01.xa; ns_ip_list=ns1.no-del-undel-par-und-1.basic01.xa/127.12.1.31;ns1.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:31
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-del-undel-par-und-1.basic01.xa; ns_ip_list=ns1.parent.no-del-undel-par-und-1.basic01.xa/127.12.1.41;ns1.parent.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-undel-par-und-1.basic01.xa/127.12.1.42;ns2.parent.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=ns1.no-del-undel-par-und-1.basic01.xa/127.12.1.31;ns1.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns1.parent.no-del-undel-par-und-1.basic01.xa/127.12.1.41;ns1.parent.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-undel-par-und-1.basic01.xa/127.12.1.42;ns2.parent.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.no-del-undel-par-und-1.basic01.xa
   0.08 ERROR    Basic01        B01_INCONSISTENT_DELEGATION  domain_child=child.parent.no-del-undel-par-und-1.basic01.xa; domain_parent=no-del-undel-par-und-1.basic01.xa; ns_ip_list=ns1.no-del-undel-par-und-1.basic01.xa/127.12.1.31;ns1.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns1.parent.no-del-undel-par-und-1.basic01.xa/127.12.1.41;ns1.parent.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-undel-par-und-1.basic01.xa/127.12.1.42;ns2.parent.no-del-undel-par-und-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> Not OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
NO-CHLD-NO-PAR-1          | B01_NO_CHILD, B01_PARENT_NOT_FOUND, B01_SERVER_ZONE_ERROR                         | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.no-chld-no-par-1.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.04 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=
   0.04 ERROR    Basic01        B01_NO_CHILD  domain_child=child.parent.no-chld-no-par-1.basic01.xa; domain_super="parent.no-chld-no-par-1.basic01.xa"
   0.04 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> Not OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHILD-ALIAS-1             | B01_CHILD_IS_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND                          | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.child-alias-1.basic01.xa.
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.child-alias-1.basic01.xa; ns_ip_list=ns1.parent.child-alias-1.basic01.xa/127.12.1.41;ns1.parent.child-alias-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.child-alias-1.basic01.xa/127.12.1.42;ns2.parent.child-alias-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 ERROR    Basic01        B01_NO_CHILD  domain_child=child.parent.child-alias-1.basic01.xa; domain_super="parent.child-alias-1.basic01.xa"
   0.08 NOTICE   Basic01        B01_CHILD_IS_ALIAS  domain_child=child.parent.child-alias-1.basic01.xa; domain_target=sister.parent.child-alias-1.basic01.xa.; ns_ip_list=ns1.parent.child-alias-1.basic01.xa/127.12.1.41;ns1.parent.child-alias-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.child-alias-1.basic01.xa/127.12.1.42;ns2.parent.child-alias-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
CHILD-ALIAS-2             | B01_CHILD_IS_ALIAS, B01_NO_CHILD, B01_INCONSISTENT_ALIAS, B01_PARENT_FOUND | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.child-alias-2.basic01.xa.
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.09 INFO     Basic01        B01_PARENT_FOUND  domain=parent.child-alias-2.basic01.xa; ns_ip_list=ns1.parent.child-alias-2.basic01.xa/127.12.1.41;ns1.parent.child-alias-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.child-alias-2.basic01.xa/127.12.1.42;ns2.parent.child-alias-2.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 ERROR    Basic01        B01_NO_CHILD  domain_child=child.parent.child-alias-2.basic01.xa; domain_super="parent.child-alias-2.basic01.xa"
   0.09 NOTICE   Basic01        B01_CHILD_IS_ALIAS  domain_child=child.parent.child-alias-2.basic01.xa; domain_target=brother.parent.child-alias-2.basic01.xa.; ns_ip_list=ns2.parent.child-alias-2.basic01.xa/127.12.1.42;ns2.parent.child-alias-2.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 NOTICE   Basic01        B01_CHILD_IS_ALIAS  domain_child=child.parent.child-alias-2.basic01.xa; domain_target=sister.parent.child-alias-2.basic01.xa.; ns_ip_list=ns1.parent.child-alias-2.basic01.xa/127.12.1.41;ns1.parent.child-alias-2.basic01.xa/fda1:b2:c3:0:127:12:1:41
   0.09 ERROR    Basic01        B01_INCONSISTENT_ALIAS  domain=child.parent.child-alias-2.basic01.xa
   0.09 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
ZONE-ERR-GRANDPARENT-1    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_SERVER_ZONE_ERROR                          | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.zone-err-grandparent-1.basic01.xa.
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.07 INFO     Basic01        B01_PARENT_FOUND  domain=parent.zone-err-grandparent-1.basic01.xa; ns_ip_list=ns1.parent.zone-err-grandparent-1.basic01.xa/127.12.1.41;ns1.parent.zone-err-grandparent-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.zone-err-grandparent-1.basic01.xa/127.12.1.42;ns2.parent.zone-err-grandparent-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.07 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.zone-err-grandparent-1.basic01.xa
   0.07 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> Not OK

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
ZONE-ERR-GRANDPARENT-2    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_SERVER_ZONE_ERROR                          | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.zone-err-grandparent-2.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.10 INFO     Basic01        B01_PARENT_FOUND  domain=parent.zone-err-grandparent-2.basic01.xa; ns_ip_list=ns1.parent.zone-err-grandparent-2.basic01.xa/127.12.1.41;ns1.parent.zone-err-grandparent-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.zone-err-grandparent-2.basic01.xa/127.12.1.42;ns2.parent.zone-err-grandparent-2.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.10 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.zone-err-grandparent-2.basic01.xa
   0.10 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
--> Not OK


Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
ZONE-ERR-GRANDPARENT-3    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_SERVER_ZONE_ERROR                          | 2)

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json child.parent.zone-err-grandparent-3.basic01.xa
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Basic01        TEST_CASE_START  testcase=Basic01
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.zone-err-grandparent-3.basic01.xa; ns_ip_list=ns1.parent.zone-err-grandparent-3.basic01.xa/127.12.1.41;ns1.parent.zone-err-grandparent-3.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.zone-err-grandparent-3.basic01.xa/127.12.1.42;ns2.parent.zone-err-grandparent-3.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.zone-err-grandparent-3.basic01.xa
   0.08 INFO     Basic01        TEST_CASE_END  testcase=Basic01
```
