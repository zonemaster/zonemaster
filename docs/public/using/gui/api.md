# API

The Zonemaster GUI provides an API to access specific resource and perform
specific tasks.

A path is added to the Zonemaster GUI base URL, e.g.
<https://zonemaster.net/>.

The supported paths are the following:

* `run-test`: the default path, access the input form
* `domain_check`: same as `run-test`, but *deprecated*
* `run-test/<domain>`: populate the input form with `<domain>`, which is expected
  to be a name of a DNS zone, and launch the test. Currently undelegated tests
  cannot be performed via the API.
* `result/<test-id>`: access the result page with results for the test with
  `<test-id>`
* `test/<test-id>`: same as `result/<test-id>`, but *deprecated*
* `faq`: access the FAQ

The GUI will rewrite `domain_check` to `run-test` before the page is displayed.
Note that `domain_check/<domain>` is **not** rewritten and hence is an invalid
path.

The GUI will rewrite `test/<test-id>` to `result/<test-id>` before the result
is displayed.
