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
  * [GOOD-UNDEL-1](#good-undel-1)
  * [GOOD-UNDEL-2](#good-undel-2)

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

If the scenario dependends on undelegated data it is provided with the
scenario below.
* The data is provided as unordered and unique pairs of name server name and IP
  address.
  * Name and address are separated by "/".
  * IP address can be empty and then there is no "/".
* The name server name can be repeated with different IP addresses (IPv4 or
  IPv6) providing multiple addresses for the same name.

## Empty or undefined data
Both empty and undefined data means that no data is expected. In the
specification of the methods a destinction is made between the two. For the
scenarios this distinction is upheld. In an empty set it will say either
`(empty)` or `(undefined)`.

## Scenarios

### GOOD-1

#### Zone

child.parent.good-1.methodsv2.xa

#### Methods and expected output
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
  * 127.40.1.31
  * fda1:b2:c3:0:127:40:1:31
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
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
* Get parent NS IP addresses
  * 127.40.1.31
  * fda1:b2:c3:0:127:40:1:31
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
  * 127.40.1.42
  * fda1:b2:c3:0:127:40:1:42
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
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
* Get parent NS IP addresses
  * 127.40.1.41
  * fda1:b2:c3:0:127:40:1:41
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












### TEMPLATE

#### Zone

xa

#### Methods and expected output
* Get parent NS IP addresses
  *
* Get delegation NS names and IP addresses
  * 
* Get zone NS names and IP addresses
  * 

#### Undelegated data
  * 






[Specification of test scenarios for MethodsV2]:                  ../../docs/public/specifications/test-zones/MethodsV2/methodsv2.md
