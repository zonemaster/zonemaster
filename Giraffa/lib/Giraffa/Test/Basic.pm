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
        basic1 => [qw(HAS_GLUE NO_GLUE NO_DOMAIN NO_PARENT_RESPONSE )],
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
                push @results, info( NS_FAILED => { source => $ns->string, rcode => $p->header->rcode } );
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
            push @results, info( HAS_A_RECORDS => { source => $ns->string, name => $name } );
        }
    }

    return @results;
}

1;

=head1 NAME

Giraffa::Test::Basic - module implementing test for very basic domain functionality

=head1 SYNOPSIS

    my @results = Giraffa::Test::Basic->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs between one and three tests, depending on the zone. If L<basic1> passes, L<basic2> is run. If L<basic2> fails, L<basic3> is run.

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

=item version()

Returns a version string for the module.

=item can_continue(@results)

Looks at the provided log entries and returns true if they indicate that further testing of the relevant zone is possible.

=back

=head1 TESTS

=over

=item basic1

Checks that we can find a parent zone for the zone we're testing. If we can't, no further testing is done.

=item basic2

Checks that the nameservers for the parent zone returns NS records for the tested zone, and that at least one of the nameservers thus pointed out
responds sensibly to an NS query for the tested zone.

=item basic3

Checks if at least one of the nameservers pointed out by the parent zone gives a useful response when sent an A query for the C<www> label in the
tested zone (that is, if we're testing C<example.org> this test will as for A records for C<www.example.org>). This test is only run if the
L<basic2> test has I<failed>.

=back

=cut