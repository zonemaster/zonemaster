# Delegation02 Test Zones Output

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

* DEL_DISTINCT_NS_IP
* CHILD_DISTINCT_NS_IP
* DEL_NS_SAME_IP
* CHILD_NS_SAME_IP

## All scenarios

Scenario name                 | Zone name
:-----------------------------|:---------------------------------------------
ALL-DISTINCT-1                | all-distinct-1.delegation02.xa
ALL-DISTINCT-2                | all-distinct-2.delegation02.xa
ALL-DISTINCT-3                | all-distinct-3.delegation02.xa
DEL-NON-DISTINCT              | del-non-distinct.delegation02.xa
DEL-NON-DISTINCT-UND          | del-non-distinct-und.delegation02.xa
CHILD-NON-DISTINCT            | child-non-distinct.delegation02.xa
CHILD-NON-DISTINCT-UND        | child-non-distinct-und.delegation02.xa
NON-DISTINCT-1                | non-distinct-1.delegation02.xa
NON-DISTINCT-2                | non-distinct-2.delegation02.xa
NON-DISTINCT-3                | non-distinct-3.delegation02.xa

## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with `--level=info
--test=delegation02`.

The test zones for these scenarios have a dedicated root zone, which means that
the hint files in the commands below must be used.

All commands are run from the same directory as this file is in.

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
ALL-DISTINCT-1                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw ALL-DISTINCT-1.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.07 INFO     Delegation02   DEL_DISTINCT_NS_IP  
   0.07 INFO     Delegation02   CHILD_DISTINCT_NS_IP  
   0.07 INFO     Delegation02   DISTINCT_IP_ADDRESS  
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
ALL-DISTINCT-2                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw ALL-DISTINCT-2.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.07 INFO     Delegation02   DEL_DISTINCT_NS_IP  
   0.07 INFO     Delegation02   CHILD_DISTINCT_NS_IP  
   0.07 INFO     Delegation02   DISTINCT_IP_ADDRESS  
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
ALL-DISTINCT-3                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw ALL-DISTINCT-3.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.05 INFO     Delegation02   DEL_DISTINCT_NS_IP  
   0.05 INFO     Delegation02   CHILD_DISTINCT_NS_IP  
   0.05 INFO     Delegation02   DISTINCT_IP_ADDRESS  
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
DEL-NON-DISTINCT              | DEL_NS_SAME_IP, CHILD_DISTINCT_NS_IP     | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw DEL-NON-DISTINCT.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.09 INFO     Delegation02   DEL_DISTINCT_NS_IP  
   0.09 INFO     Delegation02   CHILD_DISTINCT_NS_IP  
   0.09 INFO     Delegation02   DISTINCT_IP_ADDRESS  
```

--> unexpected

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
DEL-NON-DISTINCT-UND          | DEL_NS_SAME_IP, CHILD_DISTINCT_NS_IP     | 2)

* Undelegated data:
  * ns1a.del-non-distinct-und.delegation02.xa/127.16.2.31
  * ns1a.del-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:31
  * ns1b.del-non-distinct-und.delegation02.xa/127.16.2.31
  * ns1b.del-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:31

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw DEL-NON-DISTINCT-UND.delegation02.xa --ns ns1a.del-non-distinct-und.delegation02.xa/127.16.2.31 --ns ns1a.del-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:31 --ns ns1b.del-non-distinct-und.delegation02.xa/127.16.2.31 --ns ns1b.del-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:31
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.03 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.del-non-distinct-und.delegation02.xa;ns1b.del-non-distinct-und.delegation02.xa
   0.03 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.del-non-distinct-und.delegation02.xa;ns1b.del-non-distinct-und.delegation02.xa
   0.03 INFO     Delegation02   CHILD_DISTINCT_NS_IP  
   0.03 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=127.16.2.31; nsname_list=ns1a.del-non-distinct-und.delegation02.xa;ns1b.del-non-distinct-und.delegation02.xa
   0.03 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.del-non-distinct-und.delegation02.xa;ns1b.del-non-distinct-und.delegation02.xa
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
CHILD-NON-DISTINCT            | DEL_DISTINCT_NS_IP, CHILD_NS_SAME_IP     | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw CHILD-NON-DISTINCT.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.07 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.child-non-distinct.delegation02.xa;ns1b.child-non-distinct.delegation02.xa
   0.07 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.child-non-distinct.delegation02.xa;ns1b.child-non-distinct.delegation02.xa
   0.07 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.child-non-distinct.delegation02.xa;ns1b.child-non-distinct.delegation02.xa
   0.07 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.child-non-distinct.delegation02.xa;ns1b.child-non-distinct.delegation02.xa
   0.07 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=127.16.2.31; nsname_list=ns1a.child-non-distinct.delegation02.xa;ns1b.child-non-distinct.delegation02.xa
   0.07 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.child-non-distinct.delegation02.xa;ns1b.child-non-distinct.delegation02.xa
```

--> unexpected

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
CHILD-NON-DISTINCT-UND        | DEL_DISTINCT_NS_IP, CHILD_NS_SAME_IP     | 2)

* Undelegated data:
  * ns1a.child-non-distinct-und.delegation02.xa/127.16.2.31
  * ns1a.child-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:31
  * ns1b.child-non-distinct-und.delegation02.xa/127.16.2.32
  * ns1b.child-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:32

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw CHILD-NON-DISTINCT-UND.delegation02.xa --ns ns1a.child-non-distinct-und.delegation02.xa/127.16.2.31  --ns ns1a.child-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:31 --ns ns1b.child-non-distinct-und.delegation02.xa/127.16.2.32 --ns ns1b.child-non-distinct-und.delegation02.xa/fda1:b2:c3:0:127:16:2:32
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.04 INFO     Delegation02   DEL_DISTINCT_NS_IP  
   0.04 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.child-non-distinct-und.delegation02.xa;ns1b.child-non-distinct-und.delegation02.xa
   0.04 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.child-non-distinct-und.delegation02.xa;ns1b.child-non-distinct-und.delegation02.xa
   0.04 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=127.16.2.31; nsname_list=ns1a.child-non-distinct-und.delegation02.xa;ns1b.child-non-distinct-und.delegation02.xa
   0.04 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.child-non-distinct-und.delegation02.xa;ns1b.child-non-distinct-und.delegation02.xa
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
NON-DISTINCT-1                | DEL_NS_SAME_IP, CHILD_NS_SAME_IP         | 2)
```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw NON-DISTINCT-1.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.11 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.non-distinct-1.delegation02.xa;ns1b.non-distinct-1.delegation02.xa
   0.11 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.non-distinct-1.delegation02.xa;ns1b.non-distinct-1.delegation02.xa
   0.11 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.non-distinct-1.delegation02.xa;ns1b.non-distinct-1.delegation02.xa
   0.11 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.non-distinct-1.delegation02.xa;ns1b.non-distinct-1.delegation02.xa
   0.11 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=127.16.2.31; nsname_list=ns1a.non-distinct-1.delegation02.xa;ns1b.non-distinct-1.delegation02.xa
   0.11 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.non-distinct-1.delegation02.xa;ns1b.non-distinct-1.delegation02.xa
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
NON-DISTINCT-2                | DEL_NS_SAME_IP, CHILD_NS_SAME_IP         | 2)
```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw NON-DISTINCT-2.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.06 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=127.16.2.37; nsname_list=ns1a.non-distinct-2.delegation02.xb;ns1b.non-distinct-2.delegation02.xb
   0.06 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:37; nsname_list=ns1a.non-distinct-2.delegation02.xb;ns1b.non-distinct-2.delegation02.xb
   0.06 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=127.16.2.37; nsname_list=ns1a.non-distinct-2.delegation02.xb;ns1b.non-distinct-2.delegation02.xb
   0.06 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:37; nsname_list=ns1a.non-distinct-2.delegation02.xb;ns1b.non-distinct-2.delegation02.xb
   0.06 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=127.16.2.37; nsname_list=ns1a.non-distinct-2.delegation02.xb;ns1b.non-distinct-2.delegation02.xb
   0.06 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=fda1:b2:c3:0:127:16:2:37; nsname_list=ns1a.non-distinct-2.delegation02.xb;ns1b.non-distinct-2.delegation02.xb
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
NON-DISTINCT-3                | DEL_NS_SAME_IP, CHILD_NS_SAME_IP         | 2)
```
$ zonemaster-cli --hint=hintfile.zone --test=delegation02 --level=info --show-testcase --raw NON-DISTINCT-3.delegation02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.06 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.non-distinct-3.sibbling.delegation02.xa;ns1b.non-distinct-3.sibbling.delegation02.xa
   0.06 ERROR    Delegation02   DEL_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.non-distinct-3.sibbling.delegation02.xa;ns1b.non-distinct-3.sibbling.delegation02.xa
   0.06 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=127.16.2.31; nsname_list=ns1a.non-distinct-3.sibbling.delegation02.xa;ns1b.non-distinct-3.sibbling.delegation02.xa
   0.06 ERROR    Delegation02   CHILD_NS_SAME_IP  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.non-distinct-3.sibbling.delegation02.xa;ns1b.non-distinct-3.sibbling.delegation02.xa
   0.06 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=127.16.2.31; nsname_list=ns1a.non-distinct-3.sibbling.delegation02.xa;ns1b.non-distinct-3.sibbling.delegation02.xa
   0.06 ERROR    Delegation02   SAME_IP_ADDRESS  ns_ip=fda1:b2:c3:0:127:16:2:31; nsname_list=ns1a.non-distinct-3.sibbling.delegation02.xa;ns1b.non-distinct-3.sibbling.delegation02.xa
```

--OK

