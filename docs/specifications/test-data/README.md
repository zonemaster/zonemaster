# Test zoness and test data for verification of test case implementation

## Objective

The purpose of the structure found here is to define test zones and test data to
be able to test the correctness of the implementation of the Zonemaster
[test cases]. The main use case is to be the basis for the [unit test] in the
Zonemaster implementation. The second use case is to verify work in progress,
e.g. implementation of new or updated test cases or updated test case
implementation where the test case has not changed.

There can be other use cases, but only these two use cases are covered here
and in the test data specifications.


## Test scenarios

The goal of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when a test case is run on test zones. The
message tags are defined in the test case specifications found via "[test cases]"
and the scenarios are defined in the test case specific specifications for test
data found via the [test-data] directory.

In the test data specifications the scenarios are defined in two parts:

* What messages from test case that are expected to be outputted and what
  messages are expected not to be outputted when a test zone setup according to
  the scenario is tested by the test case.
* Specification of the zone setup for the scenario.


## Test environment

The tests against the test zones are assumed to be run in a closed environment
with a private DNS tree to achieve full access to any zone. Configuration data
and instructions to set this up are available elsewhere in this repository.

All test zones are created under the non-existing .xa TLD except for a few cases
where the test zone must be the root, a TLD or a domain name under .ARPA. As the
second level the test case name is used and the test zone has the name of the
scenario as a subdomain of the test case, `<scenario name>.<test case name>.xa`,
e.g. `no-response-mx-query.zone09.xa`,







[Test cases]:                                           ../specifications/tests/README.md
[unit tests]:                                           https://github.com/zonemaster/zonemaster-engine/tree/master/t
[test-data]:                                            .

