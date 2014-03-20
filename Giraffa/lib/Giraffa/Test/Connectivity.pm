package Giraffa::Test::Connectivity v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;
use List::MoreUtils qw[uniq];

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->connectivity1( $zone );
    push @results, $class->connectivity2( $zone );
    push @results, $class->connectivity3( $zone );
#    push @results, $class->connectivity4( $zone );
    push @results, $class->connectivity5( $zone );
    push @results, $class->connectivity6( $zone );

    return @results;
}

sub can_continue {
    my ( $class, @results ) = @_;
    my %tag = map { $_->tag => 1 } @results;
    
    if ( $tag{'a'} and $tag{'b'} ) {
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
        connectivity1 => [qw(NAMESERVER_HAS_UDP_53 NAMESERVER_NO_UDP_53)],
        connectivity2 => [qw(NAMESERVER_HAS_TCP_53 NAMESERVER_NO_TCP_53)],
        connectivity3 => [qw(NAMESERVER_IPV6_ADDRESS_BOGON NAMESERVER_IPV6_ADDRESSES_NOT_BOGON)],
        connectivity4 => [qw()],
        connectivity5 => [qw()],
        connectivity6 => [qw()],
    };
}

sub version {
    return "$Giraffa::Test::Connectivity::VERSION";
}

###
### Tests
###

sub connectivity1 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns } ) {
        next if $ips{$local_ns->address->short};
        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, 'SOA' , { 'usevc' => 0 } );
        if ( $p  and  $p->rcode eq 'NOERROR' ) {
            push @results,
              info(
                NAMESERVER_HAS_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        }
        $ips{$ns->address->short} = 1;
    }

    foreach my $local_ns ( @{ $zone->glue } ) {
        next if $ips{$local_ns->address->short};
        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, 'SOA' , { 'usevc' => 0 } );
        if ( $p  and  $p->rcode eq 'NOERROR' ) {
            push @results,
              info(
                NAMESERVER_HAS_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_UDP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        }
        $ips{$ns->address->short} = 1;
    }

    return @results;
} ## end sub connectivity1

sub connectivity2 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;

    foreach my $local_ns ( @{ $zone->ns } ) {

        next if $ips{$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, 'SOA' , { 'usevc' => 1 } );
        if ( $p  and  $p->rcode eq 'NOERROR' ) {
            push @results,
              info(
                NAMESERVER_HAS_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        }
        $ips{$ns->address->short} = 1;

    }
    
    foreach my $local_ns ( @{ $zone->glue } ) {

        next if $ips{$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, 'SOA' , { 'usevc' => 1 } );
        if ( $p  and  $p->rcode eq 'NOERROR' ) {
            push @results,
              info(
                NAMESERVER_HAS_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        } else {
            push @results,
              info(
                NAMESERVER_NO_TCP_53 => {
                    ns      => $ns->name->string,
                    address => $ns->address->short
                }
              );
        }
        $ips{$ns->address->short} = 1;

    }

    return @results;


    return @results;
} ## end sub connectivity2

sub connectivity3 {
    my ( $class, $zone ) = @_;
    my @results;
    my %ips;
    my $ipv6_nb = 0;

    foreach my $local_ns ( @{ $zone->ns },  @{ $zone->glue } ) {

        next unless $local_ns->address;
        next unless $local_ns->address->version == 6;
        next if $ips{$local_ns->address->short};

        $ips{$local_ns->address->short} = 1;
        $ipv6_nb++;

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        $reverse_ip_query =~ s/ip6.arpa./v6.fullbogons.cymru.com./;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query );

        if ( $p ) {
            if ( $p->rcode ne 'NXDOMAIN' ) {
                foreach my $rr ($p->answer) {
                    if ( $rr->type eq 'A' and $rr->address eq '127.0.0.2' ) {
                        push @results,
                          info(
                            NAMESERVER_IPV6_ADDRESS_BOGON => {
                                ns      => $local_ns->name->string,
                                address => $local_ns->address->short
                            }
                          );
                    }
                }
            }
        }

    }

    if ( $ipv6_nb > 0 and not grep { $_->tag eq 'NAMESERVER_IPV6_ADDRESS_BOGON' } @results ) {
        push @results,
          info(
            NAMESERVER_IPV6_ADDRESSES_NOT_BOGON => {
                nb => $ipv6_nb
            }
          );
    }

    return @results;
} ## end sub connectivity3

sub connectivity4 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
} ## end sub connectivity4

sub connectivity5 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
} ## end sub connectivity5

sub connectivity6 {
    my ( $class, $zone ) = @_;
    my @results;
    my ( %ips, %asns );

    foreach my $local_ns ( @{ $zone->ns },  @{ $zone->glue } ) {

        next if $ips{$local_ns->address->short};

        my $reverse_ip_query = $local_ns->address->reverse_ip;
        $reverse_ip_query =~ s/\.[^\.*]*\.arpa./.asn.routeviews.org./;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, 'TXT' );

        if ( $p ) {
            my ( $txt ) = $p->get_records_for_name( 'TXT', $reverse_ip_query );
            $asns{$txt->txtdata}++;
        }

    }

    if ( 1 or scalar keys %asns == 1 ) {
        push @results,
          info(
            NAMESERVERS_WITH_UNIQ_AS => {
                asn => (keys %asns)[0]
            }
          );
    }

    return @results;
} ## end sub connectivity6

1;
