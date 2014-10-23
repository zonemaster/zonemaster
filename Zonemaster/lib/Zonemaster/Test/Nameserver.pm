package Zonemaster::Test::Nameserver v0.0.2;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::Test::Address;
use Zonemaster::Constants qw[:ip];

use List::MoreUtils qw[uniq none];

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
    push @results, $class->nameserver06( $zone );

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
              NO_RECURSOR
              )
        ],
        nameserver02 => [
            qw(
              EDNS0_BAD_QUERY
              EDNS0_BAD_ANSWER
              EDNS0_SUPPORT
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
              DIFFERENT_SOURCE_IP
              SAME_SOURCE_IP
              )
        ],
        nameserver05 => [
            qw(
              QUERY_DROPPED
              ANSWER_BAD_RCODE
              )
        ],
        nameserver06 => [
            qw(
              CAN_NOT_BE_RESOLVED
              CAN_BE_RESOLVED
              NO_RESOLUTION
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        'AAAA_WELL_PROCESSED' => 'The following nameservers answer AAAA queries without problems : {names}.',
        'EDNS0_BAD_QUERY'     => 'Nameserver {ns}/{address} does not support EDNS0 (replies with FORMERR).',
        'DIFFERENT_SOURCE_IP' =>
          'Nameserver {ns}/{address} replies on a SOA query with a different source address ({source}).',
        'SAME_SOURCE_IP'      => 'All nameservers reply with same IP used to query them.',
        'AXFR_AVAILABLE'      => 'Nameserver {ns}/{address} allow zone transfer using AXFR.',
        'AXFR_FAILURE'        => 'AXFR not available on nameserver {ns}/{address}.',
        'QUERY_DROPPED'       => 'Nameserver {ns}/{address} dropped AAAA query.',
        'IS_A_RECURSOR'       => 'Nameserver {ns}/{address} answered with a RCODE NXDOMAIN to SOA query on {dname}.',
        'NO_RECURSOR'         => 'None of the following nameservers is a recursor : {names}.',
        'ANSWER_BAD_RCODE'    => 'Nameserver {ns}/{address} answered AAAA query with an unexpected rcode ({rcode}).',
        'EDNS0_BAD_ANSWER'    => 'Nameserver {ns}/{address} does not support EDNS0 (OPT not set in reply).',
        'EDNS0_SUPPORT'       => 'The following nameservers support EDNS0 : {names}.',
        'CAN_NOT_BE_RESOLVED' => 'The following nameservers failed to resolve to an IP address : {names}.',
        'CAN_BE_RESOLVED'     => 'All nameservers succeeded to resolve to an IP address.',
        'NO_RESOLUTION'       => 'No nameservers succeeded to resolve to an IP address.',
    };
} ## end sub translation

sub version {
    return "$Zonemaster::Test::Nameserver::VERSION";
}

sub nameserver01 {
    my ( $class, $zone ) = @_;
    my $nonexistent_name = q{xx--domain-cannot-exist.xx--illegal-syntax-tld};
    my @results;
    my %ips;
    my %nsnames;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $ips{ $local_ns->address->short };

        my $p = $local_ns->query( $nonexistent_name, q{SOA}, { recurse => 1 } );

        if ( $p ) {
            if ( $p->rcode eq q{NXDOMAIN} ) {
                push @results,
                  info(
                    IS_A_RECURSOR => {
                        ns      => $local_ns->name,
                        address => $local_ns->address->short,
                        dname   => $nonexistent_name,
                    }
                  );
            }
            $nsnames{ $local_ns->name }++;
            $ips{ $local_ns->address->short }++;
        }

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %nsnames and not scalar @results ) {
        push @results,
          info(
            NO_RECURSOR => {
                names => join( q{,}, sort keys %nsnames ),
            }
          );
    }

    return @results;
} ## end sub nameserver01

sub nameserver02 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short };

        my $p = $local_ns->query( $zone->name, q{SOA}, { edns_size => 512 } );
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
                if ( not $p->has_edns ) {
                    push @results,
                      info(
                        EDNS0_BAD_ANSWER => {
                            ns      => $local_ns->name,
                            address => $local_ns->address->short,
                        }
                      );
                }
            }
        } ## end if ( $p )

        $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short }++;
    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %nsnames_and_ip and not scalar @results ) {
        push @results,
          info(
            EDNS0_SUPPORT => {
                names => join( q{,}, keys %nsnames_and_ip ),
            }
          );
    }

    return @results;
} ## end sub nameserver02

sub nameserver03 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short };

        my $first_rr;
        eval {
            $local_ns->axfr( $zone->name, sub { ( $first_rr ) = @_; return 0; } );
            1;
        } or do {
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

        $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short }++;
    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    return @results;
} ## end sub nameserver03

sub nameserver04 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short };

        my $p = $local_ns->query( $zone->name, q{SOA} );
        if ( $p ) {
            if ( $local_ns->address->short ne $p->answerfrom ) {
                push @results,
                  info(
                    DIFFERENT_SOURCE_IP => {
                        ns      => $local_ns->name->string,
                        address => $local_ns->address->short,
                        source  => $p->answerfrom,
                    }
                  );
            }
        }
        $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short }++;
    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %nsnames_and_ip and not scalar @results ) {
        push @results,
          info(
            SAME_SOURCE_IP => {
                names => join( q{,}, keys %nsnames_and_ip ),
            }
          );
    }

    return @results;
} ## end sub nameserver04

sub nameserver05 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames_and_ip;

    foreach
      my $local_ns ( @{ Zonemaster::TestMethods->method4( $zone ) }, @{ Zonemaster::TestMethods->method5( $zone ) } )
    {

        next if ( not Zonemaster->config->ipv6_ok and $local_ns->address->version == $IP_VERSION_6 );

        next if ( not Zonemaster->config->ipv4_ok and $local_ns->address->version == $IP_VERSION_4 );

        next if $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short };

        $nsnames_and_ip{ $local_ns->name->string . q{/} . $local_ns->address->short }++;

        my $p = $local_ns->query( $zone->name, q{AAAA} );

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

        if (   $p->rcode eq q{FORMERR}
            or $p->rcode eq q{SERVFAIL}
            or $p->rcode eq q{NXDOMAIN}
            or $p->rcode eq q{NOTIMPL} )
        {
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

    } ## end foreach my $local_ns ( @{ Zonemaster::TestMethods...})

    if ( scalar keys %nsnames_and_ip and none { $_->tag eq q{ANSWER_BAD_RCODE} } @results ) {
        push @results,
          info(
            AAAA_WELL_PROCESSED => {
                names => join( q{,}, keys %nsnames_and_ip ),
            }
          );
    }

    return @results;
} ## end sub nameserver05

sub nameserver06 {
    my ( $class, $zone ) = @_;
    my @results;
    my @all_nsnames = uniq map { $_->string } @{ Zonemaster::TestMethods->method2( $zone ) },
      @{ Zonemaster::TestMethods->method3( $zone ) };
    my @all_nsnames_with_ip = uniq map { $_->name->string } @{ Zonemaster::TestMethods->method4( $zone ) },
      @{ Zonemaster::TestMethods->method5( $zone ) };
    my @all_nsnames_without_ip;
    my %diff;

    @diff{@all_nsnames} = undef;
    delete @diff{@all_nsnames_with_ip};

    @all_nsnames_without_ip = keys %diff;
    if ( scalar @all_nsnames_without_ip and scalar @all_nsnames_with_ip ) {
        push @results,
          info(
            CAN_NOT_BE_RESOLVED => {
                names => join( q{,}, @all_nsnames_without_ip ),
            }
          );
    }
    elsif ( not scalar @all_nsnames_with_ip ) {
        push @results,
          info(
            NO_RESOLUTION => {
                names => join( q{,}, @all_nsnames_without_ip ),
            }
          );
    }
    else {
        push @results, info( CAN_BE_RESOLVED => {} );
    }

    return @results;
} ## end sub nameserver06

1;

=head1 NAME

Zonemaster::Test::Nameserver - module implementing tests of the properties of a name server

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Nameserver->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests

=item translation()

Returns a refernce to a hash with translation data. Used by the builtin translation system.

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

Verify EDNS0 support.

=item nameserver03($zone)

Verify that zone transfer (AXFR) is not available.

=item nameserver04($zone)

Verify that replies from nameserver comes from the expected IP address.

=item nameserver05($zone)

Verify behaviour against AAAA queries.

=item nameserver06($zone)

Verify that each nameserver can be resolved to an IP address.

=back

=cut
