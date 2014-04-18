package Giraffa::Test::Address v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

use Carp;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->address1( $zone );
    push @results, $class->address2( $zone );
    push @results, $class->address3( $zone );
    push @results, $class->address4( $zone );
    push @results, $class->address5( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        address1 => [qw(NAMESERVER_IPV4_PRIVATE_NETWORK)],
        address2 => [qw(NAMESERVER_IP_WITHOUT_REVERSE)],
        address3 => [qw(NAMESERVER_IP_WITHOUT_REVERSE NAMESERVER_IP_PTR_MISMATCH)],
        address4 => [qw()],
        address5 => [qw()],
    };
} ## end sub metadata

sub version {
    return "$Giraffa::Test::Address::VERSION";
}

sub address1 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $local_ns->address->version == 6;
        next if $ips{$local_ns->address->short};

        if ( $local_ns->address->iptype eq q{PRIVATE} ) {
            push @results,
              info(
                NAMESERVER_IPV4_PRIVATE_NETWORK => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        }

        $ips{$local_ns->address->short}++;

    }

    return @results;
} ## end sub address1

sub address2 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{$local_ns->address->short};

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, 'PTR' );

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

        $ips{$local_ns->address->short}++;

    }

    return @results;
} ## end sub address2

# TODO: Cache result from address2
sub address3 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{$local_ns->address->short};

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, 'PTR' );

        if ( $p ) {
            if ( $p->rcode eq q{NOERROR} ) {
                my @ptr = $p->get_records_for_name( q{PTR}, $reverse_ip_query );
                if ( not grep { $_->ptrdname eq $local_ns->name->string.q{.} } @ptr ) {
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
        }
        else {
            croak q{No response from nameserver};
        }           
                        
        $ips{$local_ns->address->short}++;

    }  
    return @results;
} ## end sub address3

sub address4 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
} ## end sub address4

sub address5 {
    my ( $class, $zone ) = @_;
    my @results;

    return @results;
} ## end sub address5

1;
