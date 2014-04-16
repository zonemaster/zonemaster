package Giraffa::Config v0.0.1;

use 5.14.2;
use Moose;
use JSON;
use File::ShareDir qw[dist_file];
use File::Slurp;

use Giraffa;

our $config = decode_json( join( '', <DATA> ) );
our $policy = decode_json read_file dist_file( 'Giraffa', 'policy.json' );

sub get {
    my ( $class ) = @_;

    return $config;
}

sub policy {
    my ( $class ) = @_;

    return $policy;
}

1;

=head1 NAME

Giraffa::Config - configuration access module for Giraffa

=head1 SYNOPSIS

    my $value = Giraffa::Config->get->{key}{subkey};

=METHODS

=over

=item get()

Returns a reference to a hash with configuration values. As of this writing, this is simply seeded from static values hardcoded into the module.
This is intended to change.

=item policy()

Returns a reference to the current policy data. The format of that data is yet to be decided on.

=back

=cut

__DATA__
{
    "resolver": {
        "defaults":
            {
                "usevc" : 0,
                "retrans" : 3,
                "dnssec" : 0,
                "debug" : 0,
                "recurse" : 0,
                "retry" : 2,
                "igntc" : 0
            }
        },
    "net": {
        "ipv4": 1,
        "ipv6": 1
    },
    "no_network": 0
}
