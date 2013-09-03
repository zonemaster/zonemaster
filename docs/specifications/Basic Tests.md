# List of basic DNS tests

These are tests of a domain's most basic functionality. If these fail, it will be hard or impossible to perform any other tests at all. The test code should be constructed so that these tests are always run, even if a subset of tests is asked for that would not normally include them.

This document uses the terminology defined in the Master Test Plan.

## The child domain must have a parent domain

Recursing downward from the root domain to the child domain must eventually lead to a domain that has at least one nameserver which answers an NS query for the child domain with a NOERROR or NXDOMAIN response. That domain is defined as the parent domain.

In the case of an undelegated test, the information that would normally be provided by the parent domain's nameservers is instead provided manually. In that case, this test trivially passes.

If this test fails, it's impossible to continue and the whole testing process is aborted.

## The child domain must have at least one working nameserver

The parent domain must provide enough information on enough nameservers that there is at least one to which we can send an NS query for the child domain and get a valid non-empty response back.

If this test fails, it's impossible to continue and the whole testing process (except for the next test in this document) is aborted.

## Additional: The _Broken but functional_ test

If the parent domain gives enough information that we can send queries to nameservers claimed to be for the child domain, but the responses from those are not valid for the child domain, we will send them an A query for the child domain name with the label _www_ prepended. If that query returns valid A records, the _Broken but functional_ diagnostic message will be logged.