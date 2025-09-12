# Message Tag Specification

Message tags outputted by the test cases, and defined in the test case
specifications, must conform to the following specifications.

The message tag must match the regex `/^[A-Z][A-Z0-9_][A-Z]$/`. Lower case
letters are not allowed.

The tag can be broken into three parts, in order:

* Test case specific prefix
* Delimiter "_"
* Tag string

## Test case specific prefix

The message tag prefix is an abbreviation of the test case identifier created by
a 1-2 letter abbreviation of the test level name and the two-digit suffix of the
test case ID. For specification of the test case ID see
[Test Case Identifier Specification].

The test level abbreviation is always as follows:

Test level name  | Example Test case ID   | Abbreviation| Prefix  | Example message tag
:----------------|:-----------------------|:------------|:--------|:-------------------
Address          | Address01              | A           | A01     | A01_NO_RESPONSE
Basic            | Basic04                | B           | B04     | B04_NO_DATA
Connectivity     | Connectivity03         | CN          | CN03    | CN03_HAS_DATA
Consistency      | Consistency01          | CS          | CS01    | CS01_SAME_VALUE
DNSSEC           | DNSSEC15               | DS          | DS15    | DS15_NO_KEY
Delegation       | Delegation05           | DG          | DG05    | DG05_NO_GLUE
Nameserver       | Nameserver08           | N           | N08     | N08_TOO_FEW_NS
Syntax           | Syntax06               | S           | S06     | S06_WRONG_FORMAT
Zone             | Zone07                 | Z           | Z07     | Z07_SOA_RESTRY

## Delimiter

The delimiter between the prefix and the tag string is "_". See the examples in
the table above.

## Tag string

The tag string should be a short string that gives information about the message.


[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
