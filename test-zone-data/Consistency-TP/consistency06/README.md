# CONSISTENCY06

[This directory](.), i.e. the same directory as this README file, holds zonefiles and `coredns` configuration files for scenarios for test case CONSISTENCY06:

* ONE-SOA-MNAME-1
* ONE-SOA-MNAME-2
* ONE-SOA-MNAME-3
* ONE-SOA-MNAME-4
* MULTIPLE-SOA-MNAMES-1
* MULTIPLE-SOA-MNAMES-2
* MULT-SOA-MNAMES-NO-DEL-UNDEL-1
* MULT-SOA-MNAMES-NO-DEL-UNDEL-2
* NO-RESPONSE

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. Use
customized profile (see examples) to raise all tags of interest to `INFO` or
higher. The level then must be `INFO`.

The commands are assumed to be run from the `test-zone-data` directory.

```
--level info --profile COMMON/custom-profile.json
```

The level (`--level`) must be set to the lowest level of the message tags. For this test case `INFO` is the lowest level.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-1       | ONE_SOA_MNAME                                     | NO_RESPONSE, NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-1.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
   0.20 INFO     Consistency06  ONE_SOA_MNAME  mname=ns1.one-soa-mname-1.consistency06.xa.
   0.20 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-2       | ONE_SOA_MNAME, NO_RESPONSE                         | NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-2.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
  10.12 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=one-soa-mname-2.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns1.one-soa-mname-2.consistency06.xa/127.14.6.31; type=NS
  20.13 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=one-soa-mname-2.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns1.one-soa-mname-2.consistency06.xa/fda1:b2:c3:0:127:14:6:31; type=NS
  20.16 INFO     Consistency06  NO_RESPONSE  ns=ns1.one-soa-mname-2.consistency06.xa/127.14.6.31
  20.16 INFO     Consistency06  NO_RESPONSE  ns=ns1.one-soa-mname-2.consistency06.xa/fda1:b2:c3:0:127:14:6:31
  20.17 INFO     Consistency06  NO_RESPONSE  ns=ns1.one-soa-mname-2.consistency06.xa/127.14.6.31
  20.17 INFO     Consistency06  NO_RESPONSE  ns=ns1.one-soa-mname-2.consistency06.xa/fda1:b2:c3:0:127:14:6:31
  20.17 INFO     Consistency06  ONE_SOA_MNAME  mname=ns1.one-soa-mname-2.consistency06.xa.
  20.17 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-3       | ONE_SOA_MNAME, NO_RESPONSE_SOA_QUERY              | NO_RESPONSE, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-3.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
   0.14 INFO     Consistency06  NO_RESPONSE_SOA_QUERY  ns=ns1.one-soa-mname-3.consistency06.xa/127.14.6.31
   0.14 INFO     Consistency06  NO_RESPONSE_SOA_QUERY  ns=ns1.one-soa-mname-3.consistency06.xa/fda1:b2:c3:0:127:14:6:31
   0.15 INFO     Consistency06  NO_RESPONSE_SOA_QUERY  ns=ns1.one-soa-mname-3.consistency06.xa/127.14.6.31
   0.15 INFO     Consistency06  NO_RESPONSE_SOA_QUERY  ns=ns1.one-soa-mname-3.consistency06.xa/fda1:b2:c3:0:127:14:6:31
   0.15 INFO     Consistency06  ONE_SOA_MNAME  mname=ns1.one-soa-mname-3.consistency06.xa.
   0.15 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-4       | ONE_SOA_MNAME, NO_RESPONSE                        | NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-4.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
  10.04 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=one-soa-mname-4.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns2.one-soa-mname-4.consistency06.xa/fda1:b2:c3:0:127:14:6:32; type=SOA
  20.04 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=one-soa-mname-4.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns2.one-soa-mname-4.consistency06.xa/127.14.6.32; type=SOA
  20.21 INFO     Consistency06  ONE_SOA_MNAME  mname=ns1.one-soa-mname-4.consistency06.xa.
  20.21 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1300].

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
MULTIPLE-SOA-MNAMES-1 | MULTIPLE_SOA_MNAMES                               | NO_RESPONSE, NO_RESPONSE_SOA_QUERY, ONE_SOA_MNAME
```
$ zonemaster-cli MULTIPLE-SOA-MNAMES-1.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
   0.18 NOTICE   Consistency06  MULTIPLE_SOA_MNAMES  count=2
   0.18 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
MULTIPLE-SOA-MNAMES-2 | MULTIPLE_SOA_MNAMES, NO_RESPONSE                  | NO_RESPONSE_SOA_QUERY, ONE_SOA_MNAME
```
$ zonemaster-cli MULTIPLE-SOA-MNAMES-2.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
  10.03 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=multiple-soa-mnames-2.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns3.multiple-soa-mnames-2.consistency06.xa/fda1:b2:c3:0:127:14:6:33; type=SOA
  20.05 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=multiple-soa-mnames-2.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns3.multiple-soa-mnames-2.consistency06.xa/127.14.6.33; type=SOA
  20.24 INFO     Consistency06  NO_RESPONSE  ns=ns3.multiple-soa-mnames-2.consistency06.xa/127.14.6.33
  20.24 INFO     Consistency06  NO_RESPONSE  ns=ns3.multiple-soa-mnames-2.consistency06.xa/fda1:b2:c3:0:127:14:6:33
  20.24 INFO     Consistency06  NO_RESPONSE  ns=ns3.multiple-soa-mnames-2.consistency06.xa/127.14.6.33
  20.24 INFO     Consistency06  NO_RESPONSE  ns=ns3.multiple-soa-mnames-2.consistency06.xa/fda1:b2:c3:0:127:14:6:33
  20.24 NOTICE   Consistency06  MULTIPLE_SOA_MNAMES  count=2
  20.24 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name                  | Mandatory message tag                | Forbidden message tags
:------------------------------|:-------------------------------------|:-------------------------------------------
MULT-SOA-MNAMES-NO-DEL-UNDEL-1 | MULTIPLE_SOA_MNAMES                  | NO_RESPONSE, NO_RESPONSE_SOA_QUERY, ONE_SOA_MNAME

* Undelegated data:
  * ns1.mult-soa-mnames-no-del-undel-1.consistency06.xa/127.14.6.31
  * ns1.mult-soa-mnames-no-del-undel-1.consistency06.xa/fda1:b2:c3:0:127:14:6:31
  * ns2.mult-soa-mnames-no-del-undel-1.consistency06.xa/127.14.6.32
  * ns2.mult-soa-mnames-no-del-undel-1.consistency06.xa/fda1:b2:c3:0:127:14:6:32
```
$ zonemaster-cli MULT-SOA-MNAMES-NO-DEL-UNDEL-1.consistency06.xa --raw  --test consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json --ns ns1.mult-soa-mnames-no-del-undel-1.consistency06.xa/127.14.6.31  --ns ns1.mult-soa-mnames-no-del-undel-1.consistency06.xa/fda1:b2:c3:0:127:14:6:31 --ns ns2.mult-soa-mnames-no-del-undel-1.consistency06.xa/127.14.6.32 --ns ns2.mult-soa-mnames-no-del-undel-1.consistency06.xa/fda1:b2:c3:0:127:14:6:32
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
   0.13 NOTICE   Consistency06  MULTIPLE_SOA_MNAMES  count=2
   0.13 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name                  | Mandatory message tag                | Forbidden message tags
:------------------------------|:-------------------------------------|:-------------------------------------------
MULT-SOA-MNAMES-NO-DEL-UNDEL-2 | MULTIPLE_SOA_MNAMES                  | NO_RESPONSE, NO_RESPONSE_SOA_QUERY, ONE_SOA_MNAME

* Undelegated data:
  * ns3.mult-soa-mnames-no-del-undel-2.consistency06.xb
  * ns4.mult-soa-mnames-no-del-undel-2.consistency06.xb
```
$ zonemaster-cli MULT-SOA-MNAMES-NO-DEL-UNDEL-2.consistency06.xa --raw  --test consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json --ns ns3.mult-soa-mnames-no-del-undel-2.consistency06.xb --ns ns4.mult-soa-mnames-no-del-undel-2.consistency06.xb
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
   0.03 NOTICE   Consistency06  MULTIPLE_SOA_MNAMES  count=2
   0.03 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE           | NO-RESPONSE                                       | NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES, ONE_SOA_MNAME
```
$ zonemaster-cli NO-RESPONSE.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --show-testcase  --level info --profile COMMON/custom-profile.json
Loading profile from COMMON/custom-profile.json.
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v5.0.0
   0.00 INFO     Consistency06  TEST_CASE_START  testcase=Consistency06
  10.06 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=no-response.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns2.no-response.consistency06.xa/fda1:b2:c3:0:127:14:6:32; type=SOA
  20.07 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=no-response.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns2.no-response.consistency06.xa/127.14.6.32; type=SOA
  30.08 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=no-response.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns1.no-response.consistency06.xa/fda1:b2:c3:0:127:14:6:31; type=SOA
  40.08 INFO     Consistency06  LOOKUP_ERROR  class=IN; domain=no-response.consistency06.xa; message=Could not send or receive, because of network error.; ns=ns1.no-response.consistency06.xa/127.14.6.31; type=SOA
  40.25 INFO     Consistency06  TEST_CASE_END  testcase=Consistency06
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1300].


[zonemaster-engine#1300]:                                 https://github.com/zonemaster/zonemaster-engine/issues/1300
