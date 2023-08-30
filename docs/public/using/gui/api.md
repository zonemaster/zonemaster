# API

The Zonemaster GUI provides an API to access specific resource and perform
specific tasks.

A path is added to the Zonemaster GUI base URL, e.g.
<https://zonemaster.net/>.

The supported paths are the following:

* `<lang>/run-test`: the default path, access the input form.
* `<lang>/domain_check`: same as `run-test`, but *deprecated*.
* `<lang>/run-test/<domain>`: populate the input form with `<domain>`, which is
  expected to be a name of a DNS zone, and launch the test. Currently
  undelegated tests cannot be performed via the API.
* `<lang>/result/<test-id>`: access the result page with results for the test
  with `<test-id>`.
* `<lang>/test/<test-id>`: same as `<lang>/result/<test-id>`, but *deprecated*.
* `<lang>/faq`: access the FAQ.

The GUI will rewrite `<lang>/domain_check` to `<lang>/run-test` before the page
is displayed. Note that `<lang>/domain_check/<domain>` is **not** rewritten and
hence is an invalid path.

The GUI will rewrite `<lang>/test/<test-id>` to `<lang>/result/<test-id>`
before the result is displayed.

The GUI will redirect from `<path>` to `<lang>/<path>` automatically using the
user browser language, defaulting to the default language defined in the
reverse proxy configuration.
