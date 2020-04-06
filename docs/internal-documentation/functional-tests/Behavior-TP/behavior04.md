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
The Zonemaster-CLI has integrated this functionality even though
as of not we do not have different profiles to test.





