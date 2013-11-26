# List of basic DNS tests

These are tests of a domain's most basic functionality. If these fail, it will be hard or impossible to perform any other tests at all. The test code should be constructed so that these tests are always run, even if a subset of tests is asked for that would not normally include them.

This document uses the terminology defined in the Master Test Plan.

There is [an example implementation of these tests](https://github.com/dotse/new-dnscheck/blob/master/Giraffa/lib/Giraffa/Test/Basic.pm).

## Mapping from Requirements to Test Case

|Req| Description                                                          | Test Case |
|:--|:---------------------------------------------------------------------|:----------|
|R67|There must be NS records for the zone being tested on the parent side |[BASIC01](./basic01.md)|
|R68|The child domain must have at least one working nameserver            |[BASIC02](./basic02.md)|
|R69|NS records from parent exists, but the child does not have NS but answers for A|[BASIC03](./basic03.md)|
