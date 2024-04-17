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

See [Specification of test scenarios for MethodsV2].

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
scenario below. The data is provided as pairs for name server name and IP
address separated by "/". IP address can be empty and then provided with a
placeholder ("-"). The name server name can be repeated with different IP
addresses providing multiple addresses for the same name.

## Data type in method output

The expected data from the methods can be of different types. For the setup
below the data is provided as follows:

* "Get parent NS IP addresses", "Get delegation NS IP addresses" and 
  "Get zone NS IP addresses":
  * "(empty)"
  * "(undefined)"
  * Unordered list of unique IP addresses.
* "Get delegation NS names" and "Get zone NS names":
  * "(empty)"
  * "(undefined)"
  * Unordered list of unique name server names.
* "Get delegation NS names and IP addresses" and
  "Get zone NS names and IP addresses":
  * "(empty)"
  * "(undefined)"
  * Unordered list of unique pairs of name server name and IP address separated
    by "/".
    * The name server name can be repeated with different IP addresses.
    * The IP address can be empty and then with a placeholder ("-").


## Scenarios

### GOOD-1

#### Zone

child.parent.good-1.methodsv2.xa

#### Methods and Expected output
* Get parent NS IP addresses
  * 127.40.3.21
  * fda1:b2:c3:0:127:40:3:21
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
* Get delegation NS names
  * ns1.child.parent.good-1.methodsv2.xa
  * ns2.child.parent.good-1.methodsv2.xa
* Get delegation NS IP addresses
  * 127.40.4.21
  * fda1:b2:c3:0:127:40:4:21
  * 127.40.4.22
  * fda1:b2:c3:0:127:40:4:22
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-1.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns2.child.parent.good-1.methodsv2.xa/127.40.4.22
  * ns2.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:4:22
* Get zone NS names
  * ns1.child.parent.good-1.methodsv2.xa
  * ns2.child.parent.good-1.methodsv2.xa
* Get zone NS IP addresses
  * 127.40.4.21
  * fda1:b2:c3:0:127:40:4:21
  * 127.40.4.22
  * fda1:b2:c3:0:127:40:4:22
* Get zone NS names and IP addresses
  * ns1.child.parent.good-1.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns2.child.parent.good-1.methodsv2.xa/127.40.4.22
  * ns2.child.parent.good-1.methodsv2.xa/fda1:b2:c3:0:127:40:4:22

### GOOD-2

#### Zone

child.parent.good-2.methodsv2.xa

#### Methods and Expected output
* Get parent NS IP addresses
  * 127.40.3.21
  * fda1:b2:c3:0:127:40:3:21
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
* Get delegation NS names
  * ns5.good-2.methodsv2.xa
  * ns6.good-2.methodsv2.xa
* Get delegation NS IP addresses
  * 127.40.3.21
  * fda1:b2:c3:0:127:40:3:21
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
* Get delegation NS names and IP addresses
  * ns5.good-2.methodsv2.xa/127.40.2.25
  * ns5.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:2:25
  * ns6.good-2.methodsv2.xa/127.40.2.26
  * ns6.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:2:26
* Get zone NS names
  * ns5.good-2.methodsv2.xa
  * ns6.good-2.methodsv2.xa
* Get zone NS IP addresses
  * 127.40.3.21
  * fda1:b2:c3:0:127:40:3:21
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
* Get zone NS names and IP addresses
  * ns5.good-2.methodsv2.xa/127.40.2.25
  * ns5.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:2:25
  * ns6.good-2.methodsv2.xa/127.40.2.26
  * ns6.good-2.methodsv2.xa/fda1:b2:c3:0:127:40:2:26

### GOOD-3

#### Zone
child.parent.good-3.methodsv2.xa

#### Methods and Expected output
* Get parent NS IP addresses
  * 127.40.3.21
  * fda1:b2:c3:0:127:40:3:21
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
* Get delegation NS names
  * ns1.child.parent.good-3.methodsv2.xa
  * ns3.parent.good-3.methodsv2.xa
  * ns5.good-3.methodsv2.xa
* Get delegation NS IP addresses
  * 127.40.4.21
  * fda1:b2:c3:0:127:40:4:21
  * 127.40.3.23
  * fda1:b2:c3:0:127:40:3:23
  * 127.40.2.25
  * fda1:b2:c3:0:127:40:2:25
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-3.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns3.parent.good-3.methodsv2.xa/127.40.3.23
  * ns3.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns5.good-3.methodsv2.xa/127.40.2.25
  * ns5.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:2:25
* Get zone NS names
  * ns1.child.parent.good-3.methodsv2.xa
  * ns3.parent.good-3.methodsv2.xa
  * ns5.good-3.methodsv2.xa
* Get zone NS IP addresses
  * 127.40.4.21
  * fda1:b2:c3:0:127:40:4:21
  * 127.40.3.23
  * fda1:b2:c3:0:127:40:3:23
  * 127.40.2.25
  * fda1:b2:c3:0:127:40:2:25
* Get zone NS names and IP addresses
  * ns1.child.parent.good-3.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns3.parent.good-3.methodsv2.xa/127.40.3.23
  * ns3.parent.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns5.good-3.methodsv2.xa/127.40.2.25
  * ns5.good-3.methodsv2.xa/fda1:b2:c3:0:127:40:2:25


### GOOD-UNDEL-1

#### Zone
child.parent.good-undel-1.methodsv2.xa

#### Undelegated data
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/127.40.3.22
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:3:22
  * ns3.parent.good-undel-1.methodsv2.xa/127.40.3.23
  * ns3.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns6.good-undel-1.methodsv2.xa/-

#### Methods and Expected output
* Get parent NS IP addresses
  * (empty)
* Get delegation NS names
  * ns1-2.child.parent.good-undel-1.methodsv2.xa
  * ns3.parent.good-undel-1.methodsv2.xa
  * ns6.good-undel-1.methodsv2.xa/IPv4-16
* Get delegation NS IP addresses
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
  * 127.40.3.23
  * fda1:b2:c3:0:127:40:3:23
  * 127.40.2.26
  * fda1:b2:c3:0:127:40:2:26
* Get delegation NS names and IP addresses
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/127.40.3.22
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:3:22
  * ns3.parent.good-undel-1.methodsv2.xa/127.40.3.23
  * ns3.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns6.good-undel-1.methodsv2.xa/127.40.2.26
  * ns6.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:2:26
* Get zone NS names
  * ns1-2.child.parent.good-undel-1.methodsv2.xa
  * ns3.parent.good-undel-1.methodsv2.xa
  * ns6.good-undel-1.methodsv2.xa/IPv4-16
* Get zone NS IP addresses
  * 127.40.3.22
  * fda1:b2:c3:0:127:40:3:22
  * 127.40.3.23
  * fda1:b2:c3:0:127:40:3:23
  * 127.40.2.26
  * fda1:b2:c3:0:127:40:2:26
* Get zone NS names and IP addresses
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/127.40.3.22
  * ns1-2.child.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:3:22
  * ns3.parent.good-undel-1.methodsv2.xa/127.40.3.23
  * ns3.parent.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns6.good-undel-1.methodsv2.xa/127.40.2.26
  * ns6.good-undel-1.methodsv2.xa/fda1:b2:c3:0:127:40:2:26

### GOOD-UNDEL-2

#### Zone
child.parent.good-undel-2.methodsv2.xa

#### Undelegated data
  * ns1.child.parent.good-undel-2.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns3.parent.good-undel-2.methodsv2.xa/127.40.3.23
  * ns3.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns6.good-undel-2.methodsv2.xa/-

#### Methods and Expected output
* Get parent NS IP addresses
  * (empty)
* Get delegation NS names
  * ns1.child.parent.good-undel-2.methodsv2.xa
  * ns3.parent.good-undel-2.methodsv2.xa
  * ns6.good-undel-2.methodsv2.xa/IPv4-16
* Get delegation NS IP addresses
  * 127.40.4.21
  * fda1:b2:c3:0:127:40:4:21
  * 127.40.3.23
  * fda1:b2:c3:0:127:40:3:23
  * 127.40.2.26
  * fda1:b2:c3:0:127:40:2:26
* Get delegation NS names and IP addresses
  * ns1.child.parent.good-undel-2.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns3.parent.good-undel-2.methodsv2.xa/127.40.3.23
  * ns3.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns6.good-undel-2.methodsv2.xa/127.40.2.26
  * ns6.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:2:26
* Get zone NS names
  * ns1.child.parent.good-undel-2.methodsv2.xa
  * ns3.parent.good-undel-2.methodsv2.xa
  * ns6.good-undel-2.methodsv2.xa/IPv4-16
* Get zone NS IP addresses
  * 127.40.4.21
  * fda1:b2:c3:0:127:40:4:21
  * 127.40.3.23
  * fda1:b2:c3:0:127:40:3:23
  * 127.40.2.26
  * fda1:b2:c3:0:127:40:2:26
* Get zone NS names and IP addresses
  * ns1.child.parent.good-undel-2.methodsv2.xa/127.40.4.21
  * ns1.child.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:4:21
  * ns3.parent.good-undel-2.methodsv2.xa/127.40.3.23
  * ns3.parent.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:3:23
  * ns6.good-undel-2.methodsv2.xa/127.40.2.26
  * ns6.good-undel-2.methodsv2.xa/fda1:b2:c3:0:127:40:2:26


[Specification of test scenarios for MethodsV2]:                  ../../docs/public/specifications/test-zones/MethodsV2/methodsv2.md
