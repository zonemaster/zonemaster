# BASIC02: The domain must have at least one working name server

## Test case identifier
**BASIC02** The domain must have at least one working name server

## Objective

In order for the domain to work, it must have at least one name server that
can answer queries about the domain. 

## Inputs

The label of the domain name to be tested (the child zone).

## Ordered description of steps to be taken to execute the test case

1. Retrieve the NS records for the child zone (the delegation) using
   [Method 2]. If the test is an undelegated test, use the name servers
   from input data. 
2. If the NS set is empty (no delegation), this test case fails
   ("domain name does not exist").
3. Retrieve the IP addresses (glue records) for all in-bailiwick name
   servers using [Method 4]. For out-of-bailiwick name servers, do 
   recursive queries to retrieve the IP addresses.
4. If no IP addresses could be trieved, this test case fails ("no
   IP addresses to name servers").
5. Create an NS query for the apex of the child zone.
6. Send the query to each available name server IP address.
7. If there is no response on any query this test case fails 
   ("no response from name servers").
8. If there is no valid response containing the NS records of the
   child zone and with the AA bit set this test case fails ("error
   in response from name servers").

## Outcome(s)

If at least one recorded response is a valid DNS response holding 
one or more NS records for the child domain and with the AA flag
set, this test succeeds.

## Special procedural requirements

If this test fails, it's impossible to continue and the whole testing
process (except for the BASIC03 test) is aborted.

## Intercase dependencies

None.


[Method 2]: ../Methods.md#method-2-obtain-glue-name-records-from-parent
[Method 4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent


-------

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
