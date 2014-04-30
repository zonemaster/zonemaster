package Giraffa::Test::Connectivity v0.0.5;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;
use Giraffa::Test::Address;

use Carp;

use Readonly;
use List::Util qw[minstr];

Readonly our $ASN_UNASSIGNED_UNANNOUNCED_ADDRESS_SPACE_VALUE => 4_294_967_295;
Readonly our $IP_VERSION_4                                   => $Giraffa::Test::Address::IP_VERSION_4;
Readonly our $IP_VERSION_6                                   => $Giraffa::Test::Address::IP_VERSION_6;
Readonly our $ASN_CHECKING_TEAM_CYMRU_SERVICE_NAME           => q{TEAMCYRU};
Readonly our $ASN_CHECKING_ROUTE_VIEWS_SERVICE_NAME          => q{ROUTEVIEWS};
Readonly our $ASN_CHECKING_SERVICE_USED                      => $ASN_CHECKING_TEAM_CYMRU_SERVICE_NAME;
Readonly our $ASN_IPV4_CHECKING_SERVICE_TEAM_CYMRU_DOMAIN    => q{.origin.asn.cymru.com.};
Readonly our $ASN_IPV6_CHECKING_SERVICE_TEAM_CYMRU_DOMAIN    => q{.origin6.asn.cymru.com.};
Readonly our $ASN_IPV4_CHECKING_SERVICE_ROUTE_VIEWS_DOMAIN   => q{.asn.routeviews.org.};
Readonly our $ASN_IPV6_CHECKING_SERVICE_ROUTE_VIEWS_DOMAIN   => q{};

Readonly::Hash our %ASN_CHECKING_SERVICE_DOMAIN => {
                       $ASN_CHECKING_TEAM_CYMRU_SERVICE_NAME => {
                           descr => q{Team Cymru Community services 'https://www.team-cymru.org/'},
                           $IP_VERSION_4 => $ASN_IPV4_CHECKING_SERVICE_TEAM_CYMRU_DOMAIN,
                           $IP_VERSION_6 => $ASN_IPV6_CHECKING_SERVICE_TEAM_CYMRU_DOMAIN,
                           f => sub {
                                    my ( $txt, $rcode ) = @_;
                                    my ( $asn );
                                    if ( $rcode eq q{NXDOMAIN} ) {
                                        $asn = $ASN_UNASSIGNED_UNANNOUNCED_ADDRESS_SPACE_VALUE;
                                    }
                                    else {
                                        $txt =~ s/\A"|"\z//smgx;
                                        ( $asn ) = split /\s+/smx, $txt;
                                    }
                                    return ( $asn );
                                },
                       },
                       $ASN_CHECKING_ROUTE_VIEWS_SERVICE_NAME =>  {
                           descr => q{University of Oregon Route Views Project 'http://www.routeviews.org/'},
                           $IP_VERSION_4 => $ASN_IPV4_CHECKING_SERVICE_ROUTE_VIEWS_DOMAIN,
                           $IP_VERSION_6 => $ASN_IPV6_CHECKING_SERVICE_ROUTE_VIEWS_DOMAIN,
                           f => sub {
                                    my ( $txt, $rcode ) = @_;
                                    my ( $asn, $prefix, $prefix_len ) = map {my $r = $_; $r =~ s/"//smgx; $r} split /\s+/smx, $txt;
                                    return ( $asn );
                                },
                       },
                   };
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
        connectivity04 => [qw(NAMESERVER_WITH_UNALLOCATED_ADDRESS NAMESERVERS_WITH_UNIQ_AS NAMESERVERS_IPV4_WITH_UNIQ_AS NAMESERVERS_IPV6_WITH_UNIQ_AS)],
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
        }
        else {
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
        }
        else {
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
        }
        else {
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
        }
        else {
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

        next if not $local_ns->address;
        next if not $local_ns->address->version == $IP_VERSION_6;
        next if $ips{$local_ns->address->short};

        $ipv6_nb++;

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        $reverse_ip_query =~ s/ip6.arpa./v6.fullbogons.cymru.com./smx;

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

        if ( not $ASN_CHECKING_SERVICE_DOMAIN{$ASN_CHECKING_SERVICE_USED}{$local_ns->address->version} ) {
            push @results,
              info(
                ADDRESS_TYPE_NOT_IMPLEMENTED => {
                    service => $ASN_CHECKING_SERVICE_DOMAIN{$ASN_CHECKING_SERVICE_USED}{descr},
                    type    => $local_ns->address->version,
                }
              );
            next;
        }

        $reverse_ip_query =~ s/\.[^\.*]*\.arpa./$ASN_CHECKING_SERVICE_DOMAIN{$ASN_CHECKING_SERVICE_USED}{$local_ns->address->version}/smx;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, q{TXT} );

        if ( $p ) {
            my ( $txt ) = $p->get_records_for_name( q{TXT}, $reverse_ip_query );
            my ( $asn ) = &{ $ASN_CHECKING_SERVICE_DOMAIN{$ASN_CHECKING_SERVICE_USED}{f} }($txt->txtdata, $p->rcode);
            if ( $asn == $ASN_UNASSIGNED_UNANNOUNCED_ADDRESS_SPACE_VALUE ) {
                push @results,
                  info(
                    NAMESERVER_WITH_UNALLOCATED_ADDRESS => {
                        ns      => $local_ns->name->string,
                        address => $local_ns->address->short,
                    }
                  );
            }
            else {
                $asns{$local_ns->address->version}{$asn}++;
            }
        }

        $ips{$local_ns->address->short}++;

    }

    if ( ( scalar keys %{ $asns{$IP_VERSION_4} } == 1 and scalar keys %{ $asns{$IP_VERSION_6} } == 0 ) or
         ( scalar keys %{ $asns{$IP_VERSION_6} } == 1 and scalar keys %{ $asns{$IP_VERSION_4} } == 0 ) or
         (     scalar keys %{ $asns{$IP_VERSION_4} } == 1
           and scalar keys %{ $asns{$IP_VERSION_6} } == 1
           and minstr(keys %{ $asns{$IP_VERSION_4} }) == minstr(keys %{ $asns{$IP_VERSION_6} })
         )
       ) {
        push @results,
          info(
            NAMESERVERS_WITH_UNIQ_AS => {
                asn => minstr(keys %{ $asns{$IP_VERSION_4} }),
            }
          );
    }
    else {
        if ( scalar keys %{ $asns{$IP_VERSION_4} } == 1 ) {
            push @results,
              info(
                NAMESERVERS_IPV4_WITH_UNIQ_AS => {
                    asn => minstr(keys %{ $asns{$IP_VERSION_4} }),
                }
              );
        }
        if ( scalar keys %{ $asns{$IP_VERSION_6} } == 1 ) {
            push @results,
              info(
                NAMESERVERS_IPV6_WITH_UNIQ_AS => {
                    asn => minstr(keys %{ $asns{$IP_VERSION_6} }),
                }
              );
        }
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
