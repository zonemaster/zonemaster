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
CHILD_NS_FAILED  | CHILD_NS_FAILED, CHILD_ZONE_LAME                          | NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli CHILD-NS-FAILED.consistency05.xa --raw  --test Consistency/Consistency05 --hints COMMON/hintfile --level info
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO_RESPONSE  | NO_RESPONSE, CHILD_ZONE_LAME                          | CHILD_NS_FAILED IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli NO-RESPONSE.consistency05.xa --raw  --test Consistency/Consistency05 --hints COMMON/hintfile --level info
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IN_BAILIWICK_ADDR_MISMATCH  | IN_BAILIWICK_ADDR_MISMATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli IN-BAILIWICK-ADDR-MISMATCH.consistency05.xa --raw  --test Consistency/Consistency05 --hints COMMON/hintfile --level info
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
OUT_OF_BAILIWICK_ADDR_MISMATCH  | OUT_OF_BAILIWICK_ADDR_MISMATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, ADDRESSES_MATCH
```
$ zonemaster-cli OUT-OF-BAILIWICK-ADDR-MISMATCH.consistency05.xa --raw  --test Consistency/Consistency05 --hints COMMON/hintfile --level info
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
EXTRA_ADDRESS_CHILD  | EXTRA_ADDRESS_CHILD                           | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, ADDRESSES_MATCH
```
$ zonemaster-cli EXTRA-ADDRESS-CHILD.consistency05.xa --raw  --test Consistency/Consistency05 --hints COMMON/hintfile --level info
```
Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES_MATCH  | ADDRESSES_MATCH                          | CHILD_NS_FAILED, CHILD_ZONE_LAME, NO_RESPONSE, IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, IN_BAILIWICK_ADDR_MISMATCH
```
$ zonemaster-cli ADDRESSES-MATCH.consistency05.xa --raw  --test Consistency/Consistency05 --hints COMMON/hintfile --level info
```
