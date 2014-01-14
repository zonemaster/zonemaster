package Giraffa::Test::Delegation v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

use Net::IP;
use List::MoreUtils qw[uniq];
use Net::LDNS::Packet;
use Net::LDNS::RR;

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->enough_nameservers( $zone );
    push @results, $class->parent_child_match( $zone );
    push @results, $class->inzone_glue( $zone );
    push @results, $class->referral_size( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        enough_nameservers => [
            qw(
              ENOUGH_NS_GLUE
              NOT_ENOUGH_NS_GLUE
              ENOUGH_NS
              NOT_ENOUGH_NS
              )
        ],
        parent_child_match => [
            qw(
              EXTRA_NAME_PARENT
              EXTRA_NAME_CHILD
              EXTRA_ADDR_PARENT
              EXTRA_ADDR_CHILD
              TOTAL_NAME_MISMATCH
              NAMES_MATCH
              ADDRESSES_MATCH
              TOTAL_ADDRESS_MISMATCH
              )
        ],
        inzone_glue => [
            qw(
              INZONE_NO_GLUE
              INZONE_HAS_GLUE
              NOT_IN_ZONE
              )
        ],
        referral_size => [
            qw(
              REFERRAL_SIZE_LARGE
              REFERRAL_SIZE_OK
              )
        ],
    };
}

sub version {
    return "$Giraffa::Test::Delegation::VERSION";
}

###
### Tests
###

sub enough_nameservers {
    my ( $class, $zone ) = @_;
    my @results;

    if ( scalar( $zone->glue ) > 0 ) {
        push @results,
          info( ENOUGH_NS_GLUE =>
              { count => scalar( @{ $zone->glue } ), glue => join( ';', map { $_->string } @{ $zone->glue } ) } );
    }
    else {
        push @results,
          info( NOT_ENOUGH_NS_GLUE =>
              { count => scalar( @{ $zone->glue } ), glue => join( ';', map { $_->string } @{ $zone->glue } ) } );
    }

    if ( scalar( $zone->ns ) > 0 ) {
        push @results,
          info(
            ENOUGH_NS => { count => scalar( @{ $zone->ns } ), ns => join( ';', map { $_->string } @{ $zone->ns } ) } );
    }
    else {
        push @results,
          info( NOT_ENOUGH_NS =>
              { count => scalar( @{ $zone->ns } ), ns => join( ';', map { $_->string } @{ $zone->ns } ) } );
    }

    return @results;
}

sub parent_child_match {
    my ( $class, $zone ) = @_;
    my @results;

    my %names;
    my %ips;
    foreach my $name ( uniq map { $_->name } @{ $zone->ns } ) {
        $names{$name} -= 1;
    }
    foreach my $addr ( uniq map { $_->address->short } @{ $zone->ns } ) {
        $ips{$addr} -= 1;
    }
    foreach my $name ( uniq map { $_->name } @{ $zone->glue } ) {
        $names{$name} += 1;
    }
    foreach my $addr ( uniq map { $_->address->short } @{ $zone->glue } ) {
        $ips{$addr} += 1;
    }

    my @same_name         = grep { $names{$_} == 0 } keys %names;
    my @same_addr         = grep { $ips{$_} == 0 } keys %ips;
    my @extra_name_parent = grep { $names{$_} > 0 } keys %names;
    my @extra_name_child  = grep { $names{$_} < 0 } keys %names;
    my @extra_addr_parent = grep { $ips{$_} > 0 } keys %ips;
    my @extra_addr_child  = grep { $ips{$_} < 0 } keys %ips;

    if ( @extra_name_parent ) {
        push @results, info( EXTRA_NAME_PARENT => { extra => join( ';', @extra_name_parent ) } );
    }

    if ( @extra_name_child ) {
        push @results, info( EXTRA_NAME_CHILD => { extra => join( ';', @extra_name_child ) } );
    }

    if ( @extra_addr_parent ) {
        push @results, info( EXTRA_ADDR_PARENT => { extra => join( ';', @extra_addr_parent ) } );
    }

    if ( @extra_addr_child ) {
        push @results, info( EXTRA_ADDR_CHILD => { extra => join( ';', @extra_addr_child ) } );
    }

    if ( @extra_name_parent == 0 and @extra_name_child == 0 ) {
        push @results, info( NAMES_MATCH => { names => join( ';', @same_name ) } );
    }

    if ( @extra_addr_parent == 0 and @extra_addr_child == 0 ) {
        push @results, info( ADDRESSES_MATCH => { names => join( ';', @same_addr ) } );
    }

    if ( scalar( @same_name ) == 0 ) {
        push @results,
          info(
            TOTAL_NAME_MISMATCH => { glue => join( ';', @extra_name_parent ), child => join( ';', @extra_name_child ) }
          );
    }

    if ( scalar( @same_addr ) == 0 ) {
        push @results,
          info( TOTAL_ADDRESS_MISMATCH =>
              { glue => join( ';', @extra_addr_parent ), child => join( ';', @extra_addr_child ) } );
    }

    return @results;
}

sub inzone_glue {
    my ( $class, $zone ) = @_;
    my @results;

    foreach my $ns ( @{ $zone->glue } ) {
        if ( $zone->is_in_zone( $ns->name ) ) {

            my $found = 0;

            foreach my $rr ( @{ $zone->glue_addresses } ) {
                my $addr = Net::IP->new( $rr->address );
                if ( $addr->ip eq $ns->address->ip ) {
                    $found = 1;
                }
            }

            if ( not $found ) {
                push @results, info( INZONE_NO_GLUE => { ns => $ns->string } );
            }
            else {
                push @results, info( INZONE_HAS_GLUE => { ns => $ns->string } );
            }
        }
        else {
            push @results, info( NOT_IN_ZONE => { ns => $ns->string } );
        }
    }

    return @results;
}

sub referral_size {
    my ( $class, $zone ) = @_;
    my @results;

    my @nsnames = uniq map { $_->name } @{ $zone->ns };
    my @needs_glue =
      sort { length( $a->name->string ) <=> length( $b->name->string ) }
      grep { $zone->is_in_zone( $_->name ) } @{ $zone->ns };
    my @needs_v4_glue = grep { $_->address->version == 4 } @needs_glue;
    my @needs_v6_glue = grep { $_->address->version == 6 } @needs_glue;
    my $long_name     = _max_length_name_for( $zone->name );

    my $p = Net::LDNS::Packet->new( $long_name, 'NS', 'IN' );

    foreach my $ns ( @nsnames ) {
        my $rr = Net::LDNS::RR->new( sprintf( '%s IN NS %s', $zone->name, $ns ) );
        $p->unique_push( 'authority', $rr );
    }

    if ( @needs_v4_glue ) {
        my $ns = $needs_v4_glue[0];
        my $rr = Net::LDNS::RR->new( sprintf( '%s IN A %s', $ns->name, $ns->address->short ) );
        $p->unique_push( 'additional', $rr );
    }

    if ( @needs_v6_glue ) {
        my $ns = $needs_v6_glue[0];
        my $rr = Net::LDNS::RR->new( sprintf( '%s IN AAAA %s', $ns->name, $ns->address->short ) );
        $p->unique_push( 'additional', $rr );
    }

    my $size = length( $p->data );
    if ( $size > 512 ) {
        push @results, info( REFERRAL_SIZE_LARGE => { size => $size } );
    }
    else {
        push @results, info( REFERRAL_SIZE_OK => { size => $size } );
    }

    return @results;
}

###
### Helper functions
###

# Make up a name of maximum length in the given domain
sub _max_length_name_for {
    my ( $top ) = @_;
    my @chars = 'A' .. 'Z';

    my $name = '';
    $name = "$top";

    $name .= '.' if $name !~ m/\.$/;

    while ( length( $name ) < 253 ) {
        my $len = 253 - length( $name );
        $len = 63 if $len > 63;
        $name = join( '', map { $chars[ rand @chars ] } 1 .. $len ) . '.' . $name;
    }

    return $name;
}

1;

=head1 NAME

Giraffa::Test::Delegation - Tests regarding delegation details

=head1 SYNOPSIS

    my @results = Giraffa::Test::Delegation->all($zone);

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

=item enough_nameservers($zone)

Verify that there is more than one nameserver.

=item parent_child_match($zone)

Verify that the names and addresses listed at the parent and child side match up.

=item inzone_glue($zone)

Verify that in-zone nameserver have glue records at the parent.

=item referral_size($zone)

Verify that the size of the smallest legal referral packet is 512 octets or less.

=back

=cut
