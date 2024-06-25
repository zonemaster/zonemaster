Existing Functionalities
=========================

|  *Input*                                   | *Explanation*                                 |
|:-------------------------------------------|:--------------------------------------------|
|Able to disable testing certain  protocols at run time|no IPv4, IPv6, UDP, TCP etc.|
|Able to modify the test profile |Able to modify the test profile easily  without modifying the code. Such as possibility to specify what tests to be run (or) not to run|
|Able to specify delegation parameters | For example to test a hypothetical zone delegation from its parent zone|
|Able to have certain defaults in initial config file to minimize configuration time for new users|  |
|Possibility to use non default configuration file for specific runs|  |
|Able to test non delegated domain| |
|Multiple input interfaces | Should be able to be used by normal users, DNS professionals and by an API |


| *Output*                                   | *Explanation*                               |
|:-------------------------------------------|:--------------------------------------------|
|Different output format for the results         | For example;  HTML, XML etc. |
|Multiple output results                         | Comprehensible for normal user as well as DNS professionals |
|Possibility to output only a summary of results |  |
|Multiple language support                       |Such as English, French and Swedish |
|Different Levels of verbosity                   | Not only on/off with decent debugging possibility |
|Sort output by errors or hosts                  |  |
|Output a list of the tests we can run           |  |
|Error results clarity                           | Return Codes |
	
| Others                                     | Explanation                                 |
|:-------------------------------------------|:--------------------------------------------|
|Modular                                 | * Functionality of the tool could be enhanced by adding more modules preforming additional tests 
|                                        | * Reuse of functions from one module to another 
|                                        |  * Each module could have a list of dependencies on other modules. A module should be able to process the results of other modules.|
|Able to Cache the results                                              | Helps in reducing resource consumption, thus improving performance|
|Timestamp on the test being run                                        | As done by dnsCheck now |
|Modules should be able to  report tests as they are being run          | As done by dnsCheck using the "--raw"-flag|
|Separate running of tests, evaluation of results and preparing reports |   |
|Ability to store results in a database                                 |   |
|Performance - optimization of network as well as system resources when compared to dnscheck and ZoneCheck | |
|Maintaining Bug report |  |
|Web User Interface |  |
|DNS Packet Serialization |  |
| DNSSEC tests                                                          |   |
|Statistics on network performance, RTT: min, max, stddev, avg, per protocol and #queries sent per name server||


