# DNSSEC03

[This directory](.), i.e. the same directory as this README file, holds
zone files and `coredns` configuration files for scenarios for test case DNSSEC03:

* NO-DNSSEC-SUPPORT
* NO-NSEC3
* GOOD-VALUES
* ERR-MULT-NSEC3
* BAD-VALUES
* INCONSISTENT-VALUES
* NSEC3-OPT-OUT-ENABLED-TLD
* SERVER-NO-DNSSEC-SUPPORT
* SERVER-NO-NSEC3
* UNASSIGNED-FLAG-USED


## Limitation

These scenarios cannot be tested until pull request zonemaster/zonemaster#1189
has been implemented.


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level. It is only meaningful to test the
test zones with test case DNSSEC03.

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
NO-DNSSEC-SUPPORT            | DS03_NO_DNSSEC_SUPPORT                            | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli no-dnssec-support.dnssec03.xa --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.11 NOTICE   DS03_NO_DNSSEC_SUPPORT   ns_list=ns1.no-dnssec-support.dnssec03.xa/127.15.3.31;ns1.no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.no-dnssec-support.dnssec03.xa/127.15.3.32;ns2.no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
```

--> OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
NO-NSEC3                     | DS03_NO_NSEC3                                     | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NO_DNSSEC_SUPPORT, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info no-nsec3.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.16 INFO     DS03_NO_NSEC3   ns_list=ns1.no-nsec3.dnssec03.xa/127.15.3.31;ns1.no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.no-nsec3.dnssec03.xa/127.15.3.32;ns2.no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
```

--> OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
GOOD-VALUES                  | DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info good-values.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.17 INFO     DS03_LEGAL_HASH_ALGO   ns_list=ns1.good-values.dnssec03.xa/127.15.3.31;ns1.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.good-values.dnssec03.xa/127.15.3.32;ns2.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.17 INFO     DS03_NSEC3_OPT_OUT_DISABLED   ns_list=ns1.good-values.dnssec03.xa/127.15.3.31;ns1.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.good-values.dnssec03.xa/127.15.3.32;ns2.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.17 INFO     DS03_LEGAL_ITERATION_VALUE   ns_list=ns1.good-values.dnssec03.xa/127.15.3.31;ns1.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.good-values.dnssec03.xa/127.15.3.32;ns2.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.17 INFO     DS03_LEGAL_EMPTY_SALT   ns_list=ns1.good-values.dnssec03.xa/127.15.3.31;ns1.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.good-values.dnssec03.xa/127.15.3.32;ns2.good-values.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
```

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
ERR-MULT-NSEC3               | DS03_ERR_MULT_NSEC3, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALU, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info err-mult-nsec3.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.21 ERROR    DS03_ERR_MULT_NSEC3   ns_list=ns1.err-mult-nsec3.dnssec03.xa/127.15.3.31;ns1.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.err-mult-nsec3.dnssec03.xa/127.15.3.32;ns2.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.21 INFO     DS03_LEGAL_HASH_ALGO   ns_list=ns1.err-mult-nsec3.dnssec03.xa/127.15.3.31;ns1.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.err-mult-nsec3.dnssec03.xa/127.15.3.32;ns2.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.21 INFO     DS03_NSEC3_OPT_OUT_DISABLED   ns_list=ns1.err-mult-nsec3.dnssec03.xa/127.15.3.31;ns1.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.err-mult-nsec3.dnssec03.xa/127.15.3.32;ns2.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.21 INFO     DS03_LEGAL_ITERATION_VALUE   ns_list=ns1.err-mult-nsec3.dnssec03.xa/127.15.3.31;ns1.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.err-mult-nsec3.dnssec03.xa/127.15.3.32;ns2.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.22 INFO     DS03_LEGAL_EMPTY_SALT   ns_list=ns1.err-mult-nsec3.dnssec03.xa/127.15.3.31;ns1.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.err-mult-nsec3.dnssec03.xa/127.15.3.32;ns2.err-mult-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
```

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
BAD-VALUES                   | DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD | DS03_ERR_MULT_NSEC3, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info bad-values.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
free(): double free detected in tcache 2
Aborted (core dumped)
```

--> Not OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
INCONSISTENT-VALUES          | DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD | DS03_ERR_MULT_NSEC3, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info inconsistent-values.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
free(): double free detected in tcache 2
Aborted (core dumped)
```

--> Not OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
NSEC3-OPT-OUT-ENABLED-TLD    | DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info nsec3-opt-out-enabled-tld-dnssec03
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.07 INFO     DS03_LEGAL_HASH_ALGO   ns_list=ns1.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.31;ns1.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:31;ns2.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.32;ns2.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:32
   0.07 INFO     DS03_NSEC3_OPT_OUT_ENABLED_TLD   ns_list=ns1.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.31;ns1.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:31;ns2.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.32;ns2.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:32
   0.07 INFO     DS03_LEGAL_ITERATION_VALUE   ns_list=ns1.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.31;ns1.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:31;ns2.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.32;ns2.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:32
   0.07 INFO     DS03_LEGAL_EMPTY_SALT   ns_list=ns1.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.31;ns1.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:31;ns2.nsec3-opt-out-enabled-tld-dnssec03/127.15.3.32;ns2.nsec3-opt-out-enabled-tld-dnssec03/fda1:b2:c3:0:127:15:3:32
```

--> OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
SERVER-NO-DNSSEC-SUPPORT    | DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info server-no-dnssec-support.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.15 ERROR    DS03_SERVER_NO_DNSSEC_SUPPORT   ns_list=ns2.server-no-dnssec-support.dnssec03.xa/127.15.3.32;ns2.server-no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.15 INFO     DS03_LEGAL_HASH_ALGO   ns_list=ns1.server-no-dnssec-support.dnssec03.xa/127.15.3.31;ns1.server-no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
   0.15 INFO     DS03_NSEC3_OPT_OUT_DISABLED   ns_list=ns1.server-no-dnssec-support.dnssec03.xa/127.15.3.31;ns1.server-no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
   0.15 INFO     DS03_LEGAL_ITERATION_VALUE   ns_list=ns1.server-no-dnssec-support.dnssec03.xa/127.15.3.31;ns1.server-no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
   0.15 INFO     DS03_LEGAL_EMPTY_SALT   ns_list=ns1.server-no-dnssec-support.dnssec03.xa/127.15.3.31;ns1.server-no-dnssec-support.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
```

--> OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
SERVER-NO-NSEC3             | DS03_SERVER_NO_NSEC3, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_UNASSIGNED_FLAG_USED
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info server-no-nsec3.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.19 ERROR    DS03_SERVER_NO_NSEC3   ns_list=ns2.server-no-nsec3.dnssec03.xa/127.15.3.32;ns2.server-no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.19 INFO     DS03_LEGAL_HASH_ALGO   ns_list=ns1.server-no-nsec3.dnssec03.xa/127.15.3.31;ns1.server-no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
   0.19 INFO     DS03_NSEC3_OPT_OUT_DISABLED   ns_list=ns1.server-no-nsec3.dnssec03.xa/127.15.3.31;ns1.server-no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
   0.19 INFO     DS03_LEGAL_ITERATION_VALUE   ns_list=ns1.server-no-nsec3.dnssec03.xa/127.15.3.31;ns1.server-no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
   0.19 INFO     DS03_LEGAL_EMPTY_SALT   ns_list=ns1.server-no-nsec3.dnssec03.xa/127.15.3.31;ns1.server-no-nsec3.dnssec03.xa/fda1:b2:c3:0:127:15:3:31
```

--> OK

Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
UNASSIGNED-FLAG-USED        | DS03_UNASSIGNED_FLAG_USED, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3
```
$ zonemaster-cli --raw  --test DNSSEC/dnssec03 --hints COMMON/hintfile --level info unassigned-flag-used.dnssec03.xa
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.19 INFO     DS03_LEGAL_HASH_ALGO   ns_list=ns1.unassigned-flag-used.dnssec03.xa/127.15.3.31;ns1.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.unassigned-flag-used.dnssec03.xa/127.15.3.32;ns2.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.19 ERROR    DS03_UNASSIGNED_FLAG_USED   int=3; ns_list=ns1.unassigned-flag-used.dnssec03.xa/127.15.3.31;ns1.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.unassigned-flag-used.dnssec03.xa/127.15.3.32;ns2.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.19 INFO     DS03_LEGAL_ITERATION_VALUE   ns_list=ns1.unassigned-flag-used.dnssec03.xa/127.15.3.31;ns1.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.unassigned-flag-used.dnssec03.xa/127.15.3.32;ns2.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
   0.19 INFO     DS03_LEGAL_EMPTY_SALT   ns_list=ns1.unassigned-flag-used.dnssec03.xa/127.15.3.31;ns1.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:31;ns2.unassigned-flag-used.dnssec03.xa/127.15.3.32;ns2.unassigned-flag-used.dnssec03.xa/fda1:b2:c3:0:127:15:3:32
```

--> Missing DS03_NSEC3_OPT_OUT_DISABLED

