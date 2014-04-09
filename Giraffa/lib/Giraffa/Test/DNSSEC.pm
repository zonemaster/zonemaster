package Giraffa::Test::DNSSEC v0.0.1;

###
### This test module implements DNSSEC tests.
###

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;
use List::Util qw[min];

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->dnssec01( $zone );
    push @results, $class->dnssec02( $zone );
    push @results, $class->dnssec03( $zone );
    push @results, $class->dnssec04( $zone );
    push @results, $class->dnssec05( $zone );
    push @results, $class->dnssec06( $zone );
    push @results, $class->dnssec07( $zone );
    push @results, $class->dnssec08( $zone );
    push @results, $class->dnssec09( $zone );
    push @results, $class->dnssec10( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        dnssec01 => [qw( DS_DIGTYPE_OK DS_DIGTYPE_NOT_OK NO_DS )],
        dnssec02 =>
          [qw( NO_DS NO_DNSKEY_FOR_DS DS_MATCHES_DNSKEY DS_DOES_NOT_MATCH_DNSKEY MATCH_FOUND MATCH_NOT_FOUND )],
        dnssec03 => [qw( NO_NSEC3PARAM MANY_ITERATIONS TOO_MANY_ITERATIONS ITERATIONS_OK  )],
        dnssec04 => [qw( DURATION_SHORT DURATION_LONG DURATION_OK )],
        dnssec05 => [qw( ALGORITHM_DEPRECATED ALGORITHM_RESERVED ALGORITHM_UNASSIGNED ALGORITHM_OK )],
        dnssec06 => [qw( EXTRA_PROCESSING_OK EXTRA_PROCESSING_BROKEN )],
        dnssec07 => [qw()],
        dnssec08 => [qw()],
        dnssec09 => [qw()],
        dnssec10 => [qw()],
    };
}

sub version {
    return "$Giraffa::Test::DNSSEC::VERSION";
}

###
### Tests
###

sub dnssec01 {
    my ( $class, $zone ) = @_;
    my @results;

    my %type = ( 1 => 'SHA-1', 2 => 'SHA-256', 3 => 'GOST R 34.11-94', 4 => 'SHA-384' );

    my $ds_p = $zone->parent->query_one( $zone->name, 'DS', { dnssec => 1 } );
    die "No response from parent nameservers" if not $ds_p;
    my @ds = $ds_p->get_records( 'DS', 'answer' );

    if ( @ds == 0 ) {
        push @results, info( NO_DS => { zone => '' . $zone->name, from => $ds_p->answerfrom } );
    }
    else {
        foreach my $ds ( @ds ) {
            if ( $type{ $ds->digtype } ) {
                push @results, info( DS_DIGTYPE_OK => { keytag => $ds->keytag, digtype => $type{ $ds->digtype } } );
            }
            else {
                push @results, info( DS_DIGTYPE_NOT_OK => { keytag => $ds->keytag, digtype => $ds->digtype } );
            }
        }
    }

    return @results;
} ## end sub dnssec01

sub dnssec02 {
    my ( $class, $zone ) = @_;
    my @results;

    my $ds_p = $zone->parent->query_one( $zone->name, 'DS', { dnssec => 1 } );
    die "No response from parent nameservers" if not $ds_p;
    my @ds = $ds_p->get_records( 'DS', 'answer' );

    if ( @ds == 0 ) {
        push @results, info( NO_DS => { zone => '' . $zone->name, from => $ds_p->answerfrom } );
    }
    else {
        my $dnskey_p = $zone->query_one( $zone->name, 'DNSKEY', { dnssec => 1 } );
        die "No response from child nameservers" if not $dnskey_p;
        my %dnskey = map { $_->keytag => $_ } $dnskey_p->get_records( 'DNSKEY', 'answer' );
        my $match_found = 0;

        foreach my $ds ( @ds ) {
            if ( not $dnskey{ $ds->keytag } ) {
                push @results, info( NO_DNSKEY_FOR_DS => { keytag => $ds->keytag } );
            }
            foreach my $key ( values %dnskey ) {
                next if ( $key->algorithm != $ds->algorithm );
                if ( $ds->verify( $key ) ) {
                    push @results,
                      info(
                        DS_MATCHES_DNSKEY => { ds => $ds->keytag, dnskey => $key->keytag, algorithm => $ds->algorithm }
                      );
                    $match_found = 1;
                }
                else {
                    push @results,
                      info( DS_DOES_NOT_MATCH_DNSKEY =>
                          { ds => $ds->keytag, dnskey => $key->keytag, algorithm => $ds->algorithm } );
                }
            }
        } ## end foreach my $ds ( @ds )
        if ( $match_found ) {
            push @results, info( MATCH_FOUND => {} );
        }
        else {
            push @results, info( MATCH_NOT_FOUND => {} );
        }
    } ## end else [ if ( @ds == 0 ) ]

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
        push @results, info( NO_NSEC3PARAM => {} );
    }
    else {
        foreach my $n3p ( @nsec3params ) {
            my $iter = $n3p->iterations;
            if ( $iter > 100 ) {
                push @results, info( MANY_ITERATIONS => { count => $iter } );
                if (   ( $min_len >= 4096 and $iter > 2500 )
                    or ( $min_len >= 2048 and $iter > 500 )
                    or ( $min_len >= 1024 and $iter > 150 ) )
                {
                    push @results, info( TOO_MANY_ITERATIONS => { count => $iter, keylength => $min_len } );
                }
            }
            else {
                push @results, info( ITERATIONS_OK => { count => $iter } );
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
        if ( $duration < ( 12 * 60 * 60 ) ) {    # 12 hours
            push @results,
              info( DURATION_SHORT => { duration => $duration, tag => $sig->keytag, types => $sig->typecovered } );
        }
        elsif ( $duration > ( 180 * 24 * 60 * 60 ) ) {    # 180 days
            push @results,
              info( DURATION_LONG => { duration => $duration, tag => $sig->keytag, types => $sig->typecovered } );
        }
        else {
            push @results,
              info( DURATION_OK => { duration => $duration, tag => $sig->keytag, types => $sig->typecovered } );
        }
    }

    return @results;
} ## end sub dnssec04

### Table fetched from IANA on 2014-03-28
# 0	        Reserved
# 1	        RSA/MD5 (deprecated)
# 2	        Diffie-Hellman
# 3	        DSA/SHA1
# 4	        Reserved
# 5	        RSA/SHA-1
# 6	        DSA-NSEC3-SHA1
# 7	        RSASHA1-NSEC3-SHA1
# 8	        RSA/SHA-256
# 9	        Reserved
# 10	    RSA/SHA-512
# 11	    Reserved
# 12	    GOST R 34.10-2001
# 13	    ECDSA Curve P-256 with SHA-256
# 14	    ECDSA Curve P-384 with SHA-384
# 15-122	Unassigned
# 123-251	Reserved
# 252	    Reserved for Indirect Keys
# 253	    private algorithm
# 254	    private algorithm OID
# 255	    Reserved

our %algo_name = (
    2  => 'Diffie-Hellman',
    3  => 'DSA/SHA1',
    5  => 'RSA/SHA-1',
    6  => 'DSA-NSEC3-SHA1',
    7  => 'RSASHA1-NSEC3-SHA1',
    8  => 'RSA/SHA-256',
    10 => 'RSA/SHA-512',
    12 => 'GOST R 34.10-2001',
    13 => 'ECDSA Curve P-256 with SHA-256',
    14 => 'ECDSA Curve P-384 with SHA-384',
);

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
        if ( $algo == 1 ) {
            push @results, info( ALGORITHM_DEPRECATED => { algorithm => $algo, keytag => $key->keytag } );
        }
        elsif (( $algo == 0 )
            or ( $algo == 4 )
            or ( $algo == 9 )
            or ( $algo == 11 )
            or ( $algo >= 123 and $algo <= 252 )
            or ( $algo == 255 ) )
        {
            push @results, info( ALGORITHM_RESERVED => { algorithm => $algo, keytag => $key->keytag } );
        }
        elsif ( $algo >= 15 and $algo <= 122 ) {
            push @results, info( ALGORITHM_UNASSIGNED => { algorithm => $algo, keytag => $key->keytag } );
        }
        else {
            push @results,
              info( ALGORITHM_OK => { algorithm => $algo, name => $algo_name{$algo}, keytag => $key->keytag } );
        }
    } ## end foreach my $key ( @keys )

    return @results;
} ## end sub dnssec05

sub dnssec06 {
    my ( $self, $zone ) = @_;
    my @results;

    my $key_aref = $zone->query_all( $zone->name, 'DNSKEY', { dnssec => 1 });
    foreach my $key_p (@$key_aref) {
        next if not $key_p;

        my @keys = $key_p->get_records('DNSKEY', 'answer');
        my @sigs = $key_p->get_records('RRSIG', 'answer');
        if (@sigs > 0 and @keys > 0) {
            push @results, info( EXTRA_PROCESSING_OK => { server => $key_p->answerfrom, keys => scalar(@keys), sigs => scalar(@sigs) });
        } else {
            push @results, info( EXTRA_PROCESSING_BROKEN => { server => $key_p->answerfrom, keys => scalar(@keys), sigs => scalar(@sigs) });
        }
    }

    return @results;
}

sub dnssec07 {
    my ( $self, $zone ) = @_;
    my @results;

    return @results;
}

sub dnssec08 {
    my ( $self, $zone ) = @_;
    my @results;

    return @results;
}

sub dnssec09 {
    my ( $self, $zone ) = @_;
    my @results;

    return @results;
}

sub dnssec10 {
    my ( $self, $zone ) = @_;
    my @results;

    return @results;
}

1;

=head1 NAME

Giraffa::Test::DNSSEC - dnssec module showing the expected structure of Giraffa test modules

=head1 SYNOPSIS

    my @results = Giraffa::Test::DNSSEC->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests.

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

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

=back

=cut
