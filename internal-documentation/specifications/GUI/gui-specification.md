Web User interface
==================

The web framework must separate code from web page design. If possible, the system should be able to replace the web page design easily by using another set of web page templates for the design. It should be possible to use the web interface without the need for enabling javascript or cookies. The web interface should echo the web clients IP address somewhere, and be very specific in what "zonemaster" version used to generated the test results that the client is looking at.

No 3rd party resources should be loaded by the web client, all resources should be hosted on the same domain address as the rest of the web interface (this also makes it transport protocol independent).

This specification has been created based on the requirements found in this document: [Combined-GUI-Requirements](../../requirements/GUI-Combined-Requirements.txt)

**Functionality on the first page the user encounters are the following:**
* Language selection (defined languages in v1.0 must be at least English, French and Swedish)
* Domain name input (with "test now" button)
* Help text (information)
* The option to use an advanced test view
* Shortcut to undelegated test view
* Shortcut to FAQ
* A "home" button that sends the user to the first page

*Below: mockup of the simplistic, first view. Picture 1.*
![Image](./dnscheck___Home.png?raw=true)

**Advanced options:**
* IPv4 only
* IPv6 only
* "Profile" selection (pre-defined set of tests for the engine to run)

*Below: mockup of simplistic, first view with advanced options out. Picture 2.*
![Image](./dnscheck___Home-Advanced.png?raw=true)

**Undelegated options:**
* The options for an undelegated test inherits all of the advanced options.
* An undelegated test must also require one or more name servers to run the test with.
* The user must be able to submit one or more DS record(s) for use with DNSSEC.
* The user must be able to pre-fill the name server data (NS and DS) with data from
current parent name servers as pre-configured undelegated name servers.
* When the user fills in name server names the GUI should resolve all present A- and
AAAA-records and pre-fill this data for usability.
* Undelegated view MUST have text that describes what "undelegated" means ("no data
from parent, user must submit this")

*Below: mockup of undelegated view. Picture 3.*
![Image](./dnscheck___undelegated.png?raw=true)

**Functionality:**
* When the user have selected a language, this choice should be sticky, and the
web interface should only be displayed in the chosen language.
* Initial language setting must come from the web browser preference.
* The default web language must be configurable.
* In order to avoid overloading of the test engine, the new and ongoing tests must be cached
for five minutes (configurable length of time).
* If a new test is initiated on the same domain (or exact same data used with undelegated
tests) within the five minute interval above, the user interface will wait for the ongoing
test to be finished, or display the last test results.
* Each test result should have a unique (and short) URL for easy sharing.
* While waiting for a test to be finished, some sort of progress indicator must be shown -
when a test level starts running it could output information on what is being done. Preferably these
indicators should be on the same page as the "Test now".
* It should be possible to configure the number of concurrent tests being run as to not overload the 
engine/machine/network.
* Special care should be taken for undelegated tests so that these do not fill up all available
testing "slots" as configured above. One example solution could be to have "dedicated" slots for
delegated runs vs undelegated runs, like 20x delegated and 20x undelegated concurrent tests.

**Input:**
* The domain name input must be filtered and validated according the current DNS rules.
* The hostnames and IP adresses must be filtered and validated according the current
DNS and IP addressing standards.
* If the domain name is an IDN name, the input form converts the name to a punycode
DNS name for testing.
* In the advanced view, additional NS, IP and DS records should be possible by clicking
i.e. a "+"-button or similar, up to a maximum number of fields (If possible have this configurable on the serverside, else 30 maximum).

**Output:**
* When first executing a test, the output will be the simplified output for the basic user.
* The simplified output should be a summary of the test, and any warnings or errors
should be indicated using colors.
* The basic output can be expanded to show the warnings and errors.
* The basic output can be expanded to the complete log for the advanced user.
* The output can be exported in text or HTML format (or even the raw JSON API data itself)
* The exported output could also be retrieved using an extra parameter to the unique
URL for the specific test result (for example something like: &output=json?).
* Error messages should be highlighted in the output.
* Alongside with the test output, there should a paginated list of previous
test results with links to the full test results of the results - separating normal domain
tests from undelegated tests.
* Preferably results from a test should be on the same page as the progressbar and the "Test now".

*Below: mockup of normal results view. Picture 4.*
![Image](./dnscheck___results.png?raw=true)

*Below: mockup of advanced results view. Picture 5.*
![Image](./dnscheck___results-advanced.png?raw=true)

*Below: mockup of results export function. Picture 6.*
![Image](./dnscheck___results-export.png?raw=true)

**Security:**
* The server side implementation should be secured with i.e. chroot.
* All user input data must be validated and filtered.

**Nice to have:**
* View historic test results without initiating a new test for a domain.
* Being able to show advanced results for specific parts of tests in the Basic view, for example when user clicks or hovers over a test level (Delegation/DNSSEC etcetera).

**Future:**
* Add a bonus system, stars for domains with IPv6 and DNSSEC, and other features.
