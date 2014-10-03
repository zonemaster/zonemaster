package Zonemaster::Mock;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Zonemaster::Nameserver;
use Zonemaster::Mock::Nameserver;
use Net::LDNS qw[load_zonefile];

use parent 'Exporter';
our @EXPORT_OK = qw[ load_and_link_zonefiles load_zonefiles ];
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

our $ocache = \%Zonemaster::Nameserver::object_cache;

sub load_and_link_zonefiles {
    my @files = @_;

    foreach my $name (@files) {
        my @rrs = load_zonefile($name);
        my $this_zone = $rrs[0]->name;
        my %undelegated;
        my @undel_key;

        my @ns  = grep {$_->type eq 'NS' and $_->name eq $this_zone} @rrs;
        my @key  = grep {$_->type eq 'DNSKEY' and $_->name eq $this_zone} @rrs;

        foreach my $nsrr (@ns) {
            foreach my $rr (@rrs) {
                if ($nsrr->nsdname eq $rr->name and ($rr->type eq 'A' or $rr->type eq 'AAAA')) {
                    push @{$undelegated{$rr->name}}, $rr->address;
                    my $nsobj = Zonemaster::Mock::Nameserver->new({ name => $rr->name, address => $rr->address });
                    $nsobj->load(@rrs);
                    $ocache->{uc(''.$nsobj->name)}{$nsobj->address->ip} = $nsobj;
                }
            }
        }

        foreach my $key (@key) {
            my $ds1 = $key->ds('sha1');
            push @undel_key, {keytag => $ds1->keytag, algorithm => $ds1->algorithm, type => $ds1->digtype, digest => $ds1->hexdigest};
            my $ds2 = $key->ds('sha256');
            push @undel_key, {keytag => $ds2->keytag, algorithm => $ds2->algorithm, type => $ds2->digtype, digest => $ds2->hexdigest};
        }

        Zonemaster->add_fake_delegation($this_zone, \%undelegated);
        Zonemaster->add_fake_ds($this_zone, \@undel_key);
    }

    return;
}

sub load_zonefiles {
    my @files = @_;

    foreach my $name (@files) {
        my @rrs = load_zonefile($name);
        my $this_zone = $rrs[0]->name;

        my @ns  = grep {$_->type eq 'NS' and $_->name eq $this_zone} @rrs;

        foreach my $nsrr (@ns) {
            foreach my $rr (@rrs) {
                if ($nsrr->nsdname eq $rr->name and ($rr->type eq 'A' or $rr->type eq 'AAAA')) {
                    my $nsobj = Zonemaster::Mock::Nameserver->new({ name => $rr->name, address => $rr->address });
                    $nsobj->load(@rrs);
                    $ocache->{uc(''.$nsobj->name)}{$nsobj->address->ip} = $nsobj;
                }
            }
        }
    }

    return;
}

1; # End of Zonemaster::Mock

=head1 NAME

Zonemaster::Mock - add simulated nameservers to Zonemaster

=head1 SYNOPSIS

    use Zonemaster::Mock qw[load_and_link_zonefiles];
    use Zonemaster;

    load_and_link_zonefiles('example.org','example.net');
    say "$_" for Zonemaster->test_zone('example.org');

=head1 DESCRIPTION

This module has two functions, C<load_and_link_zonefiles> and
C<load_zonefiles>. Both of them take lists of filenames as arguments. The
pointed-out files will be loaded by the L<Net::LDNS::load_zonefile> method. The
returned resource records will then be used to set up simulated nameserver
objects, which will be added to the nameserver cache in
L<Zonemaster::Nameserver>. That way, any requests that would normally have been
sent over the Internet for the loaded zone's nameservers will instead be
simulated internally. If using the "_and_link" version, information for the
normal "undelegated test" function in L<Zonemaster> will be automatically
generated from the zonefiles, linking them to their parent domains as if they
were normal, live domains.

In short, by loading zone files with this module it should be possible to run
Zonemaster tests against data in zone files on disk without the need to load
those zones into actual name servers.

=head1 EXPORTABLE FUNCTIONS

=head2 load_zonefiles($filename, ...)

Takes a list of one or more names of zone files and loads them. It will use the
C<SOA> record to get the name of the zone being loaded. It will look at all
C<NS> records for that zone, and for each C<A> or C<AAAA> record that it can
find (in the file) for the pointed-out name server names it will build and add
one mock name server object to L<Zonemaster::Nameserver>'s internal cache.

=head2 load_and_link_zonefiles($filename,...)

Does the same thing as L<load_zonefiles>. On top of that, it will use the name
server information found in the zone files to build arguments that it will then
use to call L<Zonemaster::add_fake_delegation>. If there are any C<DNSKEY>
records in the zone, it will use those to build C<DS> records that it will use
to call L<Zonemaster::add_fake_ds>.

=head1 KNOWN BUGS AND LIMITATIONS

=over

=item * 

AXFR not yet implemented

=item *

Fake DS records are added for all DNSKEYs, not only those with the SEP flag set.

=item *

There is currently no way to fake the complete lack of a reply.

=item *

There is currently no way to fake timeouts.

=back

=head1 AUTHOR

Calle Dybedahl, C<< <calle at init.se> >>

=cut