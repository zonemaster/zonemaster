package Zonemaster::Test::Syntax v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::Recursor;
use Zonemaster::DNSName;

use Carp;

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

    if ( grep { $_->tag eq q{ONLY_ALLOWED_CHARS} } @results ) {

        my %nsnames;
        foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {
            next if $nsnames{ $local_ns->name };
            push @results, $class->syntax04( $local_ns->name);
            $nsnames{ $local_ns->name }++;
        }

        push @results, $class->syntax05( $zone );

        if (not grep { $_->tag eq q{NO_RESPONSE_SOA_QUERY} } @results ) {
            push @results, $class->syntax06( $zone );
            push @results, $class->syntax07( $zone );
        }

        push @results, $class->syntax08( $zone );

    }

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
              NO_ENDING_HYPHENS
              )
        ],
        syntax03 => [
            qw(
              DISCOURAGED_DOUBLE_DASH
              NO_DOUBLE_DASH
              )
        ],
        syntax04 => [
            qw(
              NAMESERVER_DISCOURAGED_DOUBLE_DASH
              NAMESERVER_LABEL_TOO_LONG
              NAMESERVER_NUMERIC_TLD
              NAMESERVER_NAME_TOO_LONG
              NAMESERVER_SYNTAX_OK
              )
        ],
        syntax05 => [
            qw(
              RNAME_MISUSED_AT_SIGN
              RNAME_NO_AT_SIGN
              NO_RESPONSE_SOA_QUERY
              )
        ],
        syntax06 => [
            qw(
              RNAME_RFC822_INVALID
              NO_RESPONSE_SOA_QUERY
              )
        ],
        syntax07 => [
            qw(
              MNAME_DISCOURAGED_DOUBLE_DASH
              MNAME_LABEL_TOO_LONG
              MNAME_NUMERIC_TLD
              MNAME_NAME_TOO_LONG
              MNAME_SYNTAX_OK
              NO_RESPONSE_SOA_QUERY
              )
        ],
        syntax08 => [
            qw(
              MX_DISCOURAGED_DOUBLE_DASH
              MX_LABEL_TOO_LONG
              MX_NUMERIC_TLD
              MX_NAME_TOO_LONG
              MX_SYNTAX_OK
              NO_RESPONSE_MX_QUERY
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        "NAMESERVER_LABEL_TOO_LONG"          => "Nameserver ({name}) has a label ({label}) too long ({length}/{max}).",
        "NAMESERVER_NAME_TOO_LONG"           => "Nameserver ({name}) is too long ({length}/{max}).",
        "NAMESERVER_DISCOURAGED_DOUBLE_DASH" => "Nameserver ({name}) has a label ({label}) with a double hyphen ('--') in position 3 and 4 (with a prefix which is not 'xn--').",
        "NAMESERVER_NUMERIC_TLD"             => "Nameserver ({name}) within a 'numeric only' TLD ({tld}).",
        "NAMESERVER_SYNTAX_OK"               => "Nameserver ({name}) syntax is valid.",
        "MNAME_LABEL_TOO_LONG"               => "SOA MNAME ({name}) has a label ({label}) too long ({length}/{max}).",
        "MNAME_NAME_TOO_LONG"                => "SOA MNAME ({name}) is too long ({length}/{max}).",
        "MNAME_DISCOURAGED_DOUBLE_DASH"      => "SOA MNAME ({name}) has a label ({label}) with a double hyphen ('--') in position 3 and 4 (with a prefix which is not 'xn--').",
        "MNAME_NUMERIC_TLD"                  => "SOA MNAME ({name}) within a 'numeric only' TLD ({tld}).",
        "MNAME_SYNTAX_OK"                    => "SOA MNAME ({name}) syntax is valid.",
        "MX_LABEL_TOO_LONG"                  => "Domain name MX ({name}) has a label ({label}) too long ({length}/{max}).",
        "MX_NAME_TOO_LONG"                   => "Domain name MX is too long ({length}/{max}).",
        "MX_DISCOURAGED_DOUBLE_DASH"         => "Domain name MX ({name}) has a label ({label}) with a double hyphen ('--') in position 3 and 4 (with a prefix which is not 'xn--').",
        "MX_NUMERIC_TLD"                     => "Domain name MX ({name}) within a 'numeric only' TLD ({tld}).",
        "MX_SYNTAX_OK"                       => "Domain name MX ({name}) syntax is valid.",
        "DISCOURAGED_DOUBLE_DASH"            => "Domain name ({name}) has a label ({label}) with a double hyphen ('--') in position 3 and 4 (with a prefix which is not 'xn--').",
        "INITIAL_HYPHEN"                     => "Domain name ({name}) has a label ({label}) starting with an hyphen ('-').",
        "TERMINAL_HYPHEN"                    => "Domain name ({name}) has a label ({label}) ending with an hyphen ('-').",
        "NON_ALLOWED_CHARS"                  => "Found illegal characters in the domain name ({name})",
        "ONLY_ALLOWED_CHARS"                 => "No illegal characters in the domain name ({name}).",
        "RNAME_MISUSED_AT_SIGN"              => "There must be no misused '\@' character in the SOA RNAME field ({rname}).",
        "RNAME_RFC822_INVALID"               => "There must be no illegal characters in the SOA RNAME field ({rname}).",
        "RNAME_RFC822_VALID"                 => "The SOA RNAME field ({rname}) is compliant with RFC2822.",
        "NO_ENDING_HYPHENS"                  => "Both ends of all labels of the domain name ({name}) have no hyphens.",
        "NO_DOUBLE_DASH"                     => "Domain name ({name}) has no label with a double hyphen ('--') in position 3 and 4 (with a prefix which is not 'xn--').",
        "RNAME_NO_AT_SIGN"                   => "There is no misused '\@' character in the SOA RNAME field ({rname}).",
        "NO_RESPONSE_SOA_QUERY"              => "No response from nameserver(s) on SOA queries.",
        "NO_RESPONSE_MX_QUERY"               => "No response from nameserver(s) on MX queries.",
    };
} ## end sub translation

sub version {
    return "$Zonemaster::Test::Syntax::VERSION";
}

###
### Tests
###

sub syntax01 {
    my ( $class, $item ) = @_;
    my @results;

    my $name = _get_name( $item );

    if ( _name_has_only_legal_characters( $name ) ) {
        push @results,
          info(
            ONLY_ALLOWED_CHARS => {
                name => $name,
            }
          );
    }
    else {
        push @results,
          info(
            NON_ALLOWED_CHARS => {
                name => $name,
            }
          );
    }

    return @results;
} ## end sub syntax01

sub syntax02 {
    my ( $class, $item ) = @_;
    my @results;

    my $name = _get_name( $item );

    foreach my $local_label ( @{ $name->labels } ) {
        if ( _label_starts_with_hyphen( $local_label ) ) {
            push @results,
              info(
                INITIAL_HYPHEN => {
                    label => $local_label,
                    name  => $name,
                }
              );
        }
        if ( _label_ends_with_hyphen( $local_label ) ) {
            push @results,
              info(
                TERMINAL_HYPHEN => {
                    label => $local_label,
                    name  => $name,
                }
              );
        }
    } ## end foreach my $local_label ( @...)

    if (scalar @{ $name->labels } and not scalar @results) {
        push @results,
          info(
            NO_ENDING_HYPHENS => {
                name  => $name,
            }
          );
    }

    return @results;
} ## end sub syntax02

sub syntax03 {
    my ( $class, $item ) = @_;
    my @results;

    my $name = _get_name( $item );

    foreach my $local_label ( @{ $name->labels } ) {
        if ( _label_not_ace_has_double_hyphen_in_position_3_and_4( $local_label ) ) {
            push @results,
              info(
                DISCOURAGED_DOUBLE_DASH => {
                    label => $local_label,
                    name  => $name,
                }
              );
        }
    }

    if (scalar @{ $name->labels } and not scalar @results) {
        push @results,
          info(
            NO_DOUBLE_DASH => {
                name  => $name,
            }
          );
    }

    return @results;
} ## end sub syntax03

sub syntax04 {
    my ( $class, $item ) = @_;
    my @results;
    my %nsnames;

    my $name = _get_name( $item );

    return _check_name_syntax( q{NAMESERVER}, $name );
} ## end sub syntax04

sub syntax05 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa ) = $p->get_records( q{SOA}, q{answer} );
        my $rname   = $soa->rname;
        $rname =~ s/\\./\./smgx;
        if ( index( $rname, q{@} ) != -1 ) {
            push @results,
              info(
                RNAME_MISUSED_AT_SIGN => {
                    rname => $soa->rname,
                }
              );
        }
        else {
            push @results,
              info(
                RNAME_NO_AT_SIGN => {
                    rname => $soa->rname,
                }
              );
        }
    }
    else {
        push @results,
          info(
            NO_RESPONSE_SOA_QUERY => { }
          );
    }

    return @results;
} ## end sub syntax05

sub syntax06 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa ) = $p->get_records( q{SOA}, q{answer} );
        my $rname   = $soa->rname;
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
        else {
            push @results,
              info(
                RNAME_RFC822_VALID => {
                    rname => $rname,
                }
              );
        }
    }
    else {
        push @results,
          info(
            NO_RESPONSE_SOA_QUERY => { }
          );
    }
    return @results;
} ## end sub syntax06

sub syntax07 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{SOA} );

    if ( $p ) {
        my ( $soa ) = $p->get_records( q{SOA}, q{answer} );

        my $mname = $soa->mname;

        push @results, _check_name_syntax( q{MNAME}, $mname );
    }
    else {
        push @results,
          info(
            NO_RESPONSE_SOA_QUERY => { }
          );
    }

    return @results;
} ## end sub syntax07

sub syntax08 {
    my ( $class, $zone ) = @_;
    my @results;

    my $p = $zone->query_one( $zone->name, q{MX} );

    if ( $p ) {
        foreach my $mx ( sort keys %{ { map { $_->exchange => 1 } $p->get_records( q{MX}, q{answer} ) } } ) {
            push @results, _check_name_syntax( q{MX}, $mx );
        }
    }
    else {
        push @results,
          info(
            NO_RESPONSE_MX_QUERY => { }
          );
    }

    return @results;
} ## end sub syntax08

###
### Internal Tests with Boolean (0|1) return value.
###

sub _name_has_only_legal_characters {
    my ( $name ) = @_;

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

sub _get_name {
    my ( $item ) = @_;
    my $name;

    if ( not ref( $item ) ) {
        $name = name( $item );
    }     
    elsif (ref( $item ) eq q{Zonemaster::Zone}) {
        $name = $item->name;
    }
    elsif (ref( $item ) eq q{Zonemaster::DNSName}) {
        $name = $item;
    }

    return $name;
}

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
                $info_label_prefix . q{_LABEL_TOO_LONG} => {
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
                $info_label_prefix . q{_DISCOURAGED_DOUBLE_DASH} => {
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
            $info_label_prefix . q{_NUMERIC_TLD} => {
                name => "$name",
                tld  => $tld,
              }
          );
    }

    if ( length "$name" >= $FQDN_MAX_LENGTH ) {    # not trailing 'dot' in $name, which explains the '=' sign.
        push @results,
          info(
            $info_label_prefix . q{_NAME_TOO_LONG} => {
                name => "$name",
                length => length( "$name" ),
                max    => $FQDN_MAX_LENGTH,
              }
          );
    }

    if (not scalar @results) {
        push @results,
          info(
            $info_label_prefix . q{_SYNTAX_OK} => {
                name  => "$name",
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

=item translation()

Returns a refernce to a hash with translation data. Used by the builtin translation system.

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

Verify that MX name (Zonemaster::DNSName) given is conform to previous syntax rules (syntax01, syntax02, syntax03). It also verify name total length as well as labels.

=back

=cut
