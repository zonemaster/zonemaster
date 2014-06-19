# List of basic DNS tests

These are tests of a domain's most basic functionality. If these fail,
it will be hard or impossible to perform any other tests at all. The
test code should be constructed so that these tests are always run, even
if a subset of tests is asked for that would not normally include them.

These documents uses the terminology defined in the Master Test Plan.

## Mapping from Requirements to Test Case

|Req| Description                                                 | Test Case           |
|:--|:------------------------------------------------------------|:--------------------|
|R67|The domain must have a parent domain                         |[BASIC01](basic01.md)|
|R08|The child domain must have at least one working nameserver   |[BASIC02](basic02.md)|
|R15|The child domain must have at least one working nameserver   |[BASIC02](basic02.md)|
|R68|The child domain must have at least one working nameserver   |[BASIC02](basic02.md)|
|R69|The _Broken but functional_ test                             |[BASIC03](basic03.md)|
