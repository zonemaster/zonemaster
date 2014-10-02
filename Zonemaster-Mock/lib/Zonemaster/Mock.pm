package Zonemaster::Mock;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Zonemaster::Nameserver;
use Zonemaster::Mock::Nameserver;
use Net::LDNS qw[load_zonefile];

our $ocache = \%Zonemaster::Nameserver::object_cache;

sub load_zonefiles {
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

1; # End of Zonemaster::Mock
