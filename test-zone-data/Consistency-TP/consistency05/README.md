# CONSISTENCY05

[This directory](.), i.e. the same directory as this README file, holds
zonefiles and `coredns` configuration files for scenarios for test case ZONE09:

* CHILD_NS_FAILED
* NO_RESPONSE
* IN_BAILIWICK_ADDR_MISMATCH
* OUT_OF_BAILIWICK_ADDR_MISMATCH
* EXTRA_ADDRESS_CHILD
* ADDRESSES_MATCH

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
CHILD-NS-FAILED  | CHILD_NS_FAILED, CHILD_ZONE_LAME                          | NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli CHILD-NS-FAILED.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug
   0.19 DEBUG    CHILD_NS_FAILED   ns=ns1.child-ns-failed.consistency05.xa/127.14.5.31
   0.19 ERROR    CHILD_ZONE_LAME
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE  | NO_RESPONSE, CHILD_ZONE_LAME                          | CHILD_NS_FAILED IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli NO-RESPONSE.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
  20.19 ERROR    CHILD_ZONE_LAME
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IN-BAILIWICK-ADDR-MISMATCH  | IN_BAILIWICK_ADDR_MISMATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli IN-BAILIWICK-ADDR-MISMATCH.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level error
   0.29 ERROR    IN_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.31;ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.32;ns1.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns1.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.31;ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.33;ns1.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.32;ns2.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:32
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
OUT-OF-BAILIWICK-ADDR-MISMATCH  | OUT_OF_BAILIWICK_ADDR_MISMATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli OUT-OF-BAILIWICK-ADDR-MISMATCH.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level error
   0.35 ERROR    OUT_OF_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.31;ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.32;ns1.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns1.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.in-bailiwick-addr-mismatch.consistency05.xa./127.14.5.31;ns1.in-bailiwick-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:31
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
EXTRA-ADDRESS-CHILD  | EXTRA_ADDRESS_CHILD                           | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, ADDRESSES_MATCH
```
$ zonemaster-cli EXTRA-ADDRESS-CHILD.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level info
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.21 NOTICE   EXTRA_ADDRESS_CHILD   ns_ip_list=ns1.extra-address-child.consistency05.xa./127.14.5.33
```
Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-1  | ADDRESSES_MATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, IN_BAILIWICK_ADDR_MISMATCH
```
$ zonemaster-cli ADDRESSES-MATCH-1.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level info
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.21 INFO     ADDRESSES_MATCH
```
Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-2  | ADDRESSES_MATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, IN_BAILIWICK_ADDR_MISMATCH
```
$ zonemaster-cli ADDRESSES-MATCH-2.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level info
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.24 INFO     ADDRESSES_MATCH
```
