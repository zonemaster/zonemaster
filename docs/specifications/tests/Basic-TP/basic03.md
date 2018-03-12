## BASIC03: The _Broken but functional_ test

### Test case identifier
**BASIC03** The _Broken but functional_ test

### Objective

The case where the delegation for a domain is too broken to be fully
tested but functional enough for simple web browsing should be detected.
This test should only be performed if the BASIC02 test has failed, in
order to explain why the domain seemingly works but otherwise is
untestable.

### Inputs

The label of the domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the IP addresses from the parent delegation using [Method 4](
   ../Methods.md#method-4-obtain-glue-address-records-from-parent). For name
   server that are out-of-bailiwick, do separate recursive queries to retrieve
   the IP addresses of those names.
2. An A query for the child domain name with the label 'www' prepended is
   sent to each address from the input parameters, and the responses
   recorded.
3. If no answer from the above queries contain any A record, this test
   fails.

### Outcome(s)

If at least one recorded response contains at least one A record for the
requested name, this test succeeds.

### Special procedural requirements
This test should only be performed if the BASIC02 test has failed.

### Intercase dependencies

Only perform this test if BASIC02 fails.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
