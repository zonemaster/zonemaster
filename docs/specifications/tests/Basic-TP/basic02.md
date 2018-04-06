# BASIC02: The domain must have at least one working name server

## Test case identifier
**BASIC02** The domain must have at least one working name server

## Objective

In order for the domain to work, it must have at least one name server that
can answer queries about the domain. 

## Inputs

* The label of the domain name to be tested ("child zone").
* If undelegated test, the list of name servers ("undelegated NS").
* If undelegated test, the IP addresses of the in-bailiwick undelegated 
  NS, if any ("undelegated glue IP").
* If undelegated test, the IP addresses of the out-of-bailiwick
  undelegated NS, if any ("undelegated non-glue IP").

## Ordered description of steps to be taken to execute the test case

1. Retrieve the NS records for _the child zone_ (the delegation) using
   [Method 2]. If the test is an undelegated test, use _undelegated
   NS_.
2. If the NS set is empty (no delegation), this test case fails
   ("domain name does not exist").
3. Retrieve the IP addresses (glue records) for any in-bailiwick name
   servers using [Method 4]. If the test is an undelegated test, use 
   _undelegated glue IP_.
4. Retrieve the IP addresses for any out-of-bailiwick name servers
   using recursive queries. If the test is an undelegated test, use 
   _undelegated non-glue IP_ all such name servers that have IP 
   address data and do a recursive lookup for the rest.
5. If no IP addresses could be trieved, this test case fails ("no
   IP addresses to name servers").
6. Create an NS query for the apex of _the child zone_.
7. Send the query to each available name server IP address.
8. If there is no response on any query this test case fails 
   ("no response from name servers").
9. If there is no valid response containing the NS records of 
   _the child zone_ and with the AA bit set this test case fails 
   ("error in response from name servers").

## Outcome(s)

If at least one recorded response is a valid DNS response holding 
one or more NS records for _the child zone_ and with the AA flag
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
