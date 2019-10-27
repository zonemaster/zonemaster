GUI - Functional Test requirements
======================================

Objective
----------
The objective of this document is to run functional tests for the Web GUI.

Scope
------
The scope of the testing will limited to the functional testing (End-to-End testing) of the GUI. 
Security and Performance testing are not included.

[![Build Status](https://travis-ci.org/zonemaster/zonemaster-gui.svg?branch=master)](https://travis-ci.org/zonemaster/zonemaster-gui)

|Req| Test requirement                           |How Verified|
|:--|:-------------------------------------------|------------|
|FR01|A Home button that sends the user to the default simple view |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR11.e2e-spec.ts)|
|FR02|All menus should be clickable in latest version of different browsers such as Firefox, IE, Chrome, Safari etc. |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR12.e2e-spec.ts)|
|FR03|All appropriate fields should be writable |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR13.e2e-spec.ts)|
|FR04|Valid title for the Web interface|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR15.e2e-spec.ts)|
|FR05|Supports Swedish language|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR01.e2e-spec.ts)| 
|FR06|Supports French language|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR02.e2e-spec.ts)| 
|FR07|Supports English language |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR03.e2e-spec.ts)| 
|FR08|Presence of a default fallback language - English |Manually|
|FR09|Once a language is chosen, all other links should open in that respective language |Manually|
|FR10|Te GUI should be able to run tests by just providing the domain name |Manually|
|FR11|On launching the URL opens with a default simple view | [Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR04.e2e-spec.ts)| 
|FR12|The simple view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   | [Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR05.e2e-spec.ts) |
|FR13|Support IDN2.0 domains as input |Manually|
|FR14|Check whether the input field in the simple view is actually a valid delegated domain name |Manually|
|FR15|Check for illegal characters as in SQL injections and illegal double dashes etc.  |Tested by Security Audit|
|FR16|Check label length not greater than 64  |Manually|
|FR17|Check domain length not greater than 256  |Manually|
|FR18|The simple view should support an advanced view expanding when the checkbox is enabled|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR06.e2e-spec.ts)|
|FR19|The advanced view should support the possibility of enabling or disabling IPv4 or IPv6 |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR07.e2e-spec.ts)|
|FR20|The advanced view should support the possibility of choosing a profile from multiple profiles|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR08.e2e-spec.ts)|            
|FR21|The advanced view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR09.e2e-spec.ts)|
|FR22|The advanced view should have a text describing what undelegated means? |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR10.e2e-spec.ts)|
|FR23|Able to specify delegation parameters  |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/FR14.e2e-spec.ts)|
|FR24|The GUI should be able to run the test with at least one name server as input |Manually|
|FR25|The user must be able to submit one or more DS record(s) for use with DNSSEC | Manually |
|FR26|On running a test from the simple view, the errors and warning should be highlighted in the same page |Manually|
|FR27|Able to provide a summarized result of the test being run (possibility in different colours for error, warning, success etc.) |Manually|
|FR28|Provide the possibility to see more information about encountered errors within the simple view |Manually|
|FR29|Provide a list of previous runs for the domain and should be paginated |Manually|
|FR30|The list of previous runs should contain links to the previous tests | Manually |
|FR31|The list of previous runs should clearly differentiate that the source of test has been normal, or undelegated |Manually|
|FR32|Should be able to export the result in HTML format|Manually|
|FR33|Should be able to export the result in CSV format|Manually|
|FR34|Should be able to show a progress bar with a rough estimate of the total test progress|Manually|


