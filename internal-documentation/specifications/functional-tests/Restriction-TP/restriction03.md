## RESTRICTION03: Character set restriction for label

### Test case identifier

**RESTRICTION03:** Character set restriction for label

### Objective

Even though section 11 of [RFC 2181](https://tools.ietf.org/html/rfc2181) mentions 
that any binary string could be part of a label, many of the registries will
not permit special symbols in the label. This is an habit purused by the
registried based on section 2.1 of the the [RFC 1123](https://tools.ietf.org/html/rfc1123),
i.e. following the LDH (Letters, Digits and Hyphen) format. Even for the
IDNs [RFC 5892](https://tools.ietf.org/html/rfc5892) limits to the LDH
format.  

The objective for this test is verify whether the engine identifies the
domain names which is not in the LDH format. 

### Result

The engine does not capture the restriction for LDH and the explanation is
provided here : https://github.com/dotse/zonemaster/issues/153 

