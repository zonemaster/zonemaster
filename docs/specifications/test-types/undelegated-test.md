# Undelegated tests

## Objective

The purpose of an undelegated test is to test a possible future delegation 
before it is put in production. Hence, while testing an undelegated test, 
extra information (such as name servers, IP addresses) must be provided 
as input, and Zonemaster should run the test cases with the provided
information.

## Specification

An undelegated test should mimic the a delegated test. The information for the 
test must be provided when starting the test.

An undelegated test can be run on a already delegated domain, but then
Zonemaster must disregard the specific information for that domain found
in public DNS.

Information that is part of the delegation must be provided with the initiation of
the test. That following information is used for the undelegated test:

* Domain (zone) to be tested. Mandatory information.

* NS records. No NS records may be looked up before the test
starts, the complete RR set must be provided. Mandatory information.

* Glue records. The IP addresses of the name server names that belong to the delegated
zone or below must be provided. They must not be looked up before the test starts. If
not provided or only partly provided, the information will be treated as an incomplete 
delegation.

* DS records. If no DS records are provided, then it is assumed that there are no DS
records for the zone. They must not be looked up.

* Name server addresses. Addresses of name server names that belong to the delegated
zone is covered under "glue redords" above. Addresses of other name servers may be
provided, of else they are looked up. If at least one address (IPv4 or IPv6) is provided
for a name server, then no further lookup shall be done for that name during the 
test (neither IPv4 nor IPv6).

The complete set of "NS records", the "Glue records" and the "DS records" is considered
to be equivalent to what must be provided by the delegating zone, and replaces that, if
the delegation exists. If the delegation does not exists, the provided set works as if 
the delegation existed.

The Name server addresses provided, if any, are considered to replace the real IP
addresses for those name server names.
