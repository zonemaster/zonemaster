package Zonemaster::ASNLookup v0.0.1;

use 5.014002;
use warnings;

use Net::IP::XS;

use Zonemaster;
use Zonemaster::Nameserver;

our @roots;

sub get_with_prefix {
    my ( $class, $ip ) = @_;

    if (not @roots) {
        @roots = map {Zonemaster->zone($_)} @{Zonemaster->config->asnroots};
    }

    if ( not ref( $ip ) or not $ip->isa( 'Net::IP::XS' ) ) {
        $ip = Net::IP::XS->new( $ip );
    }

    my $reverse = $ip->reverse_ip;
    foreach my $zone ( @roots ) {
        my $domain = $zone->name->string;
        my $pair = {
            'in-addr.arpa.' => "origin.$domain",
            'ip6.arpa.' => "origin6.$domain",
        };
        foreach my $root ( keys %$pair ) {
            if ( $reverse =~ s/$root/$pair->{$root}/i ) {
                my $p = $zone->query_persistent( $reverse, 'TXT' );
                next if not $p;

                my ( $rr ) = $p->get_records( 'TXT' );
                return if not $rr;

                my $str = $rr->txtdata;
                $str =~ s/"([^"]+)"/$1/;
                my @fields = split( / \| ?/, $str );
                my @asns = split(/\s+/, $fields[0]);

                return \@asns, Net::IP::XS->new( $fields[1] );
            }
        } ## end foreach my $root ( keys %$pair)
    } ## end foreach my $pair ( @roots )
    return;
} ## end sub get

sub get {
    my ( $class, $ip ) = @_;

    my ( $asnref, $prefix ) = $class->get_with_prefix($ip);

    return @$asnref;
}

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
in a Cymru-style DNS zone and returns a list of AS numbers for the address, if
any can be found.

=item get_with_prefix($addr)

As L<get()>, except it returns a list of a reference to a list with the AS
numbers, and a Net::IP object representing the prefix of the AS.

=back

=cut
