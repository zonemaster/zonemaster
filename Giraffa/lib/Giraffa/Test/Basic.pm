package Giraffa::Test::Basic v0.0.1;

use 5.14.2;
use Giraffa;
use Giraffa::Util;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->basic1($zone);

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        basic1 => [
            qw[
              DELEGATION
              NO_NAMESERVERS
              NO_DOMAIN
              ]
        ],
        basic2 => [],
        basic3 => [],
    };
}

###
### Tests
###

sub basic1 {
    my ( $class, $zone ) = @_;
    my @results;

    my $parent = $zone->parent;
    my $p = $parent->query_one( $zone->name, 'NS' );

    if ( $p->header->rcode eq 'NXDOMAIN' ) {
        push @results, info( 'NO_DOMAIN', { parent => ''.$parent->name } );
    }
    else {
        my @ns = grep { $_->name eq $zone->name } $p->get_records( 'ns' );
        if ( @ns > 0 ) {
            push @results, info( 'DELEGATION', { parent => ''.$parent->name, ns => join(',', sort map {$_->nsdname} @ns) } );
        }
        else {
            push @results, info( 'NO_NAMESERVERS', { parent => ''.$parent->name, rcode => $p->header->rcode } );
        }
    }

    return @results;
}

sub basic2 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
}

sub basic3 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
}

1;
