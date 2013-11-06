package Giraffa::Test::Consistency v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->ns_consistent( $zone );
    push @results, $class->soa_consistent( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        ns_consistent => [
            qw(
              NO_RESPONSE
              ONE_NS_SET
              MULTIPLE_NS_SETS
              NS_SET
              )
        ],
        soa_consistent => [
            qw(
              NO_RESPONSE
              ONE_SOA_SERIAL
              MULTIPLE_SOA_SERIALS
              SOA_SERIAL
              )
        ]
    };
}

sub version {
    return "$Giraffa::Test::Consistency::VERSION";
}

###
### Tests
###

sub ns_consistent {
    my ( $class, $zone ) = @_;
    my @results;

    my %sets;
    foreach my $ns ( @{ $zone->ns } ) {
        my $p = $ns->query( $zone->name, 'NS' );

        if ( not $p ) {
            push @results, info( NO_RESPONSE => { ns => "$ns" } );
            next;
        }

        my @nsnames = sort map { $_->nsdname } $p->get_records_for_name( 'NS', $zone->name );
        push @{ $sets{ join( ';', @nsnames ) } }, $ns;
    }

    if ( keys %sets == 1 ) {
        push @results, info( ONE_NS_SET => { set => ( keys %sets )[0] } );
    }
    else {
        push @results, info( MULTIPLE_NS_SETS => { count => scalar( keys( %sets ) ) } );
        foreach my $set ( keys %sets ) {
            push @results, info( NS_SET => { set => $set, servers => join( ';', @{ $sets{$set} } ) } );
        }
    }

    return @results;
}

sub soa_consistent {
    my ( $class, $zone ) = @_;
    my @results;

    my %serials;
    foreach my $ns ( @{ $zone->ns } ) {
        my $p = $ns->query( $zone->name, 'SOA' );

        if ( not $p ) {
            push @results, info( NO_RESPONSE => { ns => "$ns" } );
            next;
        }

        my ( $soa ) = $p->get_records_for_name( 'SOA', $zone->name );
        push @{ $serials{ $soa->serial } }, $ns;

    }

    if ( keys %serials == 1 ) {
        push @results, info( ONE_SOA_SERIAL => { serial => ( keys %serials )[0] } );
    }
    else {
        push @results, info( MULTIPLE_SOA_SERIALS => { count => scalar( keys( %serials ) ) } );
        foreach my $serial ( keys %serials ) {
            push @results, info( SOA_SERIAL => { serial => $serial, servers => join( ';', @{ $serials{$serial} } ) } );
        }
    }

    return @results;
}

1;

=head1 NAME

Giraffa::Test::Consistency - Consistency module showing the expected structure of Giraffa test modules

=head1 SYNOPSIS

    my @results = Giraffa::Test::Consistency->all($zone);

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

=item placeholder($zone)

Since this is an Consistency module, this test does nothing except return a single log entry.

=back

=cut
