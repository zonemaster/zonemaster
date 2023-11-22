# Nameserver15

[This directory](.), i.e. the same directory as this README file, holds
zone files and `coredns` configuration files for scenarios for test case Nameserver15:

* NO-VERSION-REVEALED-1
* NO-VERSION-REVEALED-2
* NO-VERSION-REVEALED-3
* NO-VERSION-REVEALED-4
* NO-VERSION-REVEALED-5
* NO-VERSION-REVEALED-6
* ERROR-ON-VERSION-QUERY-1
* ERROR-ON-VERSION-QUERY-2
* SOFTWARE-VERSION-1
* SOFTWARE-VERSION-2
* WRONG-CLASS-1
* WRONG-CLASS-2


## Limitation

These scenarios are based on updated testcase as specified in pull request
zonemaster/zonemaster##1199. The reports below are only preliminary reports.


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level. It is only meaningful to test the
test zones with test case Nameserver15.



Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-1     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info no-version-revealed-1.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.09 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.no-version-revealed-1.nameserver15.xa/127.17.15.31;ns1.no-version-revealed-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:31
```
-> OK

Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-2     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info no-version-revealed-2.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.10 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.no-version-revealed-2.nameserver15.xa/127.17.15.32;ns1.no-version-revealed-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:32
```
-> OK

Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-3     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info no-version-revealed-3.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.10 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.no-version-revealed-3.nameserver15.xa/127.17.15.33;ns1.no-version-revealed-3.nameserver15.xa/fda1:b2:c3:0:127:17:15:33
```
-> OK

Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-4     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info no-version-revealed-4.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.16 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.no-version-revealed-4.nameserver15.xa/127.17.15.34;ns1.no-version-revealed-4.nameserver15.xa/fda1:b2:c3:0:127:17:15:34
```
-> OK

Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-5     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info no-version-revealed-5.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.08 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.no-version-revealed-5.nameserver15.xa/127.17.15.35;ns1.no-version-revealed-5.nameserver15.xa/fda1:b2:c3:0:127:17:15:35
```
-> OK

Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-6     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info no-version-revealed-6.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.14 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.no-version-revealed-6.nameserver15.xa/127.17.15.36;ns1.no-version-revealed-6.nameserver15.xa/fda1:b2:c3:0:127:17:15:36
```
-> OK

Scenario name             | Mandatory message tag                              | Forbidden message tags
:-------------------------|:---------------------------------------------------|:-------------------------------------------
ERROR-ON-VERSION-QUERY-1  | N15_ERROR_ON_VERSION_QUERY,N15_NO_VERSION_REVEALED | N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info error-on-version-query-1.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.14 NOTICE   N15_ERROR_ON_VERSION_QUERY   ns_list=ns1.error-on-version-query-1.nameserver15.xa/127.17.15.37;ns1.error-on-version-query-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:37; query_name=version.bind
   0.14 NOTICE   N15_ERROR_ON_VERSION_QUERY   ns_list=ns1.error-on-version-query-1.nameserver15.xa/127.17.15.37;ns1.error-on-version-query-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:37; query_name=version.server
   0.14 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.error-on-version-query-1.nameserver15.xa/127.17.15.37;ns1.error-on-version-query-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:37
```
-> OK

Scenario name             | Mandatory message tag                               | Forbidden message tags
:-------------------------|:----------------------------------------------------|:-------------------------------------------
ERROR-ON-VERSION-QUERY-2  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED | N15_SOFTWARE_VERSION, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info error-on-version-query-2.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
  40.20 NOTICE   N15_ERROR_ON_VERSION_QUERY   ns_list=ns1.error-on-version-query-2.nameserver15.xa/127.17.15.38;ns1.error-on-version-query-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:38; query_name=version.server
  40.21 NOTICE   N15_ERROR_ON_VERSION_QUERY   ns_list=ns1.error-on-version-query-2.nameserver15.xa/127.17.15.38;ns1.error-on-version-query-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:38; query_name=version.bind
  40.21 INFO     N15_NO_VERSION_REVEALED   ns_list=ns1.error-on-version-query-2.nameserver15.xa/127.17.15.38;ns1.error-on-version-query-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:38
```
-> OK


Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
SOFTWARE-VERSION-1        | N15_SOFTWARE_VERSION                  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info software-version-1.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.11 NOTICE   N15_SOFTWARE_VERSION   ns_list=ns1.software-version-1.nameserver15.xa/127.17.15.39;ns1.software-version-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:39; query_name=version.server; string=v0
```
-> OK


Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
SOFTWARE-VERSION-2        | N15_SOFTWARE_VERSION                  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED, N15_WRONG_CLASS
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info software-version-2.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.10 NOTICE   N15_SOFTWARE_VERSION   ns_list=ns1.software-version-2.nameserver15.xa/127.17.15.40;ns1.software-version-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:40; query_name=version.bind; string=v0
```
-> OK


Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
WRONG-CLASS-1             | N15_SOFTWARE_VERSION, N15_WRONG_CLASS | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info wrong-class-1.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.12 NOTICE   N15_SOFTWARE_VERSION   ns_list=ns1.wrong-class-1.nameserver15.xa/127.17.15.41;ns1.wrong-class-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:41; query_name=version.server; string=v0
   0.12 WARNING  N15_WRONG_CLASS   ns_list=ns1.wrong-class-1.nameserver15.xa/127.17.15.41;ns1.wrong-class-1.nameserver15.xa/fda1:b2:c3:0:127:17:15:41
```
-> OK


Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
WRONG-CLASS-2             | N15_SOFTWARE_VERSION, N15_WRONG_CLASS | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED
```
$ zonemaster-cli --raw  --test Nameserver/nameserver15 --hints COMMON/hintfile --level info wrong-class-2.nameserver15.xa.
   0.00 INFO     GLOBAL_VERSION   version=v4.7.3
   0.16 NOTICE   N15_SOFTWARE_VERSION   ns_list=ns1.wrong-class-2.nameserver15.xa/127.17.15.42;ns1.wrong-class-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:42; query_name=version.bind; string=v0
   0.16 WARNING  N15_WRONG_CLASS   ns_list=ns1.wrong-class-2.nameserver15.xa/127.17.15.42;ns1.wrong-class-2.nameserver15.xa/fda1:b2:c3:0:127:17:15:42
```
-> OK

