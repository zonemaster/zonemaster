package Giraffa::Test::Connectivity v0.0.1;

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

    push @results, $class->connectivity01( $zone );
    push @results, $class->connectivity02( $zone );
    push @results, $class->connectivity03( $zone );
    push @results, $class->connectivity04( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        connectivity01 => [qw(NAMESERVER_HAS_UDP_53 NAMESERVER_NO_UDP_53)],
        connectivity02 => [qw(NAMESERVER_HAS_TCP_53 NAMESERVER_NO_TCP_53)],
        connectivity03 => [qw(NAMESERVER_IPV6_ADDRESS_BOGON NAMESERVER_IPV6_ADDRESSES_NOT_BOGON)],
        connectivity04 => [qw(NAMESERVERS_WITH_UNIQ_AS)],
    };
}

sub version {
    return "$Giraffa::Test::Connectivity::VERSION";
}

###
### Tests
###

sub connectivity01 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns } ) {

        next if $ips{$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{SOA} , { usevc => 0 } );

        if ( $p and $p->rcode eq q{NOERROR} ) {
            push @results,
              info(
                NAMESERVER_HAS_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        }

        $ips{$ns->address->short}++;

    }

    foreach my $local_ns ( @{ $zone->glue } ) {

        next if $ips{$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{SOA} , { usevc => 0 } );

        if ( $p and $p->rcode eq q{NOERROR} ) {
            push @results,
              info(
                NAMESERVER_HAS_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        }

        $ips{$ns->address->short}++;

    }

    return @results;
} ## end sub connectivity01

sub connectivity02 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;

    foreach my $local_ns ( @{ $zone->ns } ) {

        next if $ips{$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{SOA} , { usevc => 1 } );

        if ( $p and $p->rcode eq q{NOERROR} ) {
            push @results,
              info(
                NAMESERVER_HAS_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        }

        $ips{$ns->address->short}++;

    }
    
    foreach my $local_ns ( @{ $zone->glue } ) {

        next if $ips{$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{SOA} , { usevc => 1 } );

        if ( $p and $p->rcode eq q{NOERROR} ) {
            push @results,
              info(
                NAMESERVER_HAS_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short,
                }
              );
        }

        $ips{$ns->address->short}++;

    }

    return @results;
} ## end sub connectivity02

sub connectivity03 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;
    my $ipv6_nb = 0;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next unless $local_ns->address->version == 6;
        next if $ips{$local_ns->address->short};

        $ipv6_nb++;

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        $reverse_ip_query =~ s/ip6.arpa./v6.fullbogons.cymru.com./;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query );

        if ( $p ) {
            if ( $p->rcode ne q{NXDOMAIN} ) {
                foreach my $rr ($p->answer) {
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

        $ips{$local_ns->address->short}++;

    }

    if ( $ipv6_nb > 0 and not grep { $_->tag eq q{NAMESERVER_IPV6_ADDRESS_BOGON} } @results ) {
        push @results,
          info(
            NAMESERVER_IPV6_ADDRESSES_NOT_BOGON => {
                nb => $ipv6_nb,
            }
          );
    }

    return @results;
} ## end sub connectivity03

sub connectivity04 {
    my ( $class, $zone ) = @_;
    my @results;
    my ( %ips, %asns );

    foreach my $local_ns ( @{ $zone->ns },  @{ $zone->glue } ) {

        next if $ips{$local_ns->address->short};

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        $reverse_ip_query =~ s/\.[^\.*]*\.arpa./.asn.routeviews.org./;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, q{TXT} );

        if ( $p ) {
            my ( $txt ) = $p->get_records_for_name( q{TXT}, $reverse_ip_query );
            $asns{$txt->txtdata}++;
        }

        $ips{$local_ns->address->short}++;

    }

    if ( scalar keys %asns == 1 ) {
        push @results,
          info(
            NAMESERVERS_WITH_UNIQ_AS => {
                asn => (keys %asns)[0],
            }
          );
    }

    return @results;
} ## end sub connectivity04

1;

=head1 NAME

Giraffa::Test::Connectivity - module implementing tests of nameservers reachability

=head1 SYNOPSIS

    my @results = Giraffa::Test::Connectivity->all($zone);

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

=item connectivity01($zone)

Verify nameservers UDP port 53 reachability.

=item connectivity02($zone)

Verify nameservers TCP port 53 reachability.

=item connectivity03($zone)

Verify that nameservers addresses are not part of a bogon prefix.

=item connectivity04($zone)

Verify that all nameservers do not belong to the same AS.

=back

=cut
