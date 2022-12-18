This directory will hold zonefiles and `coredns` configuration files for
scenarios for test case DNSSEC16:

* CDS-INVALID-RRSIG
* CDS-MATCHES-NO-DNSKEY
* CDS-MATCHES-NON-SEP-DNSKEY
* CDS-MATCHES-NON-ZONE-DNSKEY
* CDS-NOT-SIGNED-BY-CDS
* CDS-SIGNED-BY-UNKNOWN-DNSKEY
* CDS-UNSIGNED
* CDS-WITHOUT-DNSKEY
* DELETE-CDS
* DNSKEY-NOT-SIGNED-BY-CDS
* MIXED-DELETE-CDS
* NO-CDS
* NOT-AA
* VALID-CDS

### Examples of zonemaster-cli commands and their output for each test scenario.

The level (`--level`) must be set to the lowest level of the message tags. For
this test case `INFO` is the lowest level.


Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-INVALID-RRSIG            | DS16\_CDS\_INVALID\_RRSIG                            | DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-invalid-rrsig.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 ERROR     DS16_CDS_INVALID_RRSIG   keytag=33526; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK


Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-MATCHES-NO-DNSKEY        | DS16\_CDS\_MATCHES\_NO\_DNSKEY                        | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-matches-no-dnskey.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 WARNING   DS16_CDS_MATCHES_NO_DNSKEY   keytag=50692; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-MATCHES-NON-SEP-DNSKEY   | DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY                   | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-matches-non-sep-dnskey.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.09 NOTICE    DS16_CDS_MATCHES_NON_SEP_DNSKEY   keytag=14693; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-MATCHES-NON-ZONE-DNSKEY  | DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY                  | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-matches-non-zone-dnskey.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 ERROR     DS16_CDS_MATCHES_NON_ZONE_DNSKEY   keytag=41627; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-NOT-SIGNED\_BY\_CDS        | DS16\_CDS\_NOT\_SIGNED\_BY\_CDS                        | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-not-signed-by-cds.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.09 NOTICE    DS16_CDS_NOT_SIGNED_BY_CDS   keytag=46227; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-SIGNED-BY-UNKNOWN-DNSKEY | DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY                 | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-signed-by-unknown-dnskey.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 ERROR     DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY   keytag=30573; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-UNSIGNED                 | DS16\_CDS\_UNSIGNED                                 | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-unsigned.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 NOTICE    DS16_CDS_NOT_SIGNED_BY_CDS   keytag=24862; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
   0.08 ERROR     DS16_CDS_UNSIGNED   ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> Mismatch



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-WITHOUT-DNSKEY           | DS16\_CDS\_WITHOUT\_DNSKEY                           | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli cds-without-dnskey.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 ERROR     DS16_CDS_WITHOUT_DNSKEY   ns_ip_list=127.15.16.32;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
DELETE-CDS                   | DS16\_DELETE\_CDS                                   | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli delete-cds.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 INFO      DS16_DELETE_CDS   ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
DNSKEY-NOT-SIGNED-BY-CDS     | DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS                     | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli dnskey-not-signed-by-cds.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 WARNING   DS16_DNSKEY_NOT_SIGNED_BY_CDS   keytag=63201; ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
MIXED-DELETE-CDS             | DS16\_MIXED\_DELETE\_CDS                             | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS
```
$ zonemaster-cli mixed-delete-cds.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
   0.08 ERROR     DS16_MIXED_DELETE_CDS   ns_ip_list=127.15.16.31;127.15.16.32;fda1:b2:c3:0:127:15:16:31;fda1:b2:c3:0:127:15:16:32
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
NO-CDS                       | (none)                                            | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli no-cds.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
```
-> OK



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
NOT-AA                       | (none)                                            | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```

```
-> ??



Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
VALID-CDS                    | (none)                                            | DS16\_CDS\_INVALID\_RRSIG, DS16\_CDS\_MATCHES\_NON\_SEP\_DNSKEY, DS16\_CDS\_MATCHES\_NON\_ZONE\_DNSKEY, DS16\_CDS\_MATCHES\_NO\_DNSKEY, DS16\_CDS\_NOT\_SIGNED\_BY\_CDS, DS16\_CDS\_SIGNED\_BY\_UNKNOWN\_DNSKEY, DS16\_CDS\_UNSIGNED, DS16\_CDS\_WITHOUT\_DNSKEY, DS16\_DELETE\_CDS, DS16\_DNSKEY\_NOT\_SIGNED\_BY\_CDS, DS16\_MIXED\_DELETE\_CDS
```
$ zonemaster-cli valid-cds.dnssec16.xa --raw  --test DNSSEC/dnssec16 --hints COMMON/hintfile --level info
   0.00 INFO      GLOBAL_VERSION   version=v4.5.1
```
-> OK

