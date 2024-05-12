# Basic03

[This directory](.), i.e. the same directory as this README file, holds
zone files and `coredns` configuration files for scenarios for test case Basic01.

## All message tags

* B01_CHILD_IS_ALIAS
* B01_CHILD_FOUND
* B01_CHILD_NOT_EXIST
* B01_INCONSISTENT_ALIAS
* B01_INCONSISTENT_DELEGATION
* B01_NO_CHILD
* B01_PARENT_FOUND
* B01_PARENT_NOT_FOUND
* B01_PARENT_UNDETERMINED
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
$ zonemaster-cli --raw  --test basic01 --hints COMMON/hintfile --level info child.parent.good-1.basic01.xa
   0.00 INFO     GLOBAL_VERSION  version=v5.0.0
   0.09 INFO     B01_PARENT_FOUND  domain=parent.good-1.basic01.xa; ns_ip_list=ns1.parent.good-1.basic01.xa/127.12.1.41;ns1.parent.good-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-1.basic01.xa/127.12.1.42;ns2.parent.good-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.09 INFO     B01_CHILD_FOUND  domain=child.parent.good-1.basic01.xa
```
--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-1              | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw  --test basic01 --hints COMMON/hintfile --level info child.parent.good-1.basic01.xa
   0.00 INFO     GLOBAL_VERSION  version=v5.0.0
   0.10 INFO     B01_PARENT_FOUND  domain=parent.good-mixed-1.basic01.xa; ns_ip_list=ns1.parent.good-mixed-1.basic01.xa/127.12.1.41;ns1.parent.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-mixed-1.basic01.xa/127.12.1.42;ns2.parent.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.11 INFO     B01_PARENT_FOUND  domain=good-mixed-1.basic01.xa; ns_ip_list=ns4.good-mixed-1.basic01.xa/127.12.1.34;ns4.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.11 WARNING  B01_PARENT_UNDETERMINED  ns_ip_list=ns1.parent.good-mixed-1.basic01.xa/127.12.1.41;ns1.parent.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-mixed-1.basic01.xa/127.12.1.42;ns2.parent.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:42;ns4.good-mixed-1.basic01.xa/127.12.1.34;ns4.good-mixed-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.11 INFO     B01_CHILD_FOUND  domain=child.parent.good-mixed-1.basic01.xa
```

--> Not OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-2              | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw  --test basic01 --hints COMMON/hintfile --level info child.parent.good-mixed-2.basic01.xa
   0.00 INFO     GLOBAL_VERSION  version=v5.0.0
   0.13 INFO     B01_PARENT_FOUND  domain=parent.good-mixed-2.basic01.xa; ns_ip_list=ns1.parent.good-mixed-2.basic01.xa/127.12.1.41;ns1.parent.good-mixed-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns4.parent.good-mixed-2.basic01.xa/127.12.1.44;ns4.parent.good-mixed-2.basic01.xa/fda1:b2:c3:0:127:12:1:44
   0.13 INFO     B01_CHILD_FOUND  domain=child.parent.good-mixed-2.basic01.xa
```

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-PARENT-HOST-1        | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw  --test basic01 --hints COMMON/hintfile --level info child.parent.good-parent-host-1.basic01.xa 
   0.00 INFO     GLOBAL_VERSION  version=v5.0.0
   0.14 INFO     B01_PARENT_FOUND  domain=parent.good-parent-host-1.basic01.xa; ns_ip_list=ns1.parent.good-parent-host-1.basic01.xa/127.12.1.41;ns1.parent.good-parent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-parent-host-1.basic01.xa/127.12.1.42;ns2.parent.good-parent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.14 INFO     B01_CHILD_FOUND  domain=child.parent.good-parent-host-1.basic01.xa
```

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-GRANDPARENT-HOST-1   | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --raw  --test basic01 --hints COMMON/hintfile --level info child.parent.good-grandparent-host-1.basic01.xa
   0.00 INFO     GLOBAL_VERSION  version=v5.0.0
   0.08 INFO     B01_CHILD_FOUND  domain=child.parent.good-grandparent-host-1.basic01.xa
   0.08 INFO     B01_PARENT_FOUND  domain=good-grandparent-host-1.basic01.xa; ns_ip_list=ns1.good-grandparent-host-1.basic01.xa/127.12.1.31;ns1.good-grandparent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns2.good-grandparent-host-1.basic01.xa/127.12.1.32;ns2.good-grandparent-host-1.basic01.xa/fda1:b2:c3:0:127:12:1:32
```

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-UNDEL-1              | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa/-
    * ns4-undelegated-child.basic01.xa/-

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.good-undel-1.basic01.xa
   0.37 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.37 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.06 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-undel-1.basic01.xa; ns_ip_list=ns1.parent.good-undel-1.basic01.xa/127.12.1.41;ns1.parent.good-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.good-undel-1.basic01.xa/127.12.1.42;ns2.parent.good-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.06 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-undel-1.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-UNDEL-1        | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa/-
    * ns4-undelegated-child.basic01.xa/-

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

--> Not OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
GOOD-MIXED-UNDEL-2        | B01_CHILD_FOUND, B01_PARENT_FOUND                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa/-
    * ns4-undelegated-child.basic01.xa/-

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.good-mixed-undel-2.basic01.xa
   0.40 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-mixed-undel-2.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.40 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.good-mixed-undel-2.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.11 INFO     Basic01        B01_PARENT_FOUND  domain=parent.good-mixed-undel-2.basic01.xa; ns_ip_list=ns1.parent.good-mixed-undel-2.basic01.xa/127.12.1.41;ns1.parent.good-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns6.parent.good-mixed-undel-2.basic01.xa/127.12.1.46;ns6.parent.good-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:46
   0.11 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.good-mixed-undel-2.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-DEL-UNDEL-1            | B01_CHILD_NOT_EXIST, B01_PARENT_FOUND            | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa/-
    * ns4-undelegated-child.basic01.xa/-

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.no-del-undel-1.basic01.xa
   0.39 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.39 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.03 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-del-undel-1.basic01.xa; ns_ip_list=ns1.parent.no-del-undel-1.basic01.xa/127.12.1.41;ns1.parent.no-del-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-undel-1.basic01.xa/127.12.1.42;ns2.parent.no-del-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.03 INFO     Basic01        B01_CHILD_NOT_EXIST  domain=child.parent.no-del-undel-1.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-DEL-MIXED-UNDEL-1      | B01_CHILD_NOT_EXIST, B01_PARENT_FOUND            | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa/-
    * ns4-undelegated-child.basic01.xa/-

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.no-del-mixed-undel-1.basic01.xa
   0.38 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-1.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.38 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-1.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=no-del-mixed-undel-1.basic01.xa; ns_ip_list=ns4.no-del-mixed-undel-1.basic01.xa/127.12.1.34;ns4.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.08 INFO     Basic01        B01_PARENT_FOUND  domain=parent.no-del-mixed-undel-1.basic01.xa; ns_ip_list=ns1.parent.no-del-mixed-undel-1.basic01.xa/127.12.1.41;ns1.parent.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-mixed-undel-1.basic01.xa/127.12.1.42;ns2.parent.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42
   0.08 WARNING  Basic01        B01_PARENT_UNDETERMINED  ns_ip_list=ns1.parent.no-del-mixed-undel-1.basic01.xa/127.12.1.41;ns1.parent.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:41;ns2.parent.no-del-mixed-undel-1.basic01.xa/127.12.1.42;ns2.parent.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:42;ns4.no-del-mixed-undel-1.basic01.xa/127.12.1.34;ns4.no-del-mixed-undel-1.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.08 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.no-del-mixed-undel-1.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> Not OK

Scenario name             | Mandatory message tag                            | Forbidden message tags
:-------------------------|:-------------------------------------------------|:----------------------
NO-DEL-MIXED-UNDEL-2      | B01_CHILD_NOT_EXIST, B01_PARENT_FOUND            | 2)

* (2) All tags except for those specified as "Mandatory message tags"

  * Undelgated data:
    * ns3-undelegated-child.basic01.xa/-
    * ns4-undelegated-child.basic01.xa/-

```
$ zonemaster-cli --raw  --show-testcase --test basic01 --hints COMMON/hintfile --level info --ns ns3-undelegated-child.basic01.xa --ns ns4-undelegated-child.basic01.xa child.parent.no-del-mixed-undel-2.basic01.xa
   0.48 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-2.basic01.xa; nsname=ns4-undelegated-child.basic01.xa
   0.48 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=child.parent.no-del-mixed-undel-2.basic01.xa; nsname=ns3-undelegated-child.basic01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.05 INFO     Basic01        B01_PARENT_FOUND  domain=no-del-mixed-undel-2.basic01.xa; ns_ip_list=ns1.no-del-mixed-undel-2.basic01.xa/127.12.1.31;ns1.no-del-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:31;ns4.no-del-mixed-undel-2.basic01.xa/127.12.1.34;ns4.no-del-mixed-undel-2.basic01.xa/fda1:b2:c3:0:127:12:1:34
   0.05 INFO     Basic01        B01_CHILD_FOUND  domain=child.parent.no-del-mixed-undel-2.basic01.xa
```

Note that `FAKE_DELEGATION_NO_IP` is not significant for the scenario, but it is due to a bug that it appears (<https://github.com/zonemaster/zonemaster-engine/issues/1344>).

--> OK

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

