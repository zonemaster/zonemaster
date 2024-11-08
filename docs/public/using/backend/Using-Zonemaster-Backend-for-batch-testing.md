# Using Zonemaster-Backend for batch testing

## Table of contents

* [Introduction](#introduction)
* [Combining GUI and batch](#combining-gui-and-batch)
* [Configuration to run batches](#configuration-to-run-batches)
* [Create batch user](#create-batch-user)
* [Run a batch job](#run-a-batch-job)
  * [Start a batch job](#start-a-batch-job)
  * [Status of a batch job](#status-of-a-batch-job)
* [Scale out](#scale-out)
  * [Enable global cache](#enable-global-cache)
  * [Increase number of sub processes](#increase-number-of-sub-processes)
  * [Add more test agent daemons](#add-more-test-agent-daemons)
  * [Add more test servers](#add-more-test-servers)
* [Queues](#queues)
* [Appendix: Create an additional RPCAPI](#appendix-create-an-additional-rpcapi)

## Introduction

In [Using the Backend RPCAPI] it is shown how a test of a single domain name
(zone) can be started using the RPC-API interface to Zonemaster-Backend. It is also
possible to start a batch of domain names at the same time. In principle such
a batch is the same thing as running the `start_domain_test` individually for each
domain name in the batch.

This document will describe how batches of domain name tests can be run and what
to think about when running batches, especially large ones.

Zonemaster-Backend uses a database to store information on enqueued tests and
results from tests. It is possible to use SQLite as the database backend for
small installations and test installations, but that is not useful for running
real batches on. Therefore in this document it is assumed that Backend has been
installed with [MariaDB/MySQL] or [PostgreSQL].

## Combining GUI and batch

Both GUI and batch uses Zonemaster-Backend that stores the data in the database.
If the same database is used, then all tests run, independently if they are
started via GUI or a batch, will be available in the GUI interface indirectly
using the `get_test_history` (see relevant section in
[Using the Backend RPCAPI][Using#find-previous-tests]. Depending on the
situation, running batches on the same Backend as GUI may be desirable or not
recommended. If the results are expected to be available through GUI then the batches must be
run on the same Backend. If the batches are run with a reduced set of test cases
then it can be confusing since the results are not fully comparable with
those from tests started from GUI. If the results from batch tests should not be
mixed with tests from normal GUI tests, a separate installation of Backend is
required, and that might not need any GUI at all.

Another aspect of running tests created from batches on the same Backend as tests
created from GUI is prioritization of the tests. By default Backend will run
tests from GUI (or rather by `start_domain_test`) before test from a batch. In
this way GUI users that interactively runs a test does not have to wait for a
batch to complete. A large batch might run for days.

## Configuration to run batches

To start a batch job, setting `enable_add_batch_job` in [backend_config.ini] must
be enabled (*enabled* by default). Moreover a special user must also be available.
To create that user setting `enable_add_api_user` must be enabled
(*disabled* by default). (See below for how to create the user.) Note that this setting
only needs to be enabled while creating the user(s), not when starting a batch job.

After changing these settings, the RPCAPI daemon must be restarted.

It is not recommended to enable `enable_add_api_user` for an RPCAPI that can be
used by untrusted users, e.g. via GUI. If the installation for the batch jobs
is a dedicated installation, then it is not an issue. If it is used by a public
GUI that could be closed while the batch user or users are created, then that
could be an option. Creating the user only takes as long time as it takes to
type the command in, i.e. seconds.

Another option is to create new RPCAPI to the same Backend (the same database).
A Backend can have several parallel RPCAPI running with different configuration,
see [Create an additional RPCAPI].

## Create batch user

In [Using the Backend RPCAPI] it is shown how `zmb` can be used for several
RPCAPI tasks. It can also be used for the creation of the batch user. It is now
assumed that `enable_add_api_user` is enabled or else 
`"message": "Procedure 'add_api_user' not found"` will be outputted.

Run `zmb add_api_user --username myuser --api-key mykey | jq` where `myuser` is
the user name of your choice and `mykey` the password, which should probably be
longer and more complex. The output is simply

```json
{
  "jsonrpc": "2.0",
  "result": 1,
  "id": 1
}
```

Now `enable_add_api_user` can be disabled.

## Run a batch job

The `zmb` script is used for that purpose. A batch job can be started with just a few
domain names or a list of millions of domain names.

### Start a batch job

Creating a batch is done using `add_batch_job`:

```
$ zmb add_batch_job --username myuser --api-key mykey --domain zonemaster.net --domain zonemaster.se --domain zonemaster.fr | jq
{
  "jsonrpc": "2.0",
  "result": 2,
  "id": 1
}
```

Options that are mandatory are `--username`, `--api-key` and `--domain`. Option
`--domain` is repeated for every domain name in the batch. The other options are
optional. For all options see `zmb man`.

The batch ID is found in "result", which is "2" in this case.

Listing the domain names one by one is however cumbersome unless it is a very
small batch as above. A better alternative for a larger batch is to create text
file of the domain names to test, one domain name per line. Comments starting
on `#` is permitted, which makes it possible to add meta information to the
file.

```
cat batchfile.txt
# Example batch
zonemaster.net
zonemaster.se
zonemaster.fr
```

Now we can run the same batch as above, but from the file:

```
$ zmb add_batch_job --username myuser --api-key mykey --file batchfile | jq
{
  "jsonrpc": "2.0",
  "result": 3,
  "id": 1
}
```

Starting the batch with the domain names one by one or in the file gives exactly
the same result. Also in this case, IDN domain names can be entered both with
A-label and U-label (UTF-8 is assumed).

### Status of a batch job

To check the status of a batch job the batch ID is required ("2" in the
case above), using `get_batch_job_result`:

```
$ zmb get_batch_job_result --batch-id 2 | jq
{
  "id": 1,
  "result": {
    "nb_running": 3,
    "nb_finished": 0
  },
  "jsonrpc": "2.0"
}
```

Three tests are running, none has been completed yet. After some time running the
command again gives:

```json
{
  "jsonrpc": "2.0",
  "result": {
    "nb_running": 0,
    "finished_test_ids": [
      "b26b874493ed4b57",
      "9af528070fa2551a",
      "708f82b5176261dc"
    ],
    "nb_finished": 3
  },
  "id": 1
}
```

Now all tests in the batch are completed. The test IDs in `finished_test_ids`
can be used to get the results with `get_test_results`.

## Scale out

Running a batch can take a long time and if that is a problem then it is possible
to increase the performance by:

* Enabling global cache
* Increasing `number_of_processes_for_batch_testing`
* Adding one or more parent test agent daemons
* Adding one or more test servers

### Enable global cache

When a test is executed Zonemaster caches DNS responses for the same test (same
domain name) to increase performance (no need to query for the same thing again).
In the normal case the cache is not shared between different tests (different
domain names). Such global cache can be enabled to get increased performance.

For interactive tests via GUI the global cache is probably not desired. If a user
changes the DNS configuration of a domain then the following tests results should
not be based on old data.

To enable global cache a custom profile must be used. See the instructions in
[Configuration: Global cache in Zonemaster-Engine][Global-cache].

The custom profile is assumed to be `/etc/zonemaster/profile-batch.json`
(Linux) or `/etc/local/zonemaster/profile-batch.json` (FreeBSD).

The custom profile must be added to the Backend configuration to be made
available for the tests. In `backend_config.ini` look for the section
`[PRIVATE PROFILES]`. Under that add the following line for Linux:

```
batch=/etc/zonemaster/profile-batch.json
```

For FreeBSD add:

```
batch=/usr/local/etc/zonemaster/profile-batch.json
```

After restarting both RPCAPI daemon and Test Agent daemon (all daemons if there
are more than one of each) a batch can be started with (using a batch file):

```
$ zmb add_batch_job --profile batch --username myuser --api-key mykey --file batchfile | jq
{
  "jsonrpc": "2.0",
  "result": 4,
  "id": 1
}
```

This will give an increased performance on large batches where the domain name
directly (or indirectly) share data with other domain names.

### Increase number of sub processes

By default one parent test agent daemon is run in a Backend installation. That
parent daemon will fork into child processes. The number of test agent child
processes can be increased by setting `number_of_processes_for_batch_testing` in
the [configuration file][Backend_config.ini], and in that way increase
performance. There is, however, a limit when increase does not help. Then adding
more parent test agent daemons can help.

### Add more parent test agent daemons

If the increase of `number_of_processes_for_batch_testing` does not help anymore
and the server has free resources (IO, CPU and RAM) then adding one or more test
parent agent daemons can help.

The parent test agent is started by the start script
`/etc/systemd/system/zm-testagent.service` (Rocky Linux),
`/etc/init.d/zm-testagent` (Debian/Ubuntu) or `/usr/local/etc/rc.d/zm_testagent`
(FreeBSD). Create a copy so that the additional daemon has a new name, new PID
file and new log file. Also see the [Backend installation instructions].

Start the new daemon and now a second parent test agent daemon is running.
Additional parent test agent daemons can be added.

Unless the different parent test agent daemons should process different
[queues](#queues) the same configuration file can be used.

### Add more test servers

Adding more servers is a generalization of adding more test agent daemons.

* Configure the database to listen on an external interface. The database can
  also be moved to a dedicated server.
* Install Backend on the new test agent server, but disable RPCAPI. 
* Update configuration to use the external database server.
* Consider adding more test agent daemons.
* If global cache is used, configure Redis to listen on an external interface.
  The Redis server can also be moved to a dedicated server.
* Consider moving RPCAPI to a dedicated server. If so, update the configuration
  to use the external database server.
* If applicable, configure all parts to use external database server and external
  Redis server.

## Queues

Every enqueued test has a [queue tag][RPCAPI#queue]. In the
[configuration][Config#lock_on_queue] file it is set which queue should be
processed by the test agent. Only tests with matching queue value (default 0)
will be processed. Queue tag is set by API methods `start_domain_test` and `add_batch_job`,
respectively (default 0 in both cases).

If desirable it is possible to create a batch with another queue value and then
let a dedicated tast agent, possibly on a dedicated server, process the tests in
the batch, while another test agent processes tests from the GUI.

It is important to note that if a test is tagged with a queue value that no
test agent uses it will never be processed.

In the end, all completed tests will end up in the same database and will be
mixed when looking for completed tests for the same domain name
(`get_test_history`).

## Appendix: Create an additional RPCAPI

RPCAPI listens by default on 127.0.0.1 on port 5000. That is governed by the
start script for RPCAPI which is `/etc/systemd/system/zm-rpcapi.service` (Rocky
Linux), `/etc/init.d/zm-rpcapi` (Ubuntu and Debian) or
`/usr/local/etc/rc.d/zm_rpcapi` (FreeBSD). Create a copy so that the additional
daemon has a new name, new PID file, new log file and listens to a new port. Also
see the [Backend installation instructions].

Start the new daemon and now a second RPCAPI is running.

To be useful, the second RPCAPI should probably have a different configuration
file too. The configuration file is found as
`/etc/zonemaster/backend_config.ini` (Linux) or as
`/usr/local/etc/zonemaster/backend_config.ini` (FreeBSD). The database settings
must not be changed, or else the two RPCAPI will not be part of the same
Backend. Examples of settings that could be different between the two RPCAPI
daemons are:

* enable_add_api_user
* Available profiles

Update the second daemon to use the updated configuration file.


[Backend installation instructions]:            ../../installation/zonemaster-backend.md
[Backend_config.ini]:                           ../../configuration/backend.md
[Global-cache]:                                 ../../configuration/global-cache.md
[MariaDB/MySQL]:                                ../../installation/zonemaster-backend.md#7-installation-with-mariadb
[PostgreSQL]:                                   ../../installation/zonemaster-backend.md#8-installation-with-postgresql
[Using the Backend RPCAPI]:                     Using-the-Backend-RPCAPI.md
[Using#find-previous-tests]:                    Using-the-Backend-RPCAPI.md#find-previous-tests
[RPCAPI#queue]:                                 rpcapi-reference.md#queue
[Config#lock_on_queue]:                         ../../configuration/backend.md#lock_on_queue
