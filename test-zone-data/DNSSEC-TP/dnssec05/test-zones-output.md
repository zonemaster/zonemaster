# DNSSEC05 Test scenario output

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

* DS05_ALGO_DEPRECATED
* DS05_ALGO_NOT_RECOMMENDED
* DS05_ALGO_NOT_ZONE_SIGN
* DS05_ALGO_OK
* DS05_ALGO_PRIVATE
* DS05_ALGO_RESERVED
* DS05_ALGO_UNASSIGNED
* DS05_NO_RESPONSE
* DS05_SERVER_NO_DNSSEC
* DS05_ZONE_NO_DNSSEC


## All scenarios

| Scenario name           | Zone name                                              |
|:------------------------|:-------------------------------------------------------|
| ALGO-DEPRECATED-1       | algo-deprecated-1.dnssec05.xa.                         |
| ALGO-DEPRECATED-3       | algo-deprecated-3.dnssec05.xa.                         |
| ALGO-DEPRECATED-5       | algo-deprecated-5.dnssec05.xa.                         |
| ALGO-DEPRECATED-6       | algo-deprecated-6.dnssec05.xa.                         |
| ALGO-DEPRECATED-7       | algo-deprecated-7.dnssec05.xa.                         |
| ALGO-DEPRECATED-12      | algo-deprecated-12.dnssec05.xa.                        |
| ALGO-RESERVED-4         | algo-reserved-4.dnssec05.xa.                           |
| ALGO-RESERVED-9         | algo-reserved-9.dnssec05.xa.                           |
| ALGO-RESERVED-11        | algo-reserved-11.dnssec05.xa.                          |
| ALGO-RESERVED-123       | algo-reserved-123.dnssec05.xa.                         |
| ALGO-RESERVED-251       | algo-reserved-251.dnssec05.xa.                         |
| ALGO-RESERVED-255       | algo-reserved-255.dnssec05.xa.                         |
| ALGO-UNASSIGNED-20      | algo-unassigned-17.dnssec05.xa.                        |
| ALGO-UNASSIGNED-122     | algo-unassigned-122.dnssec05.xa.                       |
| ALGO-PRIVATE-253        | algo-private-253.dnssec05.xa.                          |
| ALGO-PRIVATE-254        | algo-private-254.dnssec05.xa.                          |
| ALGO-NOT-ZONE-SIGN-0    | algo-not-zone-sign-0.dnssec05.xa.                      |
| ALGO-NOT-ZONE-SIGN-2    | algo-not-zone-sign-2.dnssec05.xa.                      |
| ALGO-NOT-ZONE-SIGN-252  | algo-not-zone-sign-252.dnssec05.xa.                    |
| ALGO-NOT-RECOMMENDED-10 | algo-not-recommended-10.dnssec05.xa.                   |
| ALGO-OK-8               | algo-ok-8.dnssec05.xa.                                 |
| ALGO-OK-13              | algo-ok-13.dnssec05.xa.                                |
| ALGO-OK-14              | algo-ok-14.dnssec05.xa.                                |
| ALGO-OK-15              | algo-ok-15.dnssec05.xa.                                |
| ALGO-OK-16              | algo-ok-16.dnssec05.xa.                                |
| ALGO-OK-17              | algorithm-ok-17.dnssec05.xa.                           |
| ALGO-OK-23              | algorithm-ok-23.dnssec05.xa."mixed-algo-1.dnssec05.xa. |
| NO-RESPONSE-1           | no-response-1.dnssec05.xa.                             |
| NO-RESPONSE-2           | no-response-2.dnssec05.xa.                             |
| SERVER_NO_DNSSEC-1      | server_no_dnssec-1.dnssec05.xa.                        |
| SHARED-IP-1             | shared-ip-1.dnssec05.xa.                               |
| ZONE_NO_DNSSEC-1        | zone_no_dnssec-1.dnssec05.xa.                          |


## zonemaster-cli commands and their output for each test scenario

> **PLEASE NOTE:**
>
> The `zonemaster-cli` output in this section is from before the implementation
> of test DNSSEC05 has been updated. All message tags and the logic for utputting
> them are to be updated. This file has to updated when the implementation
> update is available.


All commands are run from the same directory as this file is in. To be meaningful
the `zonemaster-cli` command should be run with the following options:
```
--hints=hintfile.zone --test=dnssec05 --level=info
```

| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-1       | DS05_ALGO_DEPRECATED                                          | 2)                     |

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-DEPRECATED-1.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=RSA/MD5; algo_num=1; keytag=13008
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=RSA/MD5; algo_num=1; keytag=13008
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=RSA/MD5; algo_num=1; keytag=13008
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=RSA/MD5; algo_num=1; keytag=13008
```
--> ??

| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-3       | DS05_ALGO_DEPRECATED                                          | 2)                     |

```
zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-DEPRECATED-3.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA/SHA1; algo_num=3; keytag=51288
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA/SHA1; algo_num=3; keytag=51288
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA/SHA1; algo_num=3; keytag=51288
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA/SHA1; algo_num=3; keytag=51288
```
--> ??


| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-5       | DS05_ALGO_DEPRECATED                                          | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-DEPRECATED-5.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA1; algo_num=5; keytag=51290
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA1; algo_num=5; keytag=51290
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA1; algo_num=5; keytag=51290
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA1; algo_num=5; keytag=51290
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-6       | DS05_ALGO_DEPRECATED                                          | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-DEPRECATED-6.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA-NSEC3-SHA1; algo_num=6; keytag=51291
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA-NSEC3-SHA1; algo_num=6; keytag=51291
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA-NSEC3-SHA1; algo_num=6; keytag=51291
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=DSA-NSEC3-SHA1; algo_num=6; keytag=51291
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-7       | DS05_ALGO_DEPRECATED                                          | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-DEPRECATED-7.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-12      | DS05_ALGO_DEPRECATED                                          | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-DEPRECATED-12.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=GOST R 34.10-2001; algo_num=12; keytag=51297
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=GOST R 34.10-2001; algo_num=12; keytag=51297
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=GOST R 34.10-2001; algo_num=12; keytag=51297
   0.04 ERROR    DNSSEC05       ALGORITHM_DEPRECATED  algo_descr=GOST R 34.10-2001; algo_num=12; keytag=51297
```
--> ??




| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-NOT-RECOMMENDED-10 | DS05_ALGO_NOT_RECOMMENDED                                     | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-NOT-RECOMMENDED-10.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-NOT-ZONE-SIGN-0    | DS05_ALGO_NOT_ZONE_SIGN                                       | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-NOT-ZONE-SIGN-0.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Delete DS; algo_num=0; keytag=51285
   0.03 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Delete DS; algo_num=0; keytag=51285
   0.03 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Delete DS; algo_num=0; keytag=51285
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Delete DS; algo_num=0; keytag=51285
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-NOT-ZONE-SIGN-2    | DS05_ALGO_NOT_ZONE_SIGN                                       | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-NOT-ZONE-SIGN-2.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Diffie-Hellman; algo_num=2; keytag=51287
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Diffie-Hellman; algo_num=2; keytag=51287
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Diffie-Hellman; algo_num=2; keytag=51287
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Diffie-Hellman; algo_num=2; keytag=51287
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-NOT-ZONE-SIGN-252  | DS05_ALGO_NOT_ZONE_SIGN                                       | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-NOT-ZONE-SIGN-252.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Reserved for Indirect Keys; algo_num=252; keytag=51537
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Reserved for Indirect Keys; algo_num=252; keytag=51537
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Reserved for Indirect Keys; algo_num=252; keytag=51537
   0.04 ERROR    DNSSEC05       ALGORITHM_NOT_ZONE_SIGN  algo_descr=Reserved for Indirect Keys; algo_num=252; keytag=51537
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-13              | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-13.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-14              | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-14.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-384 with SHA-384; algo_num=14; keytag=51299
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-384 with SHA-384; algo_num=14; keytag=51299
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-384 with SHA-384; algo_num=14; keytag=51299
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-384 with SHA-384; algo_num=14; keytag=51299
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-15              | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-15.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed25519; algo_num=15; keytag=51300
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed25519; algo_num=15; keytag=51300
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed25519; algo_num=15; keytag=51300
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed25519; algo_num=15; keytag=51300
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-16              | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-16.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed448; algo_num=16; keytag=51301
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed448; algo_num=16; keytag=51301
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed448; algo_num=16; keytag=51301
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=Ed448; algo_num=16; keytag=51301
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-17              | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-17.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=17; keytag=51302
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=17; keytag=51302
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=17; keytag=51302
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=17; keytag=51302
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-23              | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-23.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=23; keytag=51308
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=23; keytag=51308
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=23; keytag=51308
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=23; keytag=51308
```
--> ??


| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-OK-8               | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-OK-8.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=RSA/SHA-256; algo_num=8; keytag=51293
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=RSA/SHA-256; algo_num=8; keytag=51293
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=RSA/SHA-256; algo_num=8; keytag=51293
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=RSA/SHA-256; algo_num=8; keytag=51293
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-PRIVATE-253        | DS05_ALGO_PRIVATE                                             | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-PRIVATE-253.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm; algo_num=253; keytag=51538
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm; algo_num=253; keytag=51538
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm; algo_num=253; keytag=51538
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm; algo_num=253; keytag=51538
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-PRIVATE-254        | DS05_ALGO_PRIVATE                                             | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-PRIVATE-254.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm OID; algo_num=254; keytag=51539
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm OID; algo_num=254; keytag=51539
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm OID; algo_num=254; keytag=51539
   0.04 ERROR    DNSSEC05       ALGORITHM_PRIVATE  algo_descr=private algorithm OID; algo_num=254; keytag=51539
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-RESERVED-11        | DS05_ALGO_RESERVED                                            | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-RESERVED-11.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=11; keytag=51296
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=11; keytag=51296
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=11; keytag=51296
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=11; keytag=51296
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-RESERVED-123       | DS05_ALGO_RESERVED                                            | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-RESERVED-123.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=123; keytag=51408
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=123; keytag=51408
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=123; keytag=51408
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=123; keytag=51408
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-RESERVED-251       | DS05_ALGO_RESERVED                                            | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-RESERVED-251.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=251; keytag=51536
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=251; keytag=51536
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=251; keytag=51536
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=251; keytag=51536
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-RESERVED-255       | DS05_ALGO_RESERVED                                            | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-RESERVED-255.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=255; keytag=51540
   0.03 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=255; keytag=51540
   0.03 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=255; keytag=51540
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=255; keytag=51540
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-RESERVED-4         | DS05_ALGO_RESERVED                                            | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-RESERVED-4.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=4; keytag=51289
   0.03 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=4; keytag=51289
   0.03 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=4; keytag=51289
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=4; keytag=51289
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-RESERVED-9         | DS05_ALGO_RESERVED                                            | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-RESERVED-9.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=9; keytag=51294
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=9; keytag=51294
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=9; keytag=51294
   0.04 ERROR    DNSSEC05       ALGORITHM_RESERVED  algo_descr=Reserved; algo_num=9; keytag=51294
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-UNASSIGNED-122     | DS05_ALGO_UNASSIGNED                                          | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-UNASSIGNED-122.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=122; keytag=51407
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=122; keytag=51407
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=122; keytag=51407
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=122; keytag=51407
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-UNASSIGNED-20      | DS05_ALGO_UNASSIGNED                                          | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ALGO-UNASSIGNED-20.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=20; keytag=51305
   0.04 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=20; keytag=51305
   0.05 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=20; keytag=51305
   0.05 ERROR    DNSSEC05       ALGORITHM_UNASSIGNED  algo_descr=Unassigned; algo_num=20; keytag=51305
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| MIXED-ALGO-1            | DS05_ALGO_DEPRECATED, DS05_ALGO_NOT_RECOMMENDED, DS05_ALGO_OK | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw MIXED-ALGO-1.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSASHA1-NSEC3-SHA1; algo_num=7; keytag=51292
   0.04 WARNING  DNSSEC05       ALGORITHM_NOT_RECOMMENDED  algo_descr=RSA/SHA-512; algo_num=10; keytag=51295
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| NO-RESPONSE-1           | DS05_NO_RESPONSE                                              | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw NO-RESPONSE-1.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
  20.06 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns2.child.dnssec05.xa/127.15.5.24
  20.06 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns2.child.dnssec05.xa/fda1:b2:c3:0:127:15:5:24
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| NO-RESPONSE-2           | DS05_NO_RESPONSE                                              | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw NO-RESPONSE-2.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns1.child.dnssec05.xa/127.15.5.23
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns1.child.dnssec05.xa/fda1:b2:c3:0:127:15:5:23
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns2.child.dnssec05.xa/127.15.5.24
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns2.child.dnssec05.xa/fda1:b2:c3:0:127:15:5:24
```
--> ??



| Scenario name      | Mandatory message tags              | Forbidden message tags |
|:-------------------|:------------------------------------|:-----------------------|
| SERVER_NO_DNSSEC-1 | DS05_SERVER_NO_DNSSEC, DS05_ALGO_OK | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw SERVER_NO_DNSSEC-1.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns1.child.dnssec05.xa/127.15.5.23
   0.03 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns1.child.dnssec05.xa/fda1:b2:c3:0:127:15:5:23
   0.03 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.03 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| SHARED-IP-1             | DS05_ALGO_OK                                                  | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw SHARED-IP-1.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
   0.04 INFO     DNSSEC05       ALGORITHM_OK  algo_descr=ECDSA Curve P-256 with SHA-256; algo_num=13; keytag=51298
```
--> ??



| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ZONE_NO_DNSSEC-1        | DS05_ZONE_NO_DNSSEC                                           | 2)                     |

```
$ zonemaster-cli --hints=hintfile.zone --test=dnssec05 --level=info --show-testcase --raw ZONE_NO_DNSSEC-1.dnssec05.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v8.0.0
   0.03 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns1.child.dnssec05.xa/127.15.5.23
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns1.child.dnssec05.xa/fda1:b2:c3:0:127:15:5:23
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns2.child.dnssec05.xa/127.15.5.24
   0.04 ERROR    DNSSEC05       NO_RESPONSE_DNSKEY  ns=ns2.child.dnssec05.xa/fda1:b2:c3:0:127:15:5:24
```
--> ??



