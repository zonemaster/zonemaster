# Address plan for the test environment

* The IPv4 addresses are constructed as 127.x.y.x
* The IPv6 addresses are constructed as fda1:b2:c3::127:x:y:z
* x, y and z are the same digit strings for IPv4 and IPv6.
  * E.g. when IPv4 address is 127.1.2.3 then IPv6 is fda1:b2:c3::127:1:2:3
* In the test plans below, only the IPv4 addresses are listed. The matching
  IPv6 is assumed to be reserved for the same unit, in use or not. If only
  the IPv6 address is used, the IPv4 address is listed anyway.

The choice of z, the last octess, have some logic built in when used for the
test cases:

* 11-19: TLD NS, not scenario specific
* 21-29: SLD NS, not scenario specific
* 31-59: scenario NS, any level


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
| 127.11.0.0/16   | Address test level NS                                       |
| 127.12.0.0/16   | Basic test level NS                                         |
| 127.13.0.0/16   | Connectivity test level NS                                  |
| 127.14.0.0/16   | Consistency test level NS                                   |
| 127.15.0.0/16   | DNSSEC test level NS                                        |
| 127.16.0.0/16   | Delegation test level NS                                    |
| 127.17.0.0/16   | Nameserver test level NS                                    |
| 127.18.0.0/16   | Syntax test level NS                                        |
| 127.19.0.0/16   | Zone test level NS                                          |
| 127.20.0.0/16   | (not in use)                                                |
| (...)           |                                                             |
| 127.255.0.0/16  | (not in use)                                                |


## Adress plans for specific addresses

### Non-test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.1.0.0/8     |
| 127.1.0.1       | ns1.
| 127.1.0.2       | ns2.
| 127.2.0.0/8     |
| 127.2.0.11      | ns1.xa
| 127.2.0.12      | ns2.xa
| 127.2.0.13      | ns1.xb
| 127.2.0.14      | ns2.xb
| 127.3.0.0/8     |
| 127.3.0.1       | ns1.asnlookup.zonemaster.net
| 127.3.0.2       | ns2.asnlookup.zonemaster.net
| 127.3.0.25      | mail (no name)
| 127.3.0.26      | mail1 (no name)
| 127.3.0.53      | resolver (no name)


### Address test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.11.1.0/8    | Address01 scenarios                                         |
| 127.11.1.21     | ns1.address01.xa                                            |
| 127.11.1.22     | ns2.address01.xa                                            |
| 127.11.2.0/8    | Address02 scenarios                                         |
| 127.11.2.21     | ns1.address02.xa                                            |
| 127.11.2.22     | ns2.address02.xa                                            |
| 127.11.3.0/8    | Address03 scenarios                                         |
| 127.11.3.21     | ns1.address03.xa                                            |
| 127.11.3.22     | ns2.address03.xa                                            |


### Basic test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.12.1.0/8    | Basic01 scenarios                                           |
| 127.12.1.21     | ns1.basic01.xa                                              |
| 127.12.1.22     | ns2.basic01.xa                                              |
| 127.12.2.0/8    | Basic02 scenarios                                           |
| 127.12.2.21     | ns1.basic02.xa                                              |
| 127.12.2.22     | ns2.basic02.xa                                              |
| 127.12.3.0/8    | Basic03 scenarios                                           |
| 127.12.3.21     | ns1.basic03.xa                                              |
| 127.12.3.22     | ns2.basic03.xa                                              |


### Connectivity test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.13.1.0/8    | Connectivity01 scenarios                                    |
| 127.13.1.21     | ns1.connectivity01.xa                                       |
| 127.13.1.22     | ns2.connectivity01.xa                                       |
| 127.13.2.0/8    | Connectivity02 scenarios                                    |
| 127.13.2.21     | ns1.connectivity02.xa                                       |
| 127.13.2.22     | ns2.connectivity02.xa                                       |
| 127.13.3.0/8    | Connectivity03 scenarios                                    |
| 127.13.3.21     | ns1.connectivity03.xa                                       |
| 127.13.3.22     | ns2.connectivity03.xa                                       |
| 127.13.4.0/8    | Connectivity04 scenarios                                    |
| 127.13.4.21     | ns1.connectivity04.xa                                       |
| 127.13.4.22     | ns2.connectivity04.xa                                       |


### Consistency test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.14.1.0/8    | Consistency01 scenarios                                    |
| 127.14.1.21     | ns1.consistency01.xa                                       |
| 127.14.1.22     | ns2.consistency01.xa                                       |
| 127.14.2.0/8    | Consistency02 scenarios                                    |
| 127.14.2.21     | ns1.consistency02.xa                                       |
| 127.14.2.22     | ns2.consistency02.xa                                       |
| 127.14.3.0/8    | Consistency03 scenarios                                    |
| 127.14.3.21     | ns1.consistency03.xa                                       |
| 127.14.3.22     | ns2.consistency03.xa                                       |
| 127.14.4.0/8    | Consistency04 scenarios                                    |
| 127.14.4.21     | ns1.consistency04.xa                                       |
| 127.14.5.22     | ns2.consistency05.xa                                       |
| 127.14.5.0/8    | Consistency05 scenarios                                    |
| 127.14.5.21     | ns1.consistency05.xa                                       |
| 127.14.6.22     | ns2.consistency06.xa                                       |
| 127.14.6.0/8    | Consistency06 scenarios                                    |
| 127.14.6.21     | ns1.consistency06.xa                                       |
| 127.14.6.22     | ns2.consistency06.xa                                       |


### DNSSEC test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.15.1.0/8    | DNSSEC01 scenarios                                          |
| 127.15.1.21     | ns1.dnssec01.xa                                             |
| 127.15.1.22     | ns2.dnssec01.xa                                             |
| 127.15.2.0/8    | DNSSEC02 scenarios                                          |
| 127.15.2.21     | ns1.dnssec02.xa                                             |
| 127.15.2.22     | ns2.dnssec02.xa                                             |
| 127.15.3.0/8    | DNSSEC03 scenarios                                          |
| 127.15.3.21     | ns1.dnssec03.xa                                             |
| 127.15.3.22     | ns2.dnssec03.xa                                             |
| 127.15.3.31     | n1 server for various scenarios under dnssec03.xa           |
| 127.15.3.32     | n2 server for various scenarios under dnssec03.xa           |
| 127.15.4.0/8    | DNSSEC04 scenarios                                          |
| 127.15.4.21     | ns1.dnssec04.xa                                             |
| 127.15.4.22     | ns2.dnssec04.xa                                             |
| 127.15.5.0/8    | DNSSEC05 scenarios                                          |
| 127.15.5.21     | ns1.dnssec05.xa                                             |
| 127.15.5.22     | ns2.dnssec05.xa                                             |
| 127.15.6.0/8    | DNSSEC06 scenarios                                          |
| 127.15.6.21     | ns1.dnssec06.xa                                             |
| 127.15.6.22     | ns2.dnssec06.xa                                             |
| 127.15.7.0/8    | DNSSEC07 scenarios                                          |
| 127.15.7.21     | ns1.dnssec07.xa                                             |
| 127.15.7.22     | ns2.dnssec07.xa                                             |
| 127.15.8.0/8    | DNSSEC08 scenarios                                          |
| 127.15.8.21     | ns1.dnssec08.xa                                             |
| 127.15.8.22     | ns2.dnssec08.xa                                             |
| 127.15.9.0/8    | DNSSEC09 scenarios                                          |
| 127.15.9.21     | ns1.dnssec09.xa                                             |
| 127.15.9.22     | ns2.dnssec09.xa                                             |
| 127.15.10.0/8   | DNSSEC10 scenarios                                          |
| 127.15.10.21    | ns1.dnssec10.xa                                             |
| 127.15.10.22    | ns2.dnssec10.xa                                             |
| 127.15.11.0/8   | DNSSEC11 scenarios                                          |
| 127.15.11.21    | ns1.dnssec11.xa                                             |
| 127.15.11.22    | ns2.dnssec11.xa                                             |
| 127.15.12.0/8   | DNSSEC12 scenarios                                          |
| 127.15.12.21    | ns1.dnssec12.xa                                             |
| 127.15.12.22    | ns2.dnssec12.xa                                             |
| 127.15.13.0/8   | DNSSEC13 scenarios                                          |
| 127.15.13.21    | ns1.dnssec13.xa                                             |
| 127.15.13.22    | ns2.dnssec13.xa                                             |
| 127.15.14.0/8   | DNSSEC14 scenarios                                          |
| 127.15.14.21    | ns1.dnssec14.xa                                             |
| 127.15.14.22    | ns2.dnssec14.xa                                             |
| 127.15.15.0/8   | DNSSEC15 scenarios                                          |
| 127.15.15.21    | ns1.dnssec15.xa                                             |
| 127.15.15.22    | ns2.dnssec15.xa                                             |
| 127.15.16.0/8   | DNSSEC16 scenarios                                          |
| 127.15.16.21    | ns1.dnssec16.xa                                             |
| 127.15.16.22    | ns2.dnssec16.xa                                             |
| 127.15.16.31    | n1 server for various scenarios under dnssec16.xa           |
| 127.15.16.32    | n2 server for various scenarios under dnssec16.xa           |
| 127.15.17.0/8   | DNSSEC17 scenarios                                          |
| 127.15.17.21    | ns1.dnssec17.xa                                             |
| 127.15.17.22    | ns2.dnssec17.xa                                             |
| 127.15.18.0/8   | DNSSEC18 scenarios                                          |
| 127.15.18.21    | ns1.dnssec18.xa                                             |
| 127.15.18.22    | ns2.dnssec18.xa                                             |


### Delegation test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.16.1.0/8    | Delegation01 scenarios                                      |
| 127.16.1.21     | ns1.delegation01.xa                                         |
| 127.16.1.22     | ns2.delegation01.xa                                         |
| 127.16.2.0/8    | Delegation02 scenarios                                      |
| 127.16.2.21     | ns1.delegation02.xa                                         |
| 127.16.2.22     | ns2.delegation02.xa                                         |
| 127.16.3.0/8    | Delegation03 scenarios                                      |
| 127.16.3.21     | ns1.delegation03.xa                                         |
| 127.16.3.22     | ns2.delegation03.xa                                         |
| 127.16.4.0/8    | Delegation04 scenarios                                      |
| 127.16.4.21     | ns1.delegation04.xa                                         |
| 127.16.4.22     | ns2.delegation04.xa                                         |
| 127.16.5.0/8    | Delegation05 scenarios                                      |
| 127.16.5.21     | ns1.delegation05.xa                                         |
| 127.16.5.22     | ns2.delegation05.xa                                         |
| 127.16.6.0/8    | Delegation06 scenarios                                      |
| 127.16.6.21     | ns1.delegation06.xa                                         |
| 127.16.6.22     | ns2.delegation06.xa                                         |
| 127.16.7.0/8    | Delegation07 scenarios                                      |
| 127.16.7.21     | ns1.delegation07.xa                                         |
| 127.16.7.22     | ns2.delegation07.xa                                         |


### Nameserver test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.17.1.0/8    | Nameserver01 scenarios                                      |
| 127.17.1.21     | ns1.nameserver01.xa                                         |
| 127.17.1.22     | ns2.nameserver01.xa                                         |
| 127.17.2.0/8    | Nameserver02 scenarios                                      |
| 127.17.2.21     | ns1.nameserver02.xa                                         |
| 127.17.2.22     | ns2.nameserver02.xa                                         |
| 127.17.3.0/8    | Nameserver03 scenarios                                      |
| 127.17.3.21     | ns1.nameserver03.xa                                         |
| 127.17.3.22     | ns2.nameserver03.xa                                         |
| 127.17.4.0/8    | Nameserver04 scenarios                                      |
| 127.17.4.21     | ns1.nameserver04.xa                                         |
| 127.17.4.22     | ns2.nameserver04.xa                                         |
| 127.17.5.0/8    | Nameserver05 scenarios                                      |
| 127.17.5.21     | ns1.nameserver05.xa                                         |
| 127.17.5.22     | ns2.nameserver05.xa                                         |
| 127.17.6.0/8    | Nameserver06 scenarios                                      |
| 127.17.6.21     | ns1.nameserver06.xa                                         |
| 127.17.6.22     | ns2.nameserver06.xa                                         |
| 127.17.7.0/8    | Nameserver07 scenarios                                      |
| 127.17.7.21     | ns1.nameserver07.xa                                         |
| 127.17.7.22     | ns2.nameserver07.xa                                         |
| 127.17.8.0/8    | Nameserver08 scenarios                                      |
| 127.17.8.21     | ns1.nameserver08.xa                                         |
| 127.17.8.22     | ns2.nameserver08.xa                                         |
| 127.17.9.0/8    | Nameserver09 scenarios                                      |
| 127.17.9.21     | ns1.nameserver09.xa                                         |
| 127.17.9.22     | ns2.nameserver09.xa                                         |
| 127.17.10.0/8   | Nameserver10 scenarios                                      |
| 127.17.10.21    | ns1.nameserver10.xa                                         |
| 127.17.10.22    | ns2.nameserver10.xa                                         |
| 127.17.11.0/8   | Nameserver11 scenarios                                      |
| 127.17.11.21    | ns1.nameserver11.xa                                         |
| 127.17.11.22    | ns2.nameserver11.xa                                         |
| 127.17.12.0/8   | Nameserver12 scenarios                                      |
| 127.17.12.21    | ns1.nameserver12.xa                                         |
| 127.17.12.22    | ns2.nameserver12.xa                                         |
| 127.17.13.0/8   | Nameserver13 scenarios                                      |
| 127.17.13.21    | ns1.nameserver13.xa                                         |
| 127.17.13.22    | ns2.nameserver13.xa                                         |
| 127.17.14.0/8   | Nameserver14 scenarios                                      |
| 127.17.14.21    | ns1.nameserver14.xa                                         |
| 127.17.14.22    | ns2.nameserver14.xa                                         |
| 127.17.15.0/8   | Nameserver15 scenarios                                      |
| 127.17.15.21    | ns1.nameserver15.xa                                         |
| 127.17.15.22    | ns2.nameserver15.xa                                         |


### Syntax test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.18.1.0/8    | Syntax01 scenarios                                          |
| 127.18.1.21     | ns1.syntax01.xa                                             |
| 127.18.1.22     | ns2.syntax01.xa                                             |
| 127.18.2.0/8    | Syntax02 scenarios                                          |
| 127.18.2.21     | ns1.syntax02.xa                                             |
| 127.18.2.22     | ns2.syntax02.xa                                             |
| 127.18.3.0/8    | Syntax03 scenarios                                          |
| 127.18.3.21     | ns1.syntax03.xa                                             |
| 127.18.3.22     | ns2.syntax03.xa                                             |
| 127.18.4.0/8    | Syntax04 scenarios                                          |
| 127.18.4.21     | ns1.syntax04.xa                                             |
| 127.18.4.22     | ns2.syntax04.xa                                             |
| 127.18.5.0/8    | Syntax05 scenarios                                          |
| 127.18.5.21     | ns1.syntax05.xa                                             |
| 127.18.5.22     | ns2.syntax05.xa                                             |
| 127.18.6.0/8    | Syntax06 scenarios                                          |
| 127.18.6.21     | ns1.syntax06.xa                                             |
| 127.18.6.22     | ns2.syntax06.xa                                             |
| 127.18.7.0/8    | Syntax07 scenarios                                          |
| 127.18.7.21     | ns1.syntax07.xa                                             |
| 127.18.7.22     | ns2.syntax07.xa                                             |
| 127.18.8.0/8    | Syntax08 scenarios                                          |
| 127.18.8.21     | ns1.syntax08.xa                                             |
| 127.18.8.22     | ns2.syntax08.xa                                             |


### Zone test level address plan

| Address (range) | Used for -- range for test case or specific NS address      |
|-----------------|-------------------------------------------------------------|
| 127.19.1.0/8    | Zone01 scenarios                                            |
| 127.19.1.21     | ns1.zone01.xa                                               |
| 127.19.1.22     | ns2.zone01.xa                                               |
| 127.19.2.0/8    | Zone02 scenarios                                            |
| 127.19.2.21     | ns1.zone02.xa                                               |
| 127.19.2.22     | ns2.zone02.xa                                               |
| 127.19.3.0/8    | Zone03 scenarios                                            |
| 127.19.3.21     | ns1.zone03.xa                                               |
| 127.19.3.22     | ns2.zone03.xa                                               |
| 127.19.4.0/8    | Zone04 scenarios                                            |
| 127.19.4.21     | ns1.zone04.xa                                               |
| 127.19.4.22     | ns2.zone04.xa                                               |
| 127.19.5.0/8    | Zone05 scenarios                                            |
| 127.19.5.21     | ns1.zone05.xa                                               |
| 127.19.5.22     | ns2.zone05.xa                                               |
| 127.19.6.0/8    | Zone06 scenarios                                            |
| 127.19.6.21     | ns1.zone06.xa                                               |
| 127.19.6.22     | ns2.zone06.xa                                               |
| 127.19.7.0/8    | Zone07 scenarios                                            |
| 127.19.7.21     | ns1.zone07.xa                                               |
| 127.19.7.22     | ns2.zone07.xa                                               |
| 127.19.8.0/8    | Zone08 scenarios                                            |
| 127.19.8.21     | ns1.zone08.xa                                               |
| 127.19.8.22     | ns2.zone08.xa                                               |
| 127.19.9.0/8    | Zone09 scenarios                                            |
| 127.19.9.21     | ns1.zone09.xa                                               |
| 127.19.9.22     | ns2.zone09.xa                                               |
| 127.19.9.31     | for scenarios                                               |
| 127.19.9.32     | for scenarios                                               |
| 127.19.9.34     | testzone NS that answers without authoritative answer       |
| 127.19.9.41     | ns1.tld-email-domain-zone09.                                |
| 127.19.9.42     | for scenarios                                               |
| 127.19.9.43     | ns2.tld-email-domain-zone09.                                |
| 127.19.9.44     | for scenarios                                               |
| 127.19.10.0/8   | Zone10 scenarios                                            |
| 127.19.10.21    | ns1.zone10.xa                                               |
| 127.19.10.22    | ns2.zone10.xa                                               |

