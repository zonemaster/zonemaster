# Formal Test States

Each test in the `test_results` table is always in exactly one formal state.
The state is stored in the `state` column and is restricted to the following
values:

| State | Meaning | Progress | Timestamps |
| --- | --- | --- | --- |
| `waiting` | The test has been created and is waiting for a worker. | `0` | `started_at` and `ended_at` are unset. |
| `running` | A worker has claimed the test and is processing it. | `1`-`99` | `started_at` is set; `ended_at` is unset. |
| `completed` | The test finished normally. | `100` | `started_at` and `ended_at` are set. |
| `cancelled` | The test was terminated because it exceeded the configured maximum execution time. | `100` | `started_at` and `ended_at` are set. |
| `crashed` | The worker processing the test died before the test finished. | `100` | `started_at` and `ended_at` are set. |

The state is authoritative for the lifecycle of a test. The `progress` column
indicates processing progress while a test is running and is set to `100` for
every terminal state. It must not be used to distinguish `completed`,
`cancelled`, and `crashed`.

## State Transitions

The only valid transitions are:

```text
waiting -> running  |-> completed
                    |-> cancelled
                    |-> crashed
```

All other state changes are invalid. A test can enter `cancelled` when the
backend's maximum execution time is exceeded. A test can enter `crashed` when
the test worker dies. These terminal states include the corresponding backend
result entries:

- `cancelled`: `BACKEND_TEST_AGENT:UNABLE_TO_FINISH_TEST`
- `crashed`: `BACKEND_TEST_AGENT:TEST_DIED`

## Database Operations

The lifecycle transitions are performed by these database operations:

| Operation | Transition |
| --- | --- |
| `create_new_test()` | Creates a `waiting` test. |
| `claim_test()` | `waiting` to `running`. |
| `store_results()` | `running` to `completed`. |
| `process_unfinished_tests()` | `running` to `cancelled`. |
| `process_dead_test()` | `running` to `crashed`. |

The state constants are exported by `Zonemaster::Backend::DB`:

```perl
$TEST_WAITING
$TEST_RUNNING
$TEST_COMPLETED
$TEST_CANCELLED
$TEST_CRASHED
```

## Migration

When migrating an existing database, the initial state is derived from the
previous `progress` value:

| Previous progress | Migrated state |
| ---: | --- |
| `0` | `waiting` |
| `1`-`99` | `running` |
| `100` | `completed` |

Existing rows cannot be identified as cancelled or crashed from the previous
schema because both states were previously represented as `progress = 100`.
