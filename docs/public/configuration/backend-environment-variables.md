# Environment variables

## Variable used by both RPCAPI daemon and Test Agent daemon

* `ZONEMASTER_BACKEND_CONFIG_FILE`: Set a custom path for the backend
  configuration file.

## Variables used by RPCAPI daemon only

* `ZM_BACKEND_RPCAPI_LOGLEVEL`: Configure the log level, `trace` by default.
  Accepted values are:
  * `trace`
  * `debug`
  * `info` (also accepted: `inform`)
  * `notice`
  * `warning` (also accepted: `warn`)
  * `error` (also accepted: `err`)
  * `critical` (also accepted: `crit`, `fatal`)
  * `alert`
  * `emergency`
* `ZM_BACKEND_RPCAPI_LOGJSON`: Setting it to any thruthy value (non-empty
  string or non-zero number) will configure the logger to log in JSON format,
  undefined by default.

## Variables used by unit test scripts

* `TARGET`: Set the database to use. If empty or undefined, "SQLite" will be
  assumed. Accepted values are:
  * `SQLite`
  * `PostgreSQL`
  * `MySQL`

* `ZONEMASTER_RECORD`: Setting it to any thruthy value (non-empty string or
  non-zero number) will record the data from the test to a file. Otherwise the
  data is loaded from a file.
