package Zonemaster::Test::Syntax v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::Recursor;
use Zonemaster::DNSName;

use Readonly;

use List::MoreUtils;
use RFC::RFC822::Address qw[valid];
use Time::Local;

Readonly our $FQDN_MAX_LENGTH  => 255;
Readonly our $LABEL_MAX_LENGTH => 63;

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->syntax01( $zone->name );
    push @results, $class->syntax02( $zone->name );
    push @results, $class->syntax03( $zone->name );

    my %nsnames;
    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {
        next if $nsnames{ $local_ns->name };
        push @results, $class->syntax04( $local_ns->name );
        $nsnames{ $local_ns->name }++;
    }

    push @results, $class->syntax05( $zone );
    push @results, $class->syntax06( $zone );
    push @results, $class->syntax07( $zone );

    my $p = $zone->query_one( $zone->name, q{MX} );
    push @results, $class->syntax08( sort keys %{ { map { $_->exchange => 1 } $p->get_records( q{MX}, q{answer} ) } } );

    push @results, $class->syntax09( $zone );

    return @results;
} ## end sub all

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        syntax01 => [
            qw(
              ONLY_ALLOWED_CHARS
              NON_ALLOWED_CHARS
              )
        ],
        syntax02 => [
            qw(
              INITIAL_HYPHEN
              TERMINAL_HYPHEN
              )
        ],
        syntax03 => [
            qw(
              DISCOURAGED_DOUBLE_DASH
              )
        ],
        syntax04 => [
            qw(
              NAMESERVER_DISCOURAGED_DOUBLE_DASH
              NAMESERVER_LABEL_TOO_LONG
              NAMESERVER_NUMERIC_TLD
              NAMESERVER_NAME_TOO_LONG
              )
        ],
        syntax05 => [
            qw(
              RNAME_MISUSED_AT_SIGN
              )
        ],
        syntax06 => [
            qw(
              RNAME_RFC822_INVALID
              )
        ],
        syntax07 => [
            qw(
              MNAME_DISCOURAGED_DOUBLE_DASH
              MNAME_LABEL_TOO_LONG
              MNAME_NUMERIC_TLD
              MNAME_NAME_TOO_LONG
              )
        ],
        syntax08 => [
            qw(
              MX_DISCOURAGED_DOUBLE_DASH
              MX_LABEL_TOO_LONG
              MX_NUMERIC_TLD
              MX_NAME_TOO_LONG
              )
        ],
        syntax09 => [
            qw(
              SERIAL_NOT_DATE
              )
        ],
    };
} ## end sub metadata

sub version {
    return "$Zonemaster::Test::Syntax::VERSION";
}

###
### Tests
###

sub syntax01 {
    my ( $class, $name ) = @_;
    my @results;

    if ( _name_has_only_legal_characters( $name ) ) {
        push @results,
          info(
            ONLY_ALLOWED_CHARS => {
                name => "$name",
            }
          );
    }
    else {
        push @results,
          info(
            NON_ALLOWED_CHARS => {
                name => "$name",
            }
          );
    }

    return @results;
} ## end sub syntax01

sub syntax02 {
    my ( $class, $name ) = @_;
    my @results;

    foreach my $local_label ( @{ $name->labels } ) {
        if ( _label_starts_with_hyphen( $local_label ) ) {
            push @results,
              info(
                INITIAL_HYPHEN => {
                    label => $local_label,
                    name  => "$name",
                }
              );
        }
        if ( _label_ends_with_hyphen( $local_label ) ) {
            push @results,
              info(
                TERMINAL_HYPHEN => {
                    label => $local_label,
                    name  => "$name",
                }
              );
        }
    } ## end foreach my $local_label ( @...)

    return @results;
} ## end sub syntax02

sub syntax03 {
    my ( $class, $name ) = @_;
    my @results;

    if (not ref($name)) {
        $name = name($name);
    }

    foreach my $local_label ( @{ $name->labels } ) {
        if ( _label_not_ace_has_double_hyphen_in_position_3_and_4( $local_label ) ) {
            push @results,
              info(
                DISCOURAGED_DOUBLE_DASH => {
                    label => $local_label,
                    name  => "$name",
                }
              );
        }
    }

    return @results;
}

sub syntax04 {
    my ( $class, $name ) = @_;

    return _check_name_syntax( q{NAMESERVER}, $name );
}

sub syntax05 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );
    my ( $soa ) = $p->get_records( q{SOA}, q{answer} );

    my $rname = $soa->rname;
    $rname =~ s/\\./\./smgx;
    if ( index( $rname, q{@} ) != -1 ) {
        push @results,
          info(
            RNAME_MISUSED_AT_SIGN => {
                rname => $soa->rname,
            }
          );
    }

    return @results;
} ## end sub syntax05

sub syntax06 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );
    my ( $soa ) = $p->get_records( q{SOA}, q{answer} );

    my $rname = $soa->rname;
    $rname =~ s/([^\\])\./$1@/smx;    # Replace first non-escaped dot with an at-sign
    $rname =~ s/\\./\./smgx;          # Un-escape dots
    $rname =~ s/\.\z//smgx;           # Validator does not like final dots
    if ( not valid( $rname ) ) {
        push @results,
          info(
            RNAME_RFC822_INVALID => {
                rname => $rname,
            }
          );
    }

    return @results;
} ## end sub syntax06

sub syntax07 {
    my ( $class, $zone ) = @_;

    my $p = $zone->query_one( $zone->name, q{SOA} );
    my ( $soa ) = $p->get_records( q{SOA}, q{answer} );

    my $mname = $soa->mname;

    return _check_name_syntax( q{MNAME}, $mname );
}

sub syntax08 {
    my ( $class, @names ) = @_;
    my @results;

    foreach my $mx ( @names ) {
        push @results, _check_name_syntax( q{MX}, $mx );
    }

    return @results;
}

sub syntax09 {
    my ( $class, $zone ) = @_;

    my $p = $zone->query_one( $zone->name, q{SOA} );
    my ( $soa ) = $p->get_records( q{SOA}, q{answer} );

    my $serial = $soa->serial;

    if ( length( $serial ) != 10 ) {    # Wrong length, can't be date+counter
        return info(
            SERIAL_NOT_DATE => {
                serial => $serial,
                why    => q{wrong length},
            }
        );
    }

    my ( $year, $month, $day ) = $serial =~ m|^([0-9]{4})([0-9]{2})([0-9]{2})|;
    if ( not( defined( $year ) and defined( $month ) and defined( $day ) ) ) {
        return info(
            SERIAL_NOT_DATE => {
                serial => $serial,
                why    => q{wrong format},
            }
        );
    }

    my $t = eval { timegm( 0, 0, 0, $day, $month - 1, $year ) };
    if ( not defined( $t ) ) {
        return info(
            SERIAL_NOT_DATE => {
                serial => $serial,
                why    => q{invalid date},
            }
        );
    }

} ## end sub syntax09

###
### Internal Tests with Boolean (0|1) return value.
###

sub _name_has_only_legal_characters {
    my ( $name ) = @_;

    if ( not ref( $name ) ) {
        $name = name( $name );
    }

    if ( List::MoreUtils::all { m/\A[-A-Za-z0-9]+\z/ } @{ $name->labels } ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub _label_starts_with_hyphen {
    my ( $label ) = @_;

    return 0 if not $label;

    if ( $label =~ /\A-/smgx ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub _label_ends_with_hyphen {
    my ( $label ) = @_;

    return 0 if not $label;

    if ( $label =~ /-\z/smgx ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub _label_not_ace_has_double_hyphen_in_position_3_and_4 {
    my ( $label ) = @_;

    return 0 if not $label;

    if ( $label =~ /\A..--/ and $label !~ /\Axn/i ) {
        return 1;
    }
    else {
        return 0;
    }
}

###
### Common part for syntax04, syntax07 and syntax08
###

sub _check_name_syntax {
    my ( $info_label_prefix, $name ) = @_;
    my @results;

    if ( not ref( $name ) ) {
        $name = name( $name );
    }

    foreach my $local_label ( @{ $name->labels } ) {
        if ( length $local_label > $LABEL_MAX_LENGTH ) {
            push @results,
              info(
                $info_label_prefix
                  . q{_LABEL_TOO_LONG} => {
                    name   => "$name",
                    label  => $local_label,
                    length => length( $local_label ),
                    max    => $LABEL_MAX_LENGTH,
                  }
              );
        }
        if ( _label_not_ace_has_double_hyphen_in_position_3_and_4( $local_label ) ) {
            push @results,
              info(
                $info_label_prefix
                  . q{_DISCOURAGED_DOUBLE_DASH} => {
                    label => $local_label,
                    name  => "$name",
                  }
              );
        }
    } ## end foreach my $local_label ( @...)

    my $tld = @{ $name->labels }[-1];
    if ( $tld =~ /\A[0-9]+\z/smgx ) {
        push @results,
          info(
            $info_label_prefix
              . q{_NUMERIC_TLD} => {
                name => "$name",
                tld  => $tld,
              }
          );
    }

    if ( length "$name" >= $FQDN_MAX_LENGTH ) {    # not trailing 'dot' in $name, which explains the '=' sign.
        push @results,
          info(
            $info_label_prefix
              . q{_NAME_TOO_LONG} => {
                name => "$name",
                ,
                length => length( "$name" ),
                max    => $FQDN_MAX_LENGTH,
              }
          );
    }

    return @results;
} ## end sub _check_name_syntax

1;

=head1 NAME

Zonemaster::Test::Syntax - test validating the syntax of host names and other data

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Syntax->all($zone);

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

=item syntax01($name)

Verifies that the name (Zonemaster::DNSName) given contains only allowed characters.

=item syntax02($name)

Verifies that the name (Zonemaster::DNSName) given does not start or end with a hyphen ('-').

=item syntax03($name)

Verifies that the name (Zonemaster::DNSName) given does not contain a hyphen in 3rd and 4th position (in the exception of 'xn--').

=item syntax04($name)

Verify that a nameserver (Zonemaster::DNSName) given is conform to previous syntax rules. It also verify name total length as well as labels.

=item syntax05($zone)

Verify that a SOA rname (Zonemaster::DNSName) given has a conform usage of at sign (@).

=item syntax06($zone)

Verify that a SOA rname (Zonemaster::DNSName) given is RFC822 compliant.

=item syntax07($zone)

Verify that SOA mname of zone given is conform to previous syntax rules (syntax01, syntax02, syntax03). It also verify name total length as well as labels.

=item syntax08(@mx_names)

Verify that MX name (Zonemaster::DNSName)  given is conform to previous syntax rules (syntax01, syntax02, syntax03). It also verify name total length as well as labels.

=item syntax09($zone)

Check SOA serial format.

=back

=cut
