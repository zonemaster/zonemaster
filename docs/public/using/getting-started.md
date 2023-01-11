# Using the Backend RPCAPI

This is a guide for getting started with the Zonemaster RPC API daemon.

>
> Note: This guide makes a number of assumptions about you setup:
>
> * that it's a Unix-like environment
> * that you have Zonemaster-Backend installed according to the [installation guide]
> * that you have the tools `curl` and `jq` installed
>

First, check that the *RPC API daemon* is running and answering properly.

```sh
curl -sS -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "id": 1, "method": "version_info"}' http://localhost:5000/ | jq .
```

Enqueue a *test* of the domain `zonemaster.net`.

```sh
curl -sS -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "id": 2, "method": "start_domain_test", "params": {"domain": "zonemaster.net", "ipv4": true}}' http://localhost:5000/ | jq .
```

However, we need the *test id* of the *test* we just enqueued.
Let's query the same method with the same params again, let `jq` filter out the *test id* for us, and then store it in an environment variable.

```sh
TESTID=`curl -sS -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "id": 3, "method": "start_domain_test", "params": {"domain": "zonemaster.net", "ipv4": true}}' http://localhost:5000/ | jq .result`
echo "$TESTID"
```

Watch the *test* progress (`"result"`) up to `100` (percent) by repeatedly running this command.

```sh
curl -sS -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "id": 4, "method": "test_progress", "params": '"$TESTID"'}' http://localhost:5000/ | jq .
```

Once the progress value has reached `100`, you can query for the *test result*.

```sh
curl -sS -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "id": 5, "method": "get_test_results", "params": {"id": '"$TESTID"'}}' http://localhost:5000/ | jq .
```

If you're moderatly quick and repeatedly re-run the last command you should be able to see the progress value increase in uneven steps from `0` to `100`.
Never mind updating the JSON-RPC `"id"` - the server doesn't care.
Once the progress has reached 100, lots of test results should also be showing up.

[installation guide]: ../installation/zonemaster-backend.md
