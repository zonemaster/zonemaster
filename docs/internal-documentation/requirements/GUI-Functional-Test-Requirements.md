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
|FR01|A Home button that sends the user to the default simple view |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR01.e2e-spec.ts)|
|FR02|All menus should be clickable in latest version of different browsers such as Firefox, IE, Chrome, Safari etc. |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR02.e2e-spec.ts)|
|FR03|All appropriate fields should be writable |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR03.e2e-spec.ts)|
|FR04|Valid title for the Web interface|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR04.e2e-spec.ts)|
|FR05|Supports Swedish language|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR05.e2e-spec.ts)| 
|FR06|Supports French language|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR06.e2e-spec.ts)| 
|FR07|Supports English language |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR07.e2e-spec.ts)| 
|FR08|Presence of a default fallback language - English |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR08.e2e-spec.ts)
|FR09|Once a language is chosen, all other links should open in that respective language |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR09.e2e-spec.ts)
|FR10|On launching the URL opens with a default simple view | [Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR10.e2e-spec.ts)| 
|FR11|The simple view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc. | [Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR05.e2e-spec.ts) |
|FR12|The simple view should support an advanced view expanding when the checkbox is enabled|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR12.e2e-spec.ts)|
|FR13|The advanced view should support the possibility of enabling or disabling IPv4 or IPv6 |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR13.e2e-spec.ts)|
|FR14|The advanced view should support the possibility of choosing a profile from multiple profiles|[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR14.e2e-spec.ts)|            
|FR15|The advanced view should look the same in latest version of different browsers such as Firefox, Internet Explorer, Chrome, Safari etc.  |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR15.e2e-spec.ts)|
|FR16|The advanced view should have a text describing what undelegated means? |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR16.e2e-spec.ts)|
|FR17|Able to specify delegation parameters  |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR17.e2e-spec.ts)|
|FR18|The GUI should be able to run tests by just providing the domain name |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR18.e2e-spec.ts)|
|FR19|The GUI should be able to run the test with at least one name server as input |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR19.e2e-spec.ts)|
|FR20|The user must be able to submit one or more DS record(s) for use with DNSSEC |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR20.e2e-spec.ts)|
|FR21|Able to provide a summarized result of the test being run (possibility in different colours for error, warning, success etc.) |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR21.e2e-spec.ts)|
|FR22|Provide the possibility to see more information about encountered errors within the simple view  |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR22.e2e-spec.ts)|
|FR23|Provide a list of previous runs for the domain and should be paginated |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR23.e2e-spec.ts)|
|FR24|The list of previous runs should contain links to the previous tests |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR24.e2e-spec.ts)|
|FR25|Should be able to export the result in multiple formats (HTML, CSV, JSON, TEXT) |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR26.e2e-spec.ts)|
|FR26|Should be able to show a progress bar with a rough estimate of the total test progress |[Script](https://github.com/zonemaster/zonemaster-gui/blob/master/e2e/FR26.e2e-spec.ts)|


