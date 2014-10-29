package Zonemaster::Test::Connectivity v0.0.5;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::TestMethods;
use Zonemaster::Constants qw[:ip];
use Zonemaster::ASNLookup;
use Carp;

use List::MoreUtils qw[uniq];


###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->connectivity01( $zone );
    push @results, $class->connectivity02( $zone );
    push @results, $class->connectivity03( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        connectivity01 => [
            qw(
              NAMESERVER_HAS_UDP_53
              NAMESERVER_NO_UDP_53
              )
        ],
        connectivity02 => [
            qw(
              NAMESERVER_HAS_TCP_53
              NAMESERVER_NO_TCP_53
              )
        ],
        connectivity03 => [
            qw(
                NAMESERVERS_IPV4_NO_AS
                NAMESERVERS_IPV4_WITH_MULTIPLE_AS
                NAMESERVERS_IPV4_WITH_UNIQ_AS
                NAMESERVERS_IPV6_NO_AS
                NAMESERVERS_IPV6_WITH_MULTIPLE_AS
                NAMESERVERS_IPV6_WITH_UNIQ_AS
                NAMESERVERS_NO_AS
                NAMESERVERS_WITH_MULTIPLE_AS
                NAMESERVERS_WITH_UNIQ_AS
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        'NAMESERVERS_IPV4_WITH_UNIQ_AS'     => 'All nameservers IPv4 addresses are in the same AS ({asn}).',
        'NAMESERVERS_IPV6_WITH_UNIQ_AS'     => 'All nameservers IPv6 addresses are in the same AS ({asn}).',
        'NAMESERVERS_WITH_MULTIPLE_AS'      => 'Domain\'s authoritative nameservers do not belong to the same AS.',
        'NAMESERVERS_WITH_UNIQ_AS'          => 'All nameservers are in the same AS ({asn}).',
        'NAMESERVERS_IPV4_NO_AS'            => 'No IPv4 nameserver address is in an AS.',
        'NAMESERVERS_IPV4_WITH_MULTIPLE_AS' => 'Authoritative IPv4 nameservers are in more than one AS.',
        'NAMESERVERS_IPV6_NO_AS'            => 'No IPv6 nameserver address is in an AS.',
        'NAMESERVERS_IPV6_WITH_MULTIPLE_AS' => 'Authoritative IPv6 nameservers are in more than one AS.',
        'NAMESERVERS_NO_AS'                 => 'No nameserver address is in an AS.',
        'NAMESERVER_HAS_TCP_53'             => 'Nameserver {ns}/{address} accessible over TCP on port 53.',
        'NAMESERVER_HAS_UDP_53'             => 'Nameserver {ns}/{address} accessible over UDP on port 53.',
        'NAMESERVER_NO_TCP_53'              => 'Nameserver {ns}/{address} not accessible over TCP on port 53.',
        'NAMESERVER_NO_UDP_53'              => 'Nameserver {ns}/{address} not accessible over UDP on port 53.',
    };
}

sub version {
    return "$Zonemaster::Test::Connectivity::VERSION";
}

###
### Tests
###

sub connectivity01 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $ips{ $local_ns->address->short };

        my $p = $local_ns->query( $zone->name, q{SOA}, { usevc => 0 } );

        if ( $p and $p->rcode eq q{NOERROR} ) {
            push @results,
              info(
                NAMESERVER_HAS_UDP_53 => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        }
        else {
            push @results,
              info(
                NAMESERVER_NO_UDP_53 => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    return @results;
} ## end sub connectivity01

sub connectivity02 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $ips{ $local_ns->address->short };

        my $p = $local_ns->query( $zone->name, q{SOA}, { usevc => 1 } );

        if ( $p and $p->rcode eq q{NOERROR} ) {
            push @results,
              info(
                NAMESERVER_HAS_TCP_53 => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        }
        else {
            push @results,
              info(
                NAMESERVER_NO_TCP_53 => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        }

        $ips{ $local_ns->address->short }++;

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    return @results;
} ## end sub connectivity02

sub connectivity03 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips = ( 4 => {}, 6 => {} );

    foreach
      my $ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {
        my $addr = $ns->address;
        $ips{$addr->version}{$addr->ip} = $addr;
    }

    my @v4ips = values %{$ips{4}};
    my @v6ips = values %{$ips{6}};

    my @v4asns   = uniq map {Zonemaster::ASNLookup->get($_)} @v4ips;
    my @v6asns   = uniq map {Zonemaster::ASNLookup->get($_)} @v6ips;
    my @all_asns = uniq(@v4asns, @v6asns);

    if (@v4asns == 1) {
        push @results, info( NAMESERVERS_IPV4_WITH_UNIQ_AS => { asn => $v4asns[0] } );
    }
    elsif ( @v4asns > 1 ) {
        push @results, info( NAMESERVERS_IPV4_WITH_MULTIPLE_AS => { asn => join(';', @v4asns) } );
    }
    else {
        push @results, info( NAMESERVERS_IPV4_NO_AS => { } );
    }

    if (@v6asns == 1) {
        push @results, info( NAMESERVERS_IPV6_WITH_UNIQ_AS => { asn => $v6asns[0] } );
    }
    elsif ( @v6asns > 1 ) {
        push @results, info( NAMESERVERS_IPV6_WITH_MULTIPLE_AS => { asn => join(';', @v6asns) } );
    }
    else {
        push @results, info( NAMESERVERS_IPV6_NO_AS => { } );
    }

    if (@all_asns == 1) {
        push @results, info( NAMESERVERS_WITH_UNIQ_AS => { asn => $all_asns[0] } );
    }
    elsif ( @all_asns > 1 ) {
        push @results, info( NAMESERVERS_WITH_MULTIPLE_AS => { asn => join(';', @all_asns) } );
    }
    else {
        push @results, info( NAMESERVERS_NO_AS => { } ); # Shouldn't pass Basic
    }

    return @results;
} ## end sub connectivity03

1;

=head1 NAME

Zonemaster::Test::Connectivity - module implementing tests of nameservers reachability

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Connectivity->all($zone);

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

=item connectivity01($zone)

Verify nameservers UDP port 53 reachability.

=item connectivity02($zone)

Verify nameservers TCP port 53 reachability.

=item connectivity03($zone)

Verify that all nameservers do not belong to the same AS.

=back

=cut
