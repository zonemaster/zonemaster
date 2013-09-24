package Giraffa::Test::Basic v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->basic1( $zone );

    # Perform BASIC2 if BASIC1 passed
    if ( grep { $_->tag eq 'HAS_GLUE' } @results ) {
        push @results, $class->basic2( $zone );
    }

    # Perform BASIC3 if BASIC2 failed
    if ( not grep { $_->tag eq 'HAS_NAMESERVERS' } @results ) {
        push @results, $class->basic3( $zone );
    }

    return @results;
}

sub can_continue {
    my ( $class, @results ) = @_;
    my %tag = map {$_->tag => 1} @results;

    if ($tag{HAS_GLUE} and $tag{HAS_NAMESERVERS}) {
        return 1;
    } else {
        return;
    }
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        basic1 => [qw(HAS_GLUE NO_GLUE NO_DOMAIN)],
        basic2 => [qw(NS_FAILED NS_NO_RESPONSE HAS_NAMESERVERS)],
        basic3 => [qw(HAS_A_RECORDS)],
    };
}

sub version {
    return "$Giraffa::Test::Basic::VERSION";
}

###
### Tests
###

sub basic1 {
    my ( $class, $zone ) = @_;
    my @results;

    my $parent = $zone->parent;
    my $p = $parent->query_one( $zone->name, 'NS' );

    if ( not $p ) {
        push @results, info( NO_PARENT_RESPONSE => { parent => $parent->name->string } );
        return @results;
    }

    if ( $p->header->rcode eq 'NXDOMAIN' ) {
        push @results, info( NO_DOMAIN => { parent => $parent->name->string } );
    }
    else {
        if ( $p->has_rrs_of_type_for_name( 'ns', $zone->name ) ) {
            push @results,
              info(
                HAS_GLUE => {
                    parent => $parent->name->string,
                    ns     => join( ',', sort map { $_->nsdname } $p->get_records_for_name( 'ns', $zone->name ) )
                }
              );
        }
        else {
            push @results, info( NO_GLUE => { parent => $parent->name->string, rcode => $p->header->rcode } );
        }
    }

    return @results;
}

sub basic2 {
    my ( $class, $zone ) = @_;
    my @results;

    foreach my $ns ( @{ $zone->glue } ) {
        my $p = $ns->query( $zone->name, 'NS' );
        if ( $p ) {
            if ( $p->has_rrs_of_type_for_name( 'ns', $zone->name ) ) {
                push @results,
                  info(
                    HAS_NAMESERVERS => {
                        ns     => join( ',', sort map { $_->nsdname } $p->get_records_for_name( 'ns', $zone->name ) ),
                        source => $ns->string
                    }
                  );
            }
            else {
                push @results, info( NS_FAILED => { source => $ns->string } );
            }
        }
        else {
            push @results, info( NS_NO_RESPONSE => { source => $ns->string } );
        }
    }

    return @results;
}

sub basic3 {
    my ( $class, $zone ) = @_;
    my @results;

    my $name = 'www.' . $zone->name;
    foreach my $ns ( @{ $zone->glue } ) {
        my $p = $ns->query( $name, 'A' );
        next if not $p;
        if ( $p->has_rrs_of_type_for_name( 'a', $name ) ) {
            push @results, info( HAS_A_RECORDS => { source => $ns->string } );
        }
    }

    return @results;
}

1;
