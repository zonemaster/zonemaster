package Giraffa::Config v0.0.1;

use 5.14.2;
use Moose;
use JSON::PP;

use Giraffa;

our $config = decode_json( join( '', <DATA> ) );

sub get {
    my ( $class ) = @_;

    return $config;
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

=back

=cut

__DATA__
{
    "resolver": {
        "defaults":
            {
                "usevc" : 0,
                "retrans" : 2,
                "dnssec" : 0,
                "debug" : 0,
                "recurse" : 0,
                "udp_timeout" : 15,
                "tcp_timeout" : 15,
                "retry" : 1,
                "igntc" : 0
            }
        }
}
