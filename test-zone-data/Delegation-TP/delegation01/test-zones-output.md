# Delegation01 Test Zones Output

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

* ENOUGH_IPV4_NS_CHILD
* ENOUGH_IPV4_NS_DEL
* ENOUGH_IPV6_NS_CHILD
* ENOUGH_IPV6_NS_DEL
* ENOUGH_NS_CHILD
* ENOUGH_NS_DEL
* NOT_ENOUGH_IPV4_NS_CHILD
* NOT_ENOUGH_IPV4_NS_DEL
* NOT_ENOUGH_IPV6_NS_CHILD
* NOT_ENOUGH_IPV6_NS_DEL
* NOT_ENOUGH_NS_CHILD
* NOT_ENOUGH_NS_DEL
* NO_IPV4_NS_CHILD
* NO_IPV4_NS_DEL
* NO_IPV6_NS_CHILD
* NO_IPV6_NS_DEL

## All scenarios

Scenario name                 | Zone name
:-----------------------------|:---------------------------------------------
ENOUGH-1                      | enough-1.delegation01.xa
ENOUGH-2                      | enough-2.delegation01.xa
ENOUGH-3                      | enough-3.delegation01.xa
ENOUGH-DEL-NOT-CHILD          | enough-del-not-child.delegation01.xa
ENOUGH-CHILD-NOT-DEL          | enough-child-not-del.delegation01.xa
IPV6-AND-DEL-OK-NO-IPV4-CHILD | ipv6-and-del-ok-no-ipv4-child.delegation01.xa
IPV4-AND-DEL-OK-NO-IPV6-CHILD | ipv4-and-del-ok-no-ipv6-child.delegation01.xa
NO-IPV4-1                     | no-ipv4-1.delegation01.xa
NO-IPV4-2                     | no-ipv4-2.delegation01.xa
NO-IPV4-3                     | no-ipv4-3.delegation01.xa
NO-IPV6-1                     | no-ipv6-1.delegation01.xa
NO-IPV6-2                     | no-ipv6-2.delegation01.xa
NO-IPV6-3                     | no-ipv6-3.delegation01.xa
MISMATCH-DELEGATION-CHILD-1   | mismatch-delegation-child-1.delegation01.xa
MISMATCH-DELEGATION-CHILD-2   | mismatch-delegation-child-2.delegation01.xa



## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with `--level=info
--test=delegation01`.

The test zones for these scenarios have a dedicated root zone, which means that
the hint files in the commands below must be used.

All commands are run from the same directory as this file is in.

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
ENOUGH-1                      | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw ENOUGH-1.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.enough-1.delegation01.xa;ns2.enough-1.delegation01.xa
   0.06 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.enough-1.delegation01.xa;ns2.enough-1.delegation01.xa
   0.06 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-1.delegation01.xa/127.16.1.31;ns2.enough-1.delegation01.xa/127.16.1.32
   0.06 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-1.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.enough-1.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.07 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.enough-1.delegation01.xa/127.16.1.31;ns2.enough-1.delegation01.xa/127.16.1.32
   0.07 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.enough-1.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.enough-1.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
ENOUGH-2                      | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)

```
zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw ENOUGH-2.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.07 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.enough-2.delegation01.xb;ns2.enough-2.delegation01.xb
   0.08 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.enough-2.delegation01.xb;ns2.enough-2.delegation01.xb
   0.08 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-2.delegation01.xb/127.16.1.33;ns2.enough-2.delegation01.xb/127.16.1.34
   0.08 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-2.delegation01.xb/fda1:b2:c3:0:127:16:1:33;ns2.enough-2.delegation01.xb/fda1:b2:c3:0:127:16:1:34
   0.09 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.enough-2.delegation01.xb/127.16.1.33;ns2.enough-2.delegation01.xb/127.16.1.34
   0.09 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.enough-2.delegation01.xb/fda1:b2:c3:0:127:16:1:33;ns2.enough-2.delegation01.xb/fda1:b2:c3:0:127:16:1:34
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
ENOUGH-3                      | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw ENOUGH-3.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.04 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.enough-3.sibling.delegation01.xa;ns2.enough-3.sibling.delegation01.xa
   0.07 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.enough-3.sibling.delegation01.xa;ns2.enough-3.sibling.delegation01.xa
   0.07 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-3.sibling.delegation01.xa/127.16.1.31;ns2.enough-3.sibling.delegation01.xa/127.16.1.32
   0.07 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.enough-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.07 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.enough-3.sibling.delegation01.xa/127.16.1.31;ns2.enough-3.sibling.delegation01.xa/127.16.1.32
   0.07 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.enough-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.enough-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
ENOUGH-DEL-NOT-CHILD          | ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_DEL, NOT_ENOUGH_IPV4_NS_CHILD, NOT_ENOUGH_IPV6_NS_CHILD, NOT_ENOUGH_NS_CHILD | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw ENOUGH-DEL-NOT-CHILD.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.04 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.enough-del-not-child.delegation01.xa;ns2.enough-del-not-child.delegation01.xa
   0.06 ERROR    Delegation01   NOT_ENOUGH_NS_CHILD  count=1; minimum=2; nsname_list=ns1.enough-del-not-child.delegation01.xa
   0.06 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_CHILD  count=1; minimum=2; ns_list=ns1.enough-del-not-child.delegation01.xa/127.16.1.31
   0.06 ERROR    Delegation01   NOT_ENOUGH_IPV6_NS_CHILD  count=1; minimum=2; ns_list=ns1.enough-del-not-child.delegation01.xa/fda1:b2:c3:0:127:16:1:31
   0.06 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_DEL  count=1; minimum=2; ns_list=ns1.enough-del-not-child.delegation01.xa/127.16.1.31
   0.06 ERROR    Delegation01   NOT_ENOUGH_IPV6_NS_DEL  count=1; minimum=2; ns_list=ns1.enough-del-not-child.delegation01.xa/fda1:b2:c3:0:127:16:1:31
```

--> Unexpected

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
ENOUGH-CHILD-NOT-DEL          | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV6_NS_CHILD, ENOUGH_NS_CHILD, NOT_ENOUGH_IPV4_NS_DEL, NOT_ENOUGH_IPV6_NS_DEL, NOT_ENOUGH_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw ENOUGH-CHILD-NOT-DEL.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 ERROR    Delegation01   NOT_ENOUGH_NS_DEL  count=1; minimum=2; nsname_list=ns1.enough-child-not-del.delegation01.xa
   0.06 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.enough-child-not-del.delegation01.xa;ns2.enough-child-not-del.delegation01.xa
   0.06 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-child-not-del.delegation01.xa/127.16.1.31;ns2.enough-child-not-del.delegation01.xa/127.16.1.32
   0.06 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.enough-child-not-del.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.enough-child-not-del.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.06 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_DEL  count=1; minimum=2; ns_list=ns1.enough-child-not-del.delegation01.xa/127.16.1.31
   0.06 ERROR    Delegation01   NOT_ENOUGH_IPV6_NS_DEL  count=1; minimum=2; ns_list=ns1.enough-child-not-del.delegation01.xa/fda1:b2:c3:0:127:16:1:31
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
IPV6-AND-DEL-OK-NO-IPV4-CHILD | ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw IPV6-AND-DEL-OK-NO-IPV4-CHILD.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.ipv6-and-del-ok-no-ipv4-child.delegation01.xa;ns2.ipv6-and-del-ok-no-ipv4-child.delegation01.xa
   0.06 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.ipv6-and-del-ok-no-ipv4-child.delegation01.xa;ns2.ipv6-and-del-ok-no-ipv4-child.delegation01.xa
   0.06 WARNING  Delegation01   NO_IPV4_NS_CHILD  count=0; minimum=2; ns_list=
   0.06 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.ipv6-and-del-ok-no-ipv4-child.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.ipv6-and-del-ok-no-ipv4-child.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.06 WARNING  Delegation01   NO_IPV4_NS_DEL  count=0; minimum=2; ns_list=
   0.06 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.ipv6-and-del-ok-no-ipv4-child.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.ipv6-and-del-ok-no-ipv4-child.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> Unexpected

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
IPV4-AND-DEL-OK-NO-IPV6-CHILD | ENOUGH_IPV4_NS_DEL, ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw IPV4-AND-DEL-OK-NO-IPV6-CHILD.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.ipv4-and-del-ok-no-ipv6-child.delegation01.xa;ns2.ipv4-and-del-ok-no-ipv6-child.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.ipv4-and-del-ok-no-ipv6-child.delegation01.xa;ns2.ipv4-and-del-ok-no-ipv6-child.delegation01.xa
   0.05 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_CHILD  count=1; minimum=2; ns_list=ns1.ipv4-and-del-ok-no-ipv6-child.delegation01.xa/127.16.1.31;ns1.ipv4-and-del-ok-no-ipv6-child.delegation01.xa/127.16.1.32
   0.05 NOTICE   Delegation01   NO_IPV6_NS_CHILD  count=0; minimum=2; ns_list=
   0.05 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_DEL  count=1; minimum=2; ns_list=ns1.ipv4-and-del-ok-no-ipv6-child.delegation01.xa/127.16.1.31;ns1.ipv4-and-del-ok-no-ipv6-child.delegation01.xa/127.16.1.32
   0.05 NOTICE   Delegation01   NO_IPV6_NS_DEL  count=0; minimum=2; ns_list=
```

--> Unexpected

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
NO-IPV4-1                     | ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD, NO_IPV4_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw NO-IPV4-1.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.no-ipv4-1.delegation01.xa;ns2.no-ipv4-1.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.no-ipv4-1.delegation01.xa;ns2.no-ipv4-1.delegation01.xa
   0.05 WARNING  Delegation01   NO_IPV4_NS_CHILD  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.no-ipv4-1.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.no-ipv4-1.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.05 WARNING  Delegation01   NO_IPV4_NS_DEL  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.no-ipv4-1.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.no-ipv4-1.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
NO-IPV4-2                     | ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD, NO_IPV4_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw NO-IPV4-2.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.04 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.no-ipv4-2.delegation01.xb;ns2.no-ipv4-2.delegation01.xb
   0.07 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.no-ipv4-2.delegation01.xb;ns2.no-ipv4-2.delegation01.xb
   0.07 WARNING  Delegation01   NO_IPV4_NS_CHILD  count=0; minimum=2; ns_list=
   0.07 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.no-ipv4-2.delegation01.xb/fda1:b2:c3:0:127:16:1:33;ns2.no-ipv4-2.delegation01.xb/fda1:b2:c3:0:127:16:1:34
   0.07 WARNING  Delegation01   NO_IPV4_NS_DEL  count=0; minimum=2; ns_list=
   0.07 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.no-ipv4-2.delegation01.xb/fda1:b2:c3:0:127:16:1:33;ns2.no-ipv4-2.delegation01.xb/fda1:b2:c3:0:127:16:1:34
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
NO-IPV4-3                     | ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD, NO_IPV4_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw NO-IPV4-3.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.no-ipv4-3.sibling.delegation01.xa;ns2.no-ipv4-3.sibling.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.no-ipv4-3.sibling.delegation01.xa;ns2.no-ipv4-3.sibling.delegation01.xa
   0.05 WARNING  Delegation01   NO_IPV4_NS_CHILD  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.no-ipv4-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.no-ipv4-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.05 WARNING  Delegation01   NO_IPV4_NS_DEL  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.no-ipv4-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.no-ipv4-3.sibling.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
NO-IPV6-1                     | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD, NO_IPV6_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw NO-IPV6-1.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.02 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.no-ipv6-1.delegation01.xa;ns2.no-ipv6-1.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.no-ipv6-1.delegation01.xa;ns2.no-ipv6-1.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.no-ipv6-1.delegation01.xa/127.16.1.31;ns2.no-ipv6-1.delegation01.xa/127.16.1.32
   0.05 NOTICE   Delegation01   NO_IPV6_NS_CHILD  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.no-ipv6-1.delegation01.xa/127.16.1.31;ns2.no-ipv6-1.delegation01.xa/127.16.1.32
   0.05 NOTICE   Delegation01   NO_IPV6_NS_DEL  count=0; minimum=2; ns_list=
```

--> OK


Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
NO-IPV6-2                     | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD, NO_IPV6_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw NO-IPV6-2.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.no-ipv6-2.delegation01.xb;ns2.no-ipv6-2.delegation01.xb
   0.04 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.no-ipv6-2.delegation01.xb;ns2.no-ipv6-2.delegation01.xb
   0.04 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.no-ipv6-2.delegation01.xb/127.16.1.33;ns2.no-ipv6-2.delegation01.xb/127.16.1.34
   0.04 NOTICE   Delegation01   NO_IPV6_NS_CHILD  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.no-ipv6-2.delegation01.xb/127.16.1.33;ns2.no-ipv6-2.delegation01.xb/127.16.1.34
   0.05 NOTICE   Delegation01   NO_IPV6_NS_DEL  count=0; minimum=2; ns_list=
```
--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
NO-IPV6-3                     | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD, NO_IPV6_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw NO-IPV6-3.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.04 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.no-ipv6-3.sibling.delegation01.xa;ns2.no-ipv6-3.sibling.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.no-ipv6-3.sibling.delegation01.xa;ns2.no-ipv6-3.sibling.delegation01.xa
   0.05 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.no-ipv6-3.sibling.delegation01.xa/127.16.1.31;ns2.no-ipv6-3.sibling.delegation01.xa/127.16.1.32
   0.05 NOTICE   Delegation01   NO_IPV6_NS_CHILD  count=0; minimum=2; ns_list=
   0.05 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.no-ipv6-3.sibling.delegation01.xa/127.16.1.31;ns2.no-ipv6-3.sibling.delegation01.xa/127.16.1.32
   0.05 NOTICE   Delegation01   NO_IPV6_NS_DEL  count=0; minimum=2; ns_list=
```

--> OK

Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
MISMATCH-DELEGATION-CHILD-1   | ENOUGH_IPV4_NS_CHILD, NOT_ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, NOT_ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw MISMATCH-DELEGATION-CHILD-1.delegation01.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.mismatch-delegation-child-1.delegation01.xa;ns2.mismatch-delegation-child-1.delegation01.xa
   0.11 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.mismatch-delegation-child-1.delegation01.xa;ns2.mismatch-delegation-child-1.delegation01.xa
   0.11 INFO     Delegation01   ENOUGH_IPV4_NS_CHILD  count=2; minimum=2; ns_list=ns1.mismatch-delegation-child-1.delegation01.xa/127.16.1.31;ns2.mismatch-delegation-child-1.delegation01.xa/127.16.1.32
   0.11 INFO     Delegation01   ENOUGH_IPV6_NS_CHILD  count=2; minimum=2; ns_list=ns1.mismatch-delegation-child-1.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.mismatch-delegation-child-1.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.11 INFO     Delegation01   ENOUGH_IPV4_NS_DEL  count=2; minimum=2; ns_list=ns1.mismatch-delegation-child-1.delegation01.xa/127.16.1.31;ns2.mismatch-delegation-child-1.delegation01.xa/127.16.1.32
   0.11 INFO     Delegation01   ENOUGH_IPV6_NS_DEL  count=2; minimum=2; ns_list=ns1.mismatch-delegation-child-1.delegation01.xa/fda1:b2:c3:0:127:16:1:31;ns2.mismatch-delegation-child-1.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> Unexpected


Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
MISMATCH-DELEGATION-CHILD-2   | NOT_ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, NOT_ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation01 --level=info --show-testcase --raw MISMATCH-DELEGATION-CHILD-2.delegation01.xa
   0.01 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.05 INFO     Delegation01   ENOUGH_NS_DEL  count=2; minimum=2; nsname_list=ns1.mismatch-delegation-child-2.delegation01.xa;ns2.mismatch-delegation-child-2.delegation01.xa
   0.08 INFO     Delegation01   ENOUGH_NS_CHILD  count=2; minimum=2; nsname_list=ns1.mismatch-delegation-child-2.delegation01.xa;ns2.mismatch-delegation-child-2.delegation01.xa
   0.08 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_CHILD  count=1; minimum=2; ns_list=ns1.mismatch-delegation-child-2.delegation01.xa/127.16.1.31
   0.08 ERROR    Delegation01   NOT_ENOUGH_IPV6_NS_CHILD  count=1; minimum=2; ns_list=ns2.mismatch-delegation-child-2.delegation01.xa/fda1:b2:c3:0:127:16:1:32
   0.09 ERROR    Delegation01   NOT_ENOUGH_IPV4_NS_DEL  count=1; minimum=2; ns_list=ns1.mismatch-delegation-child-2.delegation01.xa/127.16.1.31
   0.09 ERROR    Delegation01   NOT_ENOUGH_IPV6_NS_DEL  count=1; minimum=2; ns_list=ns2.mismatch-delegation-child-2.delegation01.xa/fda1:b2:c3:0:127:16:1:32
```

--> Unexpected
