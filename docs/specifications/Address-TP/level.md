# List of Address tests

These tests focuses on the Address specific test cases of the DNS tests.

This document uses the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                              | Test Case |
|:--|:-------------------------------------------------------------------------|:----------|
|R03| Nameserver address in  private network                                  |[ADDR01](addr01.md)|
|R40| Reverse DNS entry exists for nameserver IP address                        |[ADDR02](addr02.md)|
|R41| Reverse DNS entry matches nameserver name                                |[ADDR03](addr03.md)|



## TODO / Comments / Other tmp. thoughts

a) Tests not in "Address Level" in the document "Test requirements.md" :

* R37 - loopback delegation //  This test is uncategorized  (Issue #10)
* R38 - loopback is resolvable // same thing                (Issue #10)

b) Tests  in "Address Level" in the document "Test requirements.md" :

* R03 - Nameserver address in a private network // Could be in "Connectivity level" ? (Issue #11)




