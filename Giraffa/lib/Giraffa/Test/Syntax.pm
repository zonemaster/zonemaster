package Giraffa::Test::Syntax v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;
use Giraffa::Recursor;

use List::MoreUtils;
use RFC::RFC822::Address qw[valid];
use Time::Local;

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->name_syntax( $zone->name );
    foreach my $name ( keys %{ { map { $_->name => 1 } (@{ $zone->ns }, @{ $zone->glue }) } } ) {
        push @results, $class->name_syntax( $name );
    }

    my $p = $zone->query_one( $zone->name, 'SOA' );
    my ( $soa ) = $p->get_records( 'SOA' );
    push @results, $class->name_syntax( $soa->mname );  # syntax07
    push @results, $class->rname_syntax( $soa->rname ); # syntax05 and syntax06
    push @results, $class->soa_date( $soa->serial );    # syntax09

    # syntax08
    my $rname = $soa->rname;
    $rname =~ s/[^\\]\.(.*)+$/$1/; # Keep everything after the first unescaped dot
    $p = Giraffa::Recursor->recurse( $rname, 'MX');
    foreach my $mx (grep {$_->type eq 'MX'} $p->answer) {
        push @results, $class->name_syntax( $mx->exchange );
    }

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
                ONLY_ALLOWED_CHARS
                NON_ALLOWED_CHARS
                INITIAL_HYPHEN
                TERMINAL_HYPHEN
                DISCOURAGED_DOUBLE_DASH
                NUMERIC_TLD
                NAME_TOO_LONG
                LABEL_TOO_LONG
              )
        ],
        rname_syntax => [
            qw(
                RNAME_MISUSED_AT_SIGN
                RNAME_RFC822_INVALID
            )
        ],
        soa_date => [
            qw(
                SERIAL_NOT_DATE
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

    # syntax01
    if (List::MoreUtils::all {m/^[-A-Za-z0-9]+$/} @{$name->labels}) {
        push @results, info( ONLY_ALLOWED_CHARS => { name => "$name"});
    }
    else {
        push @results, info( NON_ALLOWED_CHARS => { name => "$name"});
    }

    # syntax02
    foreach my $label (@{ $name->labels }) {
        if ($label =~ /^-/) {
            push @results, info( INITIAL_HYPHEN => { label => $label, name => "$name"});
        }
        if ($label =~ /-$/) {
            push @results, info( TERMINAL_HYPHEN => { label => $label, name => "$name"});
        }
    }

    # syntax03
    foreach my $label (@{ $name->labels }) {
        if (($label =~ /^..--/) and not ($label =~ /^xn/) ) {
            push @results, info( DISCOURAGED_DOUBLE_DASH => { label => $label, name => "$name"});
        }
    }

    # syntax04, numeric TLD subtest
    my $tld = @{$name->labels}[-1];
    if ($tld =~ /^[0-9]+$/) {
        push @results, info( NUMERIC_TLD => { name => "$name"});
    }

    # syntax04, size subtests, can only fail for manually added names
    if (length("$name") > 254) { # $name plus terminal dot > 255
        push @results, info( NAME_TOO_LONG => { name => "$name", length => length("$name")});
    }
    foreach my $label (@{$name->labels}) {
        if (length($label) > 63) {
            push @results, info( LABEL_TOO_LONG => { name => "$name", label => $label, length => length($label)});
        }
    }

    return @results;
}

sub rname_syntax {
    my ($self, $rname ) = @_;
    my @results;

    info( CHECKING_RNAME => { rname => $rname });

    # syntax05
    my $copy = $rname;
    $copy =~ s/\\././g;
    if (index($copy,'@')!=-1) {
        push @results, info( RNAME_MISUSED_AT_SIGN => {rname => $rname});
    }

    # syntax06
    $rname =~ s/([^\\])\./$1@/; # Replace first non-escaped dot with an at-sign
    $rname =~ s/\\././g;        # Un-escape dots
    $rname =~ s/\.$//;          # Validator does not like final dots
    if (not valid($rname)) {
        push @results, info( RNAME_RFC822_INVALID => { rname => $rname } );
    }

    return @results;
}

sub soa_date {
    my ( $self, $serial ) = @_;

    if (length($serial) != 10) { # Wrong length, can't be date+counter
        return info( SERIAL_NOT_DATE => { serial => $serial, why => 'wrong length' });
    }

    my ($year, $month, $day) = $serial =~ m|^([0-9]{4})([0-9]{2})([0-9]{2})|;
    if (not (defined($year) and defined($month) and defined($day))) {
        return info( SERIAL_NOT_DATE => { serial => $serial, why => 'wrong format' });
    }

    my $t = eval {timegm(0,0,0,$day,$month-1,$year)};
    if (not defined($t)) {
        return info( SERIAL_NOT_DATE => { serial => $serial, why => 'invalid date' });
    }

    return;
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

=item rname_syntax($rname)

Perform tests on a SOA RNAME.

=item soa_date($serial)

Check if the SOA serial value conforms to the date plus counter format.

=back

=cut
