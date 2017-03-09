# Proposal of merging Config and Policy into Profile

## Background

This document assumes that we have agreed to merge Config and Policy in Engine and CLI to Profile (updating Backend is the second step). How should the merge be done? Below is a proposal.

This document is not meant to be merged into the Zonemaster repo. It is here for discussions.

## Enclosed files

The following files illustrates what is said below.
 
* [config1.json](config1.json) - Engine default config in Config.pm
* [config2.json](config2.json) - Engine default config file
* [config3.json](config3.json) - Engine example config file with filter
* [policy1.json](policy1.json) - Engine default policy file
* [profile1.json](profile1.json) - Alternative 1 of merged files
* [profile2.json](profile2.json) - Alternative 2 of merged files (preferred solution)
 

## Current Config
 
Current config has the following top-level keys (description in parenthesis):
 
      snroots     (ASN lookup names)
      net         (turn IPv4/IPv6 connection on/off)
      no_network  (turn network on/off)
      resolver    (resolver settings)
      logfilter   (filter settings)
 
`logfilter` is unset and not present in default configuration in Config.pm and in default config file.

## Current Policy

Current policy has the following top level keys, where all but the last one is a Test Level (with log messages) and the last one is for the test cases.
 
      ADDRESS
      BASIC
      CONNECTIVITY
      CONSISTENCY
      DELEGATION
      EXAMPLE
      NAMESERVER
      SYNTAX
      SYSTEM
      ZONE
      __testcases__
 
 
## Alternative 1
 
Directly merge config and policy into one structure. Since the top level keys of the policy file, we would get a mixture of categories and entries ([profile1.json](profile1.json)). It has the following top-level keys:
 
      asnroots
      logfilter
      net
      no_network
      resolver
      ADDRESS
      BASIC
      CONNECTIVITY
      CONSISTENCY
      DELEGATION
      EXAMPLE
      NAMESERVER
      SYNTAX
      SYSTEM
      ZONE
      __testcases__
 
 
## Alternative 2 (preferred solution)
 
Create categories for the data in profile first and then merge ([profile2.json](profile2.json)). We would get a cleaner division between categories and data. Create category `test_levels` for the Test Levels and rename `__testcases__` to `test_cases` for consistency. It has the following top-level keys:
 
      asnroots
      logfilter
      net
      no_network
      resolver
      test_levels
      test_cases
 
## Pros and cons

Alternative 2 creates a better configuration file that is easier to document and explain. For implementation, alternative 1 requires less changes.
 
