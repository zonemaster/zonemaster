# List of basic DNS tests

These are tests of a domain's most basic functionality. If these fail, it will be hard or impossible to perform any other tests at all. The test code should be constructed so that these tests are always run, even if a subset of tests is asked for that would not normally include them.

This document uses the terminology defined in the Master Test Plan.

## BASIC1: The child domain must have a parent domain

### Rationale

In order for a domain to work, it must be delegated to from another domain (with the exception of a root domain).

### Information Needed

A recursive NS-record lookup for the child domain name starting at the root domain should be done, and the steps of the process recorded.

### Evaluation Criteria

1. If the recursion reaches a nameserver that responds with a redirect directly to the requested domain, including functional glue, the test succeeds. The domain through which the nameserver was found is considered the parent domain.
2. If the recursion reaches a nameserver that authoritatively responds with NXDOMAIN for the child domain, the test succeeds. The domain through which the nameserver was found is considered the parent domain.
3. If the recursion reaches a point where the recursion for some reason cannot continue before either case 1 or 2 happens, the test fails. 

### Notes

If this test fails, it's impossible to continue and the whole testing process is aborted.

## BASIC2: The child domain must have at least one working nameserver

### Rationale

In order for the domain to work, it must have at least one nameserver that can answer queries about the domain.

### Information Needed

A list of nameserver names taken from the parent domain, and the IP addresses corresponding to those names. The addresses should come from glue address records for in-bailiwick nameserver names, and from separate recursive queries for out-of-bailiwick nameserver names. An NS query for the child domain should be sent to each address, and the responses recorded.

### Evaluation Criteria

If at least one recorded response is a well-formed DNS response holding one or more NS records for the child domain, this test succeeds.

### Notes

If this test fails, it's impossible to continue and the whole testing process (except for the BASIC3 test) is aborted.

## BASIC3: The _Broken but functional_ test

### Rationale

The case where a domain is too broken to be fully tested but functional enough for simple web browsing should be detected. This test should only be performed if the BASIC2 test has failed.

### Information Needed

A list of nameserver names taken from the parent domain, and the IP addresses corresponding to those names. The addresses should come from glue address records for in-bailiwick nameserver names, and from separate recursive queries for out-of-bailiwick nameserver names. An A query for the child domain name with the label 'www' prepended should be sent to each address, and the responses recorded.

### Evaluation Criteria

If at least one recorded response contains at least one A record for the requested name, this test succeeds.

### Notes

None.