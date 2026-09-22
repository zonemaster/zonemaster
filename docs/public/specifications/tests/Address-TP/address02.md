# ADDRESS02: Reverse entry (PTR) exists for name server IP address

## Test case identifier
**ADDRESS02** 

## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)

## Objective

Best curent practices dictate that internet reachable hosts should have a
reverse DNS entry, as various services on the Internet (e.g. spam 
filters) may consider this when determining the trustworthiness of the host.
See [RFC1912] section 2.1 and [RFC1033] page 11 for additional information.

This test checks for the existence of PTR records for the corresponding reverse
domains of the name servers IP address.

## Scope
Only the existence of a PTR record, or a record that resolves to a PTR record, 
is checked. Not the validity of said record, which is handled by other tests.

## Inputs

* "Child zone" -- the domain name to be tested.

## Summary

Message Tag                   | Level    | Arguments  | Message ID for message tag
:---------------------------- |:---------|:-----------|:--------------------------
A02_PTR_PRESENT               | INFO     |            | PTR record present for all name server IP addresses
A02_PTR_MISSING               | NOTICE   | ns_ip_list | PTR record missing for the following name server IP addresses: "{ns_ip_list}"


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.


The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid is created, if the argument name is "ns" or "ns_list" even when in the [Test procedure] below it is only referred to the IP address of the name servers.

## Test procedure 

1. Retrieve all name server names and IP addresses for *Child Zone* using
   methods [Get-Del-NS-Names-and-IPs] and [Get-Zone-NS-Names-and-IPs] (Name Server IP).

2. Create the following empty set: name server IP address ("PTR Missing")

3. For each name server in *Name Server IP* do:
   1. Make a recursive PTR query.
   2. If the response fails to match the following criteria, add the IP address
      to the *PTR Missing* set.
        - RCODE must be NOERROR
4. For each name server IP address in *Name Server IP* do:
   1. Do a reverse *DNS Lookup* (PTR) of name server IP address.
   2. If the response fails to match the following criteria, then
      add name server IP address to the *PTR Missing* set:
        - [RCODE Name] is "NOERROR"
        - Answer section contains at least one PTR record
  
5. If the set *PTR Missing* is empty, then output *[A02_PTR_PRESENT]*.

6. Else, output *[A02_PTR_MISSING]* with a list of the IP addresses in the 
   *PTR Missing* set.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level 
*[ERROR]* or *[CRITICAL]*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]* the outcome of this Test Case is "pass".

## Special procedural requirements

None.

## Intercase dependencies

None.

## Terminology

* "DNS Lookup" - The term is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.

[A02_PTR_PRESENT]:                  #Summary
[A02_PTR_MISSING]:                  #Summary
[Argument list]:                    ../ArgumentsForTestCaseMessages.md
[CRITICAL]:                         ../SeverityLevelDefinitions.md#critical
[ERROR]:                             ../SeverityLevelDefinitions.md#error
[Get-Del-NS-Names-and-IPs]:         ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:        ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[INFO]:                             ../SeverityLevelDefinitions.md#info
[NOTICE]:                             ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                       https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC1912]:                          https://www.rfc-editor.org/rfc/rfc1912
[RFC1033]:                          https://www.rfc-editor.org/rfc/rfc1033
[Severity Level Definitions]:       ../SeverityLevelDefinitions.md
[Test procedure]:                   #test-procedure
[Undelegated test]:                 ../../test-types/undelegated-test.md
[WARNING]:                          ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:        ../../../configuration/profiles.md
