# Specification of test zones for the CNAME functions in Recursor.pm


## Table of contents

* [Background](#background)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]


## Background

See the [test zone README file] which is for test case base test zones. Since
this specifies test zones for code it is not fully applicable.

## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
the code should be tested.


## Test zone name

The test zone for these scenarios is `cname.recursor.engine.xa`. Subdomain and
subzones are created. The names are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
GOOD-CNAME-1                 | True and tags `CNAME_START`, `CNAME_FOLLOWED_IN_ZONE`
GOOD-CNAME-2                 | True and tags `CNAME_START`, `CNAME_FOLLOWED_IN_ZONE`
GOOD-CNAME-CHAIN             | True and tags `CNAME_START`, `CNAME_FOLLOWED_IN_ZONE`
GOOD-CNAME-OUT-OF-ZONE       | True and tags `CNAME_START`, `CNAME_FOLLOWED_OUT_OF_ZONE`
NXDOMAIN-VIA-CNAME           | True and tags `CNAME_START`, `CNAME_FOLLOWED_OUT_OF_ZONE`
NODATA-VIA-CNAME             | True and tags `CNAME_START`, `CNAME_FOLLOWED_OUT_OF_ZONE`
MULT-CNAME                   | Undefined and tags `CNAME_START`, `CNAME_MULTIPLE_FOR_NAME`
LOOPED-CNAME-IN-ZONE-1       | Undefined and tags `CNAME_START`, `CNAME_LOOP_INNER`
LOOPED-CNAME-IN-ZONE-2       | Undefined and tags `CNAME_START`, `CNAME_LOOP_INNER`
LOOPED-CNAME-IN-ZONE-3       | Undefined and tags `CNAME_START`, `CNAME_LOOP_INNER`
LOOPED-CNAME-OUT-OF-ZONE     | Undefined and tags `CNAME_START`, `CNAME_LOOP_OUTER`
TOO-LONG-CNAME-CHAIN         | Undefined and tags `CNAME_START`, `CNAME_RECORDS_TOO_MANY`
TARGET-NO-MATCH-CNAME        | Undefined and tags `CNAME_START`, `CNAME_NO_MATCH`
BROKEN-CNAME-CHAIN           | Undefined and tags `CNAME_START`, `CNAME_RECORDS_CHAIN_BROKEN`
WRONG-CNAME-OWNER-NAME       | False and no tags
EXTRA-CNAME-IN-ANSWER        | False and no tags

## Zone setup for test scenarios

Assumptions for the scenario specifications, unless stated otherwise for the
specific scenario:

* The `cname.recursor.engine.xa` zone is used for all scenarios.
* Relative names are under `cname.recursor.engine.xa.`.
* The query name is given by the scenario.
* Query type is assumed to be `A`.
* In the zone, the query name always has a `CNAME` record.
* The zone is set up on one NS, ns1.
* The [RCODE Name] in the response is NoError.

### GOOD-CNAME-1
The query name will resolve to one `A` record via one CNAME.

* Query name: "good-cname-1.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   good-cname-1         CNAME good-cname-1-target 
   good-cname-1-target  A     127.0.0.1
```

### GOOD-CNAME-2
The query name will resolve to two `A` record via one CNAME.

* Query name: "good-cname-2.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   good-cname-2         CNAME good-cname-2-target
   good-cname-2-target  A     127.0.0.1
   good-cname-2-target  A     127.0.0.2
```

### GOOD-CNAME-CHAIN
The query name will resolve to two `A` record via three CNAME.

* Query name: "good-cname-chain.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   good-cname-chain         CNAME good-cname-chain-two
   good-cname-chain-two     CNAME good-cname-chain-three
   good-cname-chain-three   CNAME good-cname-chain-target
   good-cname-chain-target  A     127.0.0.1
```

### GOOD-CNAME-OUT-OF-ZONE
The query name will resolve to an `A` record via a CNAME in the zone with a
target that points at a subzone, and a delegation to that sub zone.

* For all queries
  * The two zones, `cname.recursor.engine.xa` and
    `goodsub.cname.recursor.engine.xa`, are hosted on different IP addresses.
  * "x", "y" and "z" in the IP addresses in the configuration below are to be
    set in the configuration of the test zones.

* Query name: "good-cname-out-of-zone.cname.recursor.engine.xa"
  * Servers: NS of `cname.recursor.engine.xa`.
  * Answer, authority and additional sections, respectively, to be found in the
    response:
```
   ;; ANSWER SECTION:
   good-cname-out-of-zone  CNAME target.goodsub

   ;; AUTHORITY SECTION:
   goodsub                 NS    ns1.goodsub

   ;; ADDITIONAL SECTION:
   ns1.goodsub             A     127.x.y.z
   ns1.goodsub             AAAA  fda1:b2:c3::127:x:y:z
```
* Query name: "target.goodsub.cname.recursor.engine.xa"
  * Servers: NS of `goodsub.cname.recursor.engine.xa`.
  * To be found in the answer section:
```
   target.goodsub          A     127.0.0.1
```

### NXDOMAIN-VIA-CNAME
The query name exists, but as CNAME record. The target name of CNAME does not
exist.

* Query name: "nxdomain-via-cname.cname.recursor.engine.xa"
  * The [RCODE Name] in the response is NxDomain.
  * The target of the CNAME, `nxdomain-via-cname-target` does not exist in the
    zone and is not delegated.
  * SOA of "cname.recursor.engine.xa" to be found in authority section.
  * To be found in the answer section:
```
   nxdomain-via-cname       CNAME nxdomain-via-cname-target
```

### NODATA-VIA-CNAME
The query name exists, but as CNAME record. The target name of CNAME exists, but
not with any A record.

* Query name: "nodata-via-cname.cname.recursor.engine.xa"
  * The target of the CNAME, `nodata-via-cname-target`, exists in the zone but
    has neither `A` or `CNAME` record, and is not delegated.
  * SOA of "cname.recursor.engine.xa" to be found in authority section.
  * To be found in the answer section:
```
   nodata-via-cname       CNAME nodata-via-cname-target
```

### MULT-CNAME
The query name exists, but as CNAME, as two CNAME records.

* Query name: "mult-cname.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   mult-cname            CNAME mult-cname-target-1
   mult-cname            CNAME mult-cname-target-2
   mult-cname-target-1   A     127.0.0.1
   mult-cname-target-2   A     127.0.0.2
```

## LOOPED-CNAME-IN-ZONE-1
The query name will point at a CNAME record with the same target as owner name.

* Query name: "looped-cname-in-zone-1.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   looped-cname-in-zone-1 CNAME looped-cname-in-zone-1
```

## LOOPED-CNAME-IN-ZONE-2
The query name will point at a CNAME, which points at a second CNAME,
which points to a third CNAME whose target name is the same as the 
owner name of the second CNAME.

* Query name: "looped-cname-in-zone-2.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   looped-cname-in-zone-2    CNAME looped-cname-in-zone-2-a
   looped-cname-in-zone-2-a  CNAME looped-cname-in-zone-2-b
   looped-cname-in-zone-2-b  CNAME looped-cname-in-zone-2-a
```

## LOOPED-CNAME-IN-ZONE-3
The query name will point at a CNAME, which points at a second CNAME whose target
name is the same as the owner name of the first CNAME.

* Query name: "looped-cname-in-zone-3.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   looped-cname-in-zone-3       CNAME looped-cname-in-zone-3-next
   looped-cname-in-zone-3-next  CNAME looped-cname-in-zone-3
```

## LOOPED-CNAME-OUT-OF-ZONE
The query name will point at a CNAME record, but in a sub zone, and the target
name of the CNAME record will point at another CNAME record in another sub zone,
and the target name of the second CNAME record will point at the first.

* For all four queries
  * The three zones `cname.recursor.engine.xa`, `sub2.cname.recursor.engine.xa`
    and `sub3.cname.recursor.engine.xa` are hosted on different IP addresses.
  * "x", "y" and "z" in the IP addresses in the configuration below are to be
    set in the configuration of the test zones.

* Query name: "looped-cname-out-of-zone.sub2.cname.recursor.engine.xa"
  * Servers: NS of `cname.recursor.engine.xa`.
  * Authority and additional sections, respectively, to be found in the
    response:
```
   ;; AUTHORITY SECTION:
   sub2          NS    ns1.sub2

   ;; ADDITIONAL SECTION:
   ns1.sub2      A     127.x.y.z
   ns1.sub2      AAAA  fda1:b2:c3::127:x:y:z
```
* Query name: "looped-cname-out-of-zone.sub2.cname.recursor.engine.xa"
  * Servers: NS of `sub2.cname.recursor.engine.xa`.
  * To be found in the answer section:
```
   looped-cname-out-of-zone.sub2   CNAME   looped-cname-out-of-zone.sub3
```
* Query name: "looped-cname-out-of-zone.sub3.cname.recursor.engine.xa"
  * Servers: NS of `cname.recursor.engine.xa`.
  * Relative names are under `cname.recursor.engine.xa.`.
  * Authority and additional sections, respectively, to be found in the
    response:
```
   ;; AUTHORITY SECTION:
   sub3          NS    ns1.sub3

   ;; ADDITIONAL SECTION:
   ns1.sub3      A     127.x.y.z
   ns1.sub3      AAAA  fda1:b2:c3::127:x:y:z
```
* Query name: "looped-cname-out-of-zone.sub3.cname.recursor.engine.xa"
  * Servers: NS of `sub3.cname.recursor.engine.xa`.
  * To be found in the answer section:
```
   looped-cname-out-of-zone.sub3   CNAME   looped-cname-out-of-zone.sub2
```

### TOO-LONG-CNAME-CHAIN
The query name will resolve to one `A` record via ten CNAME records which is
above the limit.

* Query name: "too-long-cname-chain.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   too-long-cname-chain              CNAME too-long-cname-chain-two
   too-long-cname-chain-two          CNAME too-long-cname-chain-three
   too-long-cname-chain-three        CNAME too-long-cname-chain-four
   too-long-cname-chain-four         CNAME too-long-cname-chain-five
   too-long-cname-chain-five         CNAME too-long-cname-chain-six
   too-long-cname-chain-six          CNAME too-long-cname-chain-seven
   too-long-cname-chain-seven        CNAME too-long-cname-chain-eight
   too-long-cname-chain-eight        CNAME too-long-cname-chain-nine
   too-long-cname-chain-nine         CNAME too-long-cname-chain-ten
   too-long-cname-chain-ten          CNAME too-long-cname-chain-target
   too-long-cname-chain-target       A     127.0.0.1
```

### TARGET-NO-MATCH-CNAME
The CNAME target name does not match the owner name of the `A` record.

* Query name: "target-no-match-cname.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   target-no-match-cname         CNAME  target-no-match-cname-two
   target-no-match-cname-target  A      127.0.0.1
```

### BROKEN-CNAME-CHAIN
The CNAME chain is broken between first and second CNAME records.

* Query name: "broken-cname-chain.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   broken-cname-chain            CNAME broken-cname-chain-two
   broken-cname-chain-three      CNAME broken-cname-chain-target
   broken-cname-chain-target     A     127.0.0.1
```


### WRONG-CNAME-OWNER-NAME
The owner name of the CNAME in the response does not match query name.

* Query name: "wrong-cname-owner-name.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   wrong-cname-owner-name-1       CNAME wrong-cname-owner-name-target
   wrong-cname-owner-name-target  A     127.0.0.1
```


### EXTRA-CNAME-IN-ANSWER
There is an extra CNAME record with an owner name not matching the query name
besides the `A` record matching query name.

* Query name: "extra-cname-in-answer.cname.recursor.engine.xa"
  * To be found in the answer section:
```
   extra-cname-in-answer         A     127.0.0.1
   extra-cname-in-answer-1       CNAME extra-cname-in-answer-2
```



[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

