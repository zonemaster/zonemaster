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
* CHILD-ZONE-LAME-1
* CHILD-ZONE-LAME-2
* IB-ADDR-MISMATCH-1
* IB-ADDR-MISMATCH-2
* IB-ADDR-MISMATCH-3
* OOB-ADDR-MISMATCH
* EXTRA-ADDRESS-CHILD

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-1     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
```
$ zonemaster-cli ADDRESSES-MATCH-1.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -v EXTERNAL_QUERY
   0.00 DEBUG    START_TIME   string=2023-11-08 14:00:27 +0000; time_t=1699452027
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55abd8014eb0); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.22 INFO     ADDRESSES_MATCH
   0.22 DEBUG    TEST_CASE_END   testcase=consistency05
   0.22 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-2     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
```
$ zonemaster-cli ADDRESSES-MATCH-2.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -v EXTERNAL_QUERY
   0.00 DEBUG    START_TIME   string=2023-11-08 14:06:18 +0000; time_t=1699452378
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x560c163584a8); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.18 INFO     ADDRESSES_MATCH
   0.18 DEBUG    TEST_CASE_END   testcase=consistency05
   0.18 DEBUG    MODULE_END   module=Consistency
```
-->OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-3     | ADDRESSES_MATCH,CHILD_NS_FAILED                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-3.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -v EXTERNAL_QUERY
   0.00 DEBUG    START_TIME   string=2023-11-08 14:07:24 +0000; time_t=1699452444
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55ce0d30e070); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.22 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.22 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/127.14.5.31
   0.22 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.22 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-3.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.22 INFO     ADDRESSES_MATCH
   0.22 DEBUG    TEST_CASE_END   testcase=consistency05
   0.22 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-4     | ADDRESSES_MATCH,CHILD_NS_FAILED                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-4.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -v EXTERNAL_QUERY
   0.00 DEBUG    START_TIME   string=2023-11-08 14:08:16 +0000; time_t=1699452496
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x559c72d54500); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/127.14.5.31
   0.21 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.22 DEBUG    CHILD_NS_FAILED   ns=ns1.addresses-match-4.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.22 INFO     ADDRESSES_MATCH
   0.22 DEBUG    TEST_CASE_END   testcase=consistency05
   0.22 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-5     | ADDRESSES_MATCH,NO_RESPONSE                       | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED

```
$ zonemaster-cli ADDRESSES-MATCH-5.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:09:10 +0000; time_t=1699452550
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x5583772181a8); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
  20.23 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.23 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.23 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.23 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.24 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.24 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/127.14.5.31
  20.24 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.24 DEBUG    NO_RESPONSE   ns=ns1.addresses-match-5.consistency05.xa/fda1:b2:c3:0:127:14:5:31
  20.24 INFO     ADDRESSES_MATCH
  20.24 DEBUG    TEST_CASE_END   testcase=consistency05
  20.24 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-6     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-6.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:10:58 +0000; time_t=1699452658
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55e693a97538); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.22 INFO     ADDRESSES_MATCH
   0.22 DEBUG    TEST_CASE_END   testcase=consistency05
   0.22 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ADDRESSES-MATCH-7     | ADDRESSES_MATCH                                   | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE

```
$ zonemaster-cli ADDRESSES-MATCH-7.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:11:36 +0000; time_t=1699452696
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55d7a05531f0); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.22 INFO     ADDRESSES_MATCH
   0.22 DEBUG    TEST_CASE_END   testcase=consistency05
   0.22 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
CHILD-ZONE-LAME-1     | CHILD_ZONE_LAME, NO_RESPONSE    	          | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_NS_FAILED, ADDRESSES_MATCH

```
$ zonemaster-cli CHILD-ZONE-LAME-1.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:12:49 +0000; time_t=1699452769
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x564448d87f68); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
  40.23 ERROR    CHILD_ZONE_LAME
  40.23 DEBUG    TEST_CASE_END   testcase=consistency05
  40.23 DEBUG    MODULE_END   module=Consistency
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1301].


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
CHILD-ZONE-LAME-2     | CHILD_ZONE_LAME, CHILD_NS_FAILED                  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli CHILD-ZONE-LAME-2.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:15:53 +0000; time_t=1699452953
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x5581ef7b4ba8); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns1.child-zone-lame-2.consistency05.xa/127.14.5.31
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns1.child-zone-lame-2.consistency05.xa/127.14.5.31
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns1.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns1.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:31
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns2.child-zone-lame-2.consistency05.xa/127.14.5.32
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns2.child-zone-lame-2.consistency05.xa/127.14.5.32
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns2.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32
   0.23 DEBUG    CHILD_NS_FAILED   ns=ns2.child-zone-lame-2.consistency05.xa/fda1:b2:c3:0:127:14:5:32
   0.23 ERROR    CHILD_ZONE_LAME
   0.23 DEBUG    TEST_CASE_END   testcase=consistency05
   0.23 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-1    | IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD	  | OUT_OF_BAILIWICK_ADDR_MISMATCH, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-1.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:17:55 +0000; time_t=1699453075
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55d1d06f5030); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.22 ERROR    IN_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns1.ib-addr-mismatch-1.consistency05.xa./127.14.5.39;ns1.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:39;ns2.ib-addr-mismatch-1.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.ib-addr-mismatch-1.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.ib-addr-mismatch-1.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:32
   0.22 NOTICE   EXTRA_ADDRESS_CHILD   ns_ip_list=ns1.ib-addr-mismatch-1.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-1.consistency05.xa./fda1:b2:c3:0:127:14:5:31
   0.22 DEBUG    TEST_CASE_END   testcase=consistency05
   0.22 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-2    | IN_BAILIWICK_ADDR_MISMATCH                        | OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-2.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:19:05 +0000; time_t=1699453145
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x55e31223f950); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.20 ERROR    IN_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns1.ib-addr-mismatch-2.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-2.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.ib-addr-mismatch-2.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-2.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.ib-addr-mismatch-2.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-2.consistency05.xa./fda1:b2:c3:0:127:14:5:31
   0.20 DEBUG    TEST_CASE_END   testcase=consistency05
   0.20 DEBUG    MODULE_END   module=Consistency
```
--> OK


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
IB-ADDR-MISMATCH-3    | IN_BAILIWICK_ADDR_MISMATCH, NO_RESPONSE           | OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli IB-ADDR-MISMATCH-3.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR|DEPENDENCY_VERSION'
   0.00 DEBUG    START_TIME   string=2023-11-12 13:12:47 +0000; time_t=1699794767
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x5606f4c1f880); module=Consistency; testcase=consistency05
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.00 DEBUG    MODULE_VERSION   module=Zonemaster::Engine::Test::Consistency; version=v1.1.16
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
  20.36 ERROR    IN_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns1.ib-addr-mismatch-3.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-3.consistency05.xa./fda1:b2:c3:0:127:14:5:31;ns2.ib-addr-mismatch-3.consistency05.xa./127.14.5.32;ns2.ib-addr-mismatch-3.consistency05.xa./fda1:b2:c3:0:127:14:5:32; zone_addresses=ns1.ib-addr-mismatch-3.consistency05.xa./127.14.5.31;ns1.ib-addr-mismatch-3.consistency05.xa./fda1:b2:c3:0:127:14:5:31
  20.36 DEBUG    TEST_CASE_END   testcase=consistency05
  20.36 DEBUG    MODULE_END   module=Consistency
```
--> missing NO_RESPONSE -- Judged to be a bug in the implementation. See issue [zonemaster-engine#1301].


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
EXTRA-ADDRESS-CHILD   | EXTRA_ADDRESS_CHILD				  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli EXTRA-ADDRESS-CHILD.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:22:46 +0000; time_t=1699453366
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x559c93cc4978); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
   0.23 NOTICE   EXTRA_ADDRESS_CHILD   ns_ip_list=ns2.extra-address-child.consistency05.xa./127.14.5.35;ns2.extra-address-child.consistency05.xa./fda1:b2:c3:0:127:14:5:35
   0.23 DEBUG    TEST_CASE_END   testcase=consistency05
   0.23 DEBUG    MODULE_END   module=Consistency
```
--> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
OOB-ADDR-MISMATCH     | OUT_OF_BAILIWICK_ADDR_MISMATCH			  | IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH

```
$ zonemaster-cli child.OOB-ADDR-MISMATCH.consistency05.xa --raw  --test Consistency/consistency05 --hints COMMON/hintfile --level debug | grep -vE 'EXTERNAL_QUERY|IS_BLACKLISTED|LOOKUP_ERROR'
   0.00 DEBUG    START_TIME   string=2023-11-08 14:24:07 +0000; time_t=1699453447
   0.00 DEBUG    TEST_ARGS   args=Zonemaster::Engine::Zone=HASH(0x561a74b32b78); module=Consistency; testcase=consistency05
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
   0.00 DEBUG    TEST_CASE_START   testcase=consistency05
  20.34 ERROR    OUT_OF_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns2.sibbling.oob-addr-mismatch.consistency05.xa./127.14.5.34;ns2.sibbling.oob-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:34; zone_addresses=
  20.36 ERROR    OUT_OF_BAILIWICK_ADDR_MISMATCH   parent_addresses=ns1.sibbling.oob-addr-mismatch.consistency05.xa./127.14.5.39;ns1.sibbling.oob-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:39; zone_addresses=ns1.sibbling.oob-addr-mismatch.consistency05.xa./127.14.5.33;ns1.sibbling.oob-addr-mismatch.consistency05.xa./fda1:b2:c3:0:127:14:5:33
  20.36 DEBUG    TEST_CASE_END   testcase=consistency05
  20.36 DEBUG    MODULE_END   module=Consistency
```
--> OK



[zonemaster-engine#1301]:                                 https://github.com/zonemaster/zonemaster-engine/issues/1301
