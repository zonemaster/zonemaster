package Giraffa::Test::Address v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

use Carp;

use Readonly;
use Net::IP;

Readonly our $IP_VERSION_4 => 4;
Readonly our $IP_VERSION_6 => 6;

###
### Entry Points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->address01( $zone );
    push @results, $class->address02( $zone );
    # Perform BASIC2 if BASIC1 passed
    if ( not grep { $_->tag eq q{NAMESERVER_IP_WITHOUT_REVERSE} } @results ) {
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
        address01 => [qw(NAMESERVER_IP_PRIVATE_NETWORK)],
        address02 => [qw(NAMESERVER_IP_WITHOUT_REVERSE)],
        address03 => [qw(NAMESERVER_IP_WITHOUT_REVERSE NAMESERVER_IP_PTR_MISMATCH)],
    };
} ## end sub metadata

sub version {
    return "$Giraffa::Test::Address::VERSION";
}

sub address01 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{$local_ns->address->short};

        if ( not ( ($local_ns->address->version == $IP_VERSION_4 and $local_ns->address->iptype eq q{PUBLIC} ) or
                   ($local_ns->address->version == $IP_VERSION_6 and $local_ns->address->iptype eq q{GLOBAL-UNICAST} ) ) ) {
            push @results,
              info(
                NAMESERVER_IP_PRIVATE_NETWORK => {
                    ns      => $local_ns->name->string,
                    address => $local_ns->address->short,
                    iptype  => $local_ns->address->iptype,
                }
              );
        }

        $ips{$local_ns->address->short}++;

    }

    return @results;
} ## end sub address01

sub address02 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{$local_ns->address->short};

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, q{PTR} );

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
} ## end sub address02

sub address03 {
    my ( $class, $zone ) = @_;
    my @results;

    my %ips;

    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next unless $local_ns->address;
        next if $ips{$local_ns->address->short};

        my $reverse_ip_query = $local_ns->address->reverse_ip;

        my $p = Giraffa::Recursor->recurse( $reverse_ip_query, q{PTR} );

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
} ## end sub address03

1;

=head1 NAME

Giraffa::Test::Address - module implementing tests focused on the Address specific test cases of the DNS tests

=head1 SYNOPSIS

    my @results = Giraffa::Test::Address->all($zone);

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

=back

=cut

