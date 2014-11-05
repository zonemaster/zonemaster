package Zonemaster::Test::Address v0.0.3;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::TestMethods;
use Zonemaster::Constants qw[:addresses :ip];
use List::MoreUtils qw[none any];

use Carp;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->address01( $zone );
    push @results, $class->address02( $zone );
    # Perform ADDRESS03 if ADDRESS02 passed
    if ( any { $_->tag eq q{NAMESERVERS_IP_WITH_REVERSE} } @results ) {
        push @results, $class->address03( $zone );
    }

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        address01 => [
            qw(
              NAMESERVER_IP_PRIVATE_NETWORK
              NO_IP_PRIVATE_NETWORK
              )
        ],
        address02 => [
            qw(
              NAMESERVER_IP_WITHOUT_REVERSE
              NAMESERVERS_IP_WITH_REVERSE
              NO_RESPONSE_PTR_QUERY
              )
        ],
        address03 => [
            qw(
              NAMESERVER_IP_WITHOUT_REVERSE
              NAMESERVER_IP_PTR_MISMATCH
              NAMESERVER_IP_PTR_MATCH
              NO_RESPONSE_PTR_QUERY
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        'NAMESERVER_IP_WITHOUT_REVERSE' => 'Nameserver {ns} has an IP address ({address}) without PTR configured.',
        'NAMESERVER_IP_PTR_MISMATCH' =>
          'Nameserver {ns} has an IP address ({address}) with mismatched PTR result ({names}).',
        'NAMESERVER_IP_PRIVATE_NETWORK' =>
'Nameserver {ns} has an IP address ({address}) with prefix {prefix} referenced in {reference} as a \'{name}\'.',
        'NO_IP_PRIVATE_NETWORK'       => 'All Nameserver addresses are in the routable public addressing space.',
        'NAMESERVERS_IP_WITH_REVERSE' => 'Reverse DNS entry exist for all Nameserver IP addresses.',
        'NAMESERVER_IP_PTR_MATCH'     => 'All reverse DNS entry matches name server name.',
        'NO_RESPONSE_PTR_QUERY'       => 'No response from nameserver(s) on PTR query ({reverse}).',
    };
}

sub version {
    return "$Zonemaster::Test::Address::VERSION";
}

sub find_special_address {
    my ( $class, $ip ) = @_;
    my @special_addresses;

    if ( $ip->version == $IP_VERSION_4 ) {
        @special_addresses = @IPV4_SPECIAL_ADDRESSES;
    }
    elsif ( $ip->version == $IP_VERSION_6 ) {
        @special_addresses = @IPV6_SPECIAL_ADDRESSES;
    }

    foreach my $ip_details ( @special_addresses ) {
        if ( $ip->overlaps( ${$ip_details}{ip} ) ) {
            return $ip_details;
        }
    }

    return;
}

sub address01 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if $ips{ $local_ns->address->short };

        my $ip_details_ref = $class->find_special_address( $local_ns->address );

        if ( $ip_details_ref ) {
            push @results,
              info(
                NAMESERVER_IP_PRIVATE_NETWORK => {
                    ns        => $local_ns->name->string,
                    address   => $local_ns->address->short,
                    prefix    => ${$ip_details_ref}{ip}->print,
                    name      => ${$ip_details_ref}{name},
                    reference => ${$ip_details_ref}{reference},
                }
              );
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %ips and not scalar @results ) {
        push @results,
          info( NO_IP_PRIVATE_NETWORK => {} );
    }

    return @results;
} ## end sub address01

sub address02 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ Zonemaster::TestMethods->method5( $zone ) } ) {

        next if $ips{ $local_ns->address->short };

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        my $p = Zonemaster::Recursor->recurse( $reverse_ip_query, q{PTR} );

        if ( $p ) {
            if ( $p->rcode ne q{NOERROR} or not $p->get_records( q{PTR}, q{answer} ) ) {
                push @results,
                  info(
                    NAMESERVER_IP_WITHOUT_REVERSE => {
                        ns      => $local_ns->name->string,
                        address => $local_ns->address->short,
                    }
                  );
            }
        }
        else {
            push @results,
              info(
                NO_RESPONSE_PTR_QUERY => {
                    reverse => $reverse_ip_query,
                }
              );
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %ips and not scalar @results ) {
        push @results,
          info( NAMESERVERS_IP_WITH_REVERSE => {} );
    }

    return @results;
} ## end sub address02

sub address03 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ Zonemaster::TestMethods->method5( $zone ) } ) {

        next if $ips{ $local_ns->address->short };

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Zonemaster::Recursor->recurse( $reverse_ip_query, q{PTR} );

        if ( $p ) {
            my @ptr = $p->get_records_for_name( q{PTR}, $reverse_ip_query );
            if ( $p->rcode eq q{NOERROR} and scalar @ptr ) {
                if ( none { name( $_->ptrdname ) eq $local_ns->name->string . q{.} } @ptr ) {
                    push @results,
                      info(
                        NAMESERVER_IP_PTR_MISMATCH => {
                            ns      => $local_ns->name->string,
                            address => $local_ns->address->short,
                            names   => join( q{/}, map { $_->ptrdname } @ptr ),
                        }
                      );
                }
            }
            else {
                push @results,
                  info(
                    NAMESERVER_IP_WITHOUT_REVERSE => {
                        ns      => $local_ns->name->string,
                        address => $local_ns->address->short,
                    }
                  );
            }
        } ## end if ( $p )
        else {
            push @results,
              info(
                NO_RESPONSE_PTR_QUERY => {
                    reverse => $reverse_ip_query,
                }
              );
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %ips and not scalar @results ) {
        push @results,
          info( NAMESERVER_IP_PTR_MATCH => {} );
    }

    return @results;
} ## end sub address03

1;

=head1 NAME

Zonemaster::Test::Address - module implementing tests focused on the Address specific test cases of the DNS tests

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Address->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

=item translation()

Returns a refernce to a hash with translation data. Used by the builtin translation system.

=item version()

Returns a version string for the module.

=back

=head1 TESTS

=over

=item address01($zone)

Verify that IPv4 addresse are not in private networks.

=item address02($zone)

Verify reverse DNS entries exist for nameservers IP addresses.

=item address03($zone)

Verify that reverse DNS entries match nameservers names.

=item find_special_address($ip)

Verify that an address (Net::IP::XS) given is a special (private, reserved, ...) one.

=back

=cut

