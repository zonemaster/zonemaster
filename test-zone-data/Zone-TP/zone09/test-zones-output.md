# Zon09 Test Zones Output

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

* Z09_ARPA_EMAIL_DOMAIN
* Z09_INCONSISTENT_MX
* Z09_INCONSISTENT_MX_DATA
* Z09_MISSING_MAIL_EXCHANGE
* Z09_MX_DATA
* Z09_MX_FOUND
* Z09_NON_AUTH_MX_RESPONSE
* Z09_NO_MX_FOUND
* Z09_NO_MX_FOUND_OR_EXPECTED
* Z09_NO_SERVERS_MX_RESPONSE
* Z09_NO_RESPONSE_MX_QUERY
* Z09_NULL_MX_NON_ZERO_PREF
* Z09_NULL_MX_WITH_OTHER_MX
* Z09_ROOT_EMAIL_DOMAIN
* Z09_TLD_EMAIL_DOMAIN
* Z09_UNEXPECTED_RCODE_MX
* Z09_VALID_NULL_MX


## All scenarios

| Scenario name          | Zone name                        | Hint file |
|:-----------------------|:---------------------------------|:----------|
| NO-RESPONSE-MX-QUERY-1 | no-response-mx-query-1.zone09.xa |           |
| NO-RESPONSE-MX-QUERY-2 | no-response-mx-query-2.zone09.xa |           |
| UNEXPECTED-RCODE-MX    | unexpected-rcode-mx.zone09.xa    |           |
| NON-AUTH-MX-RESPONSE   | non-auth-mx-response.zone09.xa   |           |
| INCONSISTENT-MX        | inconsistent-mx.zone09.xa        |           |
| INCONSISTENT-MX-DATA-1 | inconsistent-mx-data-1.zone09.xa |           |
| INCONSISTENT-MX-DATA-2 | inconsistent-mx-data-2.zone09.xa |           |
| INCONSISTENT-MX-DATA-3 | inconsistent-mx-data-3.zone09.xa |           |
| MIXED-TTL-1            | mixed-ttl-1.zone09.xa            |           |
| MIXED-TTL-2            | mixed-ttl-2.zone09.xa            |           |
| NULL-MX-WITH-OTHER-MX  | null-mx-with-other-mx.zone09.xa  |           |
| NULL-MX-NON-ZERO-PREF  | null-mx-non-zero-pref.zone09.xa  |           |
| TLD-EMAIL-DOMAIN       | tld-email-domain-zone09          |           |
| ROOT-EMAIL-DOMAIN      | .                                | 1)        |
| ARPA-EMAIL-DOMAIN      | arpa-email-domain.zone09.arpa    |           |
| MX-DATA                | mx-data.zone09.xa                |           |
| NULL-MX-TLD            | null-mx-tld-zone09               |           |
| NULL-MX-ROOT           | .                                | 2)        |
| NULL-MX-ARPA           | null-mx-arpa.zone09.arpa         |           |
| NULL-MX-SLD            | null-mx-sld.zone09.xa            |           |
| NO-MX-SLD              | no-mx-sld.zone09.xa              |           |
| NO-MX-TLD              | no-mx-tld-zone09                 |           |
| NO-MX-ROOT             | .                                |           |
| NO-MX-ARPA             | no-mx-arpa.zone09.arpa           |           |

Default hintfile, `Zone-TP/zone09/hintfile.zone`, is used for all scenarios
unless another hintfile is specified:

1. `Zone-TP/zone09/hintfile-ROOT-EMAIL-DOMAIN.zone`
2. `Zone-TP/zone09/hintfile-NULL-MX-ROOT.zone`


## zonemaster-cli commands and their output for each test scenario

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level. It is only meaningful to test the
test zones with `--test Zone09`.

> **All scenarios must be checked for updated expected and forbidden message tags.
> Some scenarios listed above are not present below.**

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-RESPONSE-MX-QUERY-1 | Z09_NO_RESPONSE_MX_QUERY, Z09_MX_DATA                               | 2)                     |

* (2) All tags except for those specified as "Mandatory message tags"
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-response-mx-query-1.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
  20.10 WARNING  Z09_NO_RESPONSE_MX_QUERY  ns_list=ns2.no-response-mx-query-1.zone09.xa/127.19.9.32;ns2.no-response-mx-query-1.zone09.xa/fda1:b2:c3:0:127:19:9:32
  20.10 INFO     Z09_MX_DATA  mxrdata_list=10 mail.no-response-mx-query-1.zone09.xa.; ns_list=ns1.no-response-mx-query-1.zone09.xa/127.19.9.31;ns1.no-response-mx-query-1.zone09.xa/fda1:b2:c3:0:127:19:9:31
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-RESPONSE-MX-QUERY-2 | Z09_NO_RESPONSE_MX_QUERY, Z09_NO_SERVERS_MX_RESPONSE                | 2)                     |

```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-response-mx-query-2.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
  40.12 WARNING  Z09_NO_RESPONSE_MX_QUERY  ns_list=ns1.no-response-mx-query-2.zone09.xa/127.19.9.31;ns1.no-response-mx-query-2.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.no-response-mx-query-2.zone09.xa/127.19.9.32;ns2.no-response-mx-query-2.zone09.xa/fda1:b2:c3:0:127:19:9:32
  40.12 WARNING  Z09_NO_SERVERS_MX_RESPONSE  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| UNEXPECTED-RCODE-MX    | Z09_UNEXPECTED_RCODE_MX, Z09_MISSING_MAIL_EXCHANGE                  | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info unexpected-rcode-mx.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.11 WARNING  Z09_UNEXPECTED_RCODE_MX  ns_list=ns1.unexpected-rcode-mx.zone09.xa/127.19.9.31;ns1.unexpected-rcode-mx.zone09.xa/fda1:b2:c3:0:127:19:9:31; rcode=NOTIMPL
   0.11 NOTICE   Z09_MISSING_MAIL_EXCHANGE  ns_list=ns2.unexpected-rcode-mx.zone09.xa/127.19.9.32;ns2.unexpected-rcode-mx.zone09.xa/fda1:b2:c3:0:127:19:9:32
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NON-AUTH-MX-RESPONSE   | Z09_NON_AUTH_MX_RESPONSE, Z09_MX_DATA                               | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info non-auth-mx-response.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.11 INFO     Z09_MX_DATA  mxrdata_list=10 mail.non-auth-mx-response.zone09.xa.; ns_list=ns1.non-auth-mx-response.zone09.xa/127.19.9.31;ns1.non-auth-mx-response.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.non-auth-mx-response.zone09.xa/127.19.9.32;ns2.non-auth-mx-response.zone09.xa/fda1:b2:c3:0:127:19:9:32
```
--> Not OK (scenario cannot be correctly implemented with Coredns)

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| INCONSISTENT-MX        | Z09_INCONSISTENT_MX, Z09_MX_FOUND Z09, Z09_NO_MX_FOUND, Z09_MX_DATA | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=10 mail.inconsistent-mx.zone09.xa.; ns_list=ns1.inconsistent-mx.zone09.xa/127.19.9.31;ns1.inconsistent-mx.zone09.xa/fda1:b2:c3:0:127:19:9:31
   0.07 WARNING  Z09_INCONSISTENT_MX  
   0.07 INFO     Z09_NO_MX_FOUND  ns_list=ns2.inconsistent-mx.zone09.xa/127.19.9.32;ns2.inconsistent-mx.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.07 INFO     Z09_MX_FOUND  ns_list=ns1.inconsistent-mx.zone09.xa/127.19.9.31;ns1.inconsistent-mx.zone09.xa/fda1:b2:c3:0:127:19:9:31
```
--> OK

| Scenario name          | Mandatory message tags                | Forbidden message tags |
|:-----------------------|:--------------------------------------|:-----------------------|
| INCONSISTENT-MX-DATA-1 | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-1.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=10 mail2.inconsistent-mx-data-1.zone09.xa.; ns_list=ns2.inconsistent-mx-data-1.zone09.xa/127.19.9.32;ns2.inconsistent-mx-data-1.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.07 INFO     Z09_MX_DATA  mxrdata_list=10 mail.inconsistent-mx-data-1.zone09.xa.;10 mail2.inconsistent-mx-data-1.zone09.xa.; ns_list=ns1.inconsistent-mx-data-1.zone09.xa/127.19.9.31;ns1.inconsistent-mx-data-1.zone09.xa/fda1:b2:c3:0:127:19:9:31
   0.07 WARNING  Z09_INCONSISTENT_MX_DATA  
```
--> OK

| Scenario name          | Mandatory message tags                | Forbidden message tags |
|:-----------------------|:--------------------------------------|:-----------------------|
| INCONSISTENT-MX-DATA-2 | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-2.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.08 INFO     Z09_MX_DATA  mxrdata_list=20 mail2.inconsistent-mx-data-2.zone09.xa.; ns_list=ns1.inconsistent-mx-data-2.zone09.xa/127.19.9.31;ns1.inconsistent-mx-data-2.zone09.xa/fda1:b2:c3:0:127:19:9:31
   0.08 INFO     Z09_MX_DATA  mxrdata_list=10 mail2.inconsistent-mx-data-2.zone09.xa.; ns_list=ns2.inconsistent-mx-data-2.zone09.xa/127.19.9.32;ns2.inconsistent-mx-data-2.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.08 WARNING  Z09_INCONSISTENT_MX_DATA  
```
--> OK

| Scenario name          | Mandatory message tags                | Forbidden message tags |
|:-----------------------|:--------------------------------------|:-----------------------|
| INCONSISTENT-MX-DATA-3 | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-3.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.08 INFO     Z09_MX_DATA  mxrdata_list=10 mail.inconsistent-mx-data-3.zone09.xa.;20 mail2.inconsistent-mx-data-3.zone09.xa.; ns_list=ns1.inconsistent-mx-data-3.zone09.xa/127.19.9.31;ns1.inconsistent-mx-data-3.zone09.xa/fda1:b2:c3:0:127:19:9:31
   0.08 INFO     Z09_MX_DATA  mxrdata_list=10 mail2.inconsistent-mx-data-3.zone09.xa.;20 mail.inconsistent-mx-data-3.zone09.xa.; ns_list=ns2.inconsistent-mx-data-3.zone09.xa/127.19.9.32;ns2.inconsistent-mx-data-3.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.08 WARNING  Z09_INCONSISTENT_MX_DATA  
```
--> OK

| Scenario name | Mandatory message tags | Forbidden message tags |
|:--------------|:-----------------------|:-----------------------|
| MIXED-TTL-1   | Z09_MX_DATA            | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-ttl-1.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=10 mail.mixed-ttl-1.zone09.xa.;20 mail2.mixed-ttl-1.zone09.xa.; ns_list=ns1.mixed-ttl-1.zone09.xa/127.19.9.31;ns1.mixed-ttl-1.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.mixed-ttl-1.zone09.xa/127.19.9.32;ns2.mixed-ttl-1.zone09.xa/fda1:b2:c3:0:127:19:9:32
```
--> OK

| Scenario name | Mandatory message tags | Forbidden message tags |
|:--------------|:-----------------------|:-----------------------|
| MIXED-TTL-2   | Z09_MX_DATA            | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-ttl-2.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=10 mail.mixed-ttl-2.zone09.xa.;20 mail2.mixed-ttl-2.zone09.xa.; ns_list=ns1.mixed-ttl-2.zone09.xa/127.19.9.31;ns1.mixed-ttl-2.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.mixed-ttl-2.zone09.xa/127.19.9.32;ns2.mixed-ttl-2.zone09.xa/fda1:b2:c3:0:127:19:9:32
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NULL-MX-WITH-OTHER-MX  | Z09_NULL_MX_WITH_OTHER_MX, Z09_MX_DATA                              | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-with-other-mx.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=0 .;10 mail.null-mx-with-other-mx.zone09.xa.; ns_list=ns1.null-mx-with-other-mx.zone09.xa/127.19.9.31;ns1.null-mx-with-other-mx.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.null-mx-with-other-mx.zone09.xa/127.19.9.32;ns2.null-mx-with-other-mx.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.07 WARNING  Z09_NULL_MX_WITH_OTHER_MX  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NULL-MX-NON-ZERO-PREF  | Z09_NULL_MX_NON_ZERO_PREF, Z09_MX_DATA                              | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-non-zero-pref.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=99 .; ns_list=ns1.null-mx-non-zero-pref.zone09.xa/127.19.9.31;ns1.null-mx-non-zero-pref.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.null-mx-non-zero-pref.zone09.xa/127.19.9.32;ns2.null-mx-non-zero-pref.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.07 NOTICE   Z09_NULL_MX_NON_ZERO_PREF  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| TLD-EMAIL-DOMAIN       | Z09_TLD_EMAIL_DOMAIN, Z09_MX_DATA                                   | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info tld-email-domain-zone09
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.05 INFO     Z09_MX_DATA  mxrdata_list=10 mail.tld-email-domain-zone09.; ns_list=ns1.tld-email-domain-zone09/127.19.9.41;ns1.tld-email-domain-zone09/fda1:b2:c3:0:127:19:9:41;ns2.tld-email-domain-zone09/127.19.9.42;ns2.tld-email-domain-zone09/fda1:b2:c3:0:127:19:9:42
   0.05 NOTICE   Z09_TLD_EMAIL_DOMAIN  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| ROOT-EMAIL-DOMAIN      | Z09_ROOT_EMAIL_DOMAIN, Z09_MX_DATA                                  | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile-ROOT-EMAIL-DOMAIN.zone --level info .
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.03 INFO     Z09_MX_DATA  mxrdata_list=10 mail.; ns_list=ns1/127.19.9.63;ns1/fda1:b2:c3:0:127:19:9:63;ns2/127.19.9.64;ns2/fda1:b2:c3:0:127:19:9:64
   0.03 NOTICE   Z09_ROOT_EMAIL_DOMAIN  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| ARPA-EMAIL-DOMAIN      | Z09_ARPA_EMAIL_DOMAIN, Z09_MX_DATA                                  | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info arpa-email-domain.zone09.arpa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.06 INFO     Z09_MX_DATA  mxrdata_list=10 mail.arpa-email-domain.zone09.arpa.; ns_list=ns1.arpa-email-domain.zone09.arpa/127.19.9.31;ns1.arpa-email-domain.zone09.arpa/fda1:b2:c3:0:127:19:9:31;ns2.arpa-email-domain.zone09.arpa/127.19.9.32;ns2.arpa-email-domain.zone09.arpa/fda1:b2:c3:0:127:19:9:32
   0.06 NOTICE   Z09_ARPA_EMAIL_DOMAIN  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| MX-DATA                | Z09_MX_DATA                                                         | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mx-data.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.08 INFO     Z09_MX_DATA  mxrdata_list=10 mail.mx-data.zone09.xa.; ns_list=ns1.mx-data.zone09.xa/127.19.9.31;ns1.mx-data.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.mx-data.zone09.xa/127.19.9.32;ns2.mx-data.zone09.xa/fda1:b2:c3:0:127:19:9:32
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NULL-MX-TLD            | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-tld-zone09
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.05 INFO     Z09_MX_DATA  mxrdata_list=0 .; ns_list=ns1.null-mx-tld-zone09/127.19.9.41;ns1.null-mx-tld-zone09/fda1:b2:c3:0:127:19:9:41;ns2.null-mx-tld-zone09/127.19.9.42;ns2.null-mx-tld-zone09/fda1:b2:c3:0:127:19:9:42
   0.05 INFO     Z09_VALID_NULL_MX  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NULL-MX-ROOT           | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile-NULL-MX-ROOT.zone --level info .
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.03 INFO     Z09_MX_DATA  mxrdata_list=0 .; ns_list=ns1/127.19.9.65;ns1/fda1:b2:c3:0:127:19:9:65;ns2/127.19.9.66;ns2/fda1:b2:c3:0:127:19:9:66
   0.03 INFO     Z09_VALID_NULL_MX  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NULL-MX-ARPA           | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-arpa.zone09.arpa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.06 INFO     Z09_MX_DATA  mxrdata_list=0 .; ns_list=ns1.null-mx-arpa.zone09.arpa/127.19.9.31;ns1.null-mx-arpa.zone09.arpa/fda1:b2:c3:0:127:19:9:31;ns2.null-mx-arpa.zone09.arpa/127.19.9.32;ns2.null-mx-arpa.zone09.arpa/fda1:b2:c3:0:127:19:9:32
   0.06 INFO     Z09_VALID_NULL_MX  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NULL-MX-SLD            | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-sld.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_MX_DATA  mxrdata_list=0 .; ns_list=ns1.null-mx-sld.zone09.xa/127.19.9.31;ns1.null-mx-sld.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.null-mx-sld.zone09.xa/127.19.9.32;ns2.null-mx-sld.zone09.xa/fda1:b2:c3:0:127:19:9:32
   0.07 INFO     Z09_VALID_NULL_MX  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-MX-SLD              | Z09_MISSING_MAIL_EXCHANGE                                           | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-sld.zone09.xa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 NOTICE   Z09_MISSING_MAIL_EXCHANGE  ns_list=ns1.no-mx-sld.zone09.xa/127.19.9.31;ns1.no-mx-sld.zone09.xa/fda1:b2:c3:0:127:19:9:31;ns2.no-mx-sld.zone09.xa/127.19.9.32;ns2.no-mx-sld.zone09.xa/fda1:b2:c3:0:127:19:9:32
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-MX-TLD              | Z09_NO_MX_FOUND_OR_EXPECTED                                         | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-tld-zone09
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.06 INFO     Z09_NO_MX_FOUND_OR_EXPECTED  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-MX-ROOT             | Z09_NO_MX_FOUND_OR_EXPECTED                                         | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info .
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.03 INFO     Z09_NO_MX_FOUND_OR_EXPECTED  
```
--> OK

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-MX-ARPA             | Z09_NO_MX_FOUND_OR_EXPECTED                                         | 2)                     |
```
$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-arpa.zone09.arpa
   0.00 INFO     GLOBAL_VERSION  version=v9.0.0
   0.07 INFO     Z09_NO_MX_FOUND_OR_EXPECTED  
```
--> OK
