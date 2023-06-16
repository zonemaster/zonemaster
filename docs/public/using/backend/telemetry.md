# Telemetry

## Metrics

If enabled in the [Metrics section][metrics feature] in the configuration file,
[Statsd][statsd] compatible metrics are available to use:

| Name                                             | Type    | Description |
| ------------------------------------------------ | ------- | ----------- |
| zonemaster.rpcapi.requests.\<METHOD>.\<STATUS>   | Counter | Number of times the JSON RPC method \<METHOD> resulted in JSON RPC status \<STATUS>. The status is represented in string, possible values are: `RPC_PARSE_ERROR`, `RPC_INVALID_REQUEST`, `RPC_METHOD_NOT_FOUND`, `RPC_INVALID_PARAMS`, `RPC_INTERNAL_ERROR`. |
| zonemaster.testagent.tests_started               | Counter | Number of tests that have started. |
| zonemaster.testagent.tests_completed             | Counter | Number of tests that have been completed successfully. |
| zonemaster.testagent.tests_died                  | Counter | Number of tests that have died. |
| zonemaster.testagent.tests_duration_seconds      | Timing  | The duration of a test, emitted for each test. |
| zonemaster.testagent.cleanup_duration_seconds    | Timing  | Time spent to kill timed out processes. |
| zonemaster.testagent.fetchtests_duration_seconds | Timing  | Time spent selecting the next text to run and processing unfinished tests. |
| zonemaster.testagent.running_processes           | Gauge   | Number of running processes in a test agent. |
| zonemaster.testagent.maximum_processes           | Gauge   | Maximum number of running processes in a test agent. |


### Usage

Testing the metrics feature can be as easy as running a listening UDP server like

```sh
ns -lup 8125
```

This should be enough to see the metrics emitted by Zonemaster.

More complex setups are required for the metrics to be used in alerts and dashboards.
StatsD metrics can be integrated to a number of metrics backend like Prometheus (using the [StatsD exporter]), InfluxDB (using Telegraf and the [StatsD plugin]), Graphite ([integration guide]) and others.

#### StatsD Exporter (Prometheus)

1. Download the binary (tar file) corresponding to your environment https://github.com/prometheus/statsd_exporter/releases
2. Untar the file
3. `cd` into the statsd_exporter directory
4. Create a `statsd_mapping.yml` file with content as below
   ```yml
   mappings:
   - match: zonemaster.rpcapi.requests.*.*
     name: zonemaster_rpcapi_requests_total
     labels:
       method: $1
       status: $2
   - match: zonemaster.testagent.tests_duration_seconds
     observer_type: histogram
     buckets: [ 1, 2.5, 5, 10, 15, 30, 45, 60, 75, 90, 105, 120, 150, 180]
     name: zonemaster_testagent_tests_duration_seconds
   - match: zonemaster.testagent.cleanup_duration_seconds
     observer_type: histogram
     buckets: [ 0.01, 0.025, 0.05, 0.075, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]
     name: zonemaster_testagent_cleanup_duration_seconds
   - match: zonemaster.testagent.fetchtests_duration_seconds
     observer_type: histogram
     buckets: [ 0.001, 0.0025, 0.005, 0.0075, 0.01, 0.025, 0.05, 0.075, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 3, 5, 10]
     name: zonemaster_testagent_fetchtests_duration_seconds
   ```
5. Run it like
   ```
   ./statsd_exporter --statsd.mapping-config=./statsd_mapping.yml --statsd.listen-udp=:8125 --statsd.listen-tcp=:8125
   ```
6. Run the following to see Zonemaster metrics:
   ```
   curl localhost:9102/metrics | grep zonemaster
   ```

[metrics feature]: ../../installation/zonemaster-backend.md#101-metrics
[statsd]:          https://github.com/statsd/statsd
[StatsD exporter]: https://github.com/prometheus/statsd_exporter
[StatsD plugin]:   https://github.com/influxdata/telegraf/tree/master/plugins/inputs/statsd
[integration guide]: https://github.com/statsd/statsd/blob/master/docs/graphite.md
