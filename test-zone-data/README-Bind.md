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
directory named after the test case a `Bind` directory is created. In that a
`named.conf` is created, i.e. one `named.conf` for each test case that need
Bind. In `named.conf` it must be specified which IP addresses that Bind should
be listening on.

Use an existing `named.conf` as a template.


## Starting Bind

Bind is started for each test zone. Go to the directory where `named.conf` is
found, e.g.
```
cd test-zone-data/DNSSEC-TP/dnssec10/Bind
```
Start Bind with the following command where `ubuntu` is the owner of the git
tree, i.e. owner of the `Bind` directory and all file in that directory.
```
sudo named -c $(pwd)/named.conf -u ubuntu
```

## Stopping Bind

From the directory where Bind was started the following command stops Bind:

```
kill $(cat named.pid)
```

## Reloading Bind

After update of `named.conf` or zone file run by Bind you should reload Bind,
e.g.

```
kill -HUP $(cat named.pid)
```
