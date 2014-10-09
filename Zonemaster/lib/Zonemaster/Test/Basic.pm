package Zonemaster::Test::Basic v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::TestMethods;
use Zonemaster::Test::Address;
use Zonemaster::Test::Syntax;
use List::MoreUtils qw[any none];

use Carp;

use Readonly;

Readonly our $IP_VERSION_4 => $Zonemaster::Test::Address::IP_VERSION_4;
Readonly our $IP_VERSION_6 => $Zonemaster::Test::Address::IP_VERSION_6;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->basic00( $zone );

    if ( none { $_->tag eq q{DOMAIN_NAME_LABEL_TOO_LONG} or $_->tag eq q{DOMAIN_NAME_ZERO_LENGTH_LABEL} or $_->tag eq q{DOMAIN_NAME_TOO_LONG} } @results ) {
        push @results, $class->basic01( $zone );

        # Perform BASIC2 if BASIC1 passed
        if ( any { $_->tag eq q{HAS_GLUE} } @results ) {
            push @results, $class->basic02( $zone );
        }
        else {
            push @results,
              info(
                NO_GLUE_PREVENTS_NAMESERVER_TESTS => { } 
              );
        }

        # Perform BASIC3 if BASIC2 failed
        if ( none { $_->tag eq q{HAS_NAMESERVERS} } @results ) {
            push @results, $class->basic03( $zone );
        }
        else {
            push @results,
              info(
                HAS_NAMESERVER_NO_WWW_A_TEST => {
                    name => $zone->name,
                } 
              );
        }
    }

    return @results;
}

sub can_continue {
    my ( $class, @results ) = @_;
    my %tag = map { $_->tag => 1 } @results;

    if ( $tag{HAS_GLUE} and $tag{HAS_NAMESERVERS} ) {
        return 1;
    }
    else {
        return;
    }
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        basic00 => [
            qw(
              DOMAIN_NAME_LABEL_TOO_LONG
              DOMAIN_NAME_ZERO_LENGTH_LABEL
              DOMAIN_NAME_TOO_LONG
              )
        ],
        basic01 => [
            qw(
              NO_PARENT
              HAS_GLUE
              NO_GLUE
              NO_DOMAIN
              PARENT_REPLIES
              NO_PARENT_RESPONSE
              )
        ],
        basic02 => [
            qw(
              NO_GLUE_PREVENTS_NAMESERVER_TESTS
              NS_FAILED
              NS_NO_RESPONSE
              HAS_NAMESERVERS
              IPV4_DISABLED
              IPV6_DISABLED
              IPV4_ENABLED
              IPV6_ENABLED
              )
        ],
        basic03 => [
            qw(
              NO_NAMESERVER_PREVENTS_WWW_A_TEST
              HAS_A_RECORDS
              IPV4_DISABLED
              IPV6_DISABLED
              IPV4_ENABLED
              IPV6_ENABLED
              A_QUERY_NO_RESPONSES
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        "DOMAIN_NAME_LABEL_TOO_LONG"        => "Domain name ({name}) has a label ({label}) too long ({length}/{max}).",
        "DOMAIN_NAME_ZERO_LENGTH_LABEL"     => "Domain name ({name}) has a zero length label.",
        "DOMAIN_NAME_TOO_LONG"              => "Domain name is too long ({length}/{max}).",
        'NO_PARENT'                         => 'No parent domain could be found for the tested domain.',
        'NO_GLUE'                           => 'Nameservers for "{parent}" provided no NS records for tested zone. RCODE given was {rcode}.',
        'HAS_A_RECORDS'                     => 'Nameserver {source} returned A record(s) for {name}.',
        'NO_A_RECORDS'                      => 'Nameserver {source} did not return A record(s) for {name}.',
        'NO_DOMAIN'                         => 'Nameserver for zone {parent} responded with NXDOMAIN to query for glue.',
        'HAS_NAMESERVERS'                   => 'Nameserver {source} listed these servers as glue: {ns}.',
        'PARENT_REPLIES'                    => 'Nameserver for zone {parent} replies when trying to fetch glue.',
        'NO_PARENT_RESPONSE'                => 'No response from nameserver for zone {parent} when trying to fetch glue.',
        'NO_GLUE_PREVENTS_NAMESERVER_TESTS' => 'No NS records for tested zone from parent. NS tests aborted.',
        'NS_FAILED'                         => 'Nameserver {source} did not return NS records. RCODE was {rcode}.',
        'NS_NO_RESPONSE'                    => 'Nameserver {source} did not respond to NS query.',
        'A_QUERY_NO_RESPONSES'              => 'Nameservers did not respond to A query.',
        'HAS_NAMESERVER_NO_WWW_A_TEST'      => 'Functional nameserver found. "A" query for www.{name} test aborted.',
        'HAS_GLUE'                          => 'Nameserver for zone {parent} listed these nameservers as glue: {ns}.',
        'IPV4_DISABLED'                     => 'IPv4 is disabled, not sending "{type}" query to {ns}.',
        'IPV4_ENABLED'                      => 'IPv4 is enabled, can send "{type}" query to {ns}.',
        'IPV6_DISABLED'                     => 'IPv6 is disabled, not sending "{type}" query to {ns}.',
        'IPV6_ENABLED'                      => 'IPv6 is enabled, can send "{type}" query to {ns}.',
    };
}

sub version {
    return "$Zonemaster::Test::Basic::VERSION";
}

###
### Tests
###

sub basic00 {
    my ( $class, $item ) = @_;
    my @results;

    my $name = Zonemaster::Test::Syntax::get_name( $item );

    foreach my $local_label ( @{ $name->labels } ) {
        if ( length $local_label > $Zonemaster::Test::Syntax::LABEL_MAX_LENGTH ) {
            push @results,
              info(
                q{DOMAIN_NAME_LABEL_TOO_LONG} => {
                    name   => "$name",
                    label  => $local_label,
                    length => length( $local_label ),
                    max    => $Zonemaster::Test::Syntax::LABEL_MAX_LENGTH,
                  }
              );
        }
        elsif ( length $local_label == 0 ) {
            push @results,
              info(
                q{DOMAIN_NAME_ZERO_LENGTH_LABEL} => {
                    name   => "$name",
                  }
              );
        }
    }

    my $fqdn = Zonemaster::Test::Syntax::get_FQDN_string( $name );
    if ( length( $fqdn ) > $Zonemaster::Test::Syntax::FQDN_MAX_LENGTH ) {
        push @results,
          info(
            q{DOMAIN_NAME_TOO_LONG} => {
                name => $fqdn,
                length => length( $fqdn ),
                max    => $Zonemaster::Test::Syntax::FQDN_MAX_LENGTH,
              }
          );
    }

    return @results;

}

sub basic01 {
    my ( $class, $zone ) = @_;
    my @results;

    my $parent = $zone->parent;

    if (not $parent) {
        return info( NO_PARENT => { zone => $zone->name->string });
    }

    my $p = $parent->query_one( $zone->name, q{NS} );

    if ( $p ) {
        push @results,
          info(
            PARENT_REPLIES => {
                parent => $parent->name->string,
            }
          );
    }
    else {
        push @results,
          info(
            NO_PARENT_RESPONSE => {
                parent => $parent->name->string,
            }
          );
        return @results;
    }

    if ( $p->rcode eq q{NXDOMAIN} ) {
        push @results,
          info(
            NO_DOMAIN => {
                parent => $parent->name->string,
            }
          );
    }
    else {
        if ( $p->has_rrs_of_type_for_name( q{NS}, $zone->name ) ) {
            push @results,
              info(
                HAS_GLUE => {
                    parent => $parent->name->string,
                    ns     => join( q{,}, sort map { $_->nsdname } $p->get_records_for_name( q{NS}, $zone->name ) ),
                }
              );
        }
        else {
            push @results,
              info(
                NO_GLUE => {
                    parent => $parent->name->string,
                    rcode  => $p->rcode,
                }
              );
        }
    } ## end else [ if ( $p->rcode eq q{NXDOMAIN})]

    return @results;
} ## end sub basic01

sub basic02 {
    my ( $class, $zone ) = @_;
    my @results;

    foreach my $ns ( @{ Zonemaster::TestMethods->method4($zone) } ) {
        if (not Zonemaster->config->ipv4_ok and $ns->address->version == $IP_VERSION_4) {
            push @results,
              info(
                IPV4_DISABLED => {
                    ns   => "$ns",
                    type => q{NS},
                }
              );
            next;
        }
        elsif (Zonemaster->config->ipv4_ok and $ns->address->version == $IP_VERSION_4)  {
            push @results,
              info(
                IPV4_ENABLED => {
                    ns   => "$ns",
                    type => q{NS},
                }
              );
        }

        if (not Zonemaster->config->ipv6_ok and $ns->address->version == $IP_VERSION_6) {
            push @results,
              info(
                IPV6_DISABLED => {
                    ns   => "$ns",
                    type => q{NS},
                }
              );
            next;
        }
        elsif (Zonemaster->config->ipv6_ok and $ns->address->version == $IP_VERSION_6) {
            push @results,
              info(
                IPV6_ENABLED => {
                    ns   => "$ns",
                    type => q{NS},
                }
              );
        }

        my $p = $ns->query( $zone->name, q{NS} );
        if ( $p ) {
            if ( $p->has_rrs_of_type_for_name( q{NS}, $zone->name ) ) {
                push @results,
                  info(
                    HAS_NAMESERVERS => {
                        ns     => join( q{,}, sort map { $_->nsdname } $p->get_records_for_name( q{NS}, $zone->name ) ),
                        source => $ns->string,
                    }
                  );
            }
            else {
                push @results,
                  info(
                    NS_FAILED => {
                        source => $ns->string,
                        rcode  => $p->rcode,
                    }
                  );
            }
        } ## end if ( $p )
        else {
            push @results,
              info(
                NS_NO_RESPONSE => {
                    source => $ns->string,
                }
              );
        }
    } ## end foreach my $ns ( @{ $zone->...})

    return @results;
} ## end sub basic02

sub basic03 {
    my ( $class, $zone ) = @_;
    my @results;

    my $name = q{www.} . $zone->name;
    my $response_nb = 0;
    foreach my $ns ( @{ Zonemaster::TestMethods->method4($zone) } ) {
        if (not Zonemaster->config->ipv4_ok and $ns->address->version == $IP_VERSION_4) {
            push @results,
              info(
                IPV4_DISABLED => {
                    ns   => "$ns",
                    type => q{A},
                }
              );
            next;
        }
        else {
            push @results,
              info(
                IPV4_ENABLED => {
                    ns   => "$ns",
                    type => q{NS},
                }
              );
        }

        if (not Zonemaster->config->ipv6_ok and $ns->address->version == $IP_VERSION_6) {
            push @results,
              info(
                IPV6_DISABLED => {
                    ns   => "$ns",
                    type => q{A},
                }
              );
            next;
        }
        else {
            push @results,
              info(
                IPV6_ENABLED => {
                    ns   => "$ns",
                    type => q{NS},
                }
              );
        }

        my $p = $ns->query( $name, q{A} );
        next if not $p;
        $response_nb++;
        if ( $p->has_rrs_of_type_for_name( q{A}, $name ) ) {
            push @results,
              info(
                HAS_A_RECORDS => {
                    source => $ns->string,
                    name   => $name,
                }
              );
        }
        else {
            push @results,
              info(
                NO_A_RECORDS => {
                    source => $ns->string,
                    name   => $name,
                }
              );
        }
    }

    if (scalar( @{ Zonemaster::TestMethods->method4($zone) } ) and not $response_nb) {
        push @results,
          info(
            A_QUERY_NO_RESPONSES => { }
          );
    }

    return @results;
} ## end sub basic03

1;

=head1 NAME

Zonemaster::Test::Basic - module implementing test for very basic domain functionality

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Basic->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs between one and three tests, depending on the zone. If L<basic01> passes, L<basic02> is run. If L<basic02> fails, L<basic03> is run.

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

=item translation()

Returns a refernce to a hash with translation data. Used by the builtin translation system.

=item version()

Returns a version string for the module.

=item can_continue(@results)

Looks at the provided log entries and returns true if they indicate that further testing of the relevant zone is possible.

=back

=head1 TESTS

=over

=item basic00

Checks if the domain name to be tested is valid. Not all syntax tests are done here, it "just" checks domain name total length and labels length.
In case of failure, all other tests are aborted.

=item basic01

Checks that we can find a parent zone for the zone we're testing. If we can't, no further testing is done.

=item basic02

Checks that the nameservers for the parent zone returns NS records for the tested zone, and that at least one of the nameservers thus pointed out
responds sensibly to an NS query for the tested zone.

=item basic03

Checks if at least one of the nameservers pointed out by the parent zone gives a useful response when sent an A query for the C<www> label in the
tested zone (that is, if we're testing C<example.org> this test will as for A records for C<www.example.org>). This test is only run if the
L<basic02> test has I<failed>.

=back

=cut
