package Giraffa::Test::Nameserver v0.0.1;

use 5.14.2;
use strict;
use warnings; 
        
use Giraffa;
use Giraffa::Util;

use Net::LDNS;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->nameserver1( $zone );
    push @results, $class->nameserver2( $zone );
    push @results, $class->nameserver3( $zone );
    push @results, $class->nameserver4( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        nameserver1 => [qw(IS_A_RECURSOR)],
        nameserver2 => [qw()],
        nameserver3 => [qw(AXFR_FAILURE AXFR_AVAILABLE)],
        nameserver4 => [qw(SAME_SOURCE_IP)],
    };
}

sub version {
    return "$Giraffa::Test::Nameserver::VERSION";
}

sub nameserver1 {
    my ( $class, $zone ) = @_;
    my $nonexistent_name = q{xx--domain-cannot-exist.xx--illegal-syntax-tld};
    my @results;
    my %nsnames;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {

        next if $nsnames{$local_ns->name};

        my $p = $local_ns->query( $nonexistent_name, q{SOA}, { q{recurse} => 1 } );

        if ( $p->rcode eq q{NXDOMAIN} ) {
            push @results,
              info(
                IS_A_RECURSOR => {
                    ns     => $local_ns->name,
                    dname  => $nonexistent_name,
                }
              );
        }

        $nsnames{$local_ns->name}++;
    }

    return @results;
} ## end sub nameserver1

sub nameserver2 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {

        next if $nsnames{$local_ns->name};

        $nsnames{$local_ns->name}++;
    }

    return @results;
} ## end sub nameserver2

sub nameserver3 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {

        next if $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short};

        my $first_rr;
        eval {
            my $res = Net::LDNS->new( $local_ns->address->short );
            $res->axfr_start( $zone->name );
            ( $first_rr ) = $res->axfr_next;
            1;
        }
        or do {
            push @results,
              info(
                  AXFR_FAILURE => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        };

        if ( $first_rr and $first_rr->type eq q{SOA} ) {
            push @results,
              info(
                  AXFR_AVAILABLE => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
        }

        $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short}++;
    }

    return @results;
} ## end sub nameserver3

sub nameserver4 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {
            
        next if $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short};
                  
        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, 'SOA' );
        if ( $p ) {
            if ( $local_ns->address->short ne $p->answerfrom ) {
                push @results,
                  info(
                      SAME_SOURCE_IP => {
                        ns      => $local_ns->name->string,
                        address => $local_ns->address->short,
                        source  => $p->answerfrom,
                    }
                  );
            }
        }
        $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short}++;
    }               
                
    return @results;
} ## end sub nameserver4

1;
