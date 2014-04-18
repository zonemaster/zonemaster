package Giraffa::Test::Zone v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

use Carp;

use Readonly;

Readonly our $SOA_REFRESH_MINIMUM_VALUE     =>  14_400; # 14400 seconds (4 hours)
Readonly our $SOA_RETRY_MINIMUM_VALUE       =>   3_600; # 3600 seconds (1 hour)
Readonly our $SOA_EXPIRE_MINIMUM_VALUE      => 604_800; # 604800 seconds (7 days)
Readonly our $SOA_DEFAULT_TTL_MAXIMUM_VALUE =>  86_400; # 86400 seconds (1 day)
Readonly our $SOA_DEFAULT_TTL_MINIMUM_VALUE =>     300; # 300 seconds (5 minutes)

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->zone1( $zone );
    push @results, $class->zone2( $zone );
    push @results, $class->zone3( $zone );
    push @results, $class->zone4( $zone );
    push @results, $class->zone5( $zone );
    push @results, $class->zone6( $zone );
    push @results, $class->zone7( $zone );
    push @results, $class->zone8( $zone );
    push @results, $class->zone9( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        zone1 => [qw()],
        zone2 => [qw(REFRESH_MINIMUM_VALUE_LOWER)],
        zone3 => [qw(REFRESH_LOWER_THAN_RETRY)],
        zone4 => [qw(RETRY_MINIMUM_VALUE_LOWER)],
        zone5 => [qw(EXPIRE_MINIMUM_VALUE_LOWER EXPIRE_LOWER_THAN_REFRESH)],
        zone6 => [qw(SOA_DEFAULT_TTL_MAXIMUM_VALUE_HIGHER SOA_DEFAULT_TTL_MAXIMUM_VALUE_LOWER)],
        zone7 => [qw(MASTER_IS_AN_ALIAS)],
        zone8 => [qw(MX_RECORD_IS_CNAME)],
        zone9 => [qw(NO_MX_RECORD)],
    };
} ## end sub metadata

sub version {
    return "$Giraffa::Test::Zone::VERSION";
}

sub zone1 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
} ## end sub zone1

sub zone2 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )     = $p->get_records( q{SOA}, q{answer} );
        my $soa_refresh = $soa->refresh;
        if ( $soa_refresh < $SOA_REFRESH_MINIMUM_VALUE ) {
            push @results,
              info(
                REFRESH_MINIMUM_VALUE_LOWER => {
                    refresh          => $soa_refresh,
                    required_refresh => $SOA_REFRESH_MINIMUM_VALUE,
                }
              );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone2

sub zone3 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )     = $p->get_records( q{SOA}, q{answer} );
        my $soa_retry   = $soa->retry;
        my $soa_refresh = $soa->refresh;
        if ( $soa_retry >= $soa_refresh ) {
            push @results,
              info(
                REFRESH_LOWER_THAN_RETRY => {
                    retry   => $soa_retry,
                    refresh => $soa_refresh,
                }
              );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone3

sub zone4 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )   = $p->get_records( q{SOA}, q{answer} );
        my $soa_retry = $soa->retry;
        if ( $soa_retry < $SOA_RETRY_MINIMUM_VALUE ) {
            push @results,
              info(
                RETRY_MINIMUM_VALUE_LOWER => {
                    retry          => $soa_retry,
                    required_retry => $SOA_RETRY_MINIMUM_VALUE,
                }
              );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone4

sub zone5 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )     = $p->get_records( q{SOA}, q{answer} );
        my $soa_expire  = $soa->expire;
        my $soa_refresh = $soa->refresh;
        if ( $soa_expire < $SOA_EXPIRE_MINIMUM_VALUE ) {
            push @results,
              info(
                EXPIRE_MINIMUM_VALUE_LOWER => {
                    expire          => $soa_expire,
                    required_expire => $SOA_EXPIRE_MINIMUM_VALUE,
                }
              );
        }
        if ( $soa_expire < $soa_refresh ) {
            push @results,
              info(
                EXPIRE_LOWER_THAN_REFRESH => {
                    expire  => $soa_expire,
                    refresh => $soa_refresh,
                }
              );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone5

sub zone6 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )     = $p->get_records( q{SOA}, q{answer} );
        my $soa_minimum = $soa->minimum;
        if ( $soa_minimum > $SOA_DEFAULT_TTL_MAXIMUM_VALUE ) {
            push @results,
              info(
                SOA_DEFAULT_TTL_MAXIMUM_VALUE_HIGHER => {
                    minimum          => $soa_minimum,
                    highest_minimum  => $SOA_DEFAULT_TTL_MAXIMUM_VALUE,
                }
              );
        }
        elsif ( $soa_minimum < $SOA_DEFAULT_TTL_MINIMUM_VALUE ) {
            push @results,
              info(
                SOA_DEFAULT_TTL_MAXIMUM_VALUE_LOWER => {
                    minimum        => $soa_minimum,
                    lowest_minimum => $SOA_DEFAULT_TTL_MINIMUM_VALUE,
                }
              );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone6

sub zone7 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )   = $p->get_records( q{SOA}, q{answer} );
        my $soa_mname = $soa->mname;
        my $p_mname = Giraffa::Recursor->recurse( $soa_mname, q{A} );

        if ( $p_mname ) {
            if ( $p_mname->has_rrs_of_type_for_name( q{CNAME}, $soa_mname ) ) {
                push @results,
                  info(
                    MASTER_IS_AN_ALIAS => {
                        mname   => $soa_mname,
                    }
                  );
            }
        }

    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone7

sub zone8 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{MX} );

    if ( $p ) {
        if ( $p->has_rrs_of_type_for_name( q{CNAME}, $zone->name ) ) {
            push @results,
              info( MX_RECORD_IS_CNAME => { } );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone8

sub zone9 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{MX} );

    if ( $p ) {
        if ( not $p->has_rrs_of_type_for_name( q{MX}, $zone->name ) ) {
            my $p_a    = $zone->query_one( $zone->name, q{A} );
            my $p_aaaa = $zone->query_one( $zone->name, q{AAAA} );
            if (    not $p_a->has_rrs_of_type_for_name( q{A}, $zone->name ) 
                and not $p_aaaa->has_rrs_of_type_for_name( q{AAAA}, $zone->name ) ) {
                push @results,
                  info( NO_MX_RECORD => { } );
            }
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone9

1;

=head1 NAME

Giraffa::Test::Zone - module implementing tests of the zone content in DNS, such as SOA and MX records

=head1 SYNOPSIS

    my @results = Giraffa::Test::Zone->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

=item version()

Returns a version string for the module.

=back

=head1 TESTS

=over

=item zone1($zone)

Not yet implemented.

=item zone2($zone)

Verify SOA 'refresh' minimum value.

=item zone3($zone)

Verify SOA 'retry' value  is lower than SOA 'refresh' value.

=item zone4($zone)

Verify SOA 'retry' minimum value.

=item zone5($zone)

Verify SOA 'expire' minimum value.

=item zone6($zone)

Verify SOA 'minimum' (default TTL) value.

=item zone7($zone)

Verify that SOA master is not an alias (CNAME).

=item zone8($zone)

Verify that MX records does not resolve to a CNAME.

=item zone9($zone)

Verify that there is a target host (MX, A or AAAA) to deliver e-mail for the domain name.

=back

=cut
