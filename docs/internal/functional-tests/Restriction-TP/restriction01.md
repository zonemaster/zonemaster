## RESTRICTION01: Label length

### Test case identifier

**RESTRICTION01:** Label length

### Objective
In DNS, domain names are expressed in terms of a sequence of labels. Section 
2.3.1 of [RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035) mentions that the 
label must be 63 characters or less.

The objective for this test is verify whether the engine conforms to the
specification described in the previous paragraph.

### Results
Since it is not possible to fit in more than 63 octets in a DNS label
, it is impossible to run this test. 
