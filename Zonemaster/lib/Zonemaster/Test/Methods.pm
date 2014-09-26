package Zonemaster::Test::Methods v0.0.1;

use 5.14.2;
use strict;
use warnings;

use List::MoreUtils qw[uniq];

use Zonemaster;
use Zonemaster::Util;

sub method1 {
    my ( $class, $zone ) = @_;

    return $zone->parent;
} ## end sub method1

sub method2 {
    my ( $class, $zone ) = @_;

    return $zone->glue_names;
} ## end sub method2

sub method3 {
    my ( $class, $zone ) = @_;

    my @child_nsnames;
    my @nsnames;
    my $ns_aref = $zone->query_all( $zone->name, q{NS} );
    foreach my $p ( @$ns_aref ) {
        next if not $p;
        push @nsnames, $p->get_records_for_name( q{NS}, $zone->name );
    }
    @child_nsnames = uniq map { name($_->nsdname) } @nsnames;

    return [ @child_nsnames ];
} ## end sub method3

sub method4 {
    my ( $class, $zone ) = @_;

    return $zone->glue;
} ## end sub method4

sub method5 {
    my ( $class, $zone ) = @_;

    return $zone->ns;
} ## end sub method5

1;
