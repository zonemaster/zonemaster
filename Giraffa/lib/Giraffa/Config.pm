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
