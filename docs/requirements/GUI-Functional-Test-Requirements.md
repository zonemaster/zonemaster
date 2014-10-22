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

|Req| Test requirement                           |How Verified|Status|
|:--|:-------------------------------------------|------------|------|
|GR01|Supports Swedish language|[Script](../../Zonemaster-GUI/FunctionalTests/GR01-test-swedish-language.js)| KO |
|GR02|Supports French language|[Script](../../Zonemaster-GUI/FunctionalTests/GR01-test-french-language.js)| KO |
|GR03|Supports English language |[Script](../../Zonemaster-GUI/FunctionalTests/GR01-test-english-language.js)| Ok |
|GR04|On launching the URL opens with a default simple view | [Script](../../Zonemaster-GUI/FunctionalTests/GR04-main-page.js)| OK |
|GR05|The simple view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   |            |
|GR06|The simple view should support an advanced view expanding when the checkbox is enabled|            |
|GR07|The advanced view should support the possibility of enabling or disabling IPv4 or IPv6 |            |
|GR08|The advanced view should support the possibility of choosing a profile from multiple profiles|            |
|GR09|The advanced view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   |            |
|GR10|The simple view should have a shortcut to undelegated view and FAQ|            |
|GR11|The undelegated view must inherit all of the advanced view options  |            |
|GR12|The undelegated view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.   |            |
|GR13|The undelegated view should have a text describing what undelegated means?   |            |
|GR14|The undelegated view should have a shortcut to simple view and FAQ|            |
|GR15|A Home button that sends the user to the default simple view   |            |
|GR16|All menus should be clickable in latest version of different browsers such as Firefox, IE, Chrome, Safari etc. |            |
|GR17|All buttons should be clickable in latest version of different browsers such as Firefox, IE, Chrome, Safari etc. |            |
|GR18|All fields (both simple and undelegated) should be writable |            |
|GR19|Capable to enable and disable checkboxes in advanced option |            |
|GR20|Capable to select one of the drop down menu in the advanced option|            |
|GR21|Check the existence of broken links|            |
|GR22|Check the display of appropriate content on clicking each link |            |
|GR23|Check the tool displays the client IP address  |            |
|GR24|Able to specify delegation parameters  |            |
|GR25|Able to specify to stop the test on a fatal error (For release 1.1)   |            |
|GR26|Check all the terms (such as menus, input fields) are appropriate   |            |
|GR27|Afnic and .SE logo in the main page   |            |
|GR28|Check the existence of correct title for the web site   |            |
|FR01|Identifies the preference of connected user's language |            |
|FR02|Presence of a default fallback language |            |
|FR03|Support IDN2.0 domains as input |            |
|FR04|Once a language is chosen, all other links should open in that respective language |            |
|FR05|On running a test from the simple view, the errors and warning should be highlighted in the same page |            |
|FR06|Able to provide a summarized result of the test being run (possibility in different colours for error, warning, success etc.) |            |
|FR07|Provide the possibility to see more information about encountered errors within the simple view |            |
|FR08|Provide a list of previous runs for the domain and should be paginated |            |
|FR09|The list of previous runs should contain links to the previous tests |            |
|FR10|The list of previous runs should clearly differentiate that the source of test has been normal, undelegate or batch |            |
|FR11|For delegated zones, the GUI should be able to run tests by just providing the domain nmae |            |
|FR12|For undelegated zones, the GUI should be able to run the test with atleast one name server as input |            |
|FR13|For undelegated zones, the user must be able to submit one or more DS record(s) for use with DNSSEC |            |
|FR14|Verify the GUI runs with different test profiles|            |
|FR15|Should be able to export the result in HTML format|            |
|FR16|Should be able to export the result in TEXT format|            |
|FR17|Should be able to show a progress bar with a rough estimate of the total test progress|            |
|FR18|Should be able to tell the user what specific test it is currently running near to the progress bar|            |
|FR19|Check whether the input field in the simple view is actually a valid delegated domain name |            |
|FR20|Check for illegal characters as in SQL injections and illegal double dashes etc.  |            |
|FR21|Check label length not greater than 64  |            |
|FR22|Check domain length not greater than 256  |            |
|FR23|Check whether a default "test profile"  is mandatorily selected in the advanced view |            |
|FR24|Compare the results of a well configured domain name with ZC and DC |            |
|FR25|Compare the results of different broken  domain names with ZC and DC |            |
|FR26|In the undelegated domain check whether IP fields autocomplete when the associated NS field is added |            |

