## ADDRESS01: Name server address must be globally reachable

### Test case identifier
**ADDRESS01** 

## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Intercase dependencies](#Intercase-dependencies)


### Objective

In order for the domain and its resources to be accessible, authoritative 
name servers must have addresses in the routable public addressing space.

IANA is responsible for global coordination of the IP addressing system.
Aside its address allocation activities, it maintains reserved address ranges
for special uses. These ranges can be categorized into three types:

* [Special purpose IPv4 addresses]
* [Special purpose IPv6 addresses]

### Scope

IP addresses from authoritative name servers are matched against IANAs list of public routable address ranges.

### Inputs

* The domain name to be tested.

### Summary

Message Tag                       | Level    | Arguments | Message ID for message tag
:-------------------------------- |:---------|:----------|:--------------------------
A01_ADDR_GLOBALLY_REACHABLE       | INFO     | ns_list   | IP addresses in "{ns_list}" listed as globally reachable.
A01_NO_GLOBALLY_REACHABLE_ADDR    | CRITICAL | ns_list   | None of the IP addresses in "{ns_list}" listed as globally reachable.
A01_ADDR_NOT_GLOBALLY_REACHABLE   | ERROR    | ns        | IP adress for "{ns}" not listed as globally reachable.
A01_DOCUMENTATION_ADDR            | ERROR    | ns        | IP adress for "{ns}" part of address range for documentation purposes.
A01_LOCAL_USE_ADDR                | ERROR    | ns        | IP adress for "{ns}" part of address range intended for local use on network or service provider level..


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [Argument list].

### Test procedure 

1. Obtain the IP addresses of each name server of the domain from the parent using
   [Method4] and [Method5]. 

2. For each name server in *Name Server IP* do:
   1. Match the IP the address against the IP ranges specified in [Special purpose IPv4 addresses] and [Special purpose IPv6 addresses]
      1. If if falls within any of the address ranges reserved for *Documentation*, then output *[A01_DOCUMENTATION_ADDR]* with name and IP address of the server.
      2. Else, if it falls within an address range belonging to any of the following categories:  
         - *Private-Use*
         - *Loopback*
         - *Loopback Address*
         - *Link Local*
         - *Link-Local Unicast*
         - *Unique-Local*
         - *Shared Address Space*
         then output *[A01_LOCAL_USE_ADD]* with name and IP address of the server.
      3. Else, if the IP falls within a range that is **not** registered as *Globally Reachable*, output *[A01_ADDR_NOT_GLOBALLY_REACHABLE]* with name and IP address of the server.
   2. Go to the next server.
3. If **all** servers in *Name Server IP* are mentioned in at least one message with the severity level *[ERROR]*, then output *[A01_NO_GLOBALLY_REACHABLE_ADDR]* 
4. If **none** of the servers are mentioned in a message with a higher severity level than *[INFO]*, then output *[A01_ADDR_GLOBALLY_REACHABLE]*
 

### Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[ERROR]*, but no message with severity level
*[CRITICAL]*.

In other cases, no message or only messages with severity level
*[INFO]*  the outcome of this Test Case is "pass".

### Special procedural requirements

The registries [Special purpose IPv4 addresses] and [Special purpose IPv6 addresses] and has to be fetched prior to testing.

### Intercase dependencies

None.

 
[Special purpose IPv4 addresses]:   https://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xml 
[Special purpose IPv6 addresses]:   https://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xml
[Severity Level Definitions]:       ../SeverityLevelDefinitions.md
[Zonemaster-Engine profile]:        ../../../configuration/profiles.md
[Argument list]:                    ../ArgumentsForTestCaseMessages.md
[Method4]:                          ../Methods.md#method-4-obtain-glue-address-records-from-parent  
[Method5]:                          ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[A01_ADDR_GLOBALLY_REACHABLE]:      #summary 
[A01_NO_GLOBALLY_REACHABLE_ADDR]:   #summary 
[A01_ADDR_NOT_GLOBALLY_REACHABLE]:  #summary 
[A01_DOCUMENTATION_ADDR]:           #summary 
[A01_LOCAL_USE_ADDR]:               #summary 
[INFO]:                             ../SeverityLevelDefinitions.md#info
[WARNING]:                          ../SeverityLevelDefinitions.md#warning
[ERROR]:                            ../SeverityLevelDefinitions.md#error
[CRITICAL]:                         ../SeverityLevelDefinitions.md#critical
