# Features


  * Able to test from multiple nodes on the network *(Able to launch Zonemaster
 from  multiple points in the network for the same domain and have a summarized result)*
  * Zonemaster should have integrated all the tests cases required in IANA
profile *(IANA test profile is here: "https://www.iana.org/help/nameserver-requirements")*
  * The Zonemaster GUI should be ergonomically adapted to a mobile device *(Able
to easily test a domain, view the results, history etc. from a mobile device)*
  * As part of the zonemaster project would you prefere to have a test suite of
deliberately broken zones *(Similar to "http://dnssec-tools.org/testzone/index.html")*
  * Able to conduct test for a batch of domains *(Would you prefer to provde as
input a set of domains and have a summarized result)*
	* From the web interface
	* From the CLI
	* From an API
  * Able to test with different profiles both in GUI as well as in the CLI *(Ability 
for an user to creates his/her own profile (such as "de.profile" and
"afnic.profile" here: https://github.com/mat813/ZoneCheck/tree/master/etc/zonecheck)
  * Able to test with different policies for both GUI and CLI *(Ability for an
user to define his/her policy set. Policy here defines classification of issues
from the zonemaster result as Error/warning/Notice etc.)* 
  * Alert if the domain does not use DNSSEC (Would you like Zonemaster to
disseminate the use of DNSSEC)
  * Add EDCSA support when OpenSSL is compiled without ECDSA *(Explanation here
: "https://github.com/dotse/zonemaster-engine/issues/16")*
  * Appropriate LDNS library for Zonemaster to remove dependency on LDNS
*(Explanation here : "https://github.com/dotse/zonemaster-engine/issues/26")*
  * Able to export results other than in text format such as HTML, XML etc from
GUI as you see here with Zonecheck *("http://www.zonecheck.fr/demo"
=>Options=>Output)*
  * Preloading history of previous tests *(As soon as the user starts a test
with a domain, previous history should be preloaded if available)*
