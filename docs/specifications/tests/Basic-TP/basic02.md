## BASIC02: The domain must have at least one working name server

### Test case identifier
**BASIC02** The domain must have at least one working name server

### Objective

In order for the domain to work, it must have at least one name server that
can answer queries about the domain. 

### Inputs

The label of the domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the IP addresses from the parent delegation using [Method 4]
   (../Methods.md##method-4-obtain-glue-address-records-from-parent). For name
   server that are out-of-bailiwick, do separate recursive queries to retrieve
   the IP addresses of those names.
2. An NS query for the domain name should be sent to each address.
3. If there are no valid DNS packets containing the NS answer from any
   of the name servers, this test case fails.

### Outcome(s)

If at least one recorded response is a DNS response holding one or more NS
records for the child domain, this test succeeds.

### Special procedural requirements

If this test fails, it's impossible to continue and the whole testing
process (except for the BASIC03 test) is aborted.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
