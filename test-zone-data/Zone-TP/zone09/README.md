This directory will hold zonefiles and `coredns` configuration files for
the following scarios for test case Zoneo0:

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

<br></br>
### Examples of zonemaster-cli commands and their output for each test scenario.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE-MX-QUERY  | Z09\_NO\_RESPONSE\_MX\_QUERY                          | (none)
```
$ zonemaster-cli NO-RESPONSE-MX-QUERY.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   20.10 WARNING   Z09_NO_RESPONSE_MX_QUERY   ns_ip_list=127.19.9.32;fda1:b2:c3:0:127:19:9:32`
```
-> OK
<br/><br/>


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
UNEXPECTED-RCODE-MX   | Z09\_UNEXPECTED\_RCODE\_MX                           | (none)

```
$ zonemaster-cli UNEXPECTED-RCODE-MX.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   0.08 WARNING   Z09_UNEXPECTED_RCODE_MX   ns_ip_list=ARRAY(0x55e0688791b8); rcode=NOTIMPL
   0.08 NOTICE    Z09_MISSING_MAIL_TARGET
```
-> OK
<br/><br/>


Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NON-AUTH-MX-RESPONSE  | Z09\_NON\_AUTH\_MX\_RESPONSE                          | (none)

```
$ zonemaster-cli NON-AUTH-MX-RESPONSE.zone09.xa --raw  --test Zone/zone09 --hint COMMON/hintfile
```
-> no message! Needs new plugin!!!
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
INCONSISTENT-MX       | Z09\_INCONSISTENT\_MX, Z09\_MX\_FOUND Z09\_NO\_MX\_FOUND | Z09\_MISSING\_MAIL\_TARGET

```
$ zonemaster-cli INCONSISTENT-MX.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   0.08 WARNING   Z09_INCONSISTENT_MX
   0.08 NOTICE    Z09_MISSING_MAIL_TARGET
```
-> wrong answer from ZM
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
INCONSISTENT-MX-DATA  | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA             | Z09\_MISSING\_MAIL\_TARGET, Z09\_NULL\_MX\_NON\_ZERO\_PREF, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_TLD\_EMAIL\_DOMAIN

```
$ zonemaster-cli INCONSISTENT-MX-DATA.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   0.08 WARNING   Z09_INCONSISTENT_MX_DATA
```
-> missing one tag from ZM
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NULL-MX-WITH-OTHER-MX | Z09\_NULL\_MX\_WITH\_OTHER\_MX                         | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_TLD\_EMAIL\_DOMAIN

```
$ zonemaster-cli null-mx-with-other-mx.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
```
-> wrong answer from ZM
<br/><br/>
   
Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NULL-MX-NON-ZERO-PREF | Z09\_NULL\_MX\_NON\_ZERO\_PREF                         | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_TLD\_EMAIL\_DOMAIN

```
$ zonemaster-cli null-mx-non-zero-pref.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   0.09 NOTICE    Z09_NULL_MX_NON_ZERO_PREF
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
TLD-EMAIL-DOMAIN      | Z09\_TLD\_EMAIL\_DOMAIN                              | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli tld-email-domain-zone09 --raw  --test Zone/zone09 --hints COMMON/hintfile
   0.03 WARNING   Z09_TLD_EMAIL_DOMAIN
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
ROOT-EMAIL-DOMAIN     | Z09\_ROOT\_EMAIL\_DOMAIN                             | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli . --raw  --test Zone/zone09 --hints Zone-TP/zone09/hintfile-root-email-domain
   0.01 NOTICE    Z09_ROOT_EMAIL_DOMAIN
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
MX-DATA               | Z09\_MX\_DATA                                       | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli mx-data.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NULL-MX               | (none)                                            | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli null-mx.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-MX-SLD             | Z09\_MISSING\_MAIL\_TARGET                           | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli no-mx-sld.zone09.xa --raw  --test Zone/zone09 --hints COMMON/hintfile
   0.08 NOTICE    Z09_MISSING_MAIL_TARGET
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-MX-TLD             | (none)                                            | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli xa --raw  --test Zone/zone09 --hints COMMON/hintfile`
```
-> OK
<br/><br/>

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-MX-ARPA            | (none)                                            | Z09\_INCONSISTENT\_MX\_DATA, Z09\_MX\_DATA, Z09\_MISSING\_MAIL\_TARGET, Z09\_TLD\_EMAIL\_DOMAIN, Z09\_ROOT\_EMAIL\_DOMAIN, Z09\_NULL\_MX\_WITH\_OTHER\_MX, Z09\_NULL\_MX\_NON\_ZERO\_PREF

```
$ zonemaster-cli arpa --raw  --test Zone/zone09 --hints COMMON/hintfile`
```
-> OK
<br/><br/>
