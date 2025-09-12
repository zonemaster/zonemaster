# Bind

## Generate DNS records

Bind is used for some test cases to generate some DNS records, specifically
DNSSEC, NSEC3 and RRSIG records. That is done when the those must validate,
e.g. for DNSSEC10 test scenarios. To create those DNS records Bind must be
started.


## Running Bind

Bind is never used to serve the test zones. That is done by CoreDNS, and in the
future IBDNS. 


## Configuring Bind

Specific IP addresses must be reserved for Bind in `address-plan.md`. Under the
directory named after the test case a `Bind` directory is created, e.g.
`DNSSEC-TP/dnssec10/Bind/`. In that a`named.conf` is created, i.e. one
`named.conf` for each test case that need Bind. In `named.conf` it must be
specified which IP addresses that Bind should be listening on.

Use an existing `named.conf` as a template.


## Starting, stopping reloading Bind

See the `Bind` directory for the specific test case.

