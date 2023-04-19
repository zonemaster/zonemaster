# ZONE09

[This directory](.), i.e. the same directory as this README file, holds
zonefiles and `coredns` configuration files for scenarios for test case ZONE09:

* NO-RESPONSE-MX-QUERY
* UNEXPECTED-RCODE-MX
* NON-AUTH-MX-RESPONSE
* INCONSISTENT-MX
* INCONSISTENT-MX-DATA
* NULL-MX-WITH-OTHER-MX
* NULL-MX-NON-ZERO-PREF
* TLD-EMAIL-DOMAIN
* ROOT-EMAIL-DOMAIN
* MX-DATA
* NULL-MX
* NO-MX-SLD
* NO-MX-TLD
* NO-MX-ARPA

## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE-MX-QUERY  | Z09\_NO\_RESPONSE\_MX\_QUERY                          | (none)
```
$ zonemaster-cli NO-RESPONSE-MX-QUERY.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
  20.11 WARNING   Z09_NO_RESPONSE_MX_QUERY   ns_ip_list=127.19.9.32;fda1:b2:c3:0:127:19:9:32
  20.11 INFO      Z09_MX_DATA   mailtarget_list=mail.no-response-mx-query.zone09.xa.; ns_ip_list=127.19.9.31;fda1:b2:c3:0:127:19:9:31
```
-> OK


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
UNEXPECTED-RCODE-MX   | Z09\_UNEXPECTED\_RCODE\_MX                           | (none)

```
$ zonemaster-cli UNEXPECTED-RCODE-MX.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.07 WARNING   Z09_UNEXPECTED_RCODE_MX   ns_ip_list=ARRAY(0x5638fec55130); rcode=NOTIMPL
   0.07 NOTICE    Z09_MISSING_MAIL_TARGET
```
-> OK


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NON-AUTH-MX-RESPONSE  | Z09\_NON\_AUTH\_MX\_RESPONSE                          | (none)

```
$ zonemaster-cli NON-AUTH-MX-RESPONSE.zone09.xa --raw  --test Zone/zone09 --hint COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 INFO      Z09_MX_DATA   mailtarget_list=mail.non-auth-mx-response.zone09.xa.; ns_ip_list=127.19.9.31;127.19.9.32;fda1:b2:c3:0:127:19:9:32;fda1:b2:c3:0:127:19:9:31
```
-> The zone file configuration is not yet correct.

Scenario name         | Mandatory message tags                                                   | Forbidden message tags
:---------------------|:-------------------------------------------------------------------------|:-------------------------------------------
INCONSISTENT-MX       | Z09\_INCONSISTENT\_MX, Z09\_MX\_FOUND, Z09\_NO\_MX\_FOUND, Z09\_MX\_DATA | Z09\_MISSING\_MAIL\_TARGET

```
$ zonemaster-cli INCONSISTENT-MX.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.07 WARNING   Z09_INCONSISTENT_MX
   0.07 INFO      Z09_NO_MX_FOUND   ns_ip_list=127.19.9.32;fda1:b2:c3:0:127:19:9:32
   0.07 INFO      Z09_MX_FOUND   ns_ip_list=127.19.9.31;fda1:b2:c3:0:127:19:9:31
   0.07 INFO      Z09_MX_DATA   mailtarget_list=mail.inconsistent-mx.zone09.xa.; ns_ip_list=127.19.9.31;fda1:b2:c3:0:127:19:9:31
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
INCONSISTENT-MX-DATA  | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA             | Z09\_MISSING\_MAIL\_TARGET, Z09\_NULL\_MX\_NON\_ZERO\_PREF, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_TLD\_EMAIL\_DOMAIN

```
$ zonemaster-cli INCONSISTENT-MX-DATA.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 WARNING   Z09_INCONSISTENT_MX_DATA
   0.08 INFO      Z09_MX_DATA   mailtarget_list=mail2.inconsistent-mx-data.zone09.xa.; ns_ip_list=127.19.9.32;fda1:b2:c3:0:127:19:9:32
   0.08 INFO      Z09_MX_DATA   mailtarget_list=mail.inconsistent-mx-data.zone09.xa.;mail2.inconsistent-mx-data.zone09.xa.; ns_ip_list=127.19.9.31;fda1:b2:c3:0:127:19:9:31
```
-> OK


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NULL-MX-WITH-OTHER-MX | Z09\_NULL\_MX\_WITH\_OTHER\_MX                         | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_TLD\_EMAIL\_DOMAIN

```
$ zonemaster-cli null-mx-with-other-mx.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.09 WARNING   Z09_NULL_MX_WITH_OTHER_MX
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NULL-MX-NON-ZERO-PREF | Z09\_NULL\_MX\_NON\_ZERO\_PREF                         | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_TLD\_EMAIL\_DOMAIN

```
$ zonemaster-cli null-mx-non-zero-pref.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.09 NOTICE    Z09_NULL_MX_NON_ZERO_PREF
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
TLD-EMAIL-DOMAIN      | Z09\_TLD\_EMAIL\_DOMAIN                              | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli tld-email-domain-zone09 --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.03 WARNING   Z09_TLD_EMAIL_DOMAIN
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ROOT-EMAIL-DOMAIN     | Z09\_ROOT\_EMAIL\_DOMAIN                             | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli . --raw  --test Zone/zone09 --hints Zone-TP/zone09/hintfile-root-email-domain --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.01 NOTICE    Z09_ROOT_EMAIL_DOMAIN
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
MX-DATA               | Z09\_MX\_DATA                                       | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli mx-data.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.07 INFO      Z09_MX_DATA   mailtarget_list=mail.mx-data.zone09.xa.; ns_ip_list=fda1:b2:c3:0:127:19:9:32;127.19.9.32;fda1:b2:c3:0:127:19:9:31;127.19.9.31
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NULL-MX               | (none)                                            | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli null-mx.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-MX-SLD             | Z09\_MISSING\_MAIL\_TARGET                           | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli no-mx-sld.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.09 NOTICE    Z09_MISSING_MAIL_TARGET
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-MX-TLD             | (none)                                            | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli xa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
```
-> OK

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-MX-ARPA            | (none)                                            | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli arpa --raw  --test Zone/zone09 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
```
-> OK
