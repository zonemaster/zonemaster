# Bind

## Generate DNS records

For this test case Bind is used for generating some DNS records, and then
they are added to the CoreDNS configuration. Specifically `DNSKEY`, `NSEC`,
`NSEC3`, `NSEC3PARAM` and `RRSIG` records are generated and then copied to,
for this test case, [dnssec10.cfg](dnssec10.cfg).

Bind is never used to serve the test zones. That is done by CoreDNS, and in the
future maybe IBDNS. 

## Creating new scenarios or updating existing scenarios

The recommended path is to let Bind load the zone for the scenario and then get
the records from responses on queries to the bind specific IP addresses,
127.15.10.37 and in some cases 127.15.10.38. That will give valid DNSKEY, NSEC,
NSEC3 and NSEC3PARAM records signed by valid RRSIG.

After that manipulations could be necessary. See existing test zones for examples.

Go to the [Bind](Bind) directory for Bind configuration, zone files and more
information.
