# Bind

## Table of contents
* [Variable below](#variable-below)
* [Configuring Bind](#configuring-bind)
* [Zone files](#zone-files)
* [Key generation and zone signing](#key-generation-and-zone-signing)
* [Creating a variant zone](#creating-a-variant-zone)
* [Synchronizing the keys and zones at checkout](#synchronizing-the-keys-and-zones-at-checkout)
* [Starting and stopping Bind](#starting-and-stopping-bind)
* [Reloading Bind](#reloading-bind)
* [Checking Bind](#checking-bind)

## Variable below

Below `%ZONE-NAME%` means the name of the zone in question, without the traling
dot, e.g. `inconsist-nsec-nsec3-1.dnssec10.xa`.

## Configuring Bind

Specific IP addresses must be allocated for Bind in `address-plan.md`. For these
test scenarios 127.15.10.37 and 127.15.10.38 are allocated.

All Bind configuration must be kept in the
`test-zone-data/DNSSEC-TP/dnssec10/Bind` directory (and that model should always
be used for Bind data). In `named.conf` all configuration for Bind is kept. In
that file it is configured that Bind listens to the two addresses listed above.
There is no need to listen to IPv6.

Bind is configured with `views`, one view per IP address. In the normal case
a zone is only put into the `main` view (127.15.10.37). If the scenario requires
two variants of the same zone (NSEC vs NSEC3) then the same zone with other
settings are added to the `var1` view (127.15.10.38). In that way both NSEC and
NSEC3 responses can be fetched. See further below on the creation of the
variant zone.

## Zone files

Zone files are created as unsigned zones. The zone file name should be
`%ZONE-NAME%.zone`, e.g. `inconsist-nsec-nsec3-1.dnssec10.xa.zone`.
The file should reside in directory `zones/` unless it is a variant zone file
(view `var1`). Then is should reside in directory `zones-var1/`. A variant zone
file should have the same name as the main zone file.

## Key generation and zone signing

When started or restarted Bind will create keys (DNSKEY), signatures (RRSIG) and
NSEC or NSEC3 records. The unsigned zone file is unchanged and a `*.zone.signed`
file is created, e.g. `inconsist-nsec-nsec3-1.dnssec10.xa.zone.signed`.

Keys for `main` zones are put in the `key-dir` directory by Bind. Keys for the
`var1` zones are put in the `key-dir-var1` directory.

## Creating a variant zone

When a variant zone file (in `var1` view) of exactly the same zone (zone name)
then Bind will create a different set of keys, which is not what we want. To
prevent this, do the following steps:

1. Create the `main` variant.
2. Restart Bind.
3. Wait for the `zones/%ZONE-NAME%.zone.signed` file to be created.
4. Create the `var1` variant.
5. Copy all keys from `main` to `var1`:
```sh
   cp key-dir/K%ZONE-NAME%* key-dir-var1/
```
6. Restart Bind

To verify that both variants of the zone have the same keys run the equivalent
of the following commnds, that should list the same DNSKEY, but maybe in
different order:
```sh
dig +noall +ans +nocrypt @127.15.10.37 inconsist-nsec-nsec3-1.dnssec10.xa dnskey
```
```sh
dig +noall +ans +nocrypt @127.15.10.38 inconsist-nsec-nsec3-1.dnssec10.xa dnskey
```

If different keys are listed, then do the following steps:

1. Stop Bind.
2. Removed signed files and keys for the `var1` zone.
```sh
   rm -i zones-var1/%ZONE-NAME%.zone.* key-dir-var1/K%ZONE-NAME%*
```
3. Copy all keys for the zone:
```sh
   cp key-dir/K%ZONE-NAME%* key-dir-var1/
```
4. Start Bind
5. Verify (see above).

## Synchronizing the keys and zones at checkout

The keys and signed zones are not stored in Git. When a branch has been checked
out Bind will create new keys and signature when started. Some steps must be
taken to manually sychronize the keys between the `main` view and the `var1`
view.

1. Stop Bind if running.
2. Clean the directories from signed zones and any keys for the `var1` view:
```sh
   rm -i zones/*.zone.* zones-var1/*.zone.* key-dir-var1/*
```
2. Start Bind.
3. Wait for the `zones/*.zone.signed` files to be created.
4. Stop Bind.
5. Removed signed files and keys for the `var1` zones.
```sh
   rm -i zones-var1/*.zone.* key-dir-var1/*
```
4. Copy all keys from `main` to `var1` which will be more than we need but that
   will create no problem.
```sh
   cp key-dir/K* key-dir-var1/
```
5. Start Bind.
6. Verify (see above).

## Starting and stopping Bind

To start or stop Bind go to the directory where `named.conf` is found,
```sh
cd test-zone-data/DNSSEC-TP/dnssec10/Bind
```
Start Bind with the following command where `$USER` has the owner of the git
tree, i.e. owner of the `Bind` directory and all file in that directory. In a
default installation of Ubuntu that user name is `ubuntu`.
```sh
sudo named -c $(pwd)/named.conf -u $USER
```
From the directory where Bind was started the following command stops Bind:
```sh
kill $(cat named.pid)
```
If the PID file is lost then named can be stopped with the following command,
which may kill other Bind processes (after confirmation):
```sh
killall -i named
```

## Reloading Bind

After update of `named.conf` or zone file run by Bind you must reload Bind:

```sh
kill -HUP $(cat named.pid)
```

## Checking Bind 

To see log output run the following command:
```sh
tail -50 /var/log/syslog | grep named
```
