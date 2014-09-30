package Zonemaster::Mock;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Zonemaster::Nameserver;
use Net::LDNS qw[load_zonefile];

sub load_zonefiles {
    my @files = @_;

    foreach my $name (@files) {
        my @rrs = load_zonefile($name);
    }
    
}

1; # End of Zonemaster::Mock
