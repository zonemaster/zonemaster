# Basic02 Test Zones Output

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

* B02_AUTH_RESPONSE_SOA
* B02_NO_DELEGATION
* B02_NO_WORKING_NS
* B02_NS_BROKEN
* B02_NS_NOT_AUTH
* B02_NS_NO_IP_ADDR
* B02_NS_NO_RESPONSE
* B02_UNEXPECTED_RCODE

## All scenarios

Scenario name          | Zone name
:----------------------|:---------------------------------------------
GOOD-1                 | good-1.basic02.xa
GOOD-2                 | good-1.basic02.xa
GOOD-UNDEL-1           | good-undel-1.basic02.xa
GOOD-UNDEL-2           | good-undel-2.basic02.xa
GOOD-UNDEL-3           | good-undel-3.basic02.xa
GOOD-UNDEL-4           | good-undel-4.basic02.xa
GOOD-UNDEL-5           | good-undel-5.basic02.xa
GOOD-UNDEL-6           | good-undel-6.basic02.xa
GOOD-UNDEL-7           | good-undel-7.basic02.xa
GOOD-UNDEL-8           | good-undel-8.basic02.xa
GOOD-UNDEL-9           | good-undel-9.basic02.xa
GOOD-UNDEL-10          | good-undel-10.basic02.xa
GOOD-UNDEL-11          | good-undel-11.basic02.xa
MIXED-1                | mixed-1.basic02.xa
NO-DELEGATION-1        | no-delegation.basic02.xa
NS-BROKEN-1            | ns-broken-1.basic02.xa
NS-NOT-AUTH-1          | ns-not-auth-1.basic02.xa
NS-NO-IP-1             | ns-no-ip-1.basic02.xa
NS-NO-IP-2             | ns-no-ip-2.basic02.xa
NS-NO-IP-3             | ns-no-ip-3.basic02.xa
NS-NO-IP-UNDEL-1       | ns-no-ip-undel-1.basic02.xa
NS-NO-IP-UNDEL-2       | ns-no-ip-undel-2.basic02.xa
NS-NO-RESPONSE-1       | ns-no-response-1.basic02.xa
UNEXPECTED-RCODE-1     | unexpected-rcode-1.basic02.xa


## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with `--level=info
--test=basic02`.

The test zones for these scenarios have a dedicated root zone, which means that
the hint files in the commands below must be used.

All commands are run from the same directory as this file is in.

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-1                         | B02_AUTH_RESPONSE_SOA                      | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.04 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-1.basic02.xa"; ns_list=ns1.good-1.basic02.xa/127.12.2.31;ns1.good-1.basic02.xa/fda1:b2:c3:0:127:12:2:31;ns2.good-1.basic02.xa/127.12.2.32;ns2.good-1.basic02.xa/fda1:b2:c3:0:127:12:2:32

```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-2                         | B02_AUTH_RESPONSE_SOA                      | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-2.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.05 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-2.basic02.xa"; ns_list=ns1.good-2.basic02.xb/127.12.2.31;ns1.good-2.basic02.xb/fda1:b2:c3:0:127:12:2:31;ns2.good-2.basic02.xb/127.12.2.32;ns2.good-2.basic02.xb/fda1:b2:c3:0:127:12:2:32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-1                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns1.good-undel-1.basic02.xa/127.12.2.31
  * ns1.good-undel-1.basic02.xa/fda1:b2:c3:0:127:12:2:31
  * ns2.good-undel-1.basic02.xa/127.12.2.32
  * ns2.good-undel-1.basic02.xa/fda1:b2:c3:0:127:12:2:32

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-1.basic02.xa --ns ns1.good-undel-1.basic02.xa/127.12.2.31 --ns ns1.good-undel-1.basic02.xa/fda1:b2:c3:0:127:12:2:31 --ns ns2.good-undel-1.basic02.xa/127.12.2.32 --ns ns2.good-undel-1.basic02.xa/fda1:b2:c3:0:127:12:2:32
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-1.basic02.xa"; ns_list=ns1.good-undel-1.basic02.xa/127.12.2.31;ns1.good-undel-1.basic02.xa/fda1:b2:c3:0:127:12:2:31;ns2.good-undel-1.basic02.xa/127.12.2.32;ns2.good-undel-1.basic02.xa/fda1:b2:c3:0:127:12:2:32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-2                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns1.good-undel-2.basic02.xb
  * ns2.good-undel-2.basic02.xb

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-2.basic02.xa --ns ns1.good-undel-2.basic02.xb --ns ns2.good-undel-2.basic02.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-2.basic02.xa"; ns_list=ns1.good-undel-2.basic02.xb/127.12.2.31;ns1.good-undel-2.basic02.xb/fda1:b2:c3:0:127:12:2:31;ns2.good-undel-2.basic02.xb/127.12.2.32;ns2.good-undel-2.basic02.xb/fda1:b2:c3:0:127:12:2:32
```
--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-3                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns3.good-undel-3.basic02.xb
  * ns4.good-undel-3.basic02.xb

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-3.basic02.xa --ns ns3.good-undel-3.basic02.xb --ns ns4.good-undel-3.basic02.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-3.basic02.xa"; ns_list=ns3.good-undel-3.basic02.xb/127.12.2.33;ns3.good-undel-3.basic02.xb/fda1:b2:c3:0:127:12:2:33;ns4.good-undel-3.basic02.xb/127.12.2.34;ns4.good-undel-3.basic02.xb/fda1:b2:c3:0:127:12:2:34
```
--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-4                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns1.good-undel-4.basic02.xb
  * ns2.good-undel-4.basic02.xb

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-4.basic02.xa --ns ns1.good-undel-4.basic02.xb --ns ns2.good-undel-4.basic02.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.03 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-4.basic02.xa"; ns_list=ns1.good-undel-4.basic02.xb/127.12.2.31;ns1.good-undel-4.basic02.xb/fda1:b2:c3:0:127:12:2:31;ns2.good-undel-4.basic02.xb/127.12.2.32;ns2.good-undel-4.basic02.xb/fda1:b2:c3:0:127:12:2:32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-5                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns1.good-undel-5.basic02.xa/127.12.2.31
  * ns1.good-undel-5.basic02.xa/fda1:b2:c3:0:127:12:2:31
  * ns2.good-undel-5.basic02.xa/127.12.2.32
  * ns2.good-undel-5.basic02.xa/fda1:b2:c3:0:127:12:2:32

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-5.basic02.xa --ns ns1.good-undel-5.basic02.xa/127.12.2.31 --ns ns1.good-undel-5.basic02.xa/fda1:b2:c3:0:127:12:2:31 --ns ns2.good-undel-5.basic02.xa/127.12.2.32 --ns ns2.good-undel-5.basic02.xa/fda1:b2:c3:0:127:12:2:32
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-5.basic02.xa"; ns_list=ns1.good-undel-5.basic02.xa/127.12.2.31;ns1.good-undel-5.basic02.xa/fda1:b2:c3:0:127:12:2:31;ns2.good-undel-5.basic02.xa/127.12.2.32;ns2.good-undel-5.basic02.xa/fda1:b2:c3:0:127:12:2:32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-6                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns3.good-undel-6.basic02.xa/127.12.2.33
  * ns3.good-undel-6.basic02.xa/fda1:b2:c3:0:127:12:2:33
  * ns4.good-undel-6.basic02.xa/127.12.2.34
  * ns4.good-undel-6.basic02.xa/fda1:b2:c3:0:127:12:2:34

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-6.basic02.xa --ns ns3.good-undel-6.basic02.xa/127.12.2.33 --ns ns3.good-undel-6.basic02.xa/fda1:b2:c3:0:127:12:2:33 --ns ns4.good-undel-6.basic02.xa/127.12.2.34 --ns ns4.good-undel-6.basic02.xa/fda1:b2:c3:0:127:12:2:34
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.03 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-6.basic02.xa"; ns_list=ns3.good-undel-6.basic02.xa/127.12.2.33;ns3.good-undel-6.basic02.xa/fda1:b2:c3:0:127:12:2:33;ns4.good-undel-6.basic02.xa/127.12.2.34;ns4.good-undel-6.basic02.xa/fda1:b2:c3:0:127:12:2:34
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-7                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns3.good-undel-7.basic02.xa/127.12.2.33
  * ns3.good-undel-7.basic02.xa/fda1:b2:c3:0:127:12:2:33
  * ns4.good-undel-7.basic02.xa/127.12.2.34
  * ns5.good-undel-7.basic02.xa/fda1:b2:c3:0:127:12:2:34

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-7.basic02.xa --ns ns3.good-undel-7.basic02.xa/127.12.2.33 --ns ns3.good-undel-7.basic02.xa/fda1:b2:c3:0:127:12:2:33 --ns ns4.good-undel-7.basic02.xa/127.12.2.34 --ns ns5.good-undel-7.basic02.xa/fda1:b2:c3:0:127:12:2:34
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-7.basic02.xa"; ns_list=ns3.good-undel-7.basic02.xa/127.12.2.33;ns3.good-undel-7.basic02.xa/fda1:b2:c3:0:127:12:2:33;ns4.good-undel-7.basic02.xa/127.12.2.34;ns5.good-undel-7.basic02.xa/fda1:b2:c3:0:127:12:2:34
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-8                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * dns1.good-undel-8.basic02.xa/127.12.2.33
  * dns1.good-undel-8.basic02.xa/fda1:b2:c3:0:127:12:2:33
  * dns2.good-undel-8.basic02.xa/127.12.2.34
  * dns2.good-undel-8.basic02.xa/fda1:b2:c3:0:127:12:2:34

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-8.basic02.xa --ns dns1.good-undel-8.basic02.xa/127.12.2.33 --ns dns1.good-undel-8.basic02.xa/fda1:b2:c3:0:127:12:2:33 --ns dns2.good-undel-8.basic02.xa/127.12.2.34 --ns dns2.good-undel-8.basic02.xa/fda1:b2:c3:0:127:12:2:34
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-8.basic02.xa"; ns_list=dns1.good-undel-8.basic02.xa/127.12.2.33;dns1.good-undel-8.basic02.xa/fda1:b2:c3:0:127:12:2:33;dns2.good-undel-8.basic02.xa/127.12.2.34;dns2.good-undel-8.basic02.xa/fda1:b2:c3:0:127:12:2:34
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-9                   | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * dns1.good-undel-9.basic02.xb/127.12.2.33
  * dns1.good-undel-9.basic02.xb/fda1:b2:c3:0:127:12:2:33
  * dns2.good-undel-9.basic02.xb/127.12.2.34
  * dns2.good-undel-9.basic02.xb/fda1:b2:c3:0:127:12:2:34

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-9.basic02.xa --ns dns1.good-undel-9.basic02.xb/127.12.2.33 --ns dns1.good-undel-9.basic02.xb/fda1:b2:c3:0:127:12:2:33 --ns dns2.good-undel-9.basic02.xb/127.12.2.34 --ns dns2.good-undel-9.basic02.xb/fda1:b2:c3:0:127:12:2:34
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.03 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-9.basic02.xa"; ns_list=dns1.good-undel-9.basic02.xb/127.12.2.33;dns1.good-undel-9.basic02.xb/fda1:b2:c3:0:127:12:2:33;dns2.good-undel-9.basic02.xb/127.12.2.34;dns2.good-undel-9.basic02.xb/fda1:b2:c3:0:127:12:2:34
```
--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-10                  | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns3.good-undel-10.basic02.xb/127.12.2.33
  * ns3.good-undel-10.basic02.xb/fda1:b2:c3:0:127:12:2:33
  * ns4.good-undel-10.basic02.xb/127.12.2.34
  * ns4.good-undel-10.basic02.xb/fda1:b2:c3:0:127:12:2:34

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-10.basic02.xa --ns ns3.good-undel-10.basic02.xb/127.12.2.33 --ns ns3.good-undel-10.basic02.xb/fda1:b2:c3:0:127:12:2:33 --ns ns4.good-undel-10.basic02.xb/127.12.2.34 --ns ns4.good-undel-10.basic02.xb/fda1:b2:c3:0:127:12:2:34
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-10.basic02.xa"; ns_list=ns3.good-undel-10.basic02.xb/127.12.2.33;ns3.good-undel-10.basic02.xb/fda1:b2:c3:0:127:12:2:33;ns4.good-undel-10.basic02.xb/127.12.2.34;ns4.good-undel-10.basic02.xb/fda1:b2:c3:0:127:12:2:34
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-UNDEL-11                  | B02_AUTH_RESPONSE_SOA                      | 2)

* Undelegated data:
  * ns3.good-undel-11.basic02.xb
  * ns4.good-undel-11.basic02.xb

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw good-undel-11.basic02.xa --ns ns3.good-undel-11.basic02.xb --ns ns4.good-undel-11.basic02.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="good-undel-11.basic02.xa"; ns_list=ns3.good-undel-11.basic02.xb/127.12.2.33;ns3.good-undel-11.basic02.xb/fda1:b2:c3:0:127:12:2:33;ns4.good-undel-11.basic02.xb/127.12.2.34;ns4.good-undel-11.basic02.xb/fda1:b2:c3:0:127:12:2:34
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
MIXED-1                        | B02_AUTH_RESPONSE_SOA                      | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw mixed-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.11 INFO     Basic02        B02_AUTH_RESPONSE_SOA  domain="mixed-1.basic02.xa"; ns_list=ns1.mixed-1.basic02.xa/127.12.2.31;ns1.mixed-1.basic02.xa/fda1:b2:c3:0:127:12:2:31
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NO-DELEGATION-1                | B02_NO_DELEGATION                          | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw no-delegation.basic02.xa 
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.03 CRITICAL Basic02        B02_NO_DELEGATION  domain="no-delegation.basic02.xa"
```

--> OK


Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-BROKEN-1                    | B02_NS_BROKEN, B02_NO_WORKING_NS           | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-broken-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.11 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-broken-1.basic02.xa"
   0.11 ERROR    Basic02        B02_NS_BROKEN  ns=ns1.ns-broken-1.basic02.xa/127.12.2.31
   0.11 ERROR    Basic02        B02_NS_BROKEN  ns=ns2.ns-broken-1.basic02.xa/fda1:b2:c3:0:127:12:2:32
   0.11 ERROR    Basic02        B02_NS_BROKEN  ns=ns1.ns-broken-1.basic02.xa/fda1:b2:c3:0:127:12:2:31
   0.11 ERROR    Basic02        B02_NS_BROKEN  ns=ns2.ns-broken-1.basic02.xa/127.12.2.32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NOT-AUTH-1                  | B02_NS_NOT_AUTH, B02_NO_WORKING_NS         | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-not-auth-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.04 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-not-auth-1.basic02.xa"
   0.04 ERROR    Basic02        B02_NS_NOT_AUTH  ns=ns2.ns-not-auth-1.basic02.xa/fda1:b2:c3:0:127:12:2:32
   0.04 ERROR    Basic02        B02_NS_NOT_AUTH  ns=ns1.ns-not-auth-1.basic02.xa/127.12.2.31
   0.04 ERROR    Basic02        B02_NS_NOT_AUTH  ns=ns1.ns-not-auth-1.basic02.xa/fda1:b2:c3:0:127:12:2:31
   0.04 ERROR    Basic02        B02_NS_NOT_AUTH  ns=ns2.ns-not-auth-1.basic02.xa/127.12.2.32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NO-IP-1                     | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-no-ip-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.07 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-no-ip-1.basic02.xa"
   0.07 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns2.ns-no-ip-1.basic02.xa
   0.07 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns1.ns-no-ip-1.basic02.xa
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NO-IP-2                     | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-no-ip-2.basic02.xa  
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.04 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-no-ip-2.basic02.xa"
   0.04 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns2.ns-no-ip-2.basic02.xb
   0.04 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns1.ns-no-ip-2.basic02.xb
```

--> OK 

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NO-IP-3                     | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-no-ip-3.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.04 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-no-ip-3.basic02.xa"
   0.04 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns1.ns-no-ip-3.basic02.xb
   0.04 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns2.ns-no-ip-3.basic02.xb
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NO-IP-UNDEL-1               | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)

* Undelegated data:
  * ns1.ns-no-ip-undel-1.basic02.xa
  * ns2.ns-no-ip-undel-1.basic02.xa

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-no-ip-undel-1.basic02.xa --ns ns1.ns-no-ip-undel-1.basic02.xa --ns ns2.ns-no-ip-undel-1.basic02.xa
   0.35 ERROR    Unspecified    FAKE_DELEGATION_IN_ZONE_NO_IP  domain=ns-no-ip-undel-1.basic02.xa; nsname=ns2.ns-no-ip-undel-1.basic02.xa
   0.33 ERROR    Unspecified    FAKE_DELEGATION_IN_ZONE_NO_IP  domain=ns-no-ip-undel-1.basic02.xa; nsname=ns1.ns-no-ip-undel-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.03 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-no-ip-undel-1.basic02.xa"
   0.03 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns2.ns-no-ip-undel-1.basic02.xa
   0.03 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns1.ns-no-ip-undel-1.basic02.xa
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NO-IP-UNDEL-2               | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)

* Undelegated data:
  * ns1.ns-no-ip-undel-2.basic02.xb
  * ns2.ns-no-ip-undel-2.basic02.xb

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-no-ip-undel-2.basic02.xa --ns ns1.ns-no-ip-undel-2.basic02.xb --ns ns2.ns-no-ip-undel-2.basic02.xb
   0.23 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=ns-no-ip-undel-2.basic02.xa; nsname=ns2.ns-no-ip-undel-2.basic02.xb
   0.23 ERROR    Unspecified    FAKE_DELEGATION_NO_IP  domain=ns-no-ip-undel-2.basic02.xa; nsname=ns1.ns-no-ip-undel-2.basic02.xb
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.02 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-no-ip-undel-2.basic02.xa"
   0.02 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns1.ns-no-ip-undel-2.basic02.xb
   0.02 ERROR    Basic02        B02_NS_NO_IP_ADDR  nsname=ns2.ns-no-ip-undel-2.basic02.xb
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
NS-NO-RESPONSE-1               | B02_NS_NO_RESPONSE, B02_NO_WORKING_NS      | 2)

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw ns-no-response-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
  40.09 CRITICAL Basic02        B02_NO_WORKING_NS  domain="ns-no-response-1.basic02.xa"
  40.09 WARNING  Basic02        B02_NS_NO_RESPONSE  ns=ns1.ns-no-response-1.basic02.xa/127.12.2.31
  40.09 WARNING  Basic02        B02_NS_NO_RESPONSE  ns=ns2.ns-no-response-1.basic02.xa/fda1:b2:c3:0:127:12:2:32
  40.09 WARNING  Basic02        B02_NS_NO_RESPONSE  ns=ns1.ns-no-response-1.basic02.xa/fda1:b2:c3:0:127:12:2:31
  40.09 WARNING  Basic02        B02_NS_NO_RESPONSE  ns=ns2.ns-no-response-1.basic02.xa/127.12.2.32
```

--> OK

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
UNEXPECTED-RCODE-1             | B02_UNEXPECTED_RCODE, B02_NO_WORKING_NS    | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hints=hintfile.zone --test=basic02 --level=info --show-testcase --raw unexpected-rcode-1.basic02.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v7.1.0
   0.06 CRITICAL Basic02        B02_NO_WORKING_NS  domain="unexpected-rcode-1.basic02.xa"
   0.06 ERROR    Basic02        B02_UNEXPECTED_RCODE  ns=ns2.unexpected-rcode-1.basic02.xa/fda1:b2:c3:0:127:12:2:32; rcode=REFUSED
   0.06 ERROR    Basic02        B02_UNEXPECTED_RCODE  ns=ns1.unexpected-rcode-1.basic02.xa/fda1:b2:c3:0:127:12:2:31; rcode=NXDOMAIN
   0.06 ERROR    Basic02        B02_UNEXPECTED_RCODE  ns=ns3.unexpected-rcode-1.basic02.xa/127.12.2.33; rcode=SERVFAIL
   0.06 ERROR    Basic02        B02_UNEXPECTED_RCODE  ns=ns2.unexpected-rcode-1.basic02.xa/127.12.2.32; rcode=REFUSED
   0.06 ERROR    Basic02        B02_UNEXPECTED_RCODE  ns=ns3.unexpected-rcode-1.basic02.xa/fda1:b2:c3:0:127:12:2:33; rcode=SERVFAIL
   0.06 ERROR    Basic02        B02_UNEXPECTED_RCODE  ns=ns1.unexpected-rcode-1.basic02.xa/127.12.2.31; rcode=NXDOMAIN
```

--> OK





