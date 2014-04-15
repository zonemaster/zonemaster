# New DNSCheck Test Specifications

This is the collection of test speifications for the New DNSCheck
project. All the details are in the [Master Test Plan]
(MasterTestPlan.md).


##Background

1. The tests that has to be elaborated as test specifications has been
   defined as a list of [test requirements]
   (../../requirements/Test%20requirements.md). Each test falls under a
   specific category.

2. The document hierarchy of the test specifications could be found in
   the [Master Test Plan](MasterTestPlan.md).

## Mapping the Test Requirements to Test Case

1. Each test level has been separated into a separate directory below
   this directory.
2. Under each test level directory there is a level.md document
   describing the test level. See for example the level document from
   [Syntax-TP](Syntax-TP/level.md).
3. The level.md document describes the mapping from Test Requirement
   to each individual Test Case document.

## Elaboration of the test case

1. Test cases should be written for each Test Requirement. There could
   be the case that a requirement can be implemented by doing more test
   cases than one, or that several requirements are solved by only one
   test case.  
   Example: [Syntax-TP/syntax01.md](Syntax-TP/syntax01.md).

## Document Hierarchy

1. Each Test Level described in [Master Test Plan](MasterTestPlan.md)
   should be linked directly to the correct level.md document.
2. Each Test Case in the Test Level document should be linked directly
   to the correct Test Case document.
