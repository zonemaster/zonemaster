*This is the merged requirements from the respective CLI's of 
ZoneCheck and DNSCheck.*

**Usability:**
- [1.1] The output from the CLI MUST provide timestamps for each log line, 
with an option to remove or add the timestamps in the output.
-  [1.2] The output from the CLI MUST be able to provide information about
 what test level and test case generated a certain log entry with an 
 option to remove or add the information in the output.
- [1.3] The CLI MUST be able to report the version used to run the test. 
 Optional to report any version of each individual test case.
- [1.4] The CLI MUST be able to stop testing and return at a command line 
 configurable error level (not only CRITICAL)
- [1.5] The CLI MUST be able to run a test over IPv4 or IPv6-only with a 
provided flag (read: disable protocol at runtime).

**Input:**
- [2.1] The CLI MUST be able to output a help text, either explicitly or
 if user input does not validate.
- [2.2] The CLI SHOULD have a filter parameter to be able to hide log 
 messages below a certain error level.
- [2.3] The CLI MUST be able to run with a user-provided configuration 
(what to test). A default SHOULD be used if none is provided.
- [2.4] The CLI MUST be able to run with a user-provided policy 
(error levels). A default SHOULD be used if none is provided.
- [2.5] The CLI MUST be able to run with a user-provided locale (language).
A default SHOULD be used if none is provided.
- [2.6] The user MUST be able to specify name servers and corresponding 
IP-adresses as input for undelegated test purposes.
- [2.8] The user MUST be able to specify DS-data as input to be able to 
test DNSSEC fully even for undelegated domains.
- [2.9] The user MUST specify no more than one domain to test.
- [2.10] The CLI MUST be able to simply report its' version and exit with
a provided flag.
- [2.11] The CLI MUST be able to test all available test cases within one
group, it MAY also work per unique test case (--test=zone or --test=zone03). 

**Output:**
- [3.1] The CLI MUST be able to provide an output log that is machine 
parseable and this MAY be disabled or enabled with a provided parameter.
- [3.2] The CLI MUST be able to provide output that is human readable and
 this SHOULD be the default mode although the default MAY be configurable.
- [3.3] The output from the CLI MUST have several levels of verbosity for
 DNS debugging purposes, for example additional messages and module 
 version reports at a low level up to raw DNS packets and dependancy
 modules' versions at higher levels.
- [3.4] The CLI MUST have a flag to list all available tests and a brief
 text on what these tests do. The CLI MAY also have more detailed
 information about each test reachable elsewhere from the CLI.

**Optional (or for future uses):**
- [4.1] Boost policy error level WARNING to ERROR with provided flag.
- [4.2] Possible to activate tool debugging code.
- [4.3] Possibility for the CLI to limit output (filter) by type of errors
  or ignore specific hosts.
