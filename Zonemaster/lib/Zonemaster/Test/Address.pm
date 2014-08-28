package Zonemaster::Test::Address v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;

use Carp;

use Readonly;
use Net::IP;

Readonly our $IP_VERSION_4 => 4;
Readonly our $IP_VERSION_6 => 6;

Readonly::Array our @IPV4_SPECIAL_ADDRESSES => (
    { ip => Net::IP->new( q{0.0.0.0/8} ),          name => q{This host on this network}, reference => q{RFC 1122} },
    { ip => Net::IP->new( q{10.0.0.0/8} ),         name => q{Private-Use},               reference => q{RFC 1918} },
    { ip => Net::IP->new( q{192.168.0.0/16} ),     name => q{Private-Use},               reference => q{RFC 1918} },
    { ip => Net::IP->new( q{172.16.0.0/12} ),      name => q{Private-Use},               reference => q{RFC 1918} },
    { ip => Net::IP->new( q{100.64.0.0/10} ),      name => q{Shared Address Space},      reference => q{RFC 6598} },
    { ip => Net::IP->new( q{127.0.0.0/8} ),        name => q{Loopback},                  reference => q{RFC 1122} },
    { ip => Net::IP->new( q{169.254.0.0/16} ),     name => q{Link Local},                reference => q{RFC 3927} },
    { ip => Net::IP->new( q{192.0.0.0/24} ),       name => q{IETF Protocol Assignments}, reference => q{RFC 6890} },
    { ip => Net::IP->new( q{192.0.0.0/29} ),       name => q{DS Lite},                   reference => q{RFC 6333} },
    { ip => Net::IP->new( q{192.0.0.170/32} ),     name => q{NAT64/DNS64 Discovery},     reference => q{RFC 7050} },
    { ip => Net::IP->new( q{192.0.0.171/32} ),     name => q{NAT64/DNS64 Discovery},     reference => q{RFC 7050} },
    { ip => Net::IP->new( q{192.0.2.0/24} ),       name => q{Documentation},             reference => q{RFC 5737} },
    { ip => Net::IP->new( q{198.51.100.0/24} ),    name => q{Documentation},             reference => q{RFC 5737} },
    { ip => Net::IP->new( q{203.0.113.0/24} ),     name => q{Documentation},             reference => q{RFC 5737} },
    { ip => Net::IP->new( q{192.88.99.0/24} ),     name => q{6to4 Relay Anycast},        reference => q{RFC 3068} },
    { ip => Net::IP->new( q{198.18.0.0/15} ),      name => q{Benchmarking},              reference => q{RFC 2544} },
    { ip => Net::IP->new( q{240.0.0.0/4} ),        name => q{Reserved},                  reference => q{RFC 1112} },
    { ip => Net::IP->new( q{255.255.255.255/32} ), name => q{Limited Broadcast},         reference => q{RFC 919} },
    { ip => Net::IP->new( q{224.0.0.0/4} ),        name => q{IPv4 multicast addresses},  reference => q{RFC 5771} },
);

Readonly::Array our @IPV6_SPECIAL_ADDRESSES => (
    { ip => Net::IP->new( q{::1/128} ),       name => q{Loopback Address},           reference => q{RFC 4291} },
    { ip => Net::IP->new( q{::/128} ),        name => q{Unspecified Address},        reference => q{RFC 4291} },
    { ip => Net::IP->new( q{::ffff:0:0/96} ), name => q{IPv4-mapped Address},        reference => q{RFC 4291} },
    { ip => Net::IP->new( q{64:ff9b::/96} ),  name => q{IPv4-IPv6 Translation},      reference => q{RFC 6052} },
    { ip => Net::IP->new( q{100::/64} ),      name => q{Discard-Only Address Block}, reference => q{RFC 6666} },
    { ip => Net::IP->new( q{2001::/23} ),     name => q{IETF Protocol Assignments},  reference => q{RFC 2928} },
    { ip => Net::IP->new( q{2001::/32} ),     name => q{TEREDO},                     reference => q{RFC 4380} },
    { ip => Net::IP->new( q{2001:2::/48} ),   name => q{Benchmarking},               reference => q{RFC 5180} },
    { ip => Net::IP->new( q{2001:db8::/32} ), name => q{Documentation},              reference => q{RFC 3849} },
    { ip => Net::IP->new( q{2001:10::/28} ),  name => q{Deprecated (ORCHID)},        reference => q{RFC 4843} },
    { ip => Net::IP->new( q{2002::/16} ),     name => q{6to4},                       reference => q{RFC 3056} },
    { ip => Net::IP->new( q{fc00::/7} ),      name => q{Unique-Local},               reference => q{RFC 4193} },
    { ip => Net::IP->new( q{fe80::/10} ),     name => q{Linked-Scoped Unicast},      reference => q{RFC 4291} },
    { ip => Net::IP->new( q{::/96} ),     name => q{Deprecated (IPv4-compatible Address)}, reference => q{RFC 4291} },
    { ip => Net::IP->new( q{5f00::/8} ),  name => q{unallocated (ex 6bone)},               reference => q{RFC 3701} },
    { ip => Net::IP->new( q{3ffe::/16} ), name => q{unallocated (ex 6bone)},               reference => q{RFC 3701} },
    { ip => Net::IP->new( q{ff00::/8} ),  name => q{IPv6 multicast addresses},             reference => q{RFC 4291} },
);
###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->address01( $zone );
    push @results, $class->address02( $zone );
    # Perform ADDRESS03 if ADDRESS01 passed
    if ( not grep { $_->tag eq q{NAMESERVER_IP_WITHOUT_REVERSE} } @results ) {
        push @results, $class->address03( $zone );
    }
    push @results, $class->address04( $zone );

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
              )
        ],
        address02 => [
            qw(
              NAMESERVER_IP_WITHOUT_REVERSE
              )
        ],
        address03 => [
            qw(
              NAMESERVER_IP_WITHOUT_REVERSE
              NAMESERVER_IP_PTR_MISMATCH
              )
        ],
        address04 => [
            qw(
              NAMESERVER_IPV6_ADDRESS_BOGON
              NAMESERVER_IPV6_ADDRESSES_NOT_BOGON
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        "NAMESERVER_IP_WITHOUT_REVERSE" => "Nameserver {ns} has an IP address ({address}) without PTR configured.",
        "NAMESERVER_IP_PTR_MISMATCH" =>
          "Nameserver {ns} has an IP address ({address}) with mismatched PTR result ({names}).",
        "NAMESERVER_IPV6_ADDRESSES_NOT_BOGON" =>
          "None of the {nb} nameserver(s) with IPv6 addresses is part of a bogon prefix.",
        "NAMESERVER_IPV6_ADDRESS_BOGON" => "Nameserver {ns} IPv6 address {address} is part of a bogon prefix.",
        "NAMESERVER_IP_PRIVATE_NETWORK" =>
          "Nameserver {ns} has an IP address ({address}) with prefix {prefix} referenced in {reference} as a '{name}'.",
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

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
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

    } ## end foreach my $local_ns ( @{ $zone...})

    return @results;
} ## end sub address01

sub address02 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{ $local_ns->address->short };

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Zonemaster::Recursor->recurse( $reverse_ip_query, q{PTR} );

        if ( $p ) {
            if ( $p->rcode ne q{NOERROR} ) {
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
            croak q{No response from nameserver};
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ $zone...})

    return @results;
} ## end sub address02

sub address03 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{ $local_ns->address->short };

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Zonemaster::Recursor->recurse( $reverse_ip_query, q{PTR} );

        if ( $p ) {
            my @ptr = $p->get_records_for_name( q{PTR}, $reverse_ip_query );
            if ( $p->rcode eq q{NOERROR} and scalar @ptr ) {
                if ( not grep { $_->ptrdname eq $local_ns->name->string . q{.} } @ptr ) {
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
            croak q{No response from nameserver};
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ $zone...})
    return @results;
} ## end sub address03

sub address04 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;
    my $ipv6_nb = 0;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next if not $local_ns->address;
        next if not $local_ns->address->version == $IP_VERSION_6;
        next if $ips{ $local_ns->address->short };

        $ipv6_nb++;

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        $reverse_ip_query =~ s/ip6.arpa./v6.fullbogons.cymru.com./smx;

        my $p = Zonemaster::Recursor->recurse( $reverse_ip_query );

        if ( $p ) {
            if ( $p->rcode ne q{NXDOMAIN} ) {
                foreach my $rr ( $p->answer ) {
                    if ( $rr->type eq q{A} and $rr->address eq q{127.0.0.2} ) {
                        push @results,
                          info(
                            NAMESERVER_IPV6_ADDRESS_BOGON => {
                                ns      => $local_ns->name->string,
                                address => $local_ns->address->short,
                            }
                          );
                    }
                }
            }
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ $zone...})

    if ( $ipv6_nb > 0 and not grep { $_->tag eq q{NAMESERVER_IPV6_ADDRESS_BOGON} } @results ) {
        push @results,
          info(
            NAMESERVER_IPV6_ADDRESSES_NOT_BOGON => {
                nb => $ipv6_nb,
            }
          );
    }

    return @results;
} ## end sub address04

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

=item address04($zone)

Verify that nameservers addresses are not part of a bogon prefix.

=item find_special_address($ip)

Verify that an address (Net::IP) given is a special (private, reserved, ...) one.

=back

=cut

