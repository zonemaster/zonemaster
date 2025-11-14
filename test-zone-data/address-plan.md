# Address plan for the test environment

## Table of contents
* [Overview](#overview)
* [Making reservation](#making-reservation)
* [Address block plan](#address-block-plan)
* [Address plans for specific addresses](#address-plans-for-specific-addresses)
  * [Non-scenario address plan](#non-scenario-address-plan)
  * [Address test level address plan](#address-test-level-address-plan)
  * [Basic test level address plan](#basic-test-level-address-plan)
  * [Connectivity test level address plan](#connectivity-test-level-address-plan)
  * [Consistency test level address plan](#consistency-test-level-address-plan)
  * [DNSSEC test level address plan](#dnssec-test-level-address-plan)
  * [Delegation test level address plan](#delegation-test-level-address-plan)
  * [Nameserver test level address plan](#nameserver-test-level-address-plan)
  * [Syntax test level address plan](#syntax-test-level-address-plan)
  * [Zone test level address plan](#zone-test-level-address-plan)
  * [Engine non-test case address plan](#engine-non-test-case-address-plan)

## Overview

* The IPv4 addresses are constructed as `127.x.y.x`
* The IPv6 addresses are constructed as `fda1:b2:c3::127:x:y:z`
* x, y and z are the same digit strings for IPv4 and IPv6.
  * E.g. when IPv4 address is `127.1.2.3` then IPv6 is `fda1:b2:c3::127:1:2:3`
* The matching IPv4 and IPv6 addresses are always reserved together for the
  the same use.
* In the test plans below, only the IPv4 addresses are listed. The matching
  IPv6 is assumed to be reserved for the same unit, in use or not. If only
  the IPv6 address is used, the IPv4 address is listed anyway.
  * If one of two addresses is unused, it cannot be used for something else.

The choice of z, the last octets, have some logic built in when used for the
test cases:

* 11-19: TLD NS, not scenario specific
* 21-29: SLD NS, not scenario specific
* 31-59: scenario NS, any level


## Making reservation

When taking an address in use (or rather an address pair, IPv4 and IPv6) then
add the IPv4 address in the specific table for under 
"[Address plans for specific addresses](#address-plans-for-specific-addresses)".
Follow the same pattern as in use by adding the address without prefix, e.g. as
`127.99.99.99`.

## Address block plan

| Address range   | Reserved for                                                |
|-----------------|-------------------------------------------------------------|
| 127.0.0.0/16    | Blocked. Not to be used.                                    |
| 127.1.0.0/16    | NS for root zones                                           |
| 127.2.0.0/16    | NS for TLD zones (xa, xb, arpa)                             |
| 127.3.0.0/16    | NS for ASNlookup plus mail targets                          |
| 127.4.0.0/16    | (not in use)                                                |
| (...)           |                                                             |
| 127.10.0.0/16   | (not in use)                                                |
| 127.11.0.0/16   | Address test level                                          |
| 127.12.0.0/16   | Basic test level                                            |
| 127.13.0.0/16   | Connectivity test level                                     |
| 127.14.0.0/16   | Consistency test level                                      |
| 127.15.0.0/16   | DNSSEC test level                                           |
| 127.16.0.0/16   | Delegation test level                                       |
| 127.17.0.0/16   | Nameserver test level                                       |
| 127.18.0.0/16   | Syntax test level                                           |
| 127.19.0.0/16   | Zone test level                                             |
| 127.20.0.0/16   | (not in use)                                                |
| (...)           |                                                             |
| 127.29.0.0/16   | (not in use)                                                |
| 127.30.0.0/16   | Engine non-test case test zones                             |
| 127.31.0.0/16   | (not in use)                                                |
| (...)           |                                                             |
| 127.39.0.0/16   | (not in use)                                                |
| 127.40.0.0/16   | MethodsV2 non-test case test zones                          |
| 127.41.0.0/16   | (not in use)                                                |
| (...)           |                                                             |
| 127.99.0.0/16   | (not in use)                                                |
| 127.100.0.0/16  | Special assignment for Connectivity03 and 04                |
| 127.101.0.0/16  | (not in use)                                                |
| (...)           |                                                             |
| 127.255.0.0/16  | (not in use)                                                |


## Address plans for specific addresses

### Non-scenario address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.1.0.0/24    |                                                             |
| 127.1.0.1       | ns1.                                                        |
| 127.1.0.2       | ns2.                                                        |
| 127.1.1.0/24    | (not in use)                                                |
| (...)           |                                                             |
| 127.1.255.0/24  | (not in use)                                                |
| 127.2.0.0/24    |                                                             |
| 127.2.0.11      | ns1.xa                                                      |
| 127.2.0.12      | ns2.xa                                                      |
| 127.2.0.13      | ns1.xb                                                      |
| 127.2.0.14      | ns2.xb                                                      |
| 127.2.1.0/24    | (not in use)                                                |
| (...)           |                                                             |
| 127.2.255.0/24  | (not in use)                                                |
| 127.3.0.0/24    |                                                             |
| 127.3.0.1       | ns1.asnlookup.zonemaster.net                                |
| 127.3.0.2       | ns2.asnlookup.zonemaster.net                                |
| 127.3.0.25      | mail (no name)                                              |
| 127.3.0.26      | mail1 (no name)                                             |
| 127.3.0.53      | resolver (no name)                                          |
| 127.3.1.0/24    | (not in use)                                                |
| (...)           |                                                             |
| 127.3.255.0/24  | (not in use)                                                |


### Address test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.11.0.0/24   | (not in use)                                                |
| 127.11.1.0/24   | Address01 scenarios                                         |
| 127.11.1.21     | ns1.address01.xa                                            |
| 127.11.1.22     | ns2.address01.xa                                            |
| 127.11.2.0/24   | Address02 scenarios                                         |
| 127.11.2.21     | ns1.address02.xa                                            |
| 127.11.2.22     | ns2.address02.xa                                            |
| 127.11.3.0/24   | Address03 scenarios                                         |
| 127.11.3.21     | ns1.address03.xa                                            |
| 127.11.3.22     | ns2.address03.xa                                            |
| 127.11.3.31     | ns1.child.address03.xa                                      |
| 127.11.3.32     | ns2.child.address03.xa                                      |
| 127.11.3.33     | ns3.child.address03.xa                                      |
| 127.11.3.34     | ns4.child.address03.xa                                      |
| 127.11.3.35     | ns5.child.address03.xa                                      |
| 127.11.3.36     | ns6.child.address03.xa                                      |
| 127.11.3.37     | ns7.child.address03.xa                                      |
| 127.11.3.38     | ns8.child.address03.xa                                      |
| 127.11.3.39     | ns9.child.address03.xa                                      |
| 127.11.3.40     | ns10.child.address03.xa                                     |
| 127.11.3.41     | ns11.child.address03.xa                                     |
| 127.11.3.42     | ns12.child.address03.xa                                     |
| 127.11.3.43     | ns13.child.address03.xa                                     |
| 127.11.3.44     | ns14.child.address03.xa                                     |
| 127.11.3.45     | ns15.child.address03.xa                                     |
| 127.11.4.0/24   | (not in use)                                                |
| (...)           |                                                             |
| 127.11.255.0/24 | (not in use)                                                |


### Basic test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.12.0.0/24   | (not in use)                                                |
| 127.12.1.0/24   | Basic01 scenarios                                           |
| 127.12.1.21     | ns1.basic01.xa                                              |
| 127.12.1.22     | ns2.basic01.xa                                              |
| 127.12.1.31     | ns1.SCENARIO.basic01.xa                                     |
| 127.12.1.32     | ns2.SCENARIO.basic01.xa                                     |
| 127.12.1.33     | ns3.SCENARIO.basic01.xa                                     |
| 127.12.1.34     | ns4.SCENARIO.basic01.xa                                     |
| 127.12.1.41     | ns1.parent.SCENARIO.basic01.xa                              |
| 127.12.1.42     | ns2.parent.SCENARIO.basic01.xa                              |
| 127.12.1.44     | ns4.parent.SCENARIO.basic01.xa                              |
| 127.12.1.46     | ns6.parent.SCENARIO.basic01.xa                              |
| 127.12.1.51     | ns1.child.parent.SCENARIO.basic01.xa                        |
| 127.12.1.52     | ns2.child.parent.SCENARIO.basic01.xa                        |
| 127.12.1.53     | ns3.child.parent.SCENARIO.basic01.xa                        |
| 127.12.1.54     | ns4.child.parent.SCENARIO.basic01.xa                        |
| 127.12.2.0/24   | Basic02 scenarios                                           |
| 127.12.2.21     | ns1.basic02.xa                                              |
| 127.12.2.22     | ns2.basic02.xa                                              |
| 127.12.2.23     | root-ns1.xa                                                 |
| 127.12.2.24     | root-ns1.xa                                                 |
| 127.12.2.25     | ns1.basic02.xb                                              |
| 127.12.2.26     | ns2.basic02.xb                                              |
| 127.12.2.31     | ns1 child zone                                              |
| 127.12.2.32     | ns2 child zone                                              |
| 127.12.2.33     | ns3 child zone                                              |
| 127.12.2.34     | ns4 child zone                                              |
| 127.12.2.53     | resolver with test case local hint                          |
| 127.12.3.0/24   | Basic03 scenarios                                           |
| 127.12.3.21     | ns1.basic03.xa                                              |
| 127.12.3.22     | ns2.basic03.xa                                              |
| 127.12.4.0/24   | (not in use)                                                |
| (...)           |                                                             |
| 127.12.255.0/24 | (not in use)                                                |


### Connectivity test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.13.0.0/24   | (not in use)                                                |
| 127.13.1.0/24   | Connectivity01 scenarios                                    |
| 127.13.1.21     | ns1.connectivity01.xa                                       |
| 127.13.1.22     | ns2.connectivity01.xa                                       |
| 127.13.2.0/24   | Connectivity02 scenarios                                    |
| 127.13.2.21     | ns1.connectivity02.xa                                       |
| 127.13.2.22     | ns2.connectivity02.xa                                       |
| 127.13.3.0/24   | Connectivity03 scenarios                                    |
| 127.13.3.21     | ns1.connectivity03.xa                                       |
| 127.13.3.22     | ns2.connectivity03.xa                                       |
| 127.13.4.0/24   | Connectivity04 scenarios                                    |
| 127.13.4.21     | ns1.connectivity04.xa                                       |
| 127.13.4.22     | ns2.connectivity04.xa                                       |
| 127.13.4.23     | root-ns1.xa (test case local root zone)                     |
| 127.13.4.24     | root-ns2.xa (test case local root zone)                     |
| 127.13.4.25     | ns1.asnlookup.zonemaster.net (test case local)              |
| 127.13.4.26     | ns2.asnlookup.zonemaster.net (test case local)              |
| (...)           |                                                             |
| 127.13.4.53     | resolver with test case local hint file                     |
| 127.13.5.0/24   | (not in use)                                                |
| (...)           |                                                             |
| 127.13.255.0/24 | (not in use)                                                |
| 127.100.0.0/24  | (not in use)                                                |
| (...)           |                                                             |
| 127.100.99.0/24 | (not in use)                                                |
| 127.100.100.0/24| Connectivity04
| 127.100.100.1   | dns0
| 127.100.101.1   | dns1
| 127.100.102.1   | dns2
| 127.100.103.1   | dns3
| 127.100.104.1   | dns4
| 127.100.105.1   | dns5
| 127.100.106.1   | dns6
| 127.100.107.1   | dns7
| 127.100.108.1   | dns8
| 127.100.109.1   | dns9
| 127.100.110.1   | dns10
| 127.100.111.1   | dns11
| 127.100.112.1   | dns12
| 127.100.113.1   | dns13-1
| 127.100.113.2   | dns13-2
| 127.100.114.1   | dns14-1
| 127.100.114.2   | dns14-2
| 127.100.115.1   | dns15
| 127.100.116.1   | dns16-1
| 127.100.116.2   | dns16-2
| 127.100.117.1   | dns17-1
| 127.100.117.2   | dns17-2
| 127.100.118.1   | dns18
| 127.100.119.1   | dns19
| 127.100.120.1   | dns20
| 127.100.121.1   | dns21
| 127.100.122.1   | dns22
| 127.100.123.1   | dns23
| 127.100.124.1   | dns24
| 127.100.125.1   | dns25
| 127.100.126.1   | dns26
| 127.100.127.1   | dns27


### Consistency test level address plan

| Address (range) | Used for -- range for test case or specific NS address |
|-----------------|--------------------------------------------------------|
| 127.14.0.0/24   | (not in use)                                           |
| 127.14.1.0/24   | Consistency01 scenarios                                |
| 127.14.1.21     | ns1.consistency01.xa                                   |
| 127.14.1.22     | ns2.consistency01.xa                                   |
| 127.14.2.0/24   | Consistency02 scenarios                                |
| 127.14.2.21     | ns1.consistency02.xa                                   |
| 127.14.2.22     | ns2.consistency02.xa                                   |
| 127.14.3.0/24   | Consistency03 scenarios                                |
| 127.14.3.21     | ns1.consistency03.xa                                   |
| 127.14.3.22     | ns2.consistency03.xa                                   |
| 127.14.4.0/24   | Consistency04 scenarios                                |
| 127.14.4.21     | ns1.consistency04.xa                                   |
| 127.14.4.22     | ns2.consistency05.xa                                   |
| 127.14.5.0/24   | Consistency05 scenarios                                |
| 127.14.5.21     | ns1.consistency05.xa                                   |
| 127.14.5.22     | ns2.consistency05.xa                                   |
| 127.14.5.23     | ns1.consistency05.xb                                   |
| 127.14.5.24     | ns2.consistency05.xb                                   |
| 127.14.5.31     | for scenarios                                          |
| 127.14.5.32     | for scenarios                                          |
| 127.14.5.33     | for scenarios                                          |
| 127.14.5.34     | for scenarios                                          |
| 127.14.5.35     | for scenarios                                          |
| 127.14.6.0/24   | Consistency06 scenarios                                |
| 127.14.6.21     | ns1.consistency06.xa                                   |
| 127.14.6.22     | ns2.consistency06.xa                                   |
| 127.14.6.23     | ns1.consistency06.xb                                   |
| 127.14.6.24     | ns2.consistency06.xb                                   |
| 127.14.6.31     | for scenarios                                          |
| 127.14.6.32     | for scenarios                                          |
| 127.14.6.33     | for scenarios                                          |
| 127.14.6.34     | for scenarios                                          |
| 127.14.7.0/24   | (not in use)                                           |
| (...)           |                                                        |
| 127.14.255.0/24 | (not in use)                                           |


### DNSSEC test level address plan

| Address (range) | Used for -- range for test case or specific NS address |
|-----------------|--------------------------------------------------------|
| 127.15.0.0/24   | (not in use)                                           |
| 127.15.1.0/24   | DNSSEC01 scenarios                                     |
| 127.15.1.21     | ns1.dnssec01.xa                                        |
| 127.15.1.22     | ns2.dnssec01.xa                                        |
| 127.15.1.27     | ns1 for DNSSEC01 specific root                         |
| 127.15.1.28     | ns2 for DNSSEC01 specific root                         |
| 127.15.1.31     | scenario specific parent (if any)                      |
| 127.15.1.32     | scenario specific parent (if any)                      |
| 127.15.1.41     | ns1 for scenario child                                 |
| 127.15.1.42     | ns2 for chenario child                                 |
| 127.15.1.53     | scenario specific resolver                             |
| 127.15.2.0/24   | DNSSEC02 scenarios                                     |
| 127.15.2.21     | ns1.dnssec02.xa                                        |
| 127.15.2.22     | ns2.dnssec02.xa                                        |
| 127.15.3.0/24   | DNSSEC03 scenarios                                     |
| 127.15.3.21     | ns1.dnssec03.xa                                        |
| 127.15.3.22     | ns2.dnssec03.xa                                        |
| 127.15.3.31     | n1 server for various scenarios under dnssec03.xa      |
| 127.15.3.32     | n2 server for various scenarios under dnssec03.xa      |
| 127.15.4.0/24   | DNSSEC04 scenarios                                     |
| 127.15.4.21     | ns1.dnssec04.xa                                        |
| 127.15.4.22     | ns2.dnssec04.xa                                        |
| 127.15.5.0/24   | DNSSEC05 scenarios                                     |
| 127.15.5.21     | ns1.dnssec05.xa                                        |
| 127.15.5.22     | ns2.dnssec05.xa                                        |
| 127.15.6.0/24   | DNSSEC06 scenarios                                     |
| 127.15.6.21     | ns1.dnssec06.xa                                        |
| 127.15.6.22     | ns2.dnssec06.xa                                        |
| 127.15.7.0/24   | DNSSEC07 scenarios                                     |
| 127.15.7.21     | ns1.dnssec07.xa                                        |
| 127.15.7.22     | ns2.dnssec07.xa                                        |
| 127.15.7.27     | ns1 of root                                            |
| 127.15.7.28     | ns2 of root                                            |
| 127.15.7.31     | ns1 of parent in some scenarios                        |
| 127.15.7.32     | ns2 of parent in some scenarios                        |
| 127.15.7.41     | ns1 of child zone                                      |
| 127.15.7.42     | ns2 of child zone                                      |
| 127.15.7.53     | resolver with test case local hint                     |
| 127.15.8.0/24   | DNSSEC08 scenarios                                     |
| 127.15.8.21     | ns1.dnssec08.xa                                        |
| 127.15.8.22     | ns2.dnssec08.xa                                        |
| 127.15.9.0/24   | DNSSEC09 scenarios                                     |
| 127.15.9.21     | ns1.dnssec09.xa                                        |
| 127.15.9.22     | ns2.dnssec09.xa                                        |
| 127.15.10.0/24  | DNSSEC10 scenarios                                     |
| 127.15.10.21    | ns1.dnssec10.xa                                        |
| 127.15.10.22    | ns2.dnssec10.xa                                        |
| 127.15.10.31    | ns1 server for various scenarios for DNSSEC10          |
| 127.15.10.32    | ns2 server for various scenarios for DNSSEC10          |
| 127.15.10.33    | ns3 server for various scenarios for DNSSEC10          |
| 127.15.10.34    | ns4 server for various scenarios for DNSSEC10          |
| 127.15.10.35    | ns5 server for various scenarios for DNSSEC10          |
| 127.15.10.37    | For Bind server to create DNSKEY, NSEC3 and RRSIG      |
| 127.15.10.38    | For Bind server to create DNSKEY, NSEC3 and RRSIG      |
| 127.15.11.0/24  | DNSSEC11 scenarios                                     |
| 127.15.11.21    | ns1.dnssec11.xa                                        |
| 127.15.11.22    | ns2.dnssec11.xa                                        |
| 127.15.12.0/24  | DNSSEC12 scenarios                                     |
| 127.15.12.21    | ns1.dnssec12.xa                                        |
| 127.15.12.22    | ns2.dnssec12.xa                                        |
| 127.15.13.0/24  | DNSSEC13 scenarios                                     |
| 127.15.13.21    | ns1.dnssec13.xa                                        |
| 127.15.13.22    | ns2.dnssec13.xa                                        |
| 127.15.14.0/24  | DNSSEC14 scenarios                                     |
| 127.15.14.21    | ns1.dnssec14.xa                                        |
| 127.15.14.22    | ns2.dnssec14.xa                                        |
| 127.15.15.0/24  | DNSSEC15 scenarios                                     |
| 127.15.15.21    | ns1.dnssec15.xa                                        |
| 127.15.15.22    | ns2.dnssec15.xa                                        |
| 127.15.16.0/24  | DNSSEC16 scenarios                                     |
| 127.15.16.21    | ns1.dnssec16.xa                                        |
| 127.15.16.22    | ns2.dnssec16.xa                                        |
| 127.15.16.31    | n1 server for various scenarios under dnssec16.xa      |
| 127.15.16.32    | n2 server for various scenarios under dnssec16.xa      |
| 127.15.17.0/24  | DNSSEC17 scenarios                                     |
| 127.15.17.21    | ns1.dnssec17.xa                                        |
| 127.15.17.22    | ns2.dnssec17.xa                                        |
| 127.15.18.0/24  | DNSSEC18 scenarios                                     |
| 127.15.18.21    | ns1.dnssec18.xa                                        |
| 127.15.18.22    | ns2.dnssec18.xa                                        |
| 127.15.19.0/24  | (not in use)                                           |
| (...)           |                                                        |
| 127.15.255.0/24 | (not in use)                                           |

### Delegation test level address plan

| Address (range) | Used for -- range for test case or specific NS address |
|-----------------|--------------------------------------------------------|
| 127.16.0.0/24   | (not in use)                                           |
| 127.16.1.0/24   | Delegation01 scenarios                                 |
| 127.16.1.21     | ns1.delegation01.xa                                    |
| 127.16.1.22     | ns2.delegation01.xa                                    |
| 127.16.1.25     | ns1.delegation01.xb                                    |
| 127.16.1.26     | ns2.delegation01.xb                                    |
| 127.16.1.27     | root-ns1.xa                                            |
| 127.16.1.28     | root-ns1.xa                                            |
| 127.16.1.31     | ns1 child zone                                         |
| 127.16.1.32     | ns2 child zone                                         |
| 127.16.1.33     | ns1 in xb for child zone                               |
| 127.16.1.34     | ns2 in xb for child zone                               |
| 127.16.1.53     | resolver with test case local hint                     |
| 127.16.2.0/24   | Delegation02 scenarios                                 |
| 127.16.2.21     | ns1.delegation02.xa                                    |
| 127.16.2.22     | ns2.delegation02.xa                                    |
| 127.16.2.25     | ns1.delegation02.xb                                    |
| 127.16.2.26     | ns2.delegation02.xb                                    |
| 127.16.2.27     | root-ns1.xa                                            |
| 127.16.2.28     | root-ns1.xa                                            |
| 127.16.2.31     | ns1 (ns1a, ns1b) child zone                            |
| 127.16.2.32     | ns2 child zone                                         |
| 127.16.2.33     | ns1 (ns1b) child zone                                  |
| 127.16.2.37     | ns1 in xb for child zone                               |
| 127.16.2.38     | ns2 in xb for child zone                               |
| 127.16.2.53     | resolver with test case local hint                     |
| 127.16.3.0/24   | Delegation03 scenarios                                 |
| 127.16.3.21     | ns1.delegation03.xa                                    |
| 127.16.3.22     | ns2.delegation03.xa                                    |
| 127.16.3.27     | root-ns1.xa                                            |
| 127.16.3.28     | root-ns1.xa                                            |
| 127.16.3.31     | ns1 child zone                                         |
| 127.16.3.32     | ns2 child zone                                         |
| 127.16.3.33     | ns3 child zone                                         |
| 127.16.3.34     | ns4 child zone                                         |
| 127.16.3.35     | ns5 child zone                                         |
| 127.16.3.36     | ns6 child zone                                         |
| 127.16.3.53     | resolver with test case local hint                     |
| 127.16.4.0/24   | Delegation04 scenarios                                 |
| 127.16.4.21     | ns1.delegation04.xa                                    |
| 127.16.4.22     | ns2.delegation04.xa                                    |
| 127.16.5.0/24   | Delegation05 scenarios                                 |
| 127.16.5.21     | ns1.delegation05.xa                                    |
| 127.16.5.22     | ns2.delegation05.xa                                    |
| 127.16.6.0/24   | Delegation06 scenarios                                 |
| 127.16.6.21     | ns1.delegation06.xa                                    |
| 127.16.6.22     | ns2.delegation06.xa                                    |
| 127.16.7.0/24   | Delegation07 scenarios                                 |
| 127.16.7.21     | ns1.delegation07.xa                                    |
| 127.16.7.22     | ns2.delegation07.xa                                    |
| 127.16.8.0/24   | (not in use)                                           |
| (...)           |                                                        |
| 127.16.255.0/24 | (not in use)                                           |


### Nameserver test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.17.0.0/24   | (not in use)                                                |
| 127.17.1.0/24   | Nameserver01 scenarios                                      |
| 127.17.1.21     | ns1.nameserver01.xa                                         |
| 127.17.1.22     | ns2.nameserver01.xa                                         |
| 127.17.2.0/24   | Nameserver02 scenarios                                      |
| 127.17.2.21     | ns1.nameserver02.xa                                         |
| 127.17.2.22     | ns2.nameserver02.xa                                         |
| 127.17.3.0/24   | Nameserver03 scenarios                                      |
| 127.17.3.21     | ns1.nameserver03.xa                                         |
| 127.17.3.22     | ns2.nameserver03.xa                                         |
| 127.17.4.0/24   | Nameserver04 scenarios                                      |
| 127.17.4.21     | ns1.nameserver04.xa                                         |
| 127.17.4.22     | ns2.nameserver04.xa                                         |
| 127.17.5.0/24   | Nameserver05 scenarios                                      |
| 127.17.5.21     | ns1.nameserver05.xa                                         |
| 127.17.5.22     | ns2.nameserver05.xa                                         |
| 127.17.6.0/24   | Nameserver06 scenarios                                      |
| 127.17.6.21     | ns1.nameserver06.xa                                         |
| 127.17.6.22     | ns2.nameserver06.xa                                         |
| 127.17.7.0/24   | Nameserver07 scenarios                                      |
| 127.17.7.21     | ns1.nameserver07.xa                                         |
| 127.17.7.22     | ns2.nameserver07.xa                                         |
| 127.17.8.0/24   | Nameserver08 scenarios                                      |
| 127.17.8.21     | ns1.nameserver08.xa                                         |
| 127.17.8.22     | ns2.nameserver08.xa                                         |
| 127.17.9.0/24   | Nameserver09 scenarios                                      |
| 127.17.9.21     | ns1.nameserver09.xa                                         |
| 127.17.9.22     | ns2.nameserver09.xa                                         |
| 127.17.10.0/24  | Nameserver10 scenarios                                      |
| 127.17.10.21    | ns1.nameserver10.xa                                         |
| 127.17.10.22    | ns2.nameserver10.xa                                         |
| 127.17.11.0/24  | Nameserver11 scenarios                                      |
| 127.17.11.21    | ns1.nameserver11.xa                                         |
| 127.17.11.22    | ns2.nameserver11.xa                                         |
| 127.17.12.0/24  | Nameserver12 scenarios                                      |
| 127.17.12.21    | ns1.nameserver12.xa                                         |
| 127.17.12.22    | ns2.nameserver12.xa                                         |
| 127.17.13.0/24  | Nameserver13 scenarios                                      |
| 127.17.13.21    | ns1.nameserver13.xa                                         |
| 127.17.13.22    | ns2.nameserver13.xa                                         |
| 127.17.14.0/24  | (not in use)                                                |
| 127.17.15.0/24  | Nameserver15 scenarios                                      |
| 127.17.15.21    | ns1.nameserver15.xa                                         |
| 127.17.15.22    | ns2.nameserver15.xa                                         |
| 127.17.15.31    | ns1.no-version-revealed-1.nameserver15.xa                   |
| 127.17.15.32    | ns1.no-version-revealed-2.nameserver15.xa                   |
| 127.17.15.33    | ns1.no-version-revealed-3.nameserver15.xa                   |
| 127.17.15.34    | ns1.no-version-revealed-4.nameserver15.xa.                  |
| 127.17.15.35    | ns1.no-version-revealed-5.nameserver15.xa.                  |
| 127.17.15.36    | ns1.no-version-revealed-6.nameserver15.xa.                  |
| 127.17.15.37    | ns1.error-on-version-query-1.nameserver15.xa.               |
| 127.17.15.38    | ns1.error-on-version-query-2.nameserver15.xa.               |
| 127.17.15.39    | ns1.software-version-1.nameserver15.xa.                     |
| 127.17.15.40    | ns1.software-version-2.nameserver15.xa.                     |
| 127.17.15.41    | ns1.wrong-class-1.nameserver15.xa.                          |
| 127.17.15.42    | ns1.wrong-class-2.nameserver15.xa.                          |
| 127.17.16.0/24  | (not in use)                                                |
| (...)           |                                                             |
| 127.17.255.0/24 | (not in use)                                                |


### Syntax test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.18.0.0/24   | (not in use)                                                |
| 127.18.1.0/24   | Syntax01 scenarios                                          |
| 127.18.1.21     | ns1.syntax01.xa                                             |
| 127.18.1.22     | ns2.syntax01.xa                                             |
| 127.18.2.0/24   | Syntax02 scenarios                                          |
| 127.18.2.21     | ns1.syntax02.xa                                             |
| 127.18.2.22     | ns2.syntax02.xa                                             |
| 127.18.3.0/24   | Syntax03 scenarios                                          |
| 127.18.3.21     | ns1.syntax03.xa                                             |
| 127.18.3.22     | ns2.syntax03.xa                                             |
| 127.18.4.0/24   | Syntax04 scenarios                                          |
| 127.18.4.21     | ns1.syntax04.xa                                             |
| 127.18.4.22     | ns2.syntax04.xa                                             |
| 127.18.5.0/24   | Syntax05 scenarios                                          |
| 127.18.5.21     | ns1.syntax05.xa                                             |
| 127.18.5.22     | ns2.syntax05.xa                                             |
| 127.18.6.0/24   | Syntax06 scenarios                                          |
| 127.18.6.21     | ns1.syntax06.xa                                             |
| 127.18.6.22     | ns2.syntax06.xa                                             |
| 127.18.7.0/24   | Syntax07 scenarios                                          |
| 127.18.7.21     | ns1.syntax07.xa                                             |
| 127.18.7.22     | ns2.syntax07.xa                                             |
| 127.18.8.0/24   | Syntax08 scenarios                                          |
| 127.18.8.21     | ns1.syntax08.xa                                             |
| 127.18.8.22     | ns2.syntax08.xa                                             |
| 127.18.9.0/24   | (not in use)                                                |
| (...)           |                                                             |
| 127.18.255.0/24 | (not in use)                                                |


### Zone test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.19.0.0/24   | (not in use)                                                |
| 127.19.1.0/24   | Zone01 scenarios                                            |
| 127.19.1.21     | ns1.zone01.xa                                               |
| 127.19.1.22     | ns2.zone01.xa                                               |
| 127.19.2.0/24   | Zone02 scenarios                                            |
| 127.19.2.21     | ns1.zone02.xa                                               |
| 127.19.2.22     | ns2.zone02.xa                                               |
| 127.19.3.0/24   | Zone03 scenarios                                            |
| 127.19.3.21     | ns1.zone03.xa                                               |
| 127.19.3.22     | ns2.zone03.xa                                               |
| 127.19.4.0/24   | Zone04 scenarios                                            |
| 127.19.4.21     | ns1.zone04.xa                                               |
| 127.19.4.22     | ns2.zone04.xa                                               |
| 127.19.5.0/24   | Zone05 scenarios                                            |
| 127.19.5.21     | ns1.zone05.xa                                               |
| 127.19.5.22     | ns2.zone05.xa                                               |
| 127.19.6.0/24   | Zone06 scenarios                                            |
| 127.19.6.21     | ns1.zone06.xa                                               |
| 127.19.6.22     | ns2.zone06.xa                                               |
| 127.19.7.0/24   | Zone07 scenarios                                            |
| 127.19.7.21     | ns1.zone07.xa                                               |
| 127.19.7.22     | ns2.zone07.xa                                               |
| 127.19.8.0/24   | Zone08 scenarios                                            |
| 127.19.8.21     | ns1.zone08.xa                                               |
| 127.19.8.22     | ns2.zone08.xa                                               |
| 127.19.9.0/24   | Zone09 scenarios                                            |
| 127.19.9.21     | ns1.zone09.xa                                               |
| 127.19.9.22     | ns2.zone09.xa                                               |
| 127.19.9.31     | for scenarios                                               |
| 127.19.9.32     | for scenarios                                               |
| 127.19.9.34     | testzone NS that answers without authoritative answer       |
| 127.19.9.41     | ns1.tld-email-domain-zone09.                                |
| 127.19.9.42     | for scenarios                                               |
| 127.19.9.43     | ns2.tld-email-domain-zone09.                                |
| 127.19.9.44     | for scenarios                                               |
| 127.19.10.0/24  | Zone10 scenarios                                            |
| 127.19.10.21    | ns1.zone10.xa                                               |
| 127.19.10.22    | ns2.zone10.xa                                               |
| 127.19.11.0/24  | Zone11 scenarios                                            |
| 127.19.11.21    | ns1.zone11.xa                                               |
| 127.19.11.22    | ns2.zone11.xa                                               |
| 127.19.11.31    | ns1.child.zone11.xa                                         |
| 127.19.11.32    | ns2.child.zone11.xa                                         |
| 127.19.11.33    | ns3.child.zone11.xa                                         |
| 127.19.11.41    | ns1.no-spf.root-servers.zone11.xa                           |
| 127.19.11.42    | ns2.no-spf.root-servers.zone11.xa                           |
| 127.19.11.43    | ns1.null-spf.root-servers.zone11.xa                         |
| 127.19.11.44    | ns2.null-spf.root-servers.zone11.xa                         |
| 127.19.11.45    | ns1.non-null-spf.root-servers.zone11.xa                     |
| 127.19.11.46    | ns2.non-null-spf.root-servers.zone11.xa                     |
| 127.19.12.0/24  | (not in use)                                                |
| (...)           |                                                             |
| 127.19.255.0/24 | (not in use)                                                |


### Engine non-test case address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.30.0.0/24   | (not in use)                                                |
| 127.30.1.0/24   | Recursor.pm                                                 |
| 127.30.1.21     | ns1.recursor.engine.xa                                      |
| 127.30.1.22     | ns2.recursor.engine.xa                                      |
| 127.30.1.31     | ns1.cname.recursor.engine.xa                                |
| 127.30.1.32     | ns1.sub2.cname.recursor.engine.xa                           |
| 127.30.1.33     | ns1.sub3.cname.recursor.engine.xa                           |
| 127.30.1.34     | ns1.goodsub.cname.recursor.engine.xa                        |
| 127.30.2.0/24   | (not in use)                                                |
| (...)           |                                                             |
| 127.30.255.0/24 | (not in use)                                                |


### MethodsV2 non-test case address plan

| Address (range) | Used for -- range or specific NS address                    |
|-----------------|-------------------------------------------------------------|
| 127.40.0.0/24   | (not in use)                                                |
| 127.40.1.0/24   | NS for scenario zones or above                              |
| 127.40.1.21     | ns1.methodsv2.xa                                            |
| 127.40.1.22     | ns2.methodsv2.xa                                            |
| 127.40.1.26     | ns6 (no NS listening, defined i methodsv2.xa                |
| 127.40.1.27     | ns7 (no NS listening, defined i methodsv2.xa                |
| 127.40.1.28     | ns8 (no NS listening, defined i methodsv2.xa                |
| 127.40.1.29     | ns9 (no NS listening, defined i methodsv2.xa                |
| 127.40.1.31     | ns1.XXX.methodsv2.xa (NS for grandparent)                   |
| 127.40.1.32     | ns2.XXX.methodsv2.xa (NS for grandparent)                   |
| 127.40.1.33     | ns3.XXX.methodsv2.xa (NS for child defined in grandparent)  |
| 127.40.1.34     | ns4.XXX.methodsv2.xa (NS for child defined in grandparent)  |
| 127.40.1.35     | ns5.XXX.methodsv2.xa (NS for child defined in grandparent)  |
| 127.40.1.36     | ns6.XXX.methodsv2.xa (NS for child defined in grandparent)  |
| 127.40.1.41     | ns1.parent.XXX.methodsv2.xa (NS for parent)                 |
| 127.40.1.42     | ns2.parent.XXX.methodsv2.xa (NS for parent)                 |
| 127.40.1.43     | ns3.parent.methodsv2.xa (NS for child)                      |
| 127.40.1.44     | ns4.parent.methodsv2.xa (NS for child)                      |
| 127.40.1.51     | ns1.child.parent.XXX.methodsv2.xa (NS for child)            |
| 127.40.1.52     | ns2.child.parent.XXX.methodsv2.xa (NS for child)            |
| 127.40.1.53     | ns3.child.parent.XXX.methodsv2.xa (NS for child)            |
| 127.40.1.54     | ns4.child.parent.XXX.methodsv2.xa (NS for child)            |
| 127.40.1.55     | ns5.child.parent.XXX.methodsv2.xa (NS for child)            |
| (...)           |                                                             |
| 127.40.255.0/24 | (not in use)                                                |
