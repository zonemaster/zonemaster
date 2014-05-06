package Giraffa::Test::Zone v0.0.5;

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

    push @results, $class->zone01( $zone );
    push @results, $class->zone02( $zone );
    push @results, $class->zone03( $zone );
    push @results, $class->zone04( $zone );
    push @results, $class->zone05( $zone );
    push @results, $class->zone06( $zone );
    push @results, $class->zone07( $zone );
    if ( not grep { $_->tag eq q{MNAME_RECORD_DOES_NOT_EXIST} } @results ) {
        push @results, $class->zone08( $zone );
        push @results, $class->zone09( $zone );
    }

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        zone01 => [
            qw(
              MNAME_RECORD_DOES_NOT_EXIST
              MNAME_NOT_AUTHORITATIVE
              MNAME_NO_RESPONSE MNAME_NOT_IN_GLUE
              )
        ],
        zone02 => [
            qw(
              REFRESH_MINIMUM_VALUE_LOWER
              )
        ],
        zone03 => [
            qw(
              REFRESH_LOWER_THAN_RETRY
              )
        ],
        zone04 => [
            qw(
              RETRY_MINIMUM_VALUE_LOWER
              )
        ],
        zone05 => [
            qw(
              EXPIRE_MINIMUM_VALUE_LOWER
              EXPIRE_LOWER_THAN_REFRESH
              )
        ],
        zone06 => [
            qw(
              SOA_DEFAULT_TTL_MAXIMUM_VALUE_HIGHER
              SOA_DEFAULT_TTL_MAXIMUM_VALUE_LOWER
              )
        ],
        zone07 => [
            qw(
              MASTER_IS_AN_ALIAS
              )
        ],
        zone08 => [
            qw(
              MX_RECORD_IS_CNAME
              )
        ],
        zone09 => [
            qw(
              NO_MX_RECORD
              )
        ],
    };
} ## end sub metadata

sub version {
    return "$Giraffa::Test::Zone::VERSION";
}

sub zone01 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa )   = $p->get_records( q{SOA}, q{answer} );
        my $soa_mname = $soa->mname;
        if ( not $soa_mname ) {
            push @results, info( MNAME_RECORD_DOES_NOT_EXIST => { } );
        }
        else {
            foreach my $ip_address ( Giraffa::Recursor->get_addresses_for( $soa_mname ) ) {
                my $ns = Giraffa::Nameserver->new({ name => $soa_mname, address => $ip_address->short });
                my $p = $ns->query( $zone->name, q{SOA} );
                if ( $p and $p->rcode eq q{NOERROR} ) {
                    if ( not $p->aa ) {
                        push @results,
                          info(
                            MNAME_NOT_AUTHORITATIVE => {
                                ns      => $soa_mname,
                                address => $ip_address->short,
                                zone    => $zone->name,
                            }
                          );
                    }
                }
                else {
                    push @results,
                      info(
                        MNAME_NO_RESPONSE => {
                            ns      => $soa_mname,
                            address => $ip_address->short,
                        }
                      );
                }
            }
            if ( not grep { $_->name eq $soa_mname } @{ $zone->glue } ) {
                push @results, info( MNAME_NOT_IN_GLUE => { } );
            }
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone01

sub zone02 {
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
} ## end sub zone02

sub zone03 {
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
} ## end sub zone03

sub zone04 {
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
} ## end sub zone04

sub zone05 {
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
} ## end sub zone05

sub zone06 {
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
} ## end sub zone06

sub zone07 {
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
} ## end sub zone07

sub zone08 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{MX} );

    if ( $p ) {
        if ( $p->has_rrs_of_type_for_name( q{CNAME}, $zone->name ) ) {
            push @results, info( MX_RECORD_IS_CNAME => { } );
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone08

sub zone09 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{MX} );

    if ( $p ) {
        if ( not $p->has_rrs_of_type_for_name( q{MX}, $zone->name ) ) {
            my $p_a    = $zone->query_one( $zone->name, q{A} );
            my $p_aaaa = $zone->query_one( $zone->name, q{AAAA} );
            if (    not $p_a->has_rrs_of_type_for_name( q{A}, $zone->name ) 
                and not $p_aaaa->has_rrs_of_type_for_name( q{AAAA}, $zone->name ) ) {
                push @results, info( NO_MX_RECORD => { } );
            }
        }
    }
    else {
        croak q{No response from child nameservers};
    }

    return @results;
} ## end sub zone09

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

=item zone01($zone)

Check that master nameserver in SOA is fully qualified.

=item zone02($zone)

Verify SOA 'refresh' minimum value.

=item zone03($zone)

Verify SOA 'retry' value  is lower than SOA 'refresh' value.

=item zone04($zone)

Verify SOA 'retry' minimum value.

=item zone05($zone)

Verify SOA 'expire' minimum value.

=item zone06($zone)

Verify SOA 'minimum' (default TTL) value.

=item zone07($zone)

Verify that SOA master is not an alias (CNAME).

=item zone08($zone)

Verify that MX records does not resolve to a CNAME.

=item zone09($zone)

Verify that there is a target host (MX, A or AAAA) to deliver e-mail for the domain name.

=back

=cut
