package Giraffa::Test::Syntax v0.0.1;

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

    push @results, $class->name_syntax( $zone->name );
    foreach my $name ( keys %{ { map { $_->name => 1 } @{ $zone->ns } } } ) {
        push @results, $class->name_syntax( $name );
    }

    my $p = $zone->query_one( $zone->name, 'SOA' );
    my ( $soa ) = $p->get_records( 'SOA' );
    push @results, $class->name_syntax( $soa->mname );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        name_syntax => [
            qw(
              CHECKING_NAME
              NUMERIC_TOP
              NON_NUMERIC_TOP
              DASH_END
              NO_DASH_END
              ALPHANUMERIC_START
              NON_ALPHANUMERIC_START
              )
        ]
    };
}

sub version {
    return "$Giraffa::Test::Syntax::VERSION";
}

###
### Tests
###

sub name_syntax {
    my ( $class, $name ) = @_;
    my @results;

    if ( not ref( $name ) and not $name->isa( 'Giraffa::DNSName' ) ) {
        $name = Giraffa::DNSName->new( $name );
    }

    info( CHECKING_NAME => { name => "$name" } );

    # Checking total and label lengths is pointless, since if they were too long we
    # could not recieve them in a DNS packet.

    # RFC 3696: Top-level may not be all-numeric
    if ( $name->labels->[-1] =~ /^\d+$/ ) {
        push @results, info( NUMERIC_TOP => { name => "$name" } );
    }
    else {
        push @results, info( NON_NUMERIC_TOP => { name => "$name" } );
    }

    # RFC 952: Labels may not end with a dash
    my $oops = 0;
    foreach my $l ( @{ $name->labels } ) {
        if ( $l =~ /\-$/ ) {
            push @results, info( DASH_END => { name => "$name" } );
            $oops = 1;
        }
    }
    push @results, info( NO_DASH_END => { name => "$name" } ) if not $oops;

    # RFC 952 and RFC 1123: First label must start with alphanumeric
    if ( $name->labels->[0] =~ /^[a-z0-9]/i ) {
        push @results, info( ALPHANUMERIC_START => { name => "$name" } );
    }
    else {
        push @results, info( NON_ALPHANUMERIC_START => { name => "$name" } );
    }

    return @results;
}

1;

=head1 NAME

Giraffa::Test::Syntax - test validating the syntax of host names and other data

=head1 SYNOPSIS

    my @results = Giraffa::Test::Syntax->all($zone);

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

=item name_syntax($name)

Verifies that the name given conforms to the rules.

=back

=cut
