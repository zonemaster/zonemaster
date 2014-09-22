package Zonemaster::Test::DNSSEC v0.0.2;

###
### This test module implements DNSSEC tests.
###

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use List::Util qw[min];
use List::MoreUtils qw[none];

use Readonly;

Readonly our $ALGO_STATUS_DEPRECATED => 1;
Readonly our $ALGO_STATUS_RESERVED   => 2;
Readonly our $ALGO_STATUS_UNASSIGNED => 3;
Readonly our $ALGO_STATUS_PRIVATE    => 4;
Readonly our $ALGO_STATUS_VALID      => 5;
### Table fetched from IANA on 2014-09-12
Readonly::Hash our %algo_properties => (
    0 => {
        status      => $ALGO_STATUS_RESERVED,
        description => q{Reserved},
    },
    1 => {
        status      => $ALGO_STATUS_DEPRECATED,
        description => q{RSA/MD5},
        mnemonic    => q{RSAMD5},
    },
    2 => {
        status      => $ALGO_STATUS_VALID,
        description => q{Diffie-Hellman},
        mnemonic    => q{DH},
    },
    3 => {
        status      => $ALGO_STATUS_VALID,
        description => q{DSA/SHA1},
        mnemonic    => q{DSA},
    },
    4 => {
        status      => $ALGO_STATUS_RESERVED,
        description => q{Reserved},
    },
    5 => {
        status      => $ALGO_STATUS_VALID,
        description => q{RSA/SHA1},
        mnemonic    => q{RSASHA1},
    },
    6 => {
        status      => $ALGO_STATUS_VALID,
        description => q{DSA-NSEC3-SHA1},
        mnemonic    => q{DSA-NSEC3-SHA1},
    },
    7 => {
        status      => $ALGO_STATUS_VALID,
        description => q{RSASHA1-NSEC3-SHA1},
        mnemonic    => q{RSASHA1-NSEC3-SHA1},
    },
    8 => {
        status      => $ALGO_STATUS_VALID,
        description => q{RSA/SHA-256},
        mnemonic    => q{RSA/SHA256},
    },
    9 => {
        status      => $ALGO_STATUS_RESERVED,
        description => q{Reserved},
    },
    10 => {
        status      => $ALGO_STATUS_VALID,
        description => q{RSA/SHA-512},
        mnemonic    => q{RSA/SHA512},
    },
    11 => {
        status      => $ALGO_STATUS_RESERVED,
        description => q{Reserved},
    },
    12 => {
        status      => $ALGO_STATUS_VALID,
        description => q{GOST R 34.10-2001},
        mnemonic    => q{ECC-GOST},
    },
    13 => {
        status      => $ALGO_STATUS_VALID,
        description => q{ECDSA Curve P-256 with SHA-256},
        mnemonic    => q{ECDSAP256SHA256},
    },
    14 => {
        status      => $ALGO_STATUS_VALID,
        description => q{ECDSA Curve P-384 with SHA-384},
        mnemonic    => q{ECDSAP384SHA384},
    },
    (map { $_ => {
               status      => $ALGO_STATUS_UNASSIGNED,
               description => q{Unassigned},
           } } (15..122) ),
    (map { $_ => {
               status      => $ALGO_STATUS_RESERVED,
               description => q{Reserved},
           } } (123..251) ),
    252 => {
        status      => $ALGO_STATUS_RESERVED,
        description => q{Reserved for Indirect Keys},
        mnemonic    => q{INDIRECT},
    },
    253 => {
        status      => $ALGO_STATUS_PRIVATE,
        description => q{private algorithm},
        mnemonic    => q{PRIVATEDNS},
    },
    254 => {
        status      => $ALGO_STATUS_PRIVATE,
        description => q{private algorithm OID},
        mnemonic    => q{PRIVATEOID},
    },
    255 => {
        status      => $ALGO_STATUS_RESERVED,
        description => q{Reserved},
    },
);


###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->dnssec01( $zone );
    if ( none { $_->tag eq 'NO_DS' } @results ) {
        push @results, $class->dnssec02( $zone );
        push @results, $class->dnssec03( $zone );
        push @results, $class->dnssec04( $zone );
        push @results, $class->dnssec05( $zone );
        push @results, $class->dnssec07( $zone );
        if ( grep { $_->tag eq q{DNSKEY_BUT_NOT_DS} or $_->tag eq q{DNSKEY_AND_DS} } @results ) {
            push @results, $class->dnssec06( $zone );
        }
        else {
            push @results,
              info(
                ADDITIONAL_DNSKEY_SKIPPED => { }
              );
        }
        push @results, $class->dnssec08( $zone );
        push @results, $class->dnssec09( $zone );
        push @results, $class->dnssec10( $zone );
    }

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        dnssec01 => [
            qw(
              DS_DIGTYPE_OK
              DS_DIGTYPE_NOT_OK
              NO_DS
              )
        ],
        dnssec02 => [
            qw(
              NO_DS
              DS_FOUND
              NO_DNSKEY
              COMMON_KEYTAGS
              DS_MATCHES_DNSKEY
              DS_DOES_NOT_MATCH_DNSKEY
              DS_MATCH_FOUND
              DS_MATCH_NOT_FOUND
              NO_COMMON_KEYTAGS
              )
        ],
        dnssec03 => [
            qw(
              NO_NSEC3PARAM
              MANY_ITERATIONS
              TOO_MANY_ITERATIONS
              ITERATIONS_OK
              )
        ],
        dnssec04 => [
            qw(
              REMAINING_SHORT
              REMAINING_LONG
              DURATION_LONG
              DURATION_OK
              )
        ],
        dnssec05 => [
            qw(
              ALGORITHM_DEPRECATED
              ALGORITHM_RESERVED
              ALGORITHM_UNASSIGNED
              ALGORITHM_PRIVATE
              ALGORITHM_OK
              ALGORITHM_UNKNOWN
              )
        ],
        dnssec06 => [
            qw(
              EXTRA_PROCESSING_OK
              EXTRA_PROCESSING_BROKEN
              )
        ],
        dnssec07 => [
            qw(
              ADDITIONAL_DNSKEY_SKIPPED
              DNSKEY_BUT_NOT_DS
              DNSKEY_AND_DS
              NEITHER_DNSKEY_NOR_DS
              DS_BUT_NOT_DNSKEY
              )
        ],
        dnssec08 => [
            qw(
              DNSKEY_SIGNATURE_OK
              DNSKEY_SIGNATURE_NOT_OK
              DNSKEY_SIGNED
              DNSKEY_NOT_SIGNED
              NO_KEYS_OR_NO_SIGS
              )
        ],
        dnssec09 => [
            qw(
              NO_KEYS_OR_NO_SIGS_OR_NO_SOA
              SOA_SIGNATURE_OK
              SOA_SIGNATURE_NOT_OK
              SOA_SIGNED
              SOA_NOT_SIGNED
              )
        ],
        dnssec10 => [
            qw(
              INVALID_NAME_FOUND
              INVALID_NAME_RCODE
              NSEC_COVERS
              NSEC_COVERS_NOT
              NSEC_SIG_VERIFY_ERROR
              NSEC_SIGNED
              NSEC_NOT_SIGNED
              HAS_NSEC
              NSEC3_COVERS
              NSEC3_COVERS_NOT
              NSE3C_SIG_VERIFY_ERROR
              NSEC3_SIGNED
              NSEC3_NOT_SIGNED
              HAS_NSEC3 )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        "ADDITIONAL_DNSKEY_SKIPPED" => "No DNSKEYs found. Additional tests skipped.",
        "ALGORITHM_DEPRECATED"    => "The DNSKEY with tag {keytag} uses deprecated algorithm number {algorithm}/({description}).",
        "ALGORITHM_OK"            => "The DNSKEY with tag {keytag} uses algorithm number {algorithm}/({description}), which is OK.",
        "ALGORITHM_RESERVED"      => "The DNSKEY with tag {keytag} uses reserved algorithm number {algorithm}/({description}).",
        "ALGORITHM_UNASSIGNED"    => "The DNSKEY with tag {keytag} uses unassigned algorithm number {algorithm}/({description}).",
        "ALGORITHM_PRIVATE"       => "The DNSKEY with tag {keytag} uses private algorithm number {algorithm}/({description}).",
        "ALGORITHM_UNKNOWN"       => "The DNSKEY with tag {keytag} uses unknown algorithm number {algorithm}.",
        "COMMON_KEYTAGS"          => "There are both DS and DNSKEY records with key tags {keytags}.",
        "DNSKEY_AND_DS"           => "{parent} sent a DS record, and {child} a DNSKEY record.",
        "DNSKEY_BUT_NOT_DS"       => "{child} sent a DNSKEY record, but {parent} did not send a DS record.",
        "DNSKEY_NOT_SIGNED"       => "The apex DNSKEY RRset was not correctly signed.",
        "DNSKEY_SIGNATURE_NOT_OK" => "Signature for DNSKEY with tag {signature} failed to verify with error '{error}'.",
        "DNSKEY_SIGNATURE_OK"     => "A signature for DNSKEY with tag {signature} was correctly signed.",
        "DNSKEY_SIGNED"           => "The apex DNSKEY RRset was correcly signed.",
        "DS_BUT_NOT_DNSKEY"       => "{parent} sent a DS record, but {child} did not send a DNSKEY record.",
        "DS_DIGTYPE_NOT_OK"       => "DS record with keytag {keytag} uses forbidden digest type {digtype}.",
        "DS_DIGTYPE_OK"           => "DS record with keytag {keytag} uses digest type {digtype}, which is OK.",
        "DS_DOES_NOT_MATCH_DNSKEY" => "DS record with keytag {keytag} does not match the DNSKEY with the same tag.",
        "DS_FOUND"                 => "Found DS records with tags {keytags}",
        "DS_MATCHES_DNSKEY"        => "DS record with keytag {keytag} matches the DNSKEY with the same tag.",
        "DS_MATCH_FOUND"           => "At least one DS record with a matching DNSKEY record was found.",
        "DS_MATCH_NOT_FOUND"       => "No DS record with a matching DNSKEY record was found.",
        "DURATION_LONG" => "RRSIG with keytag {tag} and covering type(s) {types} has a duration of {duration} seconds, which is too long.",
        "DURATION_OK" => "RRSIG with keytag {tag} and covering type(s) {types} has a duration of {duration} seconds, which is just fine.",
        "REMAINING_SHORT" => "RRSIG with keytag {tag} and covering type(s) {types} has a remaining validity of {duration} seconds, which is too short.",
        "REMAINING_LONG" => "RRSIG with keytag {tag} and covering type(s) {types} has a remaining validity of {duration} seconds, which is too long.",
        "DURATION_REMAINING_SHORT" => "",
        "DURATION_REMAINING_LONG"  => "",
        "DURATION_REMAINING_OK"    => "",
        "EXTRA_PROCESSING_BROKEN" => "Server at {server} sent {keys} DNSKEY records, and {sigs} RRSIG records.",
        "EXTRA_PROCESSING_OK"     => "Server at {server} sent {keys} DNSKEY records and {sigs} RRSIG records.",
        "HAS_NSEC"                => "The zone has NSEC records.",
        "HAS_NSEC3"               => "The zone has NSEC3 records.",
        "INVALID_NAME_FOUND" => "When asked for the name {name}, which must not exist, the response was not an error.",
        "INVALID_NAME_RCODE" => "When asked for the name {name}, which must not exist, the response had RCODE {rcode}.",
        "ITERATIONS_OK"      => "The number of NSEC3 iterations is {count}, which is OK.",
        "MANY_ITERATIONS"    => "The number of NSEC3 iterations is {count}, which is on the high side.",
        "NEITHER_DNSKEY_NOR_DS" => "There are neither DS nor DNSKEY records for the zone.",
        "NO_COMMON_KEYTAGS"     => "No DS record had a DNSKEY with a matching keytag.",
        "NO_DNSKEY"             => "No DNSKEYs were returned.",
        "NO_DS"                 => "{from} returned no DS records for {zone}.",
        "NO_KEYS_OR_NO_SIGS" =>
          "Cannot test DNSKEY signatures, because we got {keys} DNSKEY records and {sigs} RRSIG records.",
        "NO_KEYS_OR_NO_SIGS_OR_NO_SOA" =>
"Cannot test SOA signatures, because we got {keys} DNSKEY records, {sigs} RRSIG records and {soas} SOA records.",
        "NO_NSEC3PARAM"          => "{server} returned no NSEC3PARAM records.",
        "NSE3C_SIG_VERIFY_ERROR" => "Trying to verify NSEC3 RRset with RRSIG {sig} gave error '{error}'.",
        "NSEC3_COVERS"           => "NSEC3 record covers {name}.",
        "NSEC3_COVERS_NOT"       => "NSEC3 record does not cover {name}.",
        "NSEC3_NOT_SIGNED"       => "No signature correctly signed the NSEC3 RRset.",
        "NSEC3_SIGNED"           => "At least one signature correctly signed the NSEC3 RRset.",
        "NSEC_COVERS"            => "NSEC covers {name}.",
        "NSEC_COVERS_NOT"        => "NSEC does not cover {name}.",
        "NSEC_NOT_SIGNED"        => "No signature correctly signed the NSEC RRset.",
        "NSEC_SIGNED"            => "At least one signature correctly signed the NSEC RRset.",
        "NSEC_SIG_VERIFY_ERROR"  => "Trying to verify NSEC RRset with RRSIG {sig} gave error '{error}'.",
        "SOA_NOT_SIGNED"         => "No RRSIG correctly signed the SOA RRset.",
        "SOA_SIGNATURE_NOT_OK"   => "Trying to verify SOA RRset with signature {signature} gave error '{error}'.",
        "SOA_SIGNATURE_OK"       => "RRSIG {signature} correctly signs SOA RRset.",
        "SOA_SIGNED"             => "At least one RRSIG correctly signs the SOA RRset.",
        "TOO_MANY_ITERATIONS" =>
          "The number of NSEC3 iterations is {count}, which is too high for key length {keylength}.",
    };
} ## end sub translation

sub policy {
    return {
        "ADDITIONAL_DNSKEY_SKIPPED"    => "DEBUG",
        "ALGORITHM_DEPRECATED"         => "WARNING",
        "ALGORITHM_OK"                 => "INFO",
        "ALGORITHM_RESERVED"           => "ERROR",
        "ALGORITHM_UNASSIGNED"         => "ERROR",
        "COMMON_KEYTAGS"               => "INFO",
        "DNSKEY_AND_DS"                => "DEBUG",
        "DNSKEY_BUT_NOT_DS"            => "WARNING",
        "DNSKEY_NOT_SIGNED"            => "ERROR",
        "DNSKEY_SIGNATURE_NOT_OK"      => "ERROR",
        "DNSKEY_SIGNATURE_OK"          => "DEBUG",
        "DNSKEY_SIGNED"                => "DEBUG",
        "DS_BUT_NOT_DNSKEY"            => "ERROR",
        "DS_DIGTYPE_NOT_OK"            => "ERROR",
        "DS_DIGTYPE_OK"                => "DEBUG",
        "DS_DOES_NOT_MATCH_DNSKEY"     => "ERROR",
        "DS_FOUND"                     => "INFO",
        "DS_MATCHES_DNSKEY"            => "INFO",
        "DS_MATCH_FOUND"               => "INFO",
        "DS_MATCH_NOT_FOUND"           => "ERROR",
        "DURATION_LONG"                => "WARNING",
        "DURATION_OK"                  => "DEBUG",
        "DURATION_SHORT"               => "WARNING",
        "DURATION_REMAINING_LONG"      => "WARNING",
        "DURATION_REMAINING_OK"        => "DEBUG",
        "DURATION_REMAINING_SHORT"     => "WARNING",
        "EXTRA_PROCESSING_BROKEN"      => "ERROR",
        "EXTRA_PROCESSING_OK"          => "DEBUG",
        "HAS_NSEC"                     => "INFO",
        "HAS_NSEC3"                    => "INFO",
        "INVALID_NAME_FOUND"           => "NOTICE",
        "INVALID_NAME_RCODE"           => "NOTICE",
        "ITERATIONS_OK"                => "DEBUG",
        "MANY_ITERATIONS"              => "NOTICE",
        "NEITHER_DNSKEY_NOR_DS"        => "DEBUG",
        "NO_COMMON_KEYTAGS"            => "ERROR",
        "NO_DNSKEY"                    => "WARNING",
        "NO_DS"                        => "NOTICE",
        "NO_KEYS_OR_NO_SIGS"           => "ERROR",
        "NO_KEYS_OR_NO_SIGS_OR_NO_SOA" => "ERROR",
        "NO_NSEC3PARAM"                => "DEBUG",
        "NSE3C_SIG_VERIFY_ERROR"       => "ERROR",
        "NSEC3_COVERS"                 => "DEBUG",
        "NSEC3_COVERS_NOT"             => "WARNING",
        "NSEC3_NOT_SIGNED"             => "ERROR",
        "NSEC3_SIGNED"                 => "DEBUG",
        "NSEC_COVERS"                  => "DEBUG",
        "NSEC_COVERS_NOT"              => "WARNING",
        "NSEC_NOT_SIGNED"              => "ERROR",
        "NSEC_SIGNED"                  => "DEBUG",
        "NSEC_SIG_VERIFY_ERROR"        => "ERROR",
        "SOA_NOT_SIGNED"               => "ERROR",
        "SOA_SIGNATURE_NOT_OK"         => "ERROR",
        "SOA_SIGNATURE_OK"             => "DEBUG",
        "SOA_SIGNED"                   => "DEBUG",
        "TOO_MANY_ITERATIONS"          => "WARNING",
    };
} ## end sub policy

sub version {
    return "$Zonemaster::Test::DNSSEC::VERSION";
}

###
### Tests
###

sub dnssec01 {
    my ( $class, $zone ) = @_;
    my @results;

    my %type = ( 1 => 'SHA-1', 2 => 'SHA-256', 3 => 'GOST R 34.11-94', 4 => 'SHA-384' );

    return if not $zone->parent;
    my $ds_p = $zone->parent->query_one( $zone->name, 'DS', { dnssec => 1 } );
    die "No response from parent nameservers" if not $ds_p;
    my @ds = $ds_p->get_records( 'DS', 'answer' );

    if ( @ds == 0 ) {
        push @results,
          info(
            NO_DS => {
                zone => '' . $zone->name,
                from => $ds_p->answerfrom
            }
          );
    }
    else {
        foreach my $ds ( @ds ) {
            if ( $type{ $ds->digtype } ) {
                push @results,
                  info(
                    DS_DIGTYPE_OK => {
                        keytag  => $ds->keytag,
                        digtype => $type{ $ds->digtype },
                    }
                  );
            }
            else {
                push @results,
                  info(
                    DS_DIGTYPE_NOT_OK => {
                        keytag => $ds->keytag,
                        digtype => $ds->digtype
                    }
                  );
            }
        }
    }

    return @results;
} ## end sub dnssec01

sub dnssec02 {
    my ( $class, $zone ) = @_;
    my @results;

    return if not $zone->parent;
    my $ds_p = $zone->parent->query_one( $zone->name, 'DS', { dnssec => 1 } );
    die "No response from parent nameservers" if not $ds_p;
    my %ds = map { $_->keytag => $_ } $ds_p->get_records( 'DS', 'answer' );

    if ( scalar( keys %ds ) == 0 ) {
        push @results,
          info(
            NO_DS => {
                zone => '' . $zone->name,
                from => $ds_p->answerfrom,
            }
          );
    }
    else {
        push @results,
          info(
            DS_FOUND => {
                keytags => join( ':', map { $_->keytag } values %ds ),
            }
          );
        my $dnskey_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
        die "No response from child nameservers" if not $dnskey_p;
        my %dnskey = map { $_->keytag => $_ } $dnskey_p->get_records( 'DNSKEY', 'answer' );

        if ( scalar( keys %dnskey ) == 0 ) {
            push @results,
              info(
                NO_DNSKEY => { }
              );
            return @results;
        }

        # Pick out keys with a tag that a DS has using a hash slice
        my @common = grep { $_ } @dnskey{ keys %ds };

        if ( @common ) {
            push @results,
              info(
                COMMON_KEYTAGS => {
                    keytags => join( ':', map { $_->keytag } @common ),
                }
              );
            my $found = 0;
            foreach my $key ( @common ) {
                if ( $ds{ $key->keytag }->verify( $key ) ) {
                    push @results,
                      info(
                        DS_MATCHES_DNSKEY => {
                            keytag => $key->keytag,
                        }
                      );
                    $found = 1;
                }
                else {
                    push @results,
                      info(
                        DS_DOES_NOT_MATCH_DNSKEY => {
                            keytag => $key->keytag,
                        }
                      );
                }
            }
            if ( $found ) {
                push @results,
                  info(
                    DS_MATCH_FOUND => { }
                  );
            }
            else {
                push @results,
                  info(
                    DS_MATCH_NOT_FOUND => { }
                  );
            }
        }
        else {
            push @results,
              info(
                NO_COMMON_KEYTAGS => {
                    dstags     => join( ':', map { $_->keytag } keys %ds ),
                    dnskeytags => join( ':', map { $_->keytag } keys %dnskey ),
                }
              );
        }
    } ## end else [ if ( scalar( keys %ds ...))]

    return @results;
} ## end sub dnssec02

sub dnssec03 {
    my ( $self, $zone ) = @_;
    my @results;

    my $param_p = $zone->query_one( $zone->name, 'NSEC3PARAM', { dnssec => 1 } );
    die "No response from child zone nameservers" if not $param_p;
    my @nsec3params = $param_p->get_records( 'NSEC3PARAM', 'answer' );

    my $dk_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    die "No response from child zone nameservers" if not $dk_p;
    my @dnskey = $dk_p->get_records( 'DNSKEY', 'answer' );
    my $min_len = min map { $_->keysize } @dnskey;

    if ( @nsec3params == 0 ) {
        push @results,
          info(
            NO_NSEC3PARAM => {
                server => $param_p->answerfrom,
            }
          );
    }
    else {
        foreach my $n3p ( @nsec3params ) {
            my $iter = $n3p->iterations;
            if ( $iter > 100 ) {
                push @results,
                  info(
                    MANY_ITERATIONS => {
                        count => $iter,
                    }
                  );
                if (   ( $min_len >= 4096 and $iter > 2500 )
                    or ( $min_len >= 2048 and $iter > 500 )
                    or ( $min_len >= 1024 and $iter > 150 ) )
                {
                    push @results,
                      info(
                        TOO_MANY_ITERATIONS => {
                            count     => $iter,
                            keylength => $min_len,
                        }
                      );
                }
            }
            else {
                push @results,
                  info(
                    ITERATIONS_OK => {
                        count => $iter,
                    }
                  );
            }
        }
    }

    return @results;
} ## end sub dnssec03

sub dnssec04 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    if ( not $key_p ) {
        die "No response from child nameservers";
    }
    my @keys     = $key_p->get_records( 'DNSKEY', 'answer' );
    my @key_sigs = $key_p->get_records( 'RRSIG',  'answer' );

    my $soa_p = $zone->query_one( $zone->name, 'SOA', { dnssec => 1 } );
    if ( not $soa_p ) {
        die "No response from child nameservers";
    }
    my @soas     = $soa_p->get_records( 'SOA',   'answer' );
    my @soa_sigs = $soa_p->get_records( 'RRSIG', 'answer' );

    foreach my $sig ( @key_sigs, @soa_sigs ) {
        my $duration = $sig->expiration - $sig->inception;
        my $remaining = $sig->expiration - int(time());
        if ( $remaining < ( 12 * 60 * 60 ) ) {    # 12 hours
            push @results,
              info(
                REMAINING_SHORT => {
                    duration => $remaining,
                    tag      => $sig->keytag,
                    types    => $sig->typecovered,
                }
              );
        }
        elsif ( $remaining > ( 180 * 24 * 60 * 60 ) ) {    # 180 days
            push @results,
              info(
                REMAINING_LONG => {
                    duration => $remaining,
                    tag      => $sig->keytag,
                    types    => $sig->typecovered,
                }
              );
        }
        elsif ( $duration > ( 180 * 24 * 60 * 60 ) ) {    # 180 days
            push @results,
              info(
                DURATION_LONG => {
                    duration => $duration,
                    tag      => $sig->keytag,
                    types    => $sig->typecovered,
                }
              );
        }
        else {
            push @results,
              info(
                DURATION_OK => {
                    duration => $duration,
                    tag      => $sig->keytag,
                    types    => $sig->typecovered,
                }
              );
        }
    }

    return @results;
} ## end sub dnssec04

sub dnssec05 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    if ( not $key_p ) {
        die "No response from child nameservers";
    }
    my @keys = $key_p->get_records( 'DNSKEY', 'answer' );

    foreach my $key ( @keys ) {
        my $algo = $key->algorithm;
        if ( $algo_properties{$algo}{status} == $ALGO_STATUS_DEPRECATED ) {
            push @results,
              info(
                ALGORITHM_DEPRECATED => {
                    algorithm   => $algo,
                    keytag      => $key->keytag,
                    description => $algo_properties{$algo}{description},
                }
              );
        }
        elsif ( $algo_properties{$algo}{status} == $ALGO_STATUS_RESERVED ) {
            push @results,
              info(
                ALGORITHM_RESERVED => {
                    algorithm   => $algo,
                    keytag      => $key->keytag,
                    description => $algo_properties{$algo}{description},
                }
              );
        }
        elsif ( $algo_properties{$algo}{status} == $ALGO_STATUS_UNASSIGNED ) {
            push @results,
              info(
                ALGORITHM_UNASSIGNED => {
                    algorithm   => $algo,
                    keytag      => $key->keytag,
                    description => $algo_properties{$algo}{description},
                }
              );
        }
        elsif ( $algo_properties{$algo}{status} == $ALGO_STATUS_PRIVATE ) {
            push @results,
              info(
                ALGORITHM_PRIVATE => {
                    algorithm   => $algo,
                    keytag      => $key->keytag,
                    description => $algo_properties{$algo}{description},
                }
              );
        }
        elsif ( $algo_properties{$algo}{status} == $ALGO_STATUS_VALID ) {
            push @results,
              info(
                ALGORITHM_OK => {
                    algorithm   => $algo,
                    keytag      => $key->keytag,
                    description => $algo_properties{$algo}{description},
                }
              );
        }
        else {
            push @results,
              info(
                ALGORITHM_UNKNOWN => {
                    algorithm => $algo,
                    keytag    => $key->keytag,
                }
              );
        }
    } ## end foreach my $key ( @keys )

    return @results;
} ## end sub dnssec05

sub dnssec06 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_aref = $zone->query_all( $zone->name, 'DNSKEY', { dnssec => 1 } );
    foreach my $key_p ( @$key_aref ) {
        next if not $key_p;

        my @keys = $key_p->get_records( 'DNSKEY', 'answer' );
        my @sigs = $key_p->get_records( 'RRSIG',  'answer' );
        if ( @sigs > 0 and @keys > 0 ) {
            push @results,
              info(
                EXTRA_PROCESSING_OK => {
                    server => $key_p->answerfrom,
                    keys   => scalar( @keys ),
                    sigs   => scalar( @sigs ),
                }
              );
        }
        else {
            push @results,
              info(
                EXTRA_PROCESSING_BROKEN => {
                    server => $key_p->answerfrom,
                    keys   => scalar( @keys ),
                    sigs   => scalar( @sigs )
                }
              );
        }
    }

    return @results;
} ## end sub dnssec06

sub dnssec07 {
    my ( $self, $zone ) = @_;
    my @results;

    return if not $zone->parent;
    my $key_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    if ( not $key_p ) {
        die "No response from child nameservers";
    }
    my ( $dnskey ) = $key_p->get_records( 'DNSKEY', 'answer' );

    my $ds_p = $zone->parent->query_one( $zone->name, 'DS', { dnssec => 1 } );
    if ( not $ds_p ) {
        die "No response from parent nameservers";
    }
    my ( $ds ) = $ds_p->get_records( 'DS', 'answer' );

    if ( $dnskey and not $ds ) {
        push @results,
          info(
            DNSKEY_BUT_NOT_DS => {
                child  => $key_p->answerfrom,
                parent => $ds_p->answerfrom,
            }
          );
    }
    elsif ( $dnskey and $ds ) {
        push @results,
          info(
            DNSKEY_AND_DS => {
                child => $key_p->answerfrom,
                parent => $ds_p->answerfrom,
            }
          );
    }
    elsif ( not $dnskey and $ds ) {
        push @results,
          info(
            DS_BUT_NOT_DNSKEY => {
                child  => $key_p->answerfrom,
                parent => $ds_p->answerfrom,
            }
          );
    }
    else {
        push @results,
          info(
            NEITHER_DNSKEY_NOR_DS => {
                child  => $key_p->answerfrom,
                parent => $ds_p->answerfrom,
            }
          );
    }

    return @results;
} ## end sub dnssec07

sub dnssec08 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    if ( not $key_p ) {
        die "No response from child servers";
    }
    my @dnskeys = $key_p->get_records( 'DNSKEY', 'answer' );
    my @sigs    = $key_p->get_records( 'RRSIG',  'answer' );

    if ( @dnskeys == 0 or @sigs == 0 ) {
        push @results,
          info(
            NO_KEYS_OR_NO_SIGS => {
                keys => scalar( @dnskeys ),
                sigs => scalar( @sigs ),
            }
          );
        return @results;
    }

    my $ok = 0;
    foreach my $sig ( @sigs ) {
        my $msg  = '';
        my $time = $key_p->timestamp;
        if ( $sig->verify_time( \@dnskeys, \@dnskeys, $time, $msg ) ) {
            push @results,
              info(
                DNSKEY_SIGNATURE_OK => {
                    signature => $sig->keytag,
                }
              );
            $ok = $sig->keytag;
        }
        else {
            push @results,
              info(
                DNSKEY_SIGNATURE_NOT_OK => {
                    signature => $sig->keytag,
                    error     => $msg,
                    time      => $time,
                }
              );
        }
    }

    if ( $ok ) {
        push @results,
          info(
            DNSKEY_SIGNED => {
                keytag => $ok,
            }
          );
    }
    else {
        push @results,
          info(
            DNSKEY_NOT_SIGNED => {}
          );
    }

    return @results;
} ## end sub dnssec08

sub dnssec09 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    if ( not $key_p ) {
        die "No response from child servers for DNSKEY";
    }
    my @dnskeys = $key_p->get_records( 'DNSKEY', 'answer' );

    my $soa_p = $zone->query_one( $zone->name, 'SOA', { dnssec => 1 } );
    if ( not $soa_p ) {
        die "No response from child servers for SOA";
    }
    my @soa  = $soa_p->get_records( 'SOA',   'answer' );
    my @sigs = $soa_p->get_records( 'RRSIG', 'answer' );

    if ( @dnskeys == 0 or @sigs == 0 or @soa == 0 ) {
        push @results,
          info(
            NO_KEYS_OR_NO_SIGS_OR_NO_SOA => {
                keys => scalar( @dnskeys ),
                sigs => scalar( @sigs ),
                soas => scalar( @soa ),
            }
          );
        return @results;
    }

    my $ok = 0;
    foreach my $sig ( @sigs ) {
        my $msg  = '';
        my $time = $soa_p->timestamp;
        if ( $sig->verify_time( \@soa, \@dnskeys, $time, $msg ) ) {
            push @results,
              info(
                SOA_SIGNATURE_OK => {
                    signature => $sig->keytag,
                }
              );
            $ok = $sig->keytag;
        }
        else {
            push @results,
              info(
                SOA_SIGNATURE_NOT_OK => {
                    signature => $sig->keytag,
                    error     => $msg,
                 }
               );
        }
    }

    if ( $ok ) {
        push @results,
          info(
            SOA_SIGNED => {
                keytag => $ok,
            }
          );
    }
    else {
        push @results,
          info(
            SOA_NOT_SIGNED => { }
          );
    }

    return @results;
} ## end sub dnssec09

sub dnssec10 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
    if ( not $key_p ) {
        die "No response from child servers for DNSKEY";
    }
    my @dnskeys = $key_p->get_records( 'DNSKEY', 'answer' );

    my $name = $zone->name->prepend( 'xx--example' );
    my $test_p = $zone->query_one( $name, 'A', { dnssec => 1 } );
    if ( not $test_p ) {
        die "No response from child servers for A";
    }

    if ( $test_p->rcode eq 'NOERROR' ) {
        push @results,
          info(
            INVALID_NAME_FOUND => {
                name => $name,
            }
          );
        return @results;
    }

    if ( $test_p->rcode ne 'NXDOMAIN' ) {
        push @results,
          info(
            INVALID_NAME_RCODE => {
                name  => $name,
                rcode => $test_p->rcode,
            }
          );
        return @results;
    }

    my @nsec = $test_p->get_records( 'NSEC', 'authority' );
    if ( @nsec ) {
        push @results, info( HAS_NSEC => {} );
        my $covered = 0;
        foreach my $nsec ( @nsec ) {

            if ( $nsec->covers( $name ) ) {
                $covered = 1;

                my @sigs = grep { $_->typecovered eq 'NSEC' } $test_p->get_records_for_name( 'RRSIG', $nsec->name );
                my $ok = 0;
                foreach my $sig ( @sigs ) {
                    my $msg = '';
                    if (
                        $sig->verify_time(
                            [ grep { $_->name eq $sig->name } @nsec ],
                            \@dnskeys, $test_p->timestamp, $msg
                        )
                      )
                    {
                        $ok = 1;
                    }
                    else {
                        push @results,
                          info(
                            NSEC_SIG_VERIFY_ERROR => {
                                error => $msg,
                                sig   => $sig->keytag,
                            }
                          );
                    }

                    if ( $ok ) {
                        push @results,
                          info(
                            NSEC_SIGNED => {}
                          );
                    }
                    else {
                        push @results,
                          info(
                            NSEC_NOT_SIGNED => {}
                        );
                    }
                } ## end foreach my $sig ( @sigs )
            } ## end if ( $nsec->covers( $name...))
        } ## end foreach my $nsec ( @nsec )
        if ( $covered ) {
            push @results,
              info(
                NSEC_COVERS => {
                    name => $name,
                }
              );
        }
        else {
            push @results,
              info(
                NSEC_COVERS_NOT => {
                    name => $name,
                }
              );
        }
    } ## end if ( @nsec )

    my @nsec3 = $test_p->get_records( 'NSEC3', 'authority' );
    if ( @nsec3 ) {
        my $covered = 0;
        push @results, info( HAS_NSEC3 => {} );
        foreach my $nsec3 ( @nsec3 ) {

            if ( $nsec3->covers( $name ) ) {
                $covered = 1;

                my @sigs = grep { $_->typecovered eq 'NSEC3' } $test_p->get_records_for_name( 'RRSIG', $nsec3->name );
                my $ok = 0;
                foreach my $sig ( @sigs ) {
                    my $msg = '';
                    if (
                        $sig->verify_time(
                            [ grep { $_->name eq $sig->name } @nsec3 ],
                            \@dnskeys, $test_p->timestamp, $msg
                        )
                      )
                    {
                        $ok = 1;
                    }
                    else {
                        push @results,
                          info(
                            NSEC3_SIG_VERIFY_ERROR => {
                                sig   => $sig->keytag,
                                error => $msg,
                            }
                          );
                    }
                    if ( $ok ) {
                        push @results,
                          info(
                            NSEC3_SIGNED => {}
                          );
                    }
                    else {
                        push @results,
                          info(
                            NSE3C_NOT_SIGNED => {}
                          );
                    }
                } ## end foreach my $sig ( @sigs )
            } ## end if ( $nsec3->covers( $name...))
        } ## end foreach my $nsec3 ( @nsec3 )
        if ( $covered ) {
            push @results,
              info(
                NSEC3_COVERS => {
                    name => $name,
                }
              );
        }
        else {
            push @results,
              info(
                NSEC3_COVERS_NOT => {
                    name => $name,
                }
              );
        }
    } ## end if ( @nsec3 )

    return @results;
} ## end sub dnssec10

1;

=head1 NAME

Zonemaster::Test::DNSSEC - dnssec module showing the expected structure of Zonemaster test modules

=head1 SYNOPSIS

    my @results = Zonemaster::Test::DNSSEC->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests.

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

=item translation()

Returns a reference to a nested hash, where the outermost keys are language
codes, the keys below that are message tags and their values are translation
strings.

=item policy()

Returns a reference to a hash with the default policy for the module. The keys
are message tags, and the corresponding values are their default log levels.

=item version()

Returns a version string for the module.

=back

=head1 TESTS

=over

=item dnssec01($zone)

Verifies that all DS records have digest types registered with IANA.

=item dnssec02($zone)

Verifies that all DS records have a matching DNSKEY.

=item dnssec03($zone)

Check iteration counts for NSEC3.

=item dnssec04($zone)

Checks the durations of the signatures for the DNSKEY and SOA RRsets.

=item dnssec05($zone)

Check DNSKEY algorithms.

=item dnssec06($zone)

Check for DNSSEC extra processing at child nameservers.

=item dnssec07($zone)

Check that both DS and DNSKEY are present.

=item dnssec08($zone)

Check that the DNSKEY RRset is signed.

=item dnssec09($zone)

Check that the SOA RRset is signed.

=item dnssec10($zone)

Check for the presence of either NSEC or NSEC3, with proper coverage and signatures.

=back

=cut
