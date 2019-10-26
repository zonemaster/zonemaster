GUI - Functional Test requirements
======================================

Objective
----------
The objective of this document is to run functional tests for the Web GUI.

Scope
------
The scope of the testing will limited to the follows:
   * GUI testing : Test if the objects in the interface are displayed exactly
   how they are supposed to display
   * Functionality testing : Validation of actual functionality of controls
   after giving input to certain fields in the application
 
Security and Performance testing are not included.

|Req| Test requirement                           |How Verified|
|:--|:-------------------------------------------|------------|
|GR01|Supports Swedish language|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR01.e2e-spec.ts)| 
|GR02|Supports French language|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR02.e2e-spec.ts)| 
|GR03|Supports English language |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR03.e2e-spec.ts)| 
|GR04|On launching the URL opens with a default simple view | [Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR04.e2e-spec.ts)| 
|GR05|The simple view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   | [Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR05.e2e-spec.ts) |
|GR06|The simple view should support an advanced view expanding when the checkbox is enabled|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR06.e2e-spec.ts)|
|GR07|The advanced view should support the possibility of enabling or disabling IPv4 or IPv6 |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR07.e2e-spec.ts)|
|GR08|The advanced view should support the possibility of choosing a profile from multiple profiles|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR08.e2e-spec.ts)|            
|GR09|The advanced view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR09.e2e-spec.ts)|
|GR10|The advanced view should have a text describing what undelegated means? |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR10.e2e-spec.ts)|
|GR11|A Home button that sends the user to the default simple view |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR11.e2e-spec.ts)|
|GR12|All menus should be clickable in latest version of different browsers such as Firefox, IE, Chrome, Safari etc. |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR12.e2e-spec.ts)|
|GR13|All appropriate fields should be writable |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR13.e2e-spec.ts)|
|GR14|Able to specify delegation parameters  |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR14.e2e-spec.ts)|
|GR15|Valid title for the Web interface|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/FunctionalTests/GR15.e2e-spec.ts)|

|FR02|Presence of a default fallback language |Manually|OK|
|FR03|Support IDN2.0 domains as input |Manually|OK|
|FR04|Once a language is chosen, all other links should open in that respective language |Manually|KO|
|FR05|On running a test from the simple view, the errors and warning should be highlighted in the same page |Manually|OK|
|FR06|Able to provide a summarized result of the test being run (possibility in different colours for error, warning, success etc.) |Manually|OK|
|FR07|Provide the possibility to see more information about encountered errors within the simple view |Manually|OK|
|FR08|Provide a list of previous runs for the domain and should be paginated |Manually|KO|
|FR09|The list of previous runs should contain links to the previous tests | Manually |OK|
|FR10|The list of previous runs should clearly differentiate that the source of test has been normal, or undelegated |Manually|KO|
|FR11|For delegated zones, the GUI should be able to run tests by just providing the domain name |Manually|OK|
|FR12|For undelegated zones, the GUI should be able to run the test with atleast one name server as input |Manually|OK|
|FR13|For undelegated zones, the user must be able to submit one or more DS record(s) for use with DNSSEC | Manually |OK |
|FR14|Verify the GUI runs with different test profiles|Manually| KO - No test profiles created (Issue <https://github.com/zonemaster/zonemaster/issues/167>)|
|FR15|Should be able to export the result in HTML format|Manually|KO|
|FR16|Should be able to export the result in TEXT format|Manually|OK|
|FR17|Should be able to show a progress bar with a rough estimate of the total test progress|Manually|OK|
|FR18|Should be able to tell the user what specific test it is currently running near to the progress bar|Manually|KO|
|FR19|Check whether the input field in the simple view is actually a valid delegated domain name |Manually|OK|
|FR20|Check for illegal characters as in SQL injections and illegal double dashes etc.  |Tested by Security Audit|OK|
|FR21|Check label length not greater than 64  |Manually|OK|
|FR22|Check domain length not greater than 256  |Manually|OK|
|FR23|Check whether a default "test profile"  is mandatorily selected in the advanced view |Manually|KO|
|FR24|Compare the results of a well configured domain name with ZC and DC |Inconsistent for iis.se|KO|  
|FR25|Compare the results of different broken  domain names with ZC and DC |Manually with some broken domains|OK|
|FR26|In the undelegated domain check whether IP fields autocomplete when the associated NS field is added |Manually|OK|

