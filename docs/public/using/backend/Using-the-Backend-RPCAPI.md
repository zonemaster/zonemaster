# Using the Backend RPCAPI

## Table of contents

* [Introduction](#introduction)
* [Check that the RPC API daemon is running and answering properly](#check-that-the-rpc-api-daemon-is-running-and-answering-properly)
* [Run a test of the zonemaster.net zone using zmtest](#run-a-test-of-the-zonemasternet-zone-using-zmtest)
* [Run a test of the zonemaster.net zone using zmb](#run-a-test-of-the-zonemasternet-zone-using-zmb)
  * [Enqueue a test](#enqueue-a-test)
  * [Check the progress](#check-the-progress)
  * [Fetch the results](#fetch-the-results)
* [Find available languages](#find-available-languages)
* [Find previous tests](#find-previous-tests)
* [Other APIs](#other-apis)

## Introduction

This is a guide for getting started with the Zonemaster [RPCAPI] daemon.

Note that this guide makes a number of assumptions about you setup:

* That it is a Unix-like environment.
* That you have Zonemaster-Backend installed according to the
  [installation guide]
* That Zonemaster-Backend is running. See [installation guide] for how to start
  Zonemaster-Backend.
* If you have changed IP address (default 127.0.0.1) or port (default 5000) then
  you must specify that in the commands below. Here we assume default.

For this guide we will use the two Zonemaster-Backend tools `zmb` and `zmtest`.
Both are installed when Zonemaster-Backend is installed. To get more information
what parameters they expect, run `zmb -h` and `zmtest -h`.

With `zmtest` you can start a domain test and get the result directly. With `zmb`
you can also do that, but in several steps, but on the other hand, `zmb` offers
many more possibilities. Actually, `zmtest` uses `zmb` behind the scen.

The `zmb` tool uses the RPC-API interface to interact with Zonemaster-Backend.
Zonemaster-GUI also uses the same RPC-API interface to start tests and fetch the
test results.

## Check that the RPC API daemon is running and answering properly

```sh
zmb version_info
```

To get a more readable output, pipe the command through `jq`:

```sh
zmb version_info | jq
```

Below most commands will be piped through `jq`, but for processing you might want
to have the JSON on one line, or you might want to look at the options for `jq`
to extract fields (see `jq -h`).

## Run a test of the zonemaster.net zone using zmtest

To just run a test `zmtest` is the simple tool to use:

```sh
zmtest zonemaster.net
```

The tool will also display the result, which will a long JSON structure (here
truncated).

```
testid: 879d13569db70fde
100% done
{
  "id": 1,
  "jsonrpc": "2.0",
  "result": {
    "created_at": "2024-10-25T09:28:38Z",
    "hash_id": "879d13569db70fde",
    "params": {
      "domain": "zonemaster.net",
      "ds_info": [],
      "ipv4": true,
      "ipv6": true,
      "nameservers": [],
      "priority": 10,
      "profile": "default",
      "queue": 0
    },
    "results": [
      {
        "level": "INFO",
        "message": "Using version v6.0.0 of the Zonemaster engine.\n",
        "module": "System",
        "testcase": "Unspecified"
      },
      {
        "level": "INFO",
        "message": "The parent zone is \"net\" as returned from name servers \"a.gtld-servers.net/192.5.6.30; a.gtld-servers.net/2001:503:a83e::2:30; b.gtld-servers.net/192.33.14.30; b.gtld-servers.net/2001:503:231d::2:30; c.gtld-servers.net/192.26.92.30; c.gtld-servers.net/2001:503:83eb::30; d.gtld-servers.net/192.31.80.30; d.gtld-servers.net/2001:500:856e::30; e.gtld-servers.net/192.12.94.30; e.gtld-servers.net/2001:502:1ca1::30; f.gtld-servers.net/192.35.51.30; f.gtld-servers.net/2001:503:d414::30; g.gtld-servers.net/192.42.93.30; g.gtld-servers.net/2001:503:eea3::30; h.gtld-servers.net/192.54.112.30; h.gtld-servers.net/2001:502:8cc::30; i.gtld-servers.net/192.43.172.30; i.gtld-servers.net/2001:503:39c1::30; j.gtld-servers.net/192.48.79.30; j.gtld-servers.net/2001:502:7094::30; k.gtld-servers.net/192.52.178.30; k.gtld-servers.net/2001:503:d2d::30; l.gtld-servers.net/192.41.162.30; l.gtld-servers.net/2001:500:d937::30; m.gtld-servers.net/192.55.83.30; m.gtld-servers.net/2001:501:b1f9::30\".\n",
        "module": "Basic",
        "testcase": "Basic01"
      },
      {
        "level": "INFO",
        "message": "The zone \"zonemaster.net\" is found.\n",
        "module": "Basic",
        "testcase": "Basic01"
      },
      {
        "level": "INFO",
        "message": "Authoritative answer on SOA query for \"zonemaster.net\" is returned by name servers \"ns2.nic.fr/192.93.0.4; ns2.nic.fr/2001:660:3005:1::1:2; nsa.dnsnode.net/194.58.192.46; nsa.dnsnode.net/2a01:3f1:46::53; nsp.dnsnode.net/194.58.198.32; nsp.dnsnode.net/2a01:3f1:3032::53; nsu.dnsnode.net/185.42.137.98; nsu.dnsnode.net/2a01:3f0:400::32\".\n",
        "module": "Basic",
        "testcase": "Basic02"
      },
(...)
```

You will find the meaning of all fields in the outputs in [Zonemaster RPCAPI reference][RPCAPI].

## Run a test of the zonemaster.net zone using zmb

If we instead use `zmb` then this will be done in three steps (that happen
behind the scen when using `zmtest`):

1. Enqueue test.
2. Check if testing has completed (progress) - maybe several times.
3. Fetch result (maybe several times with different translations).

### Enqueue a test

To enqueue the test of zonemaster.net we run 
`zmb start_domain_test --domain zonemaster.net | jq` and immediately get the
response

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "879d13569db70fde"
}
```
The `results` field holds the test ID which we need for further steps. It
always consists of 16 hexadecimal digits.

### Check the progress

To check the progress we run `zmb test_progress --test-id 879d13569db70fde | jq`
with the test ID from enqueueing, and get the response

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": 8
}
```

Now the `results` field holds the progress of testing, an integer between 0 and
100 to mean 0% to 100%. 0% means that testing has not started (maybe many tests
in the queue) and 100% means that testing has completed.

We have to stay in the check step until the test has reached 100%. In our
example above, it is 8%, so we run the command again and now we get the
response

```json
{
  "result": 100,
  "jsonrpc": "2.0",
  "id": 1
}
```

### Fetch the results

When the test has completed the test results can be fetched. The test ID is found
above and then the language has to be choosen. Here `en` is used. More about
languages below. Run 
`zmb get_test_results --test-id 879d13569db70fde --lang en | jq` and get a JSON
structure with data (as with `zmtest`). Again, the JSON structure is long and is
truncated here.

```
{
  "id": 1,
  "result": {
    "results": [
      {
        "message": "Using version v6.0.0 of the Zonemaster engine.\n",
        "testcase": "Unspecified",
        "level": "INFO",
        "module": "System"
      },
      {
        "module": "Basic",
        "level": "INFO",
        "testcase": "Basic01",
        "message": "The parent zone is \"net\" as returned from name servers \"a.gtld-servers.net/192.5.6.30; a.gtld-servers.net/2001:503:a83e::2:30; b.gtld-servers.net/192.33.14.30; b.gtld-servers.net/2001:503:231d::2:30; c.gtld-servers.net/192.26.92.30; c.gtld-servers.net/2001:503:83eb::30; d.gtld-servers.net/192.31.80.30; d.gtld-servers.net/2001:500:856e::30; e.gtld-servers.net/192.12.94.30; e.gtld-servers.net/2001:502:1ca1::30; f.gtld-servers.net/192.35.51.30; f.gtld-servers.net/2001:503:d414::30; g.gtld-servers.net/192.42.93.30; g.gtld-servers.net/2001:503:eea3::30; h.gtld-servers.net/192.54.112.30; h.gtld-servers.net/2001:502:8cc::30; i.gtld-servers.net/192.43.172.30; i.gtld-servers.net/2001:503:39c1::30; j.gtld-servers.net/192.48.79.30; j.gtld-servers.net/2001:502:7094::30; k.gtld-servers.net/192.52.178.30; k.gtld-servers.net/2001:503:d2d::30; l.gtld-servers.net/192.41.162.30; l.gtld-servers.net/2001:500:d937::30; m.gtld-servers.net/192.55.83.30; m.gtld-servers.net/2001:501:b1f9::30\".\n"
      },
      {
        "message": "The zone \"zonemaster.net\" is found.\n",
        "module": "Basic",
        "testcase": "Basic01",
        "level": "INFO"
      },
      {
        "level": "INFO",
        "testcase": "Basic02",
        "module": "Basic",
        "message": "Authoritative answer on SOA query for \"zonemaster.net\" is returned by name servers \"ns2.nic.fr/192.93.0.4; ns2.nic.fr/2001:660:3005:1::1:2; nsa.dnsnode.net/194.58.192.46; nsa.dnsnode.net/2a01:3f1:46::53; nsp.dnsnode.net/194.58.198.32; nsp.dnsnode.net/2a01:3f1:3032::53; nsu.dnsnode.net/185.42.137.98; nsu.dnsnode.net/2a01:3f0:400::32\".\n"
      },
(...)
```

## Find available languages

The result can be presented in several languages, depending on installation. To
find out what languages that are available, run `zmb get_language_tags | jq`.

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": [
    "da",
    "en",
    "es",
    "fi",
    "fr",
    "nb",
    "sv"
  ]
}
```

## Find previous tests

It is possible to find previous tests of a specific domain (zone). Run
`zmb get_test_history --domain zonemaster.net |jq` to get all tests of
`zonemaster.net`. The output looks like the following:

```
{
  "jsonrpc": "2.0",
  "result": [
    {
      "undelegated": false,
      "created_at": "2024-10-25T09:54:38Z",
      "id": "00669309ac7887c3",
      "overall_result": "ok"
    },
    {
      "overall_result": "ok",
      "id": "879d13569db70fde",
      "undelegated": false,
      "created_at": "2024-10-25T09:28:38Z"
    }
  ],
  "id": 1
}
```

Now you can get the results of any of the listed tests by running
`get_test_results` with selected test ID and language as above.

## Other APIs

There are a few other APIs that can be used throught `zmb`, and can be found by
`zmb -h` and in [Zonemaster RPCAPI reference][RPCAPI]. The APIs for batch testing
are covered in [Using Zonemaster Backend for batch testing].


[installation guide]:                                 ../../installation/zonemaster-backend.md
[RPCAPI]:                                             rpcapi-reference.md
[Using Zonemaster Backend for batch testing]:         Using-Zonemaster-Backend-for-batch-testing.md
