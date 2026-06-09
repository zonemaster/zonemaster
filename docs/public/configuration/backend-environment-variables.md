# Environment variables

## Variable used by both RPCAPI daemon and Test Agent daemon

* `ZONEMASTER_BACKEND_CONFIG_FILE`: Set a custom path for the backend
  configuration file.

## Variables used by RPCAPI daemon only

* `ZM_BACKEND_RPCAPI_LOGLEVEL`: The threshold for emitting log entries. Default:
  info.

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

* `ZM_BACKEND_RPCAPI_LOGJSON`: A [boolean]. When true, logs are written in JSON
  format.

* `ZM_BACKEND_RPCAPI_NO_LOGPID`: A [boolean]. Controls the inclusion of PID in
  log entries.

* `ZM_BACKEND_RPCAPI_NO_LOGTIMESTAMP`: A [boolean]. Controls the inclusion of
  timestamp log entries.

## Variables used by unit test scripts

* `TARGET`: Set the database to use. If empty or undefined, "SQLite" will be
  assumed. Accepted values are:
  * `SQLite`
  * `PostgreSQL`
  * `MySQL`

* `ZONEMASTER_RECORD`: A [boolean]. When true, data is retrieved over the
  network and persisted to a data file. When false, data is retrieved from a
  data file.

## Boolean variables

For boolean environment variables two values are falsy: the empty string, and
the string `0`. Every other value is truthy. An unset boolean environment
variable is false by default.



[Boolean]: #boolean-variables
