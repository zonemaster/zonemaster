# Test Case Specification Status

The test case specifications have evolved in format. The new or updated
specifications have explicit and detailed steps to execute the test case, the
message tags are defined in the specification and the format follows the template
for specification formats. The latest addition is for the specification to refer
to default settings of DNS query messages and default handling of the response
([work in progress][DNS query defaults]).

The table below gives an overview of the status of the specifications in the
develop branch. Empty cell means that the answer is "no" or that there is no
proposed update, respectively.

| Test case      | Detailed steps | Defines message tags | Follows [template01] | Refer to [DNS query defaults] | Proposed update |
|:---------------|:---------------|:---------------------|:---------------------|:------------------------------|:----------------|
|[ADDRESS01]     |                |                      |                      |  N/A                          |                 |
|[ADDRESS02]     |                |                      |                      |                               |                 |
|[ADDRESS03]     |                |                      |                      |                               |                 |
|[BASIC00]       |  Yes?          |                      | No, but see [#942]   |  N/A                          | [#942]          |
|[BASIC01]       |  Yes           |  Yes                 |                      |                               |                 |
|[BASIC02]       |  Yes           |                      |                      |                               |                 |
|[BASIC03]       |                |                      |                      |                               |                 |
|[BASIC04]       |  Yes           |  Yes                 |                      |                               |                 |
|[CONNECTIVITY01]|                |                      |                      |                               |                 |
|[CONNECTIVITY02]|                |                      |                      |                               |                 |
|[CONNECTIVITY03]|  Yes           |  Yes                 |                      |                               |                 |
|[CONSISTENCY01] |  Yes           |  Yes                 |                      |                               |                 |
|[CONSISTENCY02] |  Yes           |  Yes                 |                      |                               |                 |
|[CONSISTENCY03] |  Yes           |  Yes                 |                      |                               |                 |
|[CONSISTENCY04] |  Yes           |  Yes                 |                      |                               |                 |
|[CONSISTENCY05] |  Yes           |  Yes                 |                      |                               |                 |
|[CONSISTENCY06] |  Yes           |  Yes                 |                      |                               |                 |
|[DNSSEC01]      |  Yes           |  Yes                 |                      |                               |                 |
|[DNSSEC02]      |  Yes           |  Yes                 |  Yes                 |                               |                 |
|[DNSSEC03]      |                |                      |                      |                               |                 |
|[DNSSEC04]      |                |                      |                      |                               |                 |
|[DNSSEC05]      |  Yes           |  Yes                 |                      |                               |                 |
|[DNSSEC06]      |                |                      |                      |                               |                 |
|[DNSSEC07]      |                |                      |                      |                               |                 |
|[DNSSEC08]      |  Yes           |  Yes                 |  Yes                 |                               |                 |
|[DNSSEC09]      |  Yes           |  Yes                 |  Yes                 |                               |                 |
|[DNSSEC10]      |  Yes           |  Yes                 |  Yes                 |                               |                 |
|[DNSSEC11]      |  Yes           |  Yes                 |  Yes                 |                               |                 |
|[DNSSEC12]      |  Not defined   |                      |                      |                               |                 |
|[DNSSEC13]      |  Yes           |  Yes                 |  Yes                 |                               |                 |
|[DNSSEC14]      |  Yes           |  Yes                 |                      |                               |                 |
|[DNSSEC15]      |  Yes           |  Yes                 |  Almost              |                               |                 |
|[DNSSEC16]      |  Yes           |  Yes                 |  Almost              |                               |                 |
|[DNSSEC17]      |  Yes           |  Yes                 |  Almost              |                               |                 |
|[DNSSEC18]      |  Yes           |  Yes                 |  Almost              |                               |                 |
|[DELEGATION01]  |  Yes           |  Yes                 |                      |  N/A                          |                 |
|[DELEGATION02]  |  Yes           |  Yes                 |                      |  N/A                          |                 |
|[DELEGATION03]  |  Yes           |  Yes                 |                      |  N/A?                         |                 |
|[DELEGATION04]  |                |                      |                      |                               |                 |
|[DELEGATION05]  |  Yes           |  Yes                 |                      |                               |                 |
|[DELEGATION06]  |                |                      |                      |                               |                 |
|[DELEGATION07]  |                |                      |                      |  N/A                          |                 |
|[NAMESERVER01]  |  Yes           |  Yes                 |                      |                               |                 |
|[NAMESERVER02]  |  Yes           |  Yes                 |                      |                               |                 |
|[NAMESERVER03]  |                |                      |                      |  N/A?                         |                 |
|[NAMESERVER04]  |                |                      |                      |                               |                 |
|[NAMESERVER05]  |  Yes           |  Yes                 |                      |                               |                 |
|[NAMESERVER06]  |                |                      |                      |                               |                 |
|[NAMESERVER07]  |                |                      |                      |                               |                 |
|[NAMESERVER08]  |                |                      |                      |                               |                 |
|[NAMESERVER09]  |                |                      |                      |                               |                 |
|[NAMESERVER10]  |  Yes           |  Yes                 |                      |                               |                 |
|[NAMESERVER11]  |  Yes           |  Yes                 |                      |                               | [#1031]         |
|[NAMESERVER12]  |  Yes           |  Yes                 |                      |                               |                 |
|[NAMESERVER13]  |  Yes           |  Yes                 |                      |                               |                 |
|[NAMESERVER14]  |  Yes           |  Yes                 |                      |                               |                 |
|[SYNTAX01]      |  Yes?          |                      |                      |  N/A                          |                 |
|[SYNTAX02]      |  Yes           |                      |                      |  N/A                          |                 |
|[SYNTAX03]      |  Yes?          |                      |                      |  N/A                          |                 |
|[SYNTAX04]      |                |                      |                      |                               |                 |
|[SYNTAX05]      |  Yes           |  Yes                 |                      |                               |                 |
|[SYNTAX06]      |  Yes           |  Yes                 |                      |                               |                 |
|[SYNTAX07]      |                |                      |                      |                               |                 |
|[SYNTAX08]      |                |                      |                      |                               |                 |
|[ZONE01]        |                |                      |                      |                               |                 |
|[ZONE02]        |                |                      |                      |                               |                 |
|[ZONE03]        |                |                      |                      |                               |                 |
|[ZONE04]        |                |                      |                      |                               |                 |
|[ZONE05]        |                |                      |                      |                               |                 |
|[ZONE06]        |                |                      |                      |                               |                 |
|[ZONE07]        |                |                      |                      |                               |                 |
|[ZONE08]        |                |                      |                      |                               |                 |
|[ZONE09]        |                |                      | No, but see [#870]   |                               | [#870]          |
|[ZONE10]        |  Yes           |  Yes                 |                      |                               |                 |
|ZONE11          |  Proposal only |                      |                      |                               | [#1032]         |

[DNS query defaults]: https://github.com/zonemaster/zonemaster/pull/1000
[template01]: ../templates/specifications/tests/Template01.md
[#942]: https://github.com/zonemaster/zonemaster/pull/942
[#1031]: https://github.com/zonemaster/zonemaster/pull/1031
[#870]: https://github.com/zonemaster/zonemaster/pull/870
[#1032]: https://github.com/zonemaster/zonemaster/pull/1032


[ADDRESS01]: ../../specifications/tests/Address-TP/address01.md
[ADDRESS02]: ../../specifications/tests/Address-TP/address02.md
[ADDRESS03]: ../../specifications/tests/Address-TP/address03.md
[BASIC00]: ../../specifications/tests/Basic-TP/basic00.md
[BASIC01]: ../../specifications/tests/Basic-TP/basic01.md
[BASIC02]: ../../specifications/tests/Basic-TP/basic02.md
[BASIC03]: ../../specifications/tests/Basic-TP/basic03.md
[BASIC04]: ../../specifications/tests/Basic-TP/basic04.md
[CONNECTIVITY01]: ../../specifications/tests/Connectivity-TP/connectivity01.md
[CONNECTIVITY02]: ../../specifications/tests/Connectivity-TP/connectivity02.md
[CONNECTIVITY03]: ../../specifications/tests/Connectivity-TP/connectivity03.md
[CONSISTENCY01]: ../../specifications/tests/Consistency-TP/consistency01.md
[CONSISTENCY02]: ../../specifications/tests/Consistency-TP/consistency02.md
[CONSISTENCY03]: ../../specifications/tests/Consistency-TP/consistency03.md
[CONSISTENCY04]: ../../specifications/tests/Consistency-TP/consistency04.md
[CONSISTENCY05]: ../../specifications/tests/Consistency-TP/consistency05.md
[CONSISTENCY06]: ../../specifications/tests/Consistency-TP/consistency06.md
[DNSSEC01]: ../../specifications/tests/DNSSEC-TP/dnssec01.md
[DNSSEC02]: ../../specifications/tests/DNSSEC-TP/dnssec02.md
[DNSSEC03]: ../../specifications/tests/DNSSEC-TP/dnssec03.md
[DNSSEC04]: ../../specifications/tests/DNSSEC-TP/dnssec04.md
[DNSSEC05]: ../../specifications/tests/DNSSEC-TP/dnssec05.md
[DNSSEC06]: ../../specifications/tests/DNSSEC-TP/dnssec06.md
[DNSSEC07]: ../../specifications/tests/DNSSEC-TP/dnssec07.md
[DNSSEC08]: ../../specifications/tests/DNSSEC-TP/dnssec08.md
[DNSSEC09]: ../../specifications/tests/DNSSEC-TP/dnssec09.md
[DNSSEC10]: ../../specifications/tests/DNSSEC-TP/dnssec10.md
[DNSSEC11]: ../../specifications/tests/DNSSEC-TP/dnssec11.md
[DNSSEC12]: ../../specifications/tests/DNSSEC-TP/dnssec12.md
[DNSSEC13]: ../../specifications/tests/DNSSEC-TP/dnssec13.md
[DNSSEC14]: ../../specifications/tests/DNSSEC-TP/dnssec14.md
[DNSSEC15]: ../../specifications/tests/DNSSEC-TP/dnssec15.md
[DNSSEC16]: ../../specifications/tests/DNSSEC-TP/dnssec16.md
[DNSSEC17]: ../../specifications/tests/DNSSEC-TP/dnssec17.md
[DNSSEC18]: ../../specifications/tests/DNSSEC-TP/dnssec18.md
[DELEGATION01]: ../../specifications/tests/Delegation-TP/delegation01.md
[DELEGATION02]: ../../specifications/tests/Delegation-TP/delegation02.md
[DELEGATION03]: ../../specifications/tests/Delegation-TP/delegation03.md
[DELEGATION04]: ../../specifications/tests/Delegation-TP/delegation04.md
[DELEGATION05]: ../../specifications/tests/Delegation-TP/delegation05.md
[DELEGATION06]: ../../specifications/tests/Delegation-TP/delegation06.md
[DELEGATION07]: ../../specifications/tests/Delegation-TP/delegation07.md
[NAMESERVER01]: ../../specifications/tests/Nameserver-TP/nameserver01.md
[NAMESERVER02]: ../../specifications/tests/Nameserver-TP/nameserver02.md
[NAMESERVER03]: ../../specifications/tests/Nameserver-TP/nameserver03.md
[NAMESERVER04]: ../../specifications/tests/Nameserver-TP/nameserver04.md
[NAMESERVER05]: ../../specifications/tests/Nameserver-TP/nameserver05.md
[NAMESERVER06]: ../../specifications/tests/Nameserver-TP/nameserver06.md
[NAMESERVER07]: ../../specifications/tests/Nameserver-TP/nameserver07.md
[NAMESERVER08]: ../../specifications/tests/Nameserver-TP/nameserver08.md
[NAMESERVER09]: ../../specifications/tests/Nameserver-TP/nameserver09.md
[NAMESERVER10]: ../../specifications/tests/Nameserver-TP/nameserver10.md
[NAMESERVER11]: ../../specifications/tests/Nameserver-TP/nameserver11.md
[NAMESERVER12]: ../../specifications/tests/Nameserver-TP/nameserver12.md
[NAMESERVER13]: ../../specifications/tests/Nameserver-TP/nameserver13.md
[NAMESERVER14]: ../../specifications/tests/Nameserver-TP/nameserver14.md
[SYNTAX01]: ../../specifications/tests/Syntax-TP/syntax01.md
[SYNTAX02]: ../../specifications/tests/Syntax-TP/syntax02.md
[SYNTAX03]: ../../specifications/tests/Syntax-TP/syntax03.md
[SYNTAX04]: ../../specifications/tests/Syntax-TP/syntax04.md
[SYNTAX05]: ../../specifications/tests/Syntax-TP/syntax05.md
[SYNTAX06]: ../../specifications/tests/Syntax-TP/syntax06.md
[SYNTAX07]: ../../specifications/tests/Syntax-TP/syntax07.md
[SYNTAX08]: ../../specifications/tests/Syntax-TP/syntax08.md
[ZONE01]: ../../specifications/tests/Zone-TP/zone01.md
[ZONE02]: ../../specifications/tests/Zone-TP/zone02.md
[ZONE03]: ../../specifications/tests/Zone-TP/zone03.md
[ZONE04]: ../../specifications/tests/Zone-TP/zone04.md
[ZONE05]: ../../specifications/tests/Zone-TP/zone05.md
[ZONE06]: ../../specifications/tests/Zone-TP/zone06.md
[ZONE07]: ../../specifications/tests/Zone-TP/zone07.md
[ZONE08]: ../../specifications/tests/Zone-TP/zone08.md
[ZONE09]: ../../specifications/tests/Zone-TP/zone09.md
[ZONE10]: ../../specifications/tests/Zone-TP/zone10.md

