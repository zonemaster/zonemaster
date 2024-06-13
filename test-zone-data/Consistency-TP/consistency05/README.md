# CONSISTENCY05

[This directory](.), i.e. the same directory as this README file, holds
zonefiles and `coredns` configuration files for scenarios for test case CONISTENCY05:

* ADDRESSES-MATCH-1
* ADDRESSES-MATCH-2
* ADDRESSES-MATCH-3
* ADDRESSES-MATCH-4
* ADDRESSES-MATCH-5
* ADDRESSES-MATCH-6
* ADDRESSES-MATCH-7
* ADDR-MATCH-DEL-UNDEL-1
* ADDR-MATCH-DEL-UNDEL-2
* ADDR-MATCH-NO-DEL-UNDEL-1
* ADDR-MATCH-NO-DEL-UNDEL-2
* CHILD-ZONE-LAME-1
* CHILD-ZONE-LAME-2
* IB-ADDR-MISMATCH-1
* IB-ADDR-MISMATCH-2
* IB-ADDR-MISMATCH-3
* IB-ADDR-MISMATCH-4
* OOB-ADDR-MISMATCH
* EXTRA-ADDRESS-CHILD

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. Use
customized profile (see examples) to raise all tags of interest to `INFO` or
higher. The level then must be `INFO`.

The commands are assumed to be run from the `test-zone-data` directory.

```
--level info --profile COMMON/custom-profile.json
```

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-1     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
```
$ zonemaster-cli ADDRESSES-MATCH-1.consistency05.xa --show-testcase --raw  --test consistency05 --hints COMMON/hintfile --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.20 INFO     Consistency05  ADDRESSES_MATCH
   0.20 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-2     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
```
$ zonemaster-cli ADDRESSES-MATCH-2.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.25 INFO     Consistency05  ADDRESSES_MATCH
   0.25 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
-->OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-3     | ADDRESSES_MATCH,CHILD_NS_FAILED                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-3.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.23 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.24 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.24 INFO     Consistency05  ADDRESSES_MATCH
   0.24 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-4     | ADDRESSES_MATCH,CHILD_NS_FAILED                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-4.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.17 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.17 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.18 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.18 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.18 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.18 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.18 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.18 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.18 INFO     Consistency05  ADDRESSES_MATCH
   0.19 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-5     | ADDRESSES_MATCH,NO_RESPONSE                       | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED

```
$ zonemaster-cli ADDRESSES-MATCH-5.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.01 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
  10.29 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=addresses-match-5.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31; type=NS
  20.30 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=addresses-match-5.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31; type=NS
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.35 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.36 INFO     Consistency05  NO_RESPONSE  ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.36 INFO     Consistency05  ADDRESSES_MATCH
  20.36 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-6     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-6.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.23 INFO     Consistency05  ADDRESSES_MATCH
   0.23 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-7     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-7.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.23 INFO     Consistency05  ADDRESSES_MATCH
   0.23 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name                 | Mandatory message tags         | Forbidden message tags
:-----------------------------|:-------------------------------|:-------------------------------------------
ADDR-MATCH-DEL-UNDEL-1        | ADDRESSES_MATCH                | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

* Undelegated data:
  * ns3.addr-match-del-undel-1.consistency05.xa/127.14.5.33
  * ns3.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:33
  * ns4.addr-match-del-undel-1.consistency05.xa/127.14.5.34
  * ns4.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:34

```
$ zonemaster-cli ADDR-MATCH-DEL-UNDEL-1.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json --ns ns3.addr-match-del-undel-1.consistency05.xa/127.14.5.33 --ns ns3.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:33 --ns ns4.addr-match-del-undel-1.consistency05.xa/127.14.5.34 --ns ns4.addr-match-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:34
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.15 INFO     Consistency05  ADDRESSES_MATCH
   0.15 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name                 | Mandatory message tags         | Forbidden message tags
:-----------------------------|:-------------------------------|:-------------------------------------------
ADDR-MATCH-DEL-UNDEL-2        | ADDRESSES_MATCH                | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

* Undelegated data:
  * ns3.addr-match-del-undel-2.consistency05.xb
  * ns4.addr-match-del-undel-2.consistency05.xb

```
$ zonemaster-cli ADDR-MATCH-DEL-UNDEL-2.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json --ns  ns3.addr-match-del-undel-2.consistency05.xb --ns  ns4.addr-match-del-undel-2.consistency05.xb
Loading profile from COMMON/custom-profile.json.
   0.42 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=addr-match-del-undel-2.consistency05.xa; nsname=ns4.addr-match-del-undel-2.consistency05.xb
   0.43 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=addr-match-del-undel-2.consistency05.xa; nsname=ns3.addr-match-del-undel-2.consistency05.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.11 INFO     Consistency05  ADDRESSES_MATCH
   0.12 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK as specified, but FAKE_DELEGATION_NO_IP is not expected.

Scenario name                 | Mandatory message tags         | Forbidden message tags
:-----------------------------|:-------------------------------|:-------------------------------------------
ADDR-MATCH-NO-DEL-UNDEL-1     | ADDRESSES_MATCH                | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

* Undelegated data:
  * ns1.addr-match-no-del-undel-1.consistency05.xa/127.14.5.31
  * ns1.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  * ns2.addr-match-no-del-undel-1.consistency05.xa/127.14.5.32
  * ns2.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32

```
$ zonemaster-cli ADDR-MATCH-NO-DEL-UNDEL-1.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json  --ns ns1.addr-match-no-del-undel-1.consistency05.xa/127.14.5.31 --ns ns1.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31 --ns ns2.addr-match-no-del-undel-1.consistency05.xa/127.14.5.32 --ns ns2.addr-match-no-del-undel-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.16 INFO     Consistency05  ADDRESSES_MATCH
   0.16 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name                 | Mandatory message tags         | Forbidden message tags
:-----------------------------|:-------------------------------|:-------------------------------------------
ADDR-MATCH-NO-DEL-UNDEL-2     | ADDRESSES_MATCH                | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

* Undelegated data:
  * ns3.addr-match-no-del-undel-2.consistency05.xb
  * ns4.addr-match-no-del-undel-2.consistency05.xb

```
$ zonemaster-cli ADDR-MATCH-NO-DEL-UNDEL-2.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json  --ns ns3.addr-match-no-del-undel-2.consistency05.xb --ns ns4.addr-match-no-del-undel-2.consistency05.xb
Loading profile from COMMON/custom-profile.json.
   0.39 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=addr-match-no-del-undel-2.consistency05.xa; nsname=ns4.addr-match-no-del-undel-2.consistency05.xb
   0.39 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=addr-match-no-del-undel-2.consistency05.xa; nsname=ns3.addr-match-no-del-undel-2.consistency05.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.09 INFO     Consistency05  ADDRESSES_MATCH
   0.09 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK as specified, but FAKE_DELEGATION_NO_IP is not expected.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
CHILD-ZONE-LAME-1     | CHILD_ZONE_LAME, NO_RESPONSE    	          | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_NS_FAILED, ADDRESSES_MATCH

```
$ zonemaster-cli CHILD-ZONE-LAME-1.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
  10.03 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=child-zone-lame-1.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns2.child-zone-lame-1.consistency05.xa/fda1:b2:c3:0:127:14:5:32; type=SOA
  20.04 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=child-zone-lame-1.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns2.child-zone-lame-1.consistency05.xa/127.14.5.32; type=SOA
  30.05 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=child-zone-lame-1.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns1.child-zone-lame-1.consistency05.xa/fda1:b2:c3:0:127:14:5:31; type=SOA
  40.06 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=child-zone-lame-1.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns1.child-zone-lame-1.consistency05.xa/127.14.5.31; type=SOA
  40.19 ERROR    Consistency05  CHILD_ZONE_LAME
  40.19 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1301].

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
CHILD-ZONE-LAME-2     | CHILD_ZONE_LAME, CHILD_NS_FAILED                  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli CHILD-ZONE-LAME-2.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.child-zone-lame-2.consistency05.xa/127.14.5.31
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.child-zone-lame-2.consistency05.xa/127.14.5.31
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns1.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns2.child-zone-lame-2.consistency05.xa/127.14.5.32
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns2.child-zone-lame-2.consistency05.xa/127.14.5.32
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns2.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32
   0.26 INFO     Consistency05  CHILD_NS_FAILED  ns=ns2.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32
   0.26 ERROR    Consistency05  CHILD_ZONE_LAME
   0.26 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-1    | IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD	  | OUT_OF_BAILIWICK_ADDR_MISMATCH, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-1.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.21 ERROR    Consistency05  IN_BAILIWICK_ADDR_MISMATCH  parent_addresses=ns1.ib-addr-mismatch-1.consistency05.xa./127.14.5.39;ns1.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:39;ns2.ib-addr-mismatch-1.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.ib-addr-mismatch-1.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.ib-addr-mismatch-1.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:32
   0.21 NOTICE   Consistency05  EXTRA_ADDRESS_CHILD  ns_ip_list=ns1.ib-addr-mismatch-1.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:31
   0.21 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-2    | IN_BAILIWICK_ADDR_MISMATCH                        | OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-2.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.21 ERROR    Consistency05  IN_BAILIWICK_ADDR_MISMATCH  parent_addresses=ns1.ib-addr-mismatch-2.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-2.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.ib-addr-mismatch-2.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-2.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.ib-addr-mismatch-2.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-2.consistency05.xa./fda1:b2:c3:0:127:14:5:31
   0.21 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-3    | IN_BAILIWICK_ADDR_MISMATCH, NO_RESPONSE           | OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-3.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
  10.03 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=ib-addr-mismatch-3.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns2.ib-addr-mismatch-3.consistency05.xa/fda1:b2:c3:0:127:14:5:32; type=SOA
  20.04 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=ib-addr-mismatch-3.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns2.ib-addr-mismatch-3.consistency05.xa/127.14.5.32; type=SOA
  20.18 ERROR    Consistency05  IN_BAILIWICK_ADDR_MISMATCH  parent_addresses=ns1.ib-addr-mismatch-3.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-3.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.ib-addr-mismatch-3.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-3.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.ib-addr-mismatch-3.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-3.consistency05.xa./fda1:b2:c3:0:127:14:5:31
  20.18 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1301].

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-4    | IN_BAILIWICK_ADDR_MISMATCH                        | OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-4.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.15 ERROR    Consistency05  CHILD_ZONE_LAME
   0.15 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> No OK. See issue [zonemaster-engine#1349].

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
EXTRA-ADDRESS-CHILD   | EXTRA_ADDRESS_CHILD				  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli EXTRA-ADDRESS-CHILD.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
   0.21 NOTICE   Consistency05  EXTRA_ADDRESS_CHILD  ns_ip_list=ns2.extra-address-child.consistency05.xa./127.14.5.35;ns2.extra-address-child.consistency05.xa./fda1:b2:c3:0:127:14:5:35
   0.21 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
OOB-ADDR-MISMATCH     | OUT_OF_BAILIWICK_ADDR_MISMATCH			  | IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli child.OOB-ADDR-MISMATCH.consistency05.xa --raw  --test consistency05 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency05  TEST_CASE_START  testcase=Consistency05
  10.22 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=ns2.sibbling.oob-addr-mismatch.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns1.sibbling.oob-addr-mismatch.consistency05.xa/fda1:b2:c3:0:127:14:5:39; type=A
  20.23 INFO     Consistency05  LOOKUP_ERROR  class=IN; domain=ns2.sibbling.oob-addr-mismatch.consistency05.xa; message=Could not send or receive, because of network error.; ns=ns1.sibbling.oob-addr-mismatch.consistency05.xa/127.14.5.39; type=A
  20.32 ERROR    Consistency05  OUT_OF_BAILIWICK_ADDR_MISMATCH  parent_addresses=ns2.sibbling.oob-addr-mismatch.consistency05.xa./127.14.5.34;ns2.sibbling.oob-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:34; zone_addresses=
  20.35 ERROR    Consistency05  OUT_OF_BAILIWICK_ADDR_MISMATCH  parent_addresses=ns1.sibbling.oob-addr-mismatch.consistency05.xa./127.14.5.39;ns1.sibbling.oob-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:39; zone_addresses=ns1.sibbling.oob-addr-mismatch.consistency05.xa./127.14.5.33;ns1.sibbling.oob-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:33
  20.35 INFO     Consistency05  TEST_CASE_END  testcase=Consistency05
```
--> OK


[zonemaster-engine#1301]:                                 https://github.com/zonemaster/zonemaster-engine/issues/1301
[zonemaster-engine#1349]:                                 https://github.com/zonemaster/zonemaster-engine/issues/1349
