## BEHAVIOR04: Able to test a particular profile from the CLI using an option which selects a particular test profile

### Test case identifier

**BEHAVIOR04:** Able to test a particular profile from the CLI using an option
which selects a particular test profile

### Objective 
Zonecheck CLI has an option '-P' which allows to select a particular profile to
test. For example, "zonecheck -P Afnic iis.se" tests the zone with the tests
defined in afnic.profile
(https://github.com/mat813/ZoneCheck/blob/master/etc/zonecheck/afnic.profile). 

### Results

The WEB-GUI seems to have taken into account of this functionality even though
as of not we do not have different profiles to test.

This issues has been moved to post release 1.0

Further information on the reason to move to post release 1.0 can be found here :
https://github.com/dotse/zonemaster/issues/167.





