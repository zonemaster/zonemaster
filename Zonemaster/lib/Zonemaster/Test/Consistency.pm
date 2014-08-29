package Zonemaster::Test::Consistency v0.0.5;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->consistency01( $zone );
    push @results, $class->consistency02( $zone );
    push @results, $class->consistency03( $zone );

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        consistency01 => [
            qw(
              NO_RESPONSE
              ONE_SOA_SERIAL
              MULTIPLE_SOA_SERIALS
              SOA_SERIAL
              )
        ],
        consistency02 => [
            qw(
              NO_RESPONSE
              ONE_SOA_RNAME
              MULTIPLE_SOA_RNAMES
              SOA_RNAME
              )
        ],
        consistency03 => [
            qw(
              NO_RESPONSE
              ONE_SOA_TIME_PARAMETER_SET
              MULTIPLE_SOA_TIME_PARAMETER_SET
              SOA_TIME_PARAMETER_SET
              )
        ],
    };
} ## end sub metadata

sub translation {
    return {
        "SOA_TIME_PARAMETER_SET" =>
"Saw SOA time parameter set (REFRESH={refresh},RETRY={retry},EXPIRE={expire},MINIMUM={minimum}) on following nameserver set : {servers}.",
        "ONE_SOA_RNAME"                   => "A single SOA rname value was seen ({rname})",
        "MULTIPLE_SOA_SERIALS"            => "Saw {count} SOA serial numbers.",
        "SOA_SERIAL"                      => "Saw SOA serial number {serial} on following nameserver set : {servers}.",
        "SOA_RNAME"                       => "Saw SOA rname {rname} on following nameserver set : {servers}.",
        "MULTIPLE_SOA_RNAMES"             => "Saw {count} SOA rname.",
        "ONE_SOA_SERIAL"                  => "A single SOA serial number was seen ({serial}).",
        "MULTIPLE_SOA_TIME_PARAMETER_SET" => "Saw {count} SOA time parameter set.",
        "NO_RESPONSE"                     => "Nameserver {ns} did not respond.",
        "ONE_SOA_TIME_PARAMETER_SET" =>
"A single SOA time parameter set was seen (REFRESH={refresh},RETRY={retry},EXPIRE={expire},MINIMUM={minimum}).",
    };
}

sub version {
    return "$Zonemaster::Test::Consistency::VERSION";
}

###
### Tests
###

sub consistency01 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames;

    my %serials;
    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next if $nsnames{ $local_ns->name->string };

        my $p = $local_ns->query( $zone->name, q{SOA} );

        if ( not $p ) {
            push @results,
              info(
                NO_RESPONSE => {
                    ns => $local_ns->name,
                }
              );
            next;
        }

        my ( $soa ) = $p->get_records_for_name( q{SOA}, $zone->name );
        push @{ $serials{ $soa->serial } }, $local_ns->name->string;

        $nsnames{ $local_ns->name->string }++;
    } ## end foreach my $local_ns ( @{ $zone...})

    if ( scalar( keys %serials ) == 1 ) {
        push @results,
          info(
            ONE_SOA_SERIAL => {
                serial => ( keys %serials )[0],
            }
          );
    }
    else {
        push @results,
          info(
            MULTIPLE_SOA_SERIALS => {
                count => scalar( keys %serials ),
            }
          );
        foreach my $serial ( keys %serials ) {
            push @results,
              info(
                SOA_SERIAL => {
                    serial  => $serial,
                    servers => join( ';', @{ $serials{$serial} } ),
                }
              );
        }
    }

    return @results;
} ## end sub consistency01

sub consistency02 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames;

    my %rnames;
    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next if $nsnames{ $local_ns->name->string };

        my $p = $local_ns->query( $zone->name, q{SOA} );

        if ( not $p ) {
            push @results,
              info(
                NO_RESPONSE => {
                    ns => $local_ns->name,
                }
              );
            next;
        }

        my ( $soa ) = $p->get_records_for_name( q{SOA}, $zone->name );
        push @{ $rnames{ $soa->rname } }, $local_ns->name->string;

        $nsnames{ $local_ns->name->string }++;
    } ## end foreach my $local_ns ( @{ $zone...})

    if ( scalar( keys %rnames ) == 1 ) {
        push @results,
          info(
            ONE_SOA_RNAME => {
                rname => ( keys %rnames )[0],
            }
          );
    }
    else {
        push @results,
          info(
            MULTIPLE_SOA_RNAMES => {
                count => scalar( keys %rnames ),
            }
          );
        foreach my $rname ( keys %rnames ) {
            push @results,
              info(
                SOA_RNAME => {
                    rname   => $rname,
                    servers => join( ';', @{ $rnames{$rname} } ),
                }
              );
        }
    }

    return @results;
} ## end sub consistency02

sub consistency03 {
    my ( $class, $zone ) = @_;
    my @results;
    my %nsnames;

    my %time_parameter_sets;
    foreach my $local_ns ( @{ $zone->ns }, @{ $zone->glue } ) {

        next if $nsnames{ $local_ns->name->string };

        my $p = $local_ns->query( $zone->name, q{SOA} );

        if ( not $p ) {
            push @results,
              info(
                NO_RESPONSE => {
                    ns => $local_ns->name,
                }
              );
            next;
        }

        my ( $soa ) = $p->get_records_for_name( q{SOA}, $zone->name );
        push @{ $time_parameter_sets{ sprintf q{%d;%d;%d;%d}, $soa->refresh, $soa->retry, $soa->expire, $soa->minimum }
        }, $local_ns->name->string;

        $nsnames{ $local_ns->name->string }++;
    } ## end foreach my $local_ns ( @{ $zone...})

    if ( scalar( keys %time_parameter_sets ) == 1 ) {
        my ( $refresh, $retry, $expire, $minimum ) = split /;/, ( keys %time_parameter_sets )[0];
        push @results,
          info(
            ONE_SOA_TIME_PARAMETER_SET => {
                refresh => $refresh,
                retry   => $retry,
                expire  => $expire,
                minimum => $minimum,
            }
          );
    }
    else {
        push @results,
          info(
            MULTIPLE_SOA_TIME_PARAMETER_SET => {
                count => scalar( keys %time_parameter_sets ),
            }
          );
        foreach my $time_parameter_set ( keys %time_parameter_sets ) {
            my ( $refresh, $retry, $expire, $minimum ) = split /;/, $time_parameter_set;
            push @results,
              info(
                SOA_TIME_PARAMETER_SET => {
                    refresh => $refresh,
                    retry   => $retry,
                    expire  => $expire,
                    minimum => $minimum,
                    servers => join( ';', @{ $time_parameter_sets{$time_parameter_set} } ),
                }
              );
        }
    } ## end else [ if ( scalar( keys %time_parameter_sets...))]

    return @results;
} ## end sub consistency03

1;

=head1 NAME

Zonemaster::Test::Consistency - Consistency module showing the expected structure of Zonemaster test modules

=head1 SYNOPSIS

    my @results = Zonemaster::Test::Consistency->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests.

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

=item consistency01($zone)

Query all nameservers for SOA, and see that they all have the same SOA serial number.

=item consistency02($zone)

Query all nameservers for SOA, and see that they all have the same SOA rname.

=item consistency03($zone)

Query all nameservers for SOA, and see that they all have the same time parameters (REFRESH/RETRY/EXPIRE/MINIMUM).

=back

=cut
