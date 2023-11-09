# CONSISTENCY05

[This directory](.), i.e. the same directory as this README file, holds zonefiles and `coredns` configuration files for scenarios for test case CONSISTENCY06:

* ONE-SOA-MNAME-1
* ONE-SOA-MNAME-2
* ONE-SOA-MNAME-3
* MULTIPLE-SOA-MNAMES-1
* MULTIPLE-SOA-MNAMES-2
* NO-RESPONSE

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For this test case `INFO` is the lowest level.

Scenario name         | Mandatory message tags                            | Forbidden mess
age tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-1       | ONE_SOA_MNAME                                     | NO_RESPONSE, NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-1.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 18:31:51 +0000; time_t=1699468311
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55dc52d15118); module=Consistency; testcase=consistency06
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    DEPENDENCY_VERSION   name=Zonemaster::LDNS; version=3.2.0
   0.00 DEBUG    DEPENDENCY_VERSION   name=IO::Socket::INET6; version=2.73
   0.00 DEBUG    DEPENDENCY_VERSION   name=Moose; version=2.2200
   0.00 DEBUG    DEPENDENCY_VERSION   name=Module::Find; version=0.15
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::ShareDir; version=1.118
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::Slurp; version=9999.32
   0.00 DEBUG    DEPENDENCY_VERSION   name=Net::IP::XS; version=0.21
   0.00 DEBUG    DEPENDENCY_VERSION   name=List::MoreUtils; version=0.430
   0.00 DEBUG    DEPENDENCY_VERSION   name=Clone; version=0.45
   0.00 DEBUG    DEPENDENCY_VERSION   name=Readonly; version=2.05
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency06
   0.17 INFO     ONE_SOA_MNAME   mname=ns1.one-soa-mname-1.consistency06.xa.
   0.17 DEBUG    TEST_CASE_END   testcase=consistency06
   0.17 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden mess
age tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-2       | ONE_SOA_MNAME, NO_RESPONSE                         | NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-2.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 18:32:34 +0000; time_t=1699468354
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55d2ba8fb400); module=Consistency; testcase=consistency06
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    DEPENDENCY_VERSION   name=Zonemaster::LDNS; version=3.2.0
   0.00 DEBUG    DEPENDENCY_VERSION   name=IO::Socket::INET6; version=2.73
   0.00 DEBUG    DEPENDENCY_VERSION   name=Moose; version=2.2200
   0.00 DEBUG    DEPENDENCY_VERSION   name=Module::Find; version=0.15
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::ShareDir; version=1.118
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::Slurp; version=9999.32
   0.00 DEBUG    DEPENDENCY_VERSION   name=Net::IP::XS; version=0.21
   0.00 DEBUG    DEPENDENCY_VERSION   name=List::MoreUtils; version=0.430
   0.00 DEBUG    DEPENDENCY_VERSION   name=Clone; version=0.45
   0.00 DEBUG    DEPENDENCY_VERSION   name=Readonly; version=2.05
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency06
  20.19 DEBUG    NO_RESPONSE   ns=ns1.one-soa-mname-2.consistency06.xa/127.14.6.31
  20.19 DEBUG    NO_RESPONSE   ns=ns1.one-soa-mname-2.consistency06.xa/fda1:b2:c3:0:127:14:6:31
  20.20 DEBUG    NO_RESPONSE   ns=ns1.one-soa-mname-2.consistency06.xa/127.14.6.31
  20.20 DEBUG    NO_RESPONSE   ns=ns1.one-soa-mname-2.consistency06.xa/fda1:b2:c3:0:127:14:6:31
  20.20 INFO     ONE_SOA_MNAME   mname=ns1.one-soa-mname-2.consistency06.xa.
  20.20 DEBUG    TEST_CASE_END   testcase=consistency06
  20.20 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden mess
age tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ONE-SOA-MNAME-3       | ONE_SOA_MNAME, NO_RESPONSE_SOA_QUERY              | NO_RESPONSE, MULTIPLE_SOA_MNAMES
```
$ zonemaster-cli ONE-SOA-MNAME-3.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 18:33:24 +0000; time_t=1699468404
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55a9691529a0); module=Consistency; testcase=consistency06
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    DEPENDENCY_VERSION   name=Zonemaster::LDNS; version=3.2.0
   0.00 DEBUG    DEPENDENCY_VERSION   name=IO::Socket::INET6; version=2.73
   0.00 DEBUG    DEPENDENCY_VERSION   name=Moose; version=2.2200
   0.00 DEBUG    DEPENDENCY_VERSION   name=Module::Find; version=0.15
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::ShareDir; version=1.118
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::Slurp; version=9999.32
   0.00 DEBUG    DEPENDENCY_VERSION   name=Net::IP::XS; version=0.21
   0.00 DEBUG    DEPENDENCY_VERSION   name=List::MoreUtils; version=0.430
   0.00 DEBUG    DEPENDENCY_VERSION   name=Clone; version=0.45
   0.00 DEBUG    DEPENDENCY_VERSION   name=Readonly; version=2.05
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency06
   0.17 DEBUG    NO_RESPONSE_SOA_QUERY   ns=ns1.one-soa-mname-3.consistency06.xa/127.14.6.31
   0.17 DEBUG    NO_RESPONSE_SOA_QUERY   ns=ns1.one-soa-mname-3.consistency06.xa/fda1:b2:c3:0:127:14:6:31
   0.17 DEBUG    NO_RESPONSE_SOA_QUERY   ns=ns1.one-soa-mname-3.consistency06.xa/127.14.6.31
   0.17 DEBUG    NO_RESPONSE_SOA_QUERY   ns=ns1.one-soa-mname-3.consistency06.xa/fda1:b2:c3:0:127:14:6:31
   0.17 INFO     ONE_SOA_MNAME   mname=ns1.one-soa-mname-3.consistency06.xa.
   0.17 DEBUG    TEST_CASE_END   testcase=consistency06
   0.17 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden mess
age tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
MULTIPLE-SOA-MNAMES-1 | MULTIPLE_SOA_MNAMES                               | NO_RESPONSE, NO_RESPONSE_SOA_QUERY, ONE_SOA_MNAME
```
$ zonemaster-cli MULTIPLE-SOA-MNAMES-1.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 18:36:14 +0000; time_t=1699468574
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x563e72bfd2e8); module=Consistency; testcase=consistency06
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    DEPENDENCY_VERSION   name=Zonemaster::LDNS; version=3.2.0
   0.00 DEBUG    DEPENDENCY_VERSION   name=IO::Socket::INET6; version=2.73
   0.00 DEBUG    DEPENDENCY_VERSION   name=Moose; version=2.2200
   0.00 DEBUG    DEPENDENCY_VERSION   name=Module::Find; version=0.15
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::ShareDir; version=1.118
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::Slurp; version=9999.32
   0.00 DEBUG    DEPENDENCY_VERSION   name=Net::IP::XS; version=0.21
   0.00 DEBUG    DEPENDENCY_VERSION   name=List::MoreUtils; version=0.430
   0.00 DEBUG    DEPENDENCY_VERSION   name=Clone; version=0.45
   0.00 DEBUG    DEPENDENCY_VERSION   name=Readonly; version=2.05
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency06
   0.17 NOTICE   MULTIPLE_SOA_MNAMES   count=2
   0.17 DEBUG    SOA_MNAME   mname=ns1.multiple-soa-mnames-1.consistency06.xa.; ns_list=ns1.multiple-soa-mnames-1.consistency06.xa/127.14.6.31;ns1.multiple-soa-mnames-1.consistency06.xa/fda1:b2:c3:0:127:14:6:31
   0.17 DEBUG    SOA_MNAME   mname=ns2.multiple-soa-mnames-1.consistency06.xa.; ns_list=ns2.multiple-soa-mnames-1.consistency06.xa/127.14.6.32;ns2.multiple-soa-mnames-1.consistency06.xa/fda1:b2:c3:0:127:14:6:32
   0.17 DEBUG    TEST_CASE_END   testcase=consistency06
   0.17 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden mess
age tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
MULTIPLE-SOA-MNAMES-2 | MULTIPLE_SOA_MNAMES, NO_RESPONSE                  | NO_RESPONSE_SOA_QUERY, ONE_SOA_MNAME
```
$ zonemaster-cli MULTIPLE-SOA-MNAMES-2.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 18:42:40 +0000; time_t=1699468960
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x5575f458f0d8); module=Consistency; testcase=consistency06
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    DEPENDENCY_VERSION   name=Zonemaster::LDNS; version=3.2.0
   0.00 DEBUG    DEPENDENCY_VERSION   name=IO::Socket::INET6; version=2.73
   0.00 DEBUG    DEPENDENCY_VERSION   name=Moose; version=2.2200
   0.00 DEBUG    DEPENDENCY_VERSION   name=Module::Find; version=0.15
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::ShareDir; version=1.118
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::Slurp; version=9999.32
   0.00 DEBUG    DEPENDENCY_VERSION   name=Net::IP::XS; version=0.21
   0.00 DEBUG    DEPENDENCY_VERSION   name=List::MoreUtils; version=0.430
   0.00 DEBUG    DEPENDENCY_VERSION   name=Clone; version=0.45
   0.00 DEBUG    DEPENDENCY_VERSION   name=Readonly; version=2.05
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency06
   0.18 NOTICE   MULTIPLE_SOA_MNAMES   count=2
   0.18 DEBUG    SOA_MNAME   mname=ns1.multiple-soa-mnames-2.consistency06.xa.; ns_list=ns1.multiple-soa-mnames-2.consistency06.xa/127.14.6.31;ns1.multiple-soa-mnames-2.consistency06.xa/fda1:b2:c3:0:127:14:6:31
   0.18 DEBUG    SOA_MNAME   mname=ns2.multiple-soa-mnames-2.consistency06.xa.; ns_list=ns2.multiple-soa-mnames-2.consistency06.xa/127.14.6.32;ns2.multiple-soa-mnames-2.consistency06.xa/fda1:b2:c3:0:127:14:6:32
   0.18 DEBUG    TEST_CASE_END   testcase=consistency06
   0.18 DEBUG    MODULE_END   module=Consistency
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1300].

Scenario name         | Mandatory message tags                            | Forbidden mess
age tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE           | NO-RESPONSE                                       | NO_RESPONSE_SOA_QUERY, MULTIPLE_SOA_MNAMES, ONE_SOA_MNAME
```
$ zonemaster-cli NO-RESPONSE.consistency06.xa --raw  --test Consistency/consistency06 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 18:44:48 +0000; time_t=1699469088
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55a6a6536c00); module=Consistency; testcase=consistency06
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    DEPENDENCY_VERSION   name=Zonemaster::LDNS; version=3.2.0
   0.00 DEBUG    DEPENDENCY_VERSION   name=IO::Socket::INET6; version=2.73
   0.00 DEBUG    DEPENDENCY_VERSION   name=Moose; version=2.2200
   0.00 DEBUG    DEPENDENCY_VERSION   name=Module::Find; version=0.15
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::ShareDir; version=1.118
   0.00 DEBUG    DEPENDENCY_VERSION   name=File::Slurp; version=9999.32
   0.00 DEBUG    DEPENDENCY_VERSION   name=Net::IP::XS; version=0.21
   0.00 DEBUG    DEPENDENCY_VERSION   name=List::MoreUtils; version=0.430
   0.00 DEBUG    DEPENDENCY_VERSION   name=Clone; version=0.45
   0.00 DEBUG    DEPENDENCY_VERSION   name=Readonly; version=2.05
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency06
  40.19 DEBUG    TEST_CASE_END   testcase=consistency06
  40.19 DEBUG    MODULE_END   module=Consistency
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1300].


[zonemaster-engine#1300]:                                 https://github.com/zonemaster/zonemaster-engine/issues/1300
