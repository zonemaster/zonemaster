package Zonemaster::TestMethods v0.1.0;

use 5.14.2;
use strict;
use warnings;

use List::MoreUtils qw[uniq];

use Zonemaster;
use Zonemaster::Util;

sub method1 {
    my ( $class, $zone ) = @_;

    return $zone->parent;
}

sub method2 {
    my ( $class, $zone ) = @_;

    return $zone->glue_names;
}

sub method3 {
    my ( $class, $zone ) = @_;

    my @child_nsnames;
    my @nsnames;
    my $ns_aref = $zone->query_all( $zone->name, q{NS} );
    foreach my $p ( @{$ns_aref} ) {
        next if not $p;
        push @nsnames, $p->get_records_for_name( q{NS}, $zone->name );
    }
    @child_nsnames = uniq map { name( lc( $_->nsdname ) ) } @nsnames;

    return [@child_nsnames];
}

sub method4 {
    my ( $class, $zone ) = @_;

    return $zone->glue;
}

sub method5 {
    my ( $class, $zone ) = @_;

    return $zone->ns;
}

=head1 NAME

Zonemaster::TestMethods - Methods common to Test Specification used in test modules

=head1 SYNOPSIS

    my @results = Zonemaster::TestMethods->method1($zone);

=head1 METHODS

=over

=item method1($zone)

=item method2($zone)

=item method3($zone)

=item method4($zone)

=item method5($zone)

=back

=cut

1;
