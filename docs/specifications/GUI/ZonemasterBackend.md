# Introduction

This document describes the API of the Zonemaster Backend.

The API is available in the JSON-RPC (version 2.0) format.

Many libraries in about all languages are available to communicate using
the JSON-RPC protocol.

## Web GUI API

### JSON-RPC Call 1: version\_info

```
Request:
{
"params" : "",
"jsonrpc" : "2.0",
"id" : 140715758026879,
"method" : "**version\_info**"
}

```
-   params : Empty
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140715758026879,
"result" : "Zonemaster 0.0.3, Engine v0.01"
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: the version string

### JSON-RPC Call 2: get\_ns\_ips

```
Request:
{
"params" : "ns1.nic.fr",
"jsonrpc" : "2.0",
"id" : 140715758069409,
"method" : "**get\_ns\_ips**"
}
```
-   params : the name of the server whose IPs need to be resolved
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response 
{
"jsonrpc" : "2.0",
"id" : 140715758069409,
"result" : [
{
"ns1.nic.fr" : "192.134.4.1"
},
{
"ns1.nic.fr" : "2001:660:3003:2:0:0:4:1"
}
]
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: a list of one or two IP addresses (if 2 one is for IPv4 the
    other for IPv6)

### *JSON-RPC Call 3*: get\_data\_from\_parent\_zone

```
Request:
{
"params" : "nic.fr",
"jsonrpc" : "2.0",
"id" : 140715758074762,
"method" : "**get\_data\_from\_parent\_zone**"
}
```
-   params : the domain name currently being tested
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140715758074762,
"result" : [
{
"ns3.nic.fr" : "192.134.0.49"
},

{
"ns3.nic.fr" : "2001:660:3006:1:0:0:1:1"
},
{
"ns6.ext.nic.fr" : "130.59.138.49"
},
{
"ns6.ext.nic.fr" : "2001:620:0:1b:5054:ff:fe74:8780"
},
{
"ns1.ext.nic.fr" : "193.51.208.13"
},
{
"ns1.nic.fr" : "192.134.4.1"
},
{
"ns1.nic.fr" : "2001:660:3003:2:0:0:4:1"
},
{
"ns2.nic.fr" : "192.93.0.4"
},
{
"ns2.nic.fr" : "2001:660:3005:1:0:0:1:2"
},
{
"ns4.ext.nic.fr" : "193.0.9.4"
},
{
"ns4.ext.nic.fr" : "2001:67c:e0:0:0:0:0:4"
}
]
}
```
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: a list of several { nameserver =\> IP\_adress } pairs.

### *JSON-RPC Call 3*: get\_data\_from\_parent\_zone\_1

```
Request:
{
"params" : "nic.fr",
"jsonrpc" : "2.0",
"id" : 140715758074762,
"method" : "**get\_data\_from\_parent\_zone\_1**"
}
```

-   params : the domain name currently being tested
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
'ds\_list' =\> [
{
'sha1' =\> '08f9333b701f18a2bde95b746c473eddc57dfd11'
},
{
'sha1' =\> 'fe013e264924ceb2ad9390b3ea245da0aa8a4127'
},
{
'sha1' =\> 'ef5df1839597b6d749402ae985a85494c091f502'
},
{
'sha1' =\> '9d5e216f20b6cc3eca4d2391666137afc3f131cc'
}
],
'ns\_list' =\> [
{
'ns1.ext.nic.fr' =\> '193.51.208.13'
},
{
'ns6.ext.nic.fr' =\> '130.59.138.49'
},
{
'ns6.ext.nic.fr' =\> '2001:620:0:1b:5054:ff:fe74:8780'
},
{
'ns2.nic.fr' =\> '192.93.0.4'
},
{
'ns2.nic.fr' =\> '2001:660:3005:1:0:0:1:2'
},
{
'ns3.nic.fr' =\> '192.134.0.49'
},
{
'ns3.nic.fr' =\> '2001:660:3006:1:0:0:1:1'
},
{
'ns1.nic.fr' =\> '192.134.4.1'
},
{
'ns1.nic.fr' =\> '2001:660:3003:2:0:0:4:1'
},
{
'ns4.ext.nic.fr' =\> '193.0.9.4'
},
{
'ns4.ext.nic.fr' =\> '2001:67c:e0:0:0:0:0:4'
}
]
};
```
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result:
    -   a list of several { nameserver =\> IP\_adress } pairs in the
        ns\_list parameter
    -   a list of several { ds\_id =\> digest} pairs in the ds\_list
        parameter

### *JSON-RPC Call 4*: validate\_domain\_syntax

```
Request:
{
"params" : "nic.fr",
"jsonrpc" : "2.0",
"id" : 140717126101894,
"method" : "**validate\_domain\_syntax**"
}
```
-   params : the domain name currently being tested
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140717126101894,
"result" : "syntax\_ok"
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: either “syntax\_ok” or “syntax\_not\_ok”.

### *JSON-RPC Call 5*: start\_domain\_test

```
Request:
{
"params" : {
"test\_profile" : "test\_profile\_1",
"ipv6" : 1,
"ipv4" : 1,
"client\_id" : "Zonemaster CGI/Dancer/node.js",
"nameservers" : [
{
"ns1.nic.fr" : ""
},
{
"empty" : "192.134.4.1"
},
{
"ns1.nic.fr" : "192.134.4.1"
}
],
"domain" : "afnic-3.fr",
"ds\_digest\_pairs" : [
{
"ds1" : "digest1"
},
{
"ds2" : "digest2"
}
],
"advanced\_options" : 1,
"client\_version" : "1.0"
},
"jsonrpc" : "2.0",
"id" : 140723281305680,
"method" : "**start\_domain\_test**"
}
```
-   params :
    -   client\_id =\> 'Zonemaster CGI/Dancer/node.js',
        -   \# free string
    -   client\_version =\> '1.0',
        -   \# free version like string
    -   domain =\> 'afnic-2.fr',
        -   \# content of the domain text field
    -   advanced\_options =\> 1,
        -   \# 0 or 1, is the advanced options checkbox checked
    -   ipv4 =\> 1,
        -   \# 0 or 1, is the ipv4 checkbox checked
    -   ipv6 =\> 1,
        -   \# 0 or 1, is the ipv6 checkbox checked
    -   test\_profile =\> 'test\_profile\_1',
        -   \# the id if the Test profile listbox
    -   nameservers =\> [
        -   \# list of the namaserves up to 32
            -   {'ns1.nic.fr' =\> ''},
                -   \# key values pairs representing nameserver =\>
                    namesterver\_ip
            -   {'empty' =\> '192.134.4.1'},
                -   \#if the domain name is not input the string “empty”
                    is used as the key
            -   {'ns1.nic.fr' =\> '192.134.4.1'},
    -   ds\_digest\_pairs =\> [
        -   \# list of DS/Digest pairs up to 32
            -   {'ds1' =\> 'digest1'},
                -   \# key values pairs representing ds =\> digest
            -   {'ds2' =\> 'digest2'},

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140723281305680,
"result" : 2
}
```
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: the id of the test\_result (this id will be used in the
    other APIs related to the same test result).

### *JSON-RPC Call 6*: test\_progress

```
Request:
{
"params" : 2,
"jsonrpc" : "2.0",
"id" : 140723345184845,
"method" : "**test\_progress**"
}
```

-   params : the id of the test whose progress indicator has to be
    determined.
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140723345184845,
"result" : 100
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: the % of completion of the test from 0% to 100%

### *JSON-RPC Call 7*: get\_test\_results

```
Request:
{
"params" : {
"language" : "en",
"id" : 4
},
"jsonrpc" : "2.0",
"id" : 140732400697028,
"method" : "get\_test\_results"
}
```

-   params :
    -   id: the id of the test whose results we want to get.
    -   language: the language of the user interface
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140723510525000,
"result" : {
"params" : {
.
.
TEST PARAMS (See *JSON-RPC Call 5*: start\_domain\_test)
.
.
},
"id" : 2,
"creation\_time" : "2014-08-05 12:00:13.401442",
"results" : [
{
'module' =\> 'DELEGATION',
'message' =\> 'Messsage for DELEGATION/NAMES\_MATCH in the language:fr'
'level' =\> 'NOTICE',
},
.
.
LIST OF TEST RESULTS
.
{
'ns' =\> 'ns1.nic.fr',
'module' =\> 'NAMESERVER',
'message' =\> 'Messsage for NAMESERVER/AXFR\_FAILURE in the language:fr'
'level' =\> 'NOTICE',
},
.
.
LIST OF TEST RESULTS
.
.
]
}
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: Contains:
    -   id: The id of the test whose results are returnes
    -   creation\_time: The exact time the test was created
    -   params: The parameters used to run this test (See *JSON-RPC Call
        5*: start\_domain\_test)
    -   results: A list of results.

## Description of the results:

The individual results are of the form

```
{
'module' =\> 'DELEGATION',
'message' =\> 'Messsage for DELEGATION/NAMES\_MATCH in the language:fr'
'level' =\> 'NOTICE',
},
Or
{
'ns' =\> 'ns1.nic.fr',
'module' =\> 'NAMESERVER',
'message' =\> 'Messsage for NAMESERVER/AXFR\_FAILURE in the
language:fr',
'level' =\> 'NOTICE',
},
```

The **module** serves to group the tests by categories.

The **ns** attribute serves to show the name servers for the category
NAMESERVER.

The **message** is the message to show.

The **level** is the level of criticity of the message

-   NOTICE, INFO are considered OK -\> green
-   WARNING as warning -\> orange
-   ERROR as error -\> red

### *JSON-RPC Call 8*: get\_test\_history

```
Request:
{
"params" : {
"frontend\_params" : {
"test\_profile" : "test\_profile\_1",
"ipv6" : 1,
"ipv4" : 1,
"client\_id" : "Zonemaster CGI/Dancer/node.js",
"nameservers" : [
{
"ns1.nic.fr" : ""
},
{
"empty" : "192.134.4.1"
},
{
"ns1.nic.fr" : "192.134.4.1"
}
],
"domain" : "afnic-2.fr",
"ds\_digest\_pairs" : [
{
"ds1" : "digest1"
},
{
"ds2" : "digest2"
}
],
"advanced\_options" : 1,
"client\_version" : "1.0"
},
"limit" : 10,
"offset" : 0
},
"jsonrpc" : "2.0",
"id" : 140726285079520,
"method" : "**get\_test\_history**"
}
```

-   params : an object containing the following parameters
    -   frontend\_params: the usual structure containing all the
        parameters of the interface
    -   offset: the start of pagination
    -   limit: number of items to return
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140743003648550,
"result" : [
{
"advanced\_options" : "1",
"id" : 3,
"creation\_time" : "2014-08-05 19:41:14.522656"
},
{
"advanced\_options" : "1",
"id" : 1,
"creation\_time" : "2014-08-05 11:48:18.542216"
}
]
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: an ordered (starting by the most recent test) list of tests
    with
    -   id: the id to use to retrieve the test result
    -   creation\_date: the date of test
    -   advanced\_options: if set to 1 serves to differentiate tests
        with advanced options from those without this option.

## Batch mode API

### *JSON-RPC Call*: create\_user

```
Request:
{
"params" : {
"frontend\_params" : {
"test\_profile" : "test\_profile\_1",
"ipv6" : 1,
"ipv4" : 1,
"client\_id" : "Zonemaster CGI/Dancer/node.js",
"nameservers" : [
{
"ns1.nic.fr" : ""
},
{
"empty" : "192.134.4.1"
},
{
"ns1.nic.fr" : "192.134.4.1"
}
],
"domain" : "afnic-2.fr",
"ds\_digest\_pairs" : [
{
"ds1" : "digest1"
},
{
"ds2" : "digest2"
}
],
"advanced\_options" : 1,
"client\_version" : "1.0"
},
"limit" : 10,
"offset" : 0
},
"jsonrpc" : "2.0",
"id" : 140726285079520,
"method" : "**get\_test\_history**"
}
```

-   params : an object containing the following parameters
    -   frontend\_params: the usual structure containing all the
        parameters of the interface
    -   offset: the start of pagination
    -   limit: number of items to return
-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   method: the name of the called method

```
Response
{
"jsonrpc" : "2.0",
"id" : 140743003648550,
"result" : [
{
"advanced\_options" : "1",
"id" : 3,
"creation\_time" : "2014-08-05 19:41:14.522656"
},
{
"advanced\_options" : "1",
"id" : 1,
"creation\_time" : "2014-08-05 11:48:18.542216"
}
]
}
```

-   jsonrpc : « 2.0 »
-   id : any kind of unique id allowing to match requests and responses
-   result: an ordered (starting by the most recent test) list of tests
    with
    -   id: the id to use to retrieve the test result
    -   creation\_date: the date of test
    -   advanced\_options: if set to 1 serves to differentiate tests
        with advanced options from those without this option.
