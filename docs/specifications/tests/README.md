# Zonemaster Test Case Specifications

This is the collection of **Test Case** specifications for the Zonemaster
project. All the details are in the [Master Test Plan](MasterTestPlan.md).


## Background

1. The Test Cases that has to be elaborated as Test Case specifications 
   have been defined as a list of 
   [test requirements](../../requirements/TestRequirements.md). 
   Each test falls under a specific category.
2. The document hierarchy of the Test Case specifications could be found in
   the [Master Test Plan](MasterTestPlan.md).

## Mapping the Test Requirements to Test Case

1. Each test level has been separated into a separate directory below
   this directory.
2. Under each test level directory there is a level document (README.md)
   describing the test level. See for example the level document from
   [Syntax-TP](Syntax-TP/README.md).
3. The level document (the README.md in the test level directory) describes 
   the mapping from Test Requirement
   to each individual Test Case document.

## Elaboration of the test case

1. Test cases should be written for each Test Requirement. There could
   be the case that a requirement can be implemented by doing more test
   cases than one, or that several requirements are solved by only one
   test case. Example: [Syntax-TP/syntax01.md](Syntax-TP/syntax01.md).

## Document Hierarchy

1. Each Test Level described in [Master Test Plan](MasterTestPlan.md)
   should be linked directly to the correct level document (the README.md
   in the test level directory).
2. Each Test Case in the Test Level document should be linked directly
   to the correct Test Case document.
