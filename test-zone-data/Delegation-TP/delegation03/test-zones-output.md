# Delegation03 Test Zones Output

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

* REFERRAL_SIZE_OK
* REFERRAL_SIZE_TOO_LARGE


## All scenarios

Scenario name                 | Zone name
:-----------------------------|:---------------------------------------------
REFERRAL-SIZE-OK-1            | referral-size-ok-1.delegation03.xa.
REFERRAL-SIZE-OK-2            | referral-size-ok-2.delegation03.xa.
REFERRAL-SIZE-TOO-LARGE-1     | referral-size-too-large-1.delegation03.xa
REFERRAL-SIZE-TOO-LARGE-2     | referral-size-too-large-2.delegation03.xa



## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with `--level=info
--test=delegation03`.

The test zones for these scenarios have a dedicated root zone, which means that
the hint files in the commands below must be used.

All commands are run from the same directory as this file is in.

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
REFERRAL-SIZE-OK-1            | REFERRAL_SIZE_OK                         | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation03 --level=info --show-testcase --raw REFERRAL-SIZE-OK-1.delegation03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.06 INFO     Delegation03   REFERRAL_SIZE_OK  size=307
```

--> OK

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
REFERRAL-SIZE-OK-2            | REFERRAL_SIZE_OK                         | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation03 --level=info --show-testcase --raw REFERRAL-SIZE-OK-2.delegation03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.09 INFO     Delegation03   REFERRAL_SIZE_OK  size=353
```

--> OK


Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
REFERRAL-SIZE-TOO-LARGE-1     | REFERRAL_SIZE_TOO_LARGE                  | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation03 --level=info --show-testcase --raw REFERRAL-SIZE-TOO-LARGE-1.delegation03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.48 WARNING  Delegation03   REFERRAL_SIZE_TOO_LARGE  size=536
```



Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
REFERRAL-SIZE-TOO-LARGE-2     | REFERRAL_SIZE_TOO_LARGE                  | 2)

```
$ zonemaster-cli --hint=hintfile.zone --test=delegation03 --level=info --show-testcase --raw REFERRAL-SIZE-TOO-LARGE-2.delegation03.xa
   0.00 INFO     Unspecified    GLOBAL_VERSION  version=v6.0.0
   0.27 WARNING  Delegation03   REFERRAL_SIZE_TOO_LARGE  size=663
```



