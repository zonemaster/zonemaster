New DNSCheck Master Test Plan
=============================

Introduction
------------

This section gives a brief introduction to the New DNSCheck project.

### Background

DNSCheck from .SE and Zonecheck from AFNIC are two different software
packages that do DNS validation of the quality of a DNS
delegation. The New DNSCheck implementation intends to be a major
rewrite of these software packages, and implement the best parts of
both.

### Purpose of this project

The purpose of the New DNSCheck is to test the quality of a DNS
delegation. The core of the software is all the implemented
tests. There will be a command line tool to run a complete set of
tests, and a web interface tailored for use by both basic and advanced
users.

### Goal of this document

The goal of this document is to give an overview of the requirements
and the test levels. Each of the requirements will be broken down into
a set of test procedures. The process of doing this will be done in
accordance with the standard [IEEE 829-2008](http://en.wikipedia.org/wiki/IEEE_829).

### Scope 

For version 1.0 of this project, only the test cases derived from the current versions of DNSCheck and Zonecheck will be described as requirements. [These
documents will not describe the functionality of any software
implementing the test cases. Some test cases derived from the current
software will not be implemented as test cases in the New DNSCheck.][Not clear what you intend to convey]

The [current requirements](../requirements/Test%20requirements.md)
documents is the base directive on what these test specifications
will implement.

### References
#### External

The current implemented tests in DNSCheck are described here:  
https://github.com/dotse/dnscheck/wiki/Tests  
https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages

The current implemented tests in Zonecheck are described here:
http://www.zonecheck.fr/features.shtml

#### Internal

No internal references.

#### Document hieararchy 

* Master Test Plan  
   * Address Test Plan
        * Test Case x
   * Basic Test Plan  
        * Test Case x
   * Connectivity Test Plan
        * Test Case x
   * Consistency Test Plan
        * Test Case x
   * Delegation Test Plan
        * Test Case x
   * DNSSEC Test Plan
        * Test Case x
   * Nameserver Test Plan
        * Test Case x
   * Resolver Test Plan
        * Test Case x
   * Syntax Test Plan
        * Test Case x
   * Zone Test Plan
        * Test Case x

### System overview and key features

A domain will be tested for the quality of the delegation in the DNS
hierarchy. Some of the high level properties that will be tested
include:
 * [**Address**](Address-TP/level.md) properties (IP addresses)
 * [**Basic**](Basic-TP/level.md) (initial tests)
 * Name server [**Connectivity**](Connectivity-TP/level.md)
 * [**Consistency**](Consistency-TP/level.md) (all name have consistent
   answers)
 * [**Delegation**](Delegation-TP/level.md) properties (parent and child
   name servers)  
 * [**DNSSEC**](DNSSEC-TP/level.md) properties (algorithms, secure
   delegation)  
 * [**Name server**](Nameserver-TP/level.md) properties 
 * (not mandatory) [**Resolver**](Resolver-TP/level.md) properties
 * [**Syntax**](Syntax-TP/level.md) (illegal hostnames and characters)
 * [**Zone**](Zone-TP/level.md) properties (are data controlling the zone
   sane)

Following process can be follwed to test a domain:
 * When the input is a domain-name, the tool will retrieve all DNS information pertaining to the domain from the public global DNS hierarchy.
 * For a domain not yet published in the global DNS hierarchy, the input provided to test the domain is a set of pre-delegation data.
 * A complete set of DNS queries and answers can also be given as input to the system for repeat testing.

### Test overview

The test organization, test schedule, integrity level scheme, test
resources, responsibilities, tools, techniques, and methods are
necessary to perform the testing.

#### Organization

A test is run on any machine where the New DNSCheck software is
available. The tests ordinarily needs access to a complete DNS
hierarchy to be performed.

#### Master test schedule

A test is run as soon as the software is scheduled to run, often
immediately upon execution.

The first tests that are supposed to run are those from the Basic test
plan. If those tests succeeds, the rest of the test plans are run in
no specific order.

#### Integrity level schema

An integrity level schema is used for illustrating relative importance
of a software component. The effect of a failing component can range
from negligible to catastrophic. A component with a high integrity
level needs to be tested more thoroughly than a component with a lower
level. There is, however, no guidance in the requirements that
indicate the relative importance of different areas. Each area is thus
considered equally important. However, one of the main objectives is
to ensure the stability of DNS.

#### Resources summary

TODO: Briefly describe the necessary resources to run a test.

#### Responsibilites

#### Tools, techniques, methods, and metrics

TODO: Briefly described the necesessary input and any metrics in the
output.


Details of the Master Test Plan
-------------------------------

The utilization of the [IEEE 829-2008](http://en.wikipedia.org/wiki/IEEE_829) is described in this chapter. There is also a mapping between the test areas and the requirements.

### Test processes

The goal of these documents are to describe the test cases and how the
DNS is tested. This is a part of a larger project where the goal is to
test the quality of the Internet. Processes for Management,
Acquisition, Supply, Development, Operation, and Maintenance are not
part of this subproject to define.

### Definition of test levels

There can be different types of tests, e.g. unit, system, and
acceptance tests. This test environment will only focus on acceptance
testing, thus only one test level. Multiple areas have however been
identified within the system requirements:

* Address
* Basic
* Connectivity
* Consistency
* Delegation
* DNSSEC
* Name server
* Resolver
* Syntax
* Zone

However, the separation of test levels does not necessarily mean that
the levels are separated in the New DNSCheck implementation. The
actual test levels might differ from the actual test modules in the
code. At this level, the separation is done to make a better overview
of all the test cases specified.

### Test documentation requirements

The following documents can be created according to the standard:

* Level Test Plan (LTP)
* Level Test Design (LTD)
* Level Test Case (LTC)
* Level Test Procedure (LTPr)

However, the LTD has been incorporated in the LTP and in the LTC. LTPr
has been incorporated in the LTC.

#### Level Test Plan

The system will undergo acceptance testing against the
requirements. Each area is documented in a separate test plan. The
purpose is to map the requirements into test cases and also to
describe the approach for testing this level.

In the title of the plan, the word “Level” is replaced by the name for
the particular level being documented by the plan. E.g. Delegation
Test Plan and DNSSEC Test Plan.

#### Level Test Case

The purpose of the LTC is to define the information needed as it
pertains to inputs to and outputs from the software or software-based
system being tested. The test cases may be documented in a single or
multiple LTC depending on the extent of the area. Any procedures are
included in the documentation.

In the title of the test case, the word “Level” is replaced by the
name for the particular level being documented by the test case. The
documents have sub-titles since there can be more than one document
within one level. E.g. DNSSEC Test Cases or Connectivity Test Cases.

### Test administration requirements

These activities are needed to administer the tests during execution.

#### Anomaly Resolution

The tests are executed with the input given by the user. The input
data is validated to be correct. Depending on the input data and what
is available in the public DNS, some test cases might not be executed.

The output from DNSCheck should clearly indicate what test cases have
been executed, and which have not.

#### Reporting Processes

The output from all the tests are collected by the system and reported
back to the user depending on the choice of the user. There might be
several different methods used, for example as a brief or verbose log
file, or as XML or JSON output, or directly into a database.

### Test reporting requirements

The following documents can be created according to the standard:

 * Level Test Log (LTL)
 * Anomaly Report (AR)
 * Level Interim Test Status Report (LITSR)
 * Level Test Report (LTR)
 * Master Test Report (MTR)

Only an MTR will be generated by the system.

#### Level Test Log

All logs from each test level are aggregated into the Master Test
Report.

#### Anomaly Report

An Anomaly Report is created if the result from the test is not
conclusive due to internal or external anomalies. All anomalies are in
the Master Test Report. However, the software implementation will also
report any anomalies with a different return code, so any calling
software can determine if the test cases were executed as planned, or
if any anomaly stopped the execution prematurely.

#### Master Test Report

The Master Test Report is generated continually during the execution
of the test plan. It will indicate the result of all the test cases,
and depending on any selected verbosity also down to the level where
you can see all the DNS queries and replies in a preferred data
format.

TODO: make a better description of the log files here?

### System requirements

The initial requirements are derived from the current Zonecheck and
DNSCheck documentation and implementations. The requirement for version 1.0 of the project is to implement all tests that Zonecheck and DNSCheck currently
implements. However, there is a large overlap between the two
implementations, and also several test cases that are no longer
applicable.

Currently there is no other requirements other than to implement the
test cases from the current implementations.

TODO: do we need a separate requirements document? [Comment : Yes]

#### DNSCheck [Comment : Except for RFC the below two subsections are repeat of the "References" section above. Shoykd try to merge]

These are the current documented test cases from DNSCheck:  
https://github.com/dotse/dnscheck/wiki/Tests  
https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages

#### Zonecheck

The current implemented tests in Zonecheck are described here:  
http://www.zonecheck.fr/features.shtml

#### RFCs

Where it is possible, the test cases refer to any RFCs describing what
the current IETF standards advise on the implementation of the DNS
protocol.


General
-------

This section contains the glossary and document change procedures for
all of the test plans and test cases.

### Glossary
| Word / Acronym | Explanation                              |
|:---------------|:-----------------------------------------|
| DNS            | Domain Name System                       |
| DNSSEC         | DNS Security Extensions                  |
| RFC            | Requst for Comments, IETF document       |
| MTP            | Master Test Plan                         |
| MTR            | Master Test Report                       |
| LTC            | Level Test Case                          |
| LTL            | Level Test Log                           |
| LTP            | Level Test Plan                          |
| LTR            | Level Test Report                        |
| AR             | Anomaly Report                           |

### Definitions of Terms

Since there are some terms relating to DNS that are commonly used with
unclear or multiple meanings, we will define here exactly what we mean
when we use them in the context of these specifications and these
tests. Any uncommon or special terms we use will also be defined here.

_domain-name_ is the domain being tested. [RFC 1035](http://tools.ietf.org/html/rfc1035)

_Child Domain_ is the domain being tested.

_Parent Domain_ is the domain that delegates directly to the domain
being tested. Differently put, it is the domain whose nameservers
delivers the glue records for the child domain.

_Glue Record_  A glue record is an A or AAAA (address) RR that specifies the address of the server.  Glue records are only needed in the server delegating the domain, not in the domain itself. [RFC 1033](http://tools.ietf.org/html/rfc1033)

_Glue Name Records_ are defined as all NS, A and AAAA records
pertaining to the child domain that are delivered by the nameservers
for the parent domain. [Comment : Reference to an RFC]

_Glue Address Records_ are all glue records of type A or AAAA. [Comment : Reference to an RFC]

_In bailiwick_ Bailiwick is the scope of authority of any particular domain. If the name servers for a child domain has the same domain hierarchy as that of the domain being queried, then it is called as in-bailiwick [Comment : need to rephrase] 

_Out of bailiwick_ If the name servers for the child domain has a different domain hierarchy as that of the domain being queried, then it is called out-of-bailiwick

[Comment] : Shouldn't it be another document under the title "Methods to be called in the test specifications"

#### Method 1 : How to find the parent domain

A recursive SOA-record lookup for the child domain name starting at
the root domain should be done, and the steps of the process recorded.

 1. If the recursion reaches a name server that responds with a redirect
    directly to the requested domain, including functional glue, the test
    succeeds. The domain through which the name server was found is
    considered the parent domain.
 1.a The list of name servers in the authority section are recorded
 2. If the recursion reaches a name server that authoritatively responds
    with NXDOMAIN for the child domain, the test succeeds. The domain
    through which the name server was found is considered the parent domain.
 2.a The list of name servers in the authority section are recorded
 3. If the recursion reaches a point where the recursion for some reason
    cannot continue before either case 1 or 2 happens, a parent domain does
    not exist.

#### Method 2: Get the glue name records [Comment:Isn't that glue records are only A and AAAA records?]  and glue address records from the parent

In order to obtain the delegation from the parent, this is the process
we use for the tests that needs this as an input parameter.

The list of parent name servers [obtained from the recorded list of method 1] are sorted in alphabetic order using the NS name as the first and secondarily the IP address.

 1. Query the parent name servers for the NS records for the domain. If
    the first name server does not respond, a query is sent to the next
    server from the list.
 2. The NS RR set and the corresponding IP addresses are stored in a list
    and returned.

#### Method 3 : Get the NS records  from the child zone

Some tests need to have the NS for the domain from the child zone,
This is the method to find these.

 1. A NS query for the domain is sent all name servers [Obtained from method 1] present in the  parent zone.  (See "Get the glue name records and glue address
    records from the parent").
 2. Return all the unique names from the answers received from the
    query in step 1.

#### Get the IP address records  from the child zone

Some tests need to have the IP addresses for the NS records in the
child zone, This is the method to find these.

TODO



### Document change procedures

The overall change procedures are defined by the project and the
change management. However, there are some steps to take into
consideration when changing the test documents.

#### Identifying

A change to the documents may be initiated because of several reasons:

 * New internal or external requirements
 * Problems with the test cases
 * Text that needs to be clarified
 * Etc.

#### Implementing

The document revisioning is managed by a version control system
(Git). Each change must contain a specific commit message detailing
the change. The major revisions section of this document should also
be updated if there is a new release of the document.

It is important that the outcome of the test cases stays the same;
unless the change was based on new or updated requirements.

#### Recording changes

An overall description must be stated in the document control chapter,
including a new revision number. A more detailed description of the
changes is part of the specific commit in the version control system.

#### Approving

The technical review team must approve any changes made to the test
cases.
