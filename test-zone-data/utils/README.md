# Utilities for test zones

## keytag-from-dnskey

The [keytag-from-dnskey](keytag-from-dnskey) utility provides the key tag for a
DNSKEY record. Run `keytag-from-dnskey --help` for manual.

## sign-rrset

The [sign-rrset](sign-rrset) utility creates a valid RRSIG for an RRset using
the private key provided. Run `sign-rrset --help` for manual.

## verify-rrset

The [verify-rrset](verify-rrset) utility verifies if the provided RRSIG is a
valid signature for the given RRset using the provided DNSKEY. Run
`verify-rrset --help` for manual.

