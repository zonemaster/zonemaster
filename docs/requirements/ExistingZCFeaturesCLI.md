Existing ZC CLI Features
========================

ZoneCheck CLI Features which could be included in "Zonemaster" 

Link to example : http://www.zonecheck.fr/doc/man/zonecheck.cli.shtml


Input:
------- 

1. Possible to run with a user-provided locale (language). By default, ZC
CLI takes the OS language settings  

2. Possible to run with a user-provided policy (Policy in ZC means the
option of running different types of tests). A default is used if none is
provided.  

3. Possible to run with a user-provided configuration file (this
means the default configuration - such as the transport protocol used, the
type of output, type of error etc.). A default is used if none is provided.

4. The CLI outputs a help message if the user input does not validate. Also,
capable of providing a short description of different options available on
using --help or -h 

5. Pops up an error when more than one domain is provided as input

6. Possible to provide the list of name servers and IP addresses for the
domain. Useful when testing un delegated domains.  

7. Possible to display the version and exit.

8. Possible to modify the behavior as a result of different types of
errors. For example, stop testing on the first fata error or consider all errors as warnings.  

9. Possible to limit the test to perform to the categories specified
by a category list.

10. Possible to specify the test to perform. In case of failing to pass the
test is considered as fatal.  

11. Possible to list all the test available.  

12. Possible to have a brief description of the tests.

13. Possible to provide as input the resolver for finding infomration about
the zone. A default resolver is used if none is provided. 

14. Possible to precise the Trust Anchor of the zone to be tested by giving
the DNSKEY or the DS and the algorithm used to hash the key.  

15. Possible to test only specific transport options such as udp, tcp. If
none is provided, the default is used.  

16. Possible to test only for IPv4 or IPv6 connectivity. If none is provided
the default is used.

Output: 
------- 

1. Possible to select the debugging messages to print or activate debugging
code.  A default is used if none is provided. 

2. Has the possibility to display extra output information or remove
available output information.  

3. Has the capability to limit the output options by the type of errors, by
hosts etc.  

4. Possible to output in different formats such as xml, html etc.  code.  A
default is used if none is provided.  

5. Possible to display only the relevant messages in a compact format. 
