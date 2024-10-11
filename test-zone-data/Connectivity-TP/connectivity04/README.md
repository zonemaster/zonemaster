# Connectivity04

[This directory](.), i.e. the same directory as this README file, holds
zone files and `coredns` configuration files for scenarios for test case Connectivity04.

## All message tags

* CN04_EMPTY_PREFIX_SET
* CN04_ERROR_PREFIX_DATABASE
* CN04_IPV4_DIFFERENT_PREFIX
* CN04_IPV4_SAME_PREFIX
* CN04_IPV4_SINGLE_PREFIX
* CN04_IPV6_DIFFERENT_PREFIX
* CN04_IPV6_SAME_PREFIX
* CN04_IPV6_SINGLE_PREFIX

## All scenarios

Scenario name             | Zone name
:-------------------------|:---------------------------------------------
GOOD-1                    | good-1.connectivity04.xa
GOOD-2                    | good-2.connectivity04.xa
GOOD-3                    | good-3.connectivity04.xa
GOOD-4                    | good-4.connectivity04.xa
EMPTY-PREFIX-SET-1        | empty-prefix-set-1.connectivity04.xa
EMPTY-PREFIX-SET-2        | empty-prefix-set-2.connectivity04.xa
EMPTY-PREFIX-SET-3        | empty-prefix-set-3.connectivity04.xa
ERROR-PREFIX-DATABASE-1   | error-prefix-database-1.connectivity04.xa
ERROR-PREFIX-DATABASE-2   | error-prefix-database-2.connectivity04.xa
ERROR-PREFIX-DATABASE-3   | error-prefix-database-3.connectivity04.xa
IPV4-ONE-PREFIX-1         | ipv4-one-prefix-1.connectivity04.xa
IPV4-TWO-PREFIXES-1       | ipv4-two-prefixes-1.connectivity04.xa
IPV6-ONE-PREFIX-1         | ipv6-one-prefix-1.connectivity04.xa
IPV6-TWO-PREFIXES-1       | ipv6-two-prefixes-1.connectivity04.xa
IPV4-SINGLE-NS-1          | ipv4-single-ns-1.connectivity04.xa
IPV6-SINGLE-NS-1          | ipv6-single-ns-1.connectivity04.xa
DOUBBLE-PREFIX-1          | doubble-prefix-1.connectivity04.xa
DOUBBLE-PREFIX-2          | doubble-prefix-2.connectivity04.xa

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level. It is only meaningful to test the test
zones with `--test connetivity04`.

The test zones for these scenarios have a dedicated root zone, which means that
the hint files in the commands below must be used.

All commands are run from the same directory as this file is in.

**The commands below were run before the necessary update of the implementation
of the test case.**

In all outputs below the following command was run with `$SCENARIO` was set to
the scenario name, and the command was run from the same directory as this file
resides in.

```
zonemaster-cli --hint hintfile.zone $SCENARIO.connectivity04.xa --test connectivity04 --show-testcase --level info --raw
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-1                   | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.08 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns0.connectivity04.xa/127.100.100.1;dns1.connectivity04.xa/127.100.101.1
   0.08 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns0.connectivity04.xa/fda1:b2:c3:0:127:100:100:1;dns1.connectivity04.xa/fda1:b2:c3:0:127:100:101:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-2                   | CN04_IPV4_DIFFERENT_PREFIX                               | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.07 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns2.connectivity04.xa/127.100.102.1;dns3.connectivity04.xa/127.100.103.1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-3                   | CN04_IPV6_DIFFERENT_PREFIX                               | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.08 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns4.connectivity04.xa/fda1:b2:c3:0:127:100:104:1;dns5.connectivity04.xa/fda1:b2:c3:0:127:100:105:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
GOOD-4                   | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
Use of uninitialized value $_fields[1] in pattern match (m//) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 93.
Use of uninitialized value $_prefix_length in numeric gt (>) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 94.
Use of uninitialized value $_fields[1] in pattern match (m//) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 93.
Use of uninitialized value $_prefix_length in numeric gt (>) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 94.
   0.09 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns1.connectivity04.xa/127.100.101.1;dns6.connectivity04.xa/127.100.106.1
   0.09 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns1.connectivity04.xa/fda1:b2:c3:0:127:100:101:1;dns6.connectivity04.xa/fda1:b2:c3:0:127:100:106:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
EMPTY-PREFIX-SET-1       | CN04_EMPTY_PREFIX_SET                                    | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.06 ERROR    Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=127.100.107.1
   0.07 ERROR    Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=fda1:b2:c3:0:127:100:107:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
EMPTY-PREFIX-SET-2       | CN04_EMPTY_PREFIX_SET                                    | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.05 ERROR    Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=127.100.108.1
   0.06 ERROR    Connectivity04 CN04_EMPTY_PREFIX_SET  ns_ip=fda1:b2:c3:0:127:100:108:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
EMPTY-PREFIX-SET-3       | CN04_EMPTY_PREFIX_SET                                    | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
Use of uninitialized value $_fields[1] in pattern match (m//) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 93.
Use of uninitialized value $_prefix_length in numeric gt (>) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 94.
Use of uninitialized value in subroutine entry at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 102.
Use of uninitialized value $_fields[1] in pattern match (m//) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 93.
Use of uninitialized value $_prefix_length in numeric gt (>) at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 94.
Use of uninitialized value in subroutine entry at /usr/local/share/perl/5.34.0/Zonemaster/Engine/ASNLookup.pm line 102.
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-1  | CN04_ERROR_PREFIX_DATABASE                               | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.05 ERROR    Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.110.1
   0.07 ERROR    Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:110:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-2  | CN04_ERROR_PREFIX_DATABASE                               | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.08 ERROR    Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.111.1
   0.11 ERROR    Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:111:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
ERROR-PREFIX-DATABASE-3  | CN04_ERROR_PREFIX_DATABASE                               | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
  40.17 ERROR    Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=127.100.112.1
  40.19 ERROR    Connectivity04 CN04_ERROR_PREFIX_DATABASE  ns_ip=fda1:b2:c3:0:127:100:112:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV4-ONE-PREFIX-1        | CN04_IPV4_SAME_PREFIX, CN04_IPV4_SINGLE_PREFIX           | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.05 WARNING  Connectivity04 CN04_IPV4_SAME_PREFIX  ip_prefix=127.100.113.0/24; ns_list=dns13-1.connectivity04.xa/127.100.113.1;dns13-2.connectivity04.xa/127.100.113.2
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV4-TWO-PREFIXES-1      | CN04_IPV4_SAME_PREFIX, CN04_IPV4_DIFFERENT_PREFIX        | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.06 WARNING  Connectivity04 CN04_IPV4_SAME_PREFIX  ip_prefix=127.100.114.0/24; ns_list=dns14-1.connectivity04.xa/127.100.114.1;dns14-2.connectivity04.xa/127.100.114.2
   0.06 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns15.connectivity04.xa/127.100.115.1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV6-ONE-PREFIX-1        | CN04_IPV6_SAME_PREFIX, CN04_IPV6_SINGLE_PREFIX           | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.06 WARNING  Connectivity04 CN04_IPV6_SAME_PREFIX  ip_prefix=fda1:b2:c3:0:127:100:116:0/112; ns_list=dns16-1.connectivity04.xa/fda1:b2:c3:0:127:100:116:1;dns16-2.connectivity04.xa/fda1:b2:c3:0:127:100:116:2
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV6-TWO-PREFIXES-1      | CN04_IPV6_SAME_PREFIX, CN04_IPV6_SINGLE_PREFIX           | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.08 WARNING  Connectivity04 CN04_IPV6_SAME_PREFIX  ip_prefix=fda1:b2:c3:0:127:100:117:0/112; ns_list=dns17-1.connectivity04.xa/fda1:b2:c3:0:127:100:117:1;dns17-2.connectivity04.xa/fda1:b2:c3:0:127:100:117:2
   0.08 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns18.connectivity04.xa/fda1:b2:c3:0:127:100:118:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV4-SINGLE-NS-1         | CN04_IPV4_SINGLE_PREFIX, CN04_IPV4_DIFFERENT_PREFIX      | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.04 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns19.connectivity04.xa/127.100.119.1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
IPV6-SINGLE-NS-1         | CN04_IPV6_SINGLE_PREFIX, CN04_IPV6_DIFFERENT_PREFIX      | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.05 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns20.connectivity04.xa/fda1:b2:c3:0:127:100:120:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
DOUBBLE-PREFIX-1         | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.10 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns21.connectivity04.xa/127.100.121.1;dns22.connectivity04.xa/127.100.122.1
   0.10 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns21.connectivity04.xa/fda1:b2:c3:0:127:100:121:1;dns22.connectivity04.xa/fda1:b2:c3:0:127:100:122:1
```

Scenario name            | Mandatory message tag                                    | Forbidden message tags
:------------------------|:---------------------------------------------------------|:--------------------
DOUBBLE-PREFIX-2         | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX   | 2)

```
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.13 INFO     Connectivity04 CN04_IPV4_DIFFERENT_PREFIX  ns_list=dns23.connectivity04.xa/127.100.123.1;dns24.connectivity04.xa/127.100.124.1
   0.13 INFO     Connectivity04 CN04_IPV6_DIFFERENT_PREFIX  ns_list=dns23.connectivity04.xa/fda1:b2:c3:0:127:100:123:1;dns24.connectivity04.xa/fda1:b2:c3:0:127:100:124:1
```





