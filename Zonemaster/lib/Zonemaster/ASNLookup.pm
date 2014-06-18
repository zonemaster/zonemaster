package Zonemaster::ASNLookup v0.0.1;

use 5.014002;
use warnings;

use Net::IP;

use Zonemaster;
use Zonemaster::Nameserver;

our %roots = (
    'in-addr.arpa.' => 'origin.asnlookup.iis.se',
    'ip6.arpa.'     => 'origin6.asnlookup.iis.se',
);

sub get {
    my ( $class, $ip ) = @_;

    if ( not ref( $ip ) or not $ip->isa( 'Net::IP' ) ) {
        $ip = Net::IP->new( $ip );
    }

    my $reverse = $ip->reverse_ip;
    foreach my $root ( keys %roots ) {
        if ( $reverse =~ s/$root/$roots{$root}/i ) {
            my $p = Zonemaster->recurse( $reverse, 'TXT' );
            next if not $p;

            my ( $rr ) = $p->get_records( 'TXT' );
            return if not $rr;

            my $str = $rr->txtdata;
            $str =~ s/"([^"]+)"/$1/;
            my @fields = split( / \| ?/, $str );

            if ( wantarray() ) {
                return $fields[0], Net::IP->new( $fields[1] );
            }
            else {
                return $fields[0];
            }
        }
    } ## end foreach my $root ( keys %roots)
} ## end sub get

1;

=head1 NAME

Zonemaster::ASNLookup - do lookups of ASNs for IP addresses

=head1 SYNOPSIS

   my ($asn, $prefix) = Zonemaster::ASNLookup->get( '8.8.4.4' );
   my $other_asn = Zonemaster::ASNLookup->get( '192.168.0.1' );

=head1 FUNCTION

=over

=item get($addr)

Takes a string (or a L<Net::IP> object) with a single IP address, does a lookup
in a Cymru-style DNS zone and returns the result. If called in scalar context,
it returns only the AS number. If called in a list context it returns a list of
the AS number and a Net::IP object representing the prefix of the AS. If no AS
was found for the IP address, it returns nothing;

=back

=cut
