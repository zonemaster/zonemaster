# Implementation of test scenarios for MethodsV2


## Table of contents

* [Background](#background)
* [Root hint for scenarios](#root-hint-for-scenarios)
* [Undelegated data for scenarios](#undelegated-data-for-scenarios)
* [Data type in method output](#data-type-in-method-output)
* [Scenarios](#scenarios)
  * [GOOD-1](#good-1)
  * [GOOD-2](#good-2)
  * [GOOD-3](#good-3)
  * [GOOD-4](#good-4)
  * [GOOD-5](#good-5)
  * [GOOD-6](#good-6)
  * [GOOD-7](#good-7)
  * [GOOD-UNDEL-1](#good-undel-1)
  * [GOOD-UNDEL-2](#good-undel-2)
  * [DIFF-NS-1](#diff-ns-1)
  * [DIFF-NS-2](#diff-ns-2)
  * [IB-NOT-IN-ZONE-1](#ib-not-in-zone-1)
  * [CHILD-NO-ZONE-1](#child-no-zone-1)
  * [CHILD-NO-ZONE-2](#child-no-zone-2)
  * [GOOD-MIXED-UNDEL-1](#good-mixed-undel-1)
  * [GOOD-MIXED-UNDEL-2](#good-mixed-undel-2)
  * [NO-DEL-MIXED-UNDEL-1](#no-del-mixed-undel-1)
  * [NO-CHILD-1](#no-child-1)
  * [NO-CHILD-2](#no-child-2)
  * [NO-CHLD-PAR-UNDETER-1](#no-chld-par-undeter-1)
  * [CHLD-FOUND-PAR-UNDET-1](#chld-found-par-undet-1)
  * [CHLD-FOUND-INCONSIST-1](#chld-found-inconsist-1)
  * [CHLD-FOUND-INCONSIST-2](#chld-found-inconsist-2)
  * [CHLD-FOUND-INCONSIST-3](#chld-found-inconsist-3)
  * [CHLD-FOUND-INCONSIST-4](#chld-found-inconsist-4)
  * [CHLD-FOUND-INCONSIST-5](#chld-found-inconsist-5)
  * [CHLD-FOUND-INCONSIST-6](#chld-found-inconsist-6)
  * [CHLD-FOUND-INCONSIST-7](#chld-found-inconsist-7)
  * [CHLD-FOUND-INCONSIST-8](#chld-found-inconsist-8)
  * [CHLD-FOUND-INCONSIST-9](#chld-found-inconsist-9)
  * [CHLD-FOUND-INCONSIST-10](#chld-found-inconsist-10)
  * [NO-DEL-UNDEL-NO-PAR-1](#no-del-undel-no-par-1)
  * [NO-DEL-UNDEL-PAR-UND-1](#no-del-undel-par-und-1)
  * [NO-CHLD-NO-PAR-1](#no-chld-no-par-1)
  * [CHILD-ALIAS-1](#child-alias-1)
  * [ZONE-ERR-GRANDPARENT-1](#zone-err-grandparent-1)
  * [ZONE-ERR-GRANDPARENT-2](#zone-err-grandparent-2)
  * [ZONE-ERR-GRANDPARENT-3](#zone-err-grandparent-3)
  * [DELEG-OOB-W-ERROR-1](#deleg-oob-w-error-1)
  * [DELEG-OOB-W-ERROR-2](#deleg-oob-w-error-2)
  * [DELEG-OOB-W-ERROR-3](#deleg-oob-w-error-3)
  * [DELEG-OOB-W-ERROR-4](#deleg-oob-w-error-4)
  * [CHILD-NS-CNAME-1](#child-ns-cname-1)
  * [CHILD-NS-CNAME-2](#child-ns-cname-2)
  * [CHILD-NS-CNAME-3](#child-ns-cname-3)
  * [CHILD-NS-CNAME-4](#child-ns-cname-4)
  * [PARENT-NS-CNAME-1](#parent-ns-cname-1)
  * [PARENT-NS-CNAME-2](#parent-ns-cname-2)


## Background

See [Specification of test scenarios for MethodsV2] for the specification of
data and the definition of the scenarios.

## Root hint for scenarios

For all scenarios the root hint should be

```
ns1.      A      127.1.0.1
ns1.      AAAA   fda1:b2:c3::127:1:0:1

ns2.      A      127.1.0.2
ns2.      AAAA   fda1:b2:c3::127:1:0:2
```

## Undelegated data for scenarios

If the scenario depends on undelegated data it is provided with the
scenario below.
* The data is provided as unordered and unique pairs of name server name and IP
  address.
  * Name and address are separated by "/".
  * IP address can be empty and then there is no "/".
* The name server name can be repeated with different IP addresses (IPv4 or
  IPv6) providing multiple addresses for the same name.

## Empty or undefined data
Both empty and undefined data means that no data is expected. In the
specification of the methods a distinction is made between the two. For the
scenarios this distinction is upheld. In an empty set it will say either
`(empty)` or `(undefined)`.

## Scenarios

### GOOD-1

#### Zone

child.parent.good-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-1.methodsv2.xa/127.40.1.41
  * ns1.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-1.methodsv2.xa/127.40.1.42
  * ns2.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.good-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.good-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.good-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data

None.

### GOOD-2

#### Zone

child.parent.good-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-2.methodsv2.xa/127.40.1.41
  * ns1.parent.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-2.methodsv2.xa/127.40.1.42
  * ns2.parent.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns5.good-2.methodsv2.xa/127.40.1.35
  * ns5.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:35
  * ns6.good-2.methodsv2.xa/127.40.1.36
  * ns6.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:36
* Get zone NS names and IP addresses
  * ns5.good-2.methodsv2.xa/127.40.1.35
  * ns5.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:35
  * ns6.good-2.methodsv2.xa/127.40.1.36
  * ns6.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:36

#### Undelegated data

None.

### GOOD-3

#### Zone
child.parent.good-3.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-3.methodsv2.xa/127.40.1.41
  * ns1.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-3.methodsv2.xa/127.40.1.42
  * ns2.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-3.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns3.parent.good-3.methodsv2.xa/127.40.1.43
  * ns3.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns5.good-3.methodsv2.xa/127.40.1.35
  * ns5.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:35
* Get zone NS names and IP addresses
  * ns1.child.parent.good-3.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns3.parent.good-3.methodsv2.xa/127.40.1.43
  * ns3.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns5.good-3.methodsv2.xa/127.40.1.35
  * ns5.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:35

#### Undelegated data

None.

### GOOD-4

#### Zone
child.parent.good-4.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-4.methodsv2.xa/127.40.1.41
  * ns1.parent.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-4.methodsv2.xa/127.40.1.42
  * ns2.parent.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
  * ns1.good-4.methodsv2.xa/127.40.1.31
  * ns1.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:31
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-4.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.good-4.methodsv2.xa/127.40.1.52
  * ns2.child.parent.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.good-4.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.good-4.methodsv2.xa/127.40.1.52
  * ns2.child.parent.good-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data

None.

### GOOD-5

#### Zone
child.parent.good-5.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-5.methodsv2.xa/127.40.1.41
  * ns1.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-5.methodsv2.xa/127.40.1.42
  * ns2.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-5.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.good-5.methodsv2.xa/127.40.1.52
  * ns2.child.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.good-5.methodsv2.xa/127.40.1.31
  * ns1.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:31
  * ns1.parent.good-5.methodsv2.xa/127.40.1.41
  * ns1.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get zone NS names and IP addresses
  * ns1.child.parent.good-5.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.good-5.methodsv2.xa/127.40.1.52
  * ns2.child.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.good-5.methodsv2.xa/127.40.1.31
  * ns1.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:31
  * ns1.parent.good-5.methodsv2.xa/127.40.1.41
  * ns1.parent.good-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:41

#### Undelegated data

None.

### GOOD-6

#### Zone
child.parent.good-6.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-6.methodsv2.xa/127.40.1.41
  * ns1.parent.good-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-6.methodsv2.xa/127.40.1.42
  * ns2.parent.good-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.good-6.methodsv2.xa/127.40.1.31
  * ns1.good-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:31
  * ns2.good-6.methodsv2.xa/127.40.1.32
  * ns2.good-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:32

* Get zone NS names and IP addresses
  * ns1.good-6.methodsv2.xa/127.40.1.31
  * ns1.good-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:31
  * ns2.good-6.methodsv2.xa/127.40.1.32
  * ns2.good-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:32

#### Undelegated data

None.

### GOOD-7

#### Zone
child.parent.good-7.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.good-7.methodsv2.xa/127.40.1.41
  * ns1.parent.good-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-7.methodsv2.xa/127.40.1.42
  * ns2.parent.good-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.parent.good-7.methodsv2.xa/127.40.1.41
  * ns1.parent.good-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-7.methodsv2.xa/127.40.1.42
  * ns2.parent.good-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:42

* Get zone NS names and IP addresses
  * ns1.parent.good-7.methodsv2.xa/127.40.1.41
  * ns1.parent.good-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.good-7.methodsv2.xa/127.40.1.42
  * ns2.parent.good-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:42

#### Undelegated data

None.

### GOOD-UNDEL-1

#### Zone
child.parent.good-undel-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/127.40.1.52
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns3.parent.good-undel-1.methodsv2.xa/127.40.1.43
  * ns3.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns6.good-undel-1.methodsv2.xa/127.40.1.36
  * ns6.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:36
* Get zone NS names and IP addresses
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/127.40.1.52
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns3.parent.good-undel-1.methodsv2.xa/127.40.1.43
  * ns3.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns6.good-undel-1.methodsv2.xa/127.40.1.36
  * ns6.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:36

#### Undelegated data
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/127.40.1.52
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns3.parent.good-undel-1.methodsv2.xa/127.40.1.43
  * ns3.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns6.good-undel-1.methodsv2.xa

### GOOD-UNDEL-2

#### Zone
child.parent.good-undel-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-undel-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns3.parent.good-undel-2.methodsv2.xa/127.40.1.43
  * ns3.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns6.good-undel-2.methodsv2.xa/127.40.1.36
  * ns6.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:36
* Get zone NS names and IP addresses
  * ns1.child.parent.good-undel-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns3.parent.good-undel-2.methodsv2.xa/127.40.1.43
  * ns3.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns6.good-undel-2.methodsv2.xa/127.40.1.36
  * ns6.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:36


#### Undelegated data
  * ns1.child.parent.good-undel-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns3.parent.good-undel-2.methodsv2.xa/127.40.1.43
  * ns3.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:43
  * ns6.good-undel-2.methodsv2.xa

### DIFF-NS-1

#### Zone

child.parent.diff-ns-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.diff-ns-1.methodsv2.xa/127.40.1.41
  * ns1.parent.diff-ns-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.diff-ns-1.methodsv2.xa/127.40.1.42
  * ns2.parent.diff-ns-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.diff-ns-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.diff-ns-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.diff-ns-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.diff-ns-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1-2.child.parent.diff-ns-1.methodsv2.xa/127.40.1.51
  * ns1-2.child.parent.diff-ns-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2-2.child.parent.diff-ns-1.methodsv2.xa/127.40.1.52
  * ns2-2.child.parent.diff-ns-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data

None.

### DIFF-NS-2

#### Zone

child.parent.diff-ns-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.diff-ns-2.methodsv2.xa/127.40.1.41
  * ns1.parent.diff-ns-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.diff-ns-2.methodsv2.xa/127.40.1.42
  * ns2.parent.diff-ns-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.diff-ns-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.diff-ns-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.diff-ns-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.diff-ns-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1-2.child.parent.diff-ns-2.methodsv2.xa/127.40.1.51
  * ns1-2.child.parent.diff-ns-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns3.child.parent.diff-ns-2.methodsv2.xa/127.40.1.53
  * ns3.child.parent.diff-ns-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:53

#### Undelegated data

None.

### IB-NOT-IN-ZONE-1

#### Zone

child.parent.ib-not-in-zone-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.ib-not-in-zone-1.methodsv2.xa/127.40.1.41
  * ns1.parent.ib-not-in-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.ib-not-in-zone-1.methodsv2.xa/127.40.1.42
  * ns2.parent.ib-not-in-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.ib-not-in-zone-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.ib-not-in-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.ib-not-in-zone-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.ib-not-in-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.ib-not-in-zone-1.methodsv2.xa
  * ns2.child.parent.ib-not-in-zone-1.methodsv2.xa

#### Undelegated data

None.

### CHILD-NO-ZONE-1

#### Zone

child.parent.child-no-zone-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.child-no-zone-1.methodsv2.xa/127.40.1.41
  * ns1.parent.child-no-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.child-no-zone-1.methodsv2.xa/127.40.1.42
  * ns2.parent.child-no-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.child-no-zone-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.child-no-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.child-no-zone-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.child-no-zone-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * (empty)
  
#### Undelegated data

None.

### CHILD-NO-ZONE-2

#### Zone

child.parent.child-no-zone-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.child-no-zone-2.methodsv2.xa/127.40.1.41
  * ns1.parent.child-no-zone-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.child-no-zone-2.methodsv2.xa/127.40.1.42
  * ns2.parent.child-no-zone-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.child-no-zone-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.child-no-zone-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.child-no-zone-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.child-no-zone-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  (empty)


#### Undelegated data

None.

### GOOD-MIXED-UNDEL-1

#### Zone

child.parent.good-mixed-undel-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns3.child.parent.good-mixed-undel-1.methodsv2.xa/127.40.1.53
  * ns3.child.parent.good-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:53
  * ns4.child.parent.good-mixed-undel-1.methodsv2.xa/127.40.1.54
  * ns4.child.parent.good-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:54
* Get zone NS names and IP addresses
  * ns3.child.parent.good-mixed-undel-1.methodsv2.xa/127.40.1.53
  * ns3.child.parent.good-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:53
  * ns4.child.parent.good-mixed-undel-1.methodsv2.xa/127.40.1.54
  * ns4.child.parent.good-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:54

#### Undelegated data
  * ns3.child.parent.good-mixed-undel-1.methodsv2.xa/127.40.1.53
  * ns3.child.parent.good-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:53
  * ns4.child.parent.good-mixed-undel-1.methodsv2.xa/127.40.1.54
  * ns4.child.parent.good-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:54

### GOOD-MIXED-UNDEL-2

#### Zone

child.parent.good-mixed-undel-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns3.child.parent.good-mixed-undel-2.methodsv2.xa/127.40.1.53
  * ns3.child.parent.good-mixed-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:53
  * ns4.child.parent.good-mixed-undel-2.methodsv2.xa/127.40.1.54
  * ns4.child.parent.good-mixed-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:54
* Get zone NS names and IP addresses
  * ns3.child.parent.good-mixed-undel-2.methodsv2.xa/127.40.1.53
  * ns3.child.parent.good-mixed-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:53
  * ns4.child.parent.good-mixed-undel-2.methodsv2.xa/127.40.1.54
  * ns4.child.parent.good-mixed-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:54

#### Undelegated data
  * ns3.child.parent.good-mixed-undel-2.methodsv2.xa/127.40.1.53
  * ns3.child.parent.good-mixed-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:53
  * ns4.child.parent.good-mixed-undel-2.methodsv2.xa/127.40.1.54
  * ns4.child.parent.good-mixed-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:54

### NO-DEL-MIXED-UNDEL-1

#### Zone

child.parent.no-del-mixed-undel-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns1.child.parent.no-del-mixed-undel-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-mixed-undel-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.no-del-mixed-undel-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-mixed-undel-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * ns1.child.parent.no-del-mixed-undel-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-mixed-undel-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-mixed-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

### NO-CHILD-1

#### Zone

child.parent.no-child-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (undefined)
* Get delegation NS names and IP addresses
  * (undefined)
* Get zone NS names and IP addresses
  * (undefined)

#### Undelegated data
  * (empty)

### NO-CHILD-2

#### Zone

child.parent.no-child-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (undefined)
* Get delegation NS names and IP addresses
  * (undefined)
* Get zone NS names and IP addresses
  * (undefined)

#### Undelegated data
  * (empty)

### NO-CHLD-PAR-UNDETER-1

#### Zone

child.parent.no-chld-par-undeter-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (undefined)
* Get delegation NS names and IP addresses
  * (undefined)
* Get zone NS names and IP addresses
  * (undefined)

#### Undelegated data
  * (empty)

### CHLD-FOUND-PAR-UNDET-1

#### Zone

child.parent.chld-found-par-undet-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.chld-found-par-undet-1.methodsv2.xa/127.40.1.31
  * ns1.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:31
  * ns1.parent.chld-found-par-undet-1.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.chld-found-par-undet-1.methodsv2.xa/127.40.1.42
  * ns2.parent.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-par-undet-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-par-undet-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-par-undet-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-par-undet-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-par-undet-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-1

#### Zone

child.parent.chld-found-inconsist-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-1.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-2

#### Zone

child.parent.chld-found-inconsist-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-2.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-3

#### Zone

child.parent.chld-found-inconsist-3.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-3.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-3.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-3.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-3.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-3.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-4

#### Zone

child.parent.chld-found-inconsist-4.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-4.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-4.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-4.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-4.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-4.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-5

#### Zone

child.parent.chld-found-inconsist-5.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-5.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-5.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-5.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-5.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-5.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-5.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-6

#### Zone

child.parent.chld-found-inconsist-6.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-6.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-6.methodsv2.xa/fda1:b2:c3:0:127:40:1:41

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-7

#### Zone

child.parent.chld-found-inconsist-7.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-7.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-7.methodsv2.xa/fda1:b2:c3:0:127:40:1:41

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-8

#### Zone

child.parent.chld-found-inconsist-8.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-8.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-8.methodsv2.xa/fda1:b2:c3:0:127:40:1:41

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-9

#### Zone

child.parent.chld-found-inconsist-9.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-9.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-9.methodsv2.xa/fda1:b2:c3:0:127:40:1:41

#### Undelegated data
  * (empty)

### CHLD-FOUND-INCONSIST-10

#### Zone

child.parent.chld-found-inconsist-10.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get delegation NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
* Get zone NS names and IP addresses
  * ns1.child.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.51
  * ns1.child.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.52
  * ns2.child.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
  * ns1.parent.chld-found-inconsist-10.methodsv2.xa/127.40.1.41
  * ns1.parent.chld-found-inconsist-10.methodsv2.xa/fda1:b2:c3:0:127:40:1:41

#### Undelegated data
  * (empty)


### NO-DEL-UNDEL-NO-PAR-1

#### Zone

child.parent.no-del-undel-no-par-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns1.child.parent.no-del-undel-no-par-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-undel-no-par-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-undel-no-par-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-undel-no-par-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.no-del-undel-no-par-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-undel-no-par-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-undel-no-par-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-undel-no-par-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * ns1.child.parent.no-del-undel-no-par-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-undel-no-par-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-undel-no-par-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-undel-no-par-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52


### NO-DEL-UNDEL-PAR-UND-1

#### Zone

child.parent.no-del-undel-par-und-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (empty)
* Get delegation NS names and IP addresses
  * ns1.child.parent.no-del-undel-par-und-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-undel-par-und-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-undel-par-und-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-undel-par-und-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.no-del-undel-par-und-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-undel-par-und-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-undel-par-und-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-undel-par-und-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * ns1.child.parent.no-del-undel-par-und-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.no-del-undel-par-und-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.no-del-undel-par-und-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.no-del-undel-par-und-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52


### NO-CHLD-NO-PAR-1

#### Zone

child.parent.no-chld-no-par-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (undefined)
* Get delegation NS names and IP addresses
  * (undefined)
* Get zone NS names and IP addresses
  * (undefined)

#### Undelegated data
  * (empty)


### CHILD-ALIAS-1

#### Zone

child.parent.child-alias-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * (undefined)
* Get delegation NS names and IP addresses
  * (undefined)
* Get zone NS names and IP addresses
  * (undefined)

#### Undelegated data
  * (empty)


### ZONE-ERR-GRANDPARENT-1

#### Zone

child.parent.zone-err-grandparent-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.zone-err-grandparent-1.methodsv2.xa/127.40.1.41
  * ns1.parent.zone-err-grandparent-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.zone-err-grandparent-1.methodsv2.xa/127.40.1.42
  * ns2.parent.zone-err-grandparent-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.zone-err-grandparent-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.zone-err-grandparent-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.zone-err-grandparent-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.zone-err-grandparent-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.zone-err-grandparent-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.zone-err-grandparent-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.zone-err-grandparent-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.zone-err-grandparent-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


### ZONE-ERR-GRANDPARENT-2

#### Zone

child.parent.zone-err-grandparent-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.zone-err-grandparent-2.methodsv2.xa/127.40.1.41
  * ns1.parent.zone-err-grandparent-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.zone-err-grandparent-2.methodsv2.xa/127.40.1.42
  * ns2.parent.zone-err-grandparent-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.zone-err-grandparent-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.zone-err-grandparent-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.zone-err-grandparent-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.zone-err-grandparent-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.zone-err-grandparent-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.zone-err-grandparent-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.zone-err-grandparent-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.zone-err-grandparent-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


### ZONE-ERR-GRANDPARENT-3

#### Zone

child.parent.zone-err-grandparent-3.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.zone-err-grandparent-3.methodsv2.xa/127.40.1.41
  * ns1.parent.zone-err-grandparent-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.zone-err-grandparent-3.methodsv2.xa/127.40.1.42
  * ns2.parent.zone-err-grandparent-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.zone-err-grandparent-3.methodsv2.xa/127.40.1.51
  * ns1.child.parent.zone-err-grandparent-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.zone-err-grandparent-3.methodsv2.xa/127.40.1.52
  * ns2.child.parent.zone-err-grandparent-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.zone-err-grandparent-3.methodsv2.xa/127.40.1.51
  * ns1.child.parent.zone-err-grandparent-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.zone-err-grandparent-3.methodsv2.xa/127.40.1.52
  * ns2.child.parent.zone-err-grandparent-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


### DELEG-OOB-W-ERROR-1

#### Zone

child.parent.deleg-oob-w-error-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.deleg-oob-w-error-1.methodsv2.xa/127.40.1.41
  * ns1.parent.deleg-oob-w-error-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.deleg-oob-w-error-1.methodsv2.xa/127.40.1.42
  * ns2.parent.deleg-oob-w-error-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns3.deleg-oob-w-error-1.methodsv2.xa/127.40.1.33
  * ns3.deleg-oob-w-error-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:33
  * ns4-nodata.deleg-oob-w-error-1.methodsv2.xa
* Get zone NS names and IP addresses
  * ns3.deleg-oob-w-error-1.methodsv2.xa/127.40.1.33
  * ns3.deleg-oob-w-error-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:33
  * ns4-nodata.deleg-oob-w-error-1.methodsv2.xa

#### Undelegated data
  * (empty)


### DELEG-OOB-W-ERROR-2

#### Zone

child.parent.deleg-oob-w-error-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.deleg-oob-w-error-2.methodsv2.xa/127.40.1.41
  * ns1.parent.deleg-oob-w-error-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.deleg-oob-w-error-2.methodsv2.xa/127.40.1.42
  * ns2.parent.deleg-oob-w-error-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns3.deleg-oob-w-error-2.methodsv2.xa/127.40.1.33
  * ns3.deleg-oob-w-error-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:33
  * ns4-nxdomain.deleg-oob-w-error-2.methodsv2.xa
* Get zone NS names and IP addresses
  * ns3.deleg-oob-w-error-2.methodsv2.xa/127.40.1.33
  * ns3.deleg-oob-w-error-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:33
  * ns4-nxdomain.deleg-oob-w-error-2.methodsv2.xa

#### Undelegated data
  * (empty)


### DELEG-OOB-W-ERROR-3

#### Zone

child.parent.deleg-oob-w-error-3.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.deleg-oob-w-error-3.methodsv2.xa/127.40.1.41
  * ns1.parent.deleg-oob-w-error-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.deleg-oob-w-error-3.methodsv2.xa/127.40.1.42
  * ns2.parent.deleg-oob-w-error-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns3-nodata.deleg-oob-w-error-3.methodsv2.xa
  * ns4-nodata.deleg-oob-w-error-3.methodsv2.xa
* Get zone NS names and IP addresses
  * (empty)

#### Undelegated data
  * (empty)


### DELEG-OOB-W-ERROR-4

#### Zone

child.parent.deleg-oob-w-error-4.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.deleg-oob-w-error-4.methodsv2.xa/127.40.1.41
  * ns1.parent.deleg-oob-w-error-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.deleg-oob-w-error-4.methodsv2.xa/127.40.1.42
  * ns2.parent.deleg-oob-w-error-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns3-nxdomain.deleg-oob-w-error-4.methodsv2.xa
  * ns4-nxdomain.deleg-oob-w-error-4.methodsv2.xa
* Get zone NS names and IP addresses
  * (empty)

#### Undelegated data
  * (empty)


### CHILD-NS-CNAME-1

#### Zone

child.parent.child-ns-cname-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.child-ns-cname-1.methodsv2.xa/127.40.1.41
  * ns1.parent.child-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.child-ns-cname-1.methodsv2.xa/127.40.1.42
  * ns2.parent.child-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1-cname.child.parent.child-ns-cname-1.methodsv2.xa/127.40.1.51
  * ns1-cname.child.parent.child-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2-cname.child.parent.child-ns-cname-1.methodsv2.xa/127.40.1.52
  * ns2-cname.child.parent.child-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1-cname.child.parent.child-ns-cname-1.methodsv2.xa/127.40.1.51
  * ns1-cname.child.parent.child-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2-cname.child.parent.child-ns-cname-1.methodsv2.xa/127.40.1.52
  * ns2-cname.child.parent.child-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


### CHILD-NS-CNAME-2

#### Zone

child.parent.child-ns-cname-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.child-ns-cname-2.methodsv2.xa/127.40.1.41
  * ns1.parent.child-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.child-ns-cname-2.methodsv2.xa/127.40.1.42
  * ns2.parent.child-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1-cname.child.parent.child-ns-cname-2.methodsv2.xa/127.40.1.51
  * ns1-cname.child.parent.child-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2-cname.child.parent.child-ns-cname-2.methodsv2.xa/127.40.1.52
  * ns2-cname.child.parent.child-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1-cname.child.parent.child-ns-cname-2.methodsv2.xa/127.40.1.51
  * ns1-cname.child.parent.child-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2-cname.child.parent.child-ns-cname-2.methodsv2.xa/127.40.1.52
  * ns2-cname.child.parent.child-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


### CHILD-NS-CNAME-3

#### Zone

child.parent.child-ns-cname-3.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.child-ns-cname-3.methodsv2.xa/127.40.1.41
  * ns1.parent.child-ns-cname-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.child-ns-cname-3.methodsv2.xa/127.40.1.42
  * ns2.parent.child-ns-cname-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns3-cname.child-ns-cname-3.methodsv2.xa/127.40.1.33
  * ns3-cname.child-ns-cname-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:33
  * ns4-cname.child-ns-cname-3.methodsv2.xa/127.40.1.34
  * ns4-cname.child-ns-cname-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:34
* Get zone NS names and IP addresses
  * ns3-cname.child-ns-cname-3.methodsv2.xa/127.40.1.33
  * ns3-cname.child-ns-cname-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:33
  * ns4-cname.child-ns-cname-3.methodsv2.xa/127.40.1.34
  * ns4-cname.child-ns-cname-3.methodsv2.xa/fda1:b2:c3:0:127:40:1:34

#### Undelegated data
  * (empty)

### CHILD-NS-CNAME-4

#### Zone

child.parent.child-ns-cname-4.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1.parent.child-ns-cname-4.methodsv2.xa/127.40.1.41
  * ns1.parent.child-ns-cname-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2.parent.child-ns-cname-4.methodsv2.xa/127.40.1.42
  * ns2.parent.child-ns-cname-4.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1-cname.child.parent.child-ns-cname-4.methodsv2.xa/127.40.1.51
* Get zone NS names and IP addresses
  * ns1-cname.child.parent.child-ns-cname-4.methodsv2.xa/127.40.1.51
  * ns2-cname.child.parent.child-ns-cname-4.methodsv2.xa/127.40.1.52

#### Undelegated data
  * (empty)

### PARENT-NS-CNAME-1

#### Zone

child.parent.parent-ns-cname-1.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1-cname.parent.parent-ns-cname-1.methodsv2.xa/127.40.1.41
  * ns1-cname.parent.parent-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2-cname.parent.parent-ns-cname-1.methodsv2.xa/127.40.1.42
  * ns2-cname.parent.parent-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.parent-ns-cname-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.parent-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.parent-ns-cname-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.parent-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.parent-ns-cname-1.methodsv2.xa/127.40.1.51
  * ns1.child.parent.parent-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.parent-ns-cname-1.methodsv2.xa/127.40.1.52
  * ns2.child.parent.parent-ns-cname-1.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


### PARENT-NS-CNAME-2

#### Zone

child.parent.parent-ns-cname-2.methodsv2.xa

#### Methods and expected output
* Get parent NS names and IP addresses
  * ns1-cname.parent.parent-ns-cname-2.methodsv2.xa/127.40.1.41
  * ns1-cname.parent.parent-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:41
  * ns2-cname.parent.parent-ns-cname-2.methodsv2.xa/127.40.1.42
  * ns2-cname.parent.parent-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:42
* Get delegation NS names and IP addresses
  * ns1.child.parent.parent-ns-cname-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.parent-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.parent-ns-cname-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.parent-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52
* Get zone NS names and IP addresses
  * ns1.child.parent.parent-ns-cname-2.methodsv2.xa/127.40.1.51
  * ns1.child.parent.parent-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:51
  * ns2.child.parent.parent-ns-cname-2.methodsv2.xa/127.40.1.52
  * ns2.child.parent.parent-ns-cname-2.methodsv2.xa/fda1:b2:c3:0:127:40:1:52

#### Undelegated data
  * (empty)


<!--
### TEMPLATE

#### Zone

XA

#### Methods and expected output
* Get parent NS names and IP addresses
  *
* Get delegation NS names and IP addresses
  * 
* Get zone NS names and IP addresses
  * 

#### Undelegated data
  * 

-->




[Specification of test scenarios for MethodsV2]:                  ../../docs/public/specifications/test-zones/MethodsV2/methodsv2.md
