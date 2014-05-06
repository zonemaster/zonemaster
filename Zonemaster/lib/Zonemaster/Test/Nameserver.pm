package Zonemaster::Test::Nameserver v0.0.1;

use 5.14.2;
use strict;
use warnings; 
        
use Zonemaster;
use Zonemaster::Util;

use Net::LDNS;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->nameserver01( $zone );
    push @results, $class->nameserver02( $zone );
    push @results, $class->nameserver03( $zone );
    push @results, $class->nameserver04( $zone );
    push @results, $class->nameserver05( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        nameserver01 => [
            qw(
              IS_A_RECURSOR
              )
        ],
        nameserver02 => [
            qw(
              )
        ],
        nameserver03 => [
            qw(
              AXFR_FAILURE
              AXFR_AVAILABLE
              )
        ],
        nameserver04 => [
            qw(
              SAME_SOURCE_IP
              )
        ],
        nameserver05 => [
            qw(
              QUERY_DROPPED
              ANSWER_BAD_RCODE
              )
        ],
    };
}

sub version {
    return "$Zonemaster::Test::Nameserver::VERSION";
}

sub nameserver01 {
    my ( $class, $zone ) = @_;
    my $nonexistent_name = q{xx--domain-cannot-exist.xx--illegal-syntax-tld};
    my @results;
    my %nsnames;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {

        next if $nsnames{$local_ns->name};

        my $p = $local_ns->query( $nonexistent_name, q{SOA}, { recurse => 1 } );

        if ( $p ) {
            if ( $p->rcode eq q{NXDOMAIN} ) {
                push @results,
                  info(
                    IS_A_RECURSOR => {
                        ns     => $local_ns->name,
                        dname  => $nonexistent_name,
                    }
                  );
            }
        }

        $nsnames{$local_ns->name}++;
    }

    return @results;
} ## end sub nameserver01

sub nameserver02 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {

        next if $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short};

        my $ns = Giraffa::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{SOA}, { dnssec => 1, edns_size => 512 } );
        if ( $p ) {
            if ( $p->rcode eq q{FORMERR} ) {
                push @results,
                  info(
                    EDNS0_BAD_QUERY => {
                        ns      => $local_ns->name,
                        address => $local_ns->address->short,
                    }
                  );
            }
            else {
                if ( not $p->edns_rcode or not $p->edns_size() ) {
                    push @results,
                      info(
                        EDNS0_BAD_ANSWER => {
                            ns      => $local_ns->name,
                            address => $local_ns->address->short,
                        }
                      );
                }
            }
        }

        $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short}++;
    }

    return @results;
} ## end sub nameserver02

sub nameserver03 {
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
} ## end sub nameserver03

sub nameserver04 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {
            
        next if $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short};
                  
        my $ns = Zonemaster::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{SOA} );
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
} ## end sub nameserver04

sub nameserver05 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach my $local_ns ( @{ $zone->glue }, @{ $zone->ns } ) {

        next if $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short};

        $nsnames_and_ip{$local_ns->name->string.q{/}.$local_ns->address->short}++;

        my $ns = Zonemaster::Nameserver->new({ name => $local_ns->name->string, address => $local_ns->address->short });
        my $p = $ns->query( $zone->name, q{AAAA} );

        if ( not $p ) {
            push @results,
              info(
                  QUERY_DROPPED => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                }
              );
            next;
        }

        next if not scalar $p->answer and $p->rcode eq q{NOERROR};

        if ( $p->rcode eq q{FORMERR} or $p->rcode eq q{SERVFAIL} or $p->rcode eq q{NXDOMAIN} or $p->rcode eq q{NOTIMPL} ) {
            push @results,
              info(
                  ANSWER_BAD_RCODE => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                    rcode   => $p->rcode,
                }
              );
            next;
        }

    }

    return @results;
} ## end sub nameserver05

1;

=head1 NAME

Zonemaster::Test::Nameserver - module implementing tests of the properties of a name server

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Nameserver->all($zone);

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

=item nameserver01($zone)

Verify that nameserver is not recursive.

=item nameserver02($zone)

Verify EDNS0 support. (WORK IN PROGRESS)

=item nameserver03($zone)

Verify that zone transfer (AXFR) is not available.

=item nameserver04($zone)

Verify that replies from nameserver comes from the expected IP address.

=item nameserver05($zone)

Verify behaviour against AAAA queries.

=back

=cut
