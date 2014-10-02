package Zonemaster::Mock::Nameserver;

use 5.14.2;
use Moose;
use Moose::Util::TypeConstraints;
use Time::HiRes qw[time];

use Zonemaster;
use Zonemaster::Packet;

use overload
  '""'  => \&string,
  'cmp' => \&compare;

has 'name'    => ( is => 'ro', isa => 'Zonemaster::DNSName', coerce => 1, required => 1 );
has 'address' => ( is => 'ro', isa => 'Zonemaster::Net::IP', coerce => 1, required => 1 );

has 'db'       => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has 'zones'    => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has 'subzones' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );

our $id = 1;

sub dname { Zonemaster::DNSName->new(@_)}
sub next_id { return $id++}

sub load {
    my ( $self, @rrs ) = @_;

    my $soa      = $rrs[0];
    my $zonename = dname( $soa->name );

    $self->zones->{$zonename} = $soa;
    foreach my $rr ( @rrs ) {
        my $n = dname( $rr->name );
        push @{ $self->db->{$n}{ $rr->class }{ $rr->type } }, $rr;
        if ( $rr->type eq 'NS' and $n ne $zonename ) {
            $self->subzones->{$n} = $n;
        }
    }

    return;
}

sub query {
    my ( $self, $name, $type, $href ) = @_;
    my $class = $href->{class} // 'IN';
    my $p = Zonemaster::Packet->new({ packet => Net::LDNS::Packet->new( "$name", $type, $class ) });
    $p->answerfrom($self->address->short);
    $p->id(next_id());
    $p->timestamp(time());
    if ($href->{dnssec}) {
        $p->do(1);
    }

    $name = dname( $name );

    my $rrset = $self->get_rrset($name, $type, $class);

    if (not $rrset or @$rrset == 0) {
        $rrset = $self->get_rrset($name, 'CNAME', $class)
    }

    # Found data, so answer with it
    if ($rrset and @$rrset > 0) {
        return $self->answer( $rrset, $p );
    }
    # It's in a subzone, so refer to that
    elsif (my $sub = $self->in_subzone($name)) {
        my $rrset = $self->db->{$sub}{'IN'}{'NS'};
        return $self->referral($p,$rrset);
    }
    # Should it be in one of our zones?
    elsif ( my $soa = $self->in_zone($name)) {
        if ($self->db->{$name}) {
            return $self->empty_response($p, $soa);
        } else {
            return $self->nxdomain($p, $soa);
        }
    }
}

sub get_rrset {
    my ( $self, $name, $type, $class ) = @_;
    $class //= 'IN';
    $name = dname($name);

    my $rrset;
    if ($self->db->{$name} and $self->db->{$name}{ uc( $class ) } and $self->db->{$name}{ uc( $class ) }{ uc( $type ) }) {
        $rrset = $self->db->{$name}{ uc( $class ) }{ uc( $type ) };
    }

    return $rrset;
}

sub in_zone {
    my ( $self, $name ) = @_;

    foreach my $sn (keys %{$self->zones}) {
        if ($name =~ /\Q$sn\E$/) {
            return $self->zones->{$sn};
        }
    }

    return;
}

sub in_subzone {
    my ( $self, $name ) = @_;

    foreach my $sn (keys %{$self->subzones}) {
        if ($name =~ /\Q$sn\E$/) {
            return $self->subzones->{$sn};
        }
    }

    return;
}

sub dnssec_extra {
    my ( $self, $p ) = @_;

    return $p if not $p->do;

    my $queryname = ($p->question)[0]->name;
    # Add NSEC
    if ($p->rcode eq 'NXDOMAIN') {
        my ($soa) = $p->authority;
        my $apexset = $self->get_rrset($soa->name, 'NSEC');
        if ($apexset and @$apexset > 0) {
            $p->unique_push('authority', $_) for @$apexset;
        }

        foreach my $n (keys %{$self->db}) {
            my $set = $self->get_rrset($n, 'NSEC');
            if ($set and @$set > 0) {
                foreach my $sec (@$set) {
                    if ($sec->covers($queryname)) {
                        $p->unique_push('authority', $sec)
                    }
                }
            }
            $set = $self->get_rrset($n, 'NSEC3');
            if ($set and @$set > 0) {
                foreach my $sec (@$set) {
                    if ($sec->covers($queryname)) {
                        $p->unique_push('authority', $sec)
                    }
                }
            }
        }
    }

    # Add RRSIGs
    foreach my $section (qw(answer authority additional)) {
        foreach my $rr ($p->$section) {
            my $rrset = $self->get_rrset($rr->name, 'RRSIG');
            if ($rrset and @$rrset > 0) {
                foreach my $sig (@$rrset) {
                    if($sig->typecovered eq $rr->type) {
                        $p->unique_push($section, $sig);
                    }
                }
            }
        }
    }

    return $p;
}

###
### Methods to finish response packets
###

sub empty_response {
    my ( $self, $p, $soa ) = @_;

    $p->unique_push('authority', $soa);
    $p->aa(1);
    return $self->dnssec_extra($p);
}

sub referral {
    my ( $self, $p, $rrset ) = @_;

    foreach my $rr (@$rrset) {
        $p->unique_push('authority', $rr);

        my @arrs;
        if (my $ref = $self->get_rrset($rr->nsdname, 'A')) {
            push @arrs, @$ref;
        }
        if (my $ref = $self->get_rrset($rr->nsdname, 'AAAA')) {
            push @arrs, @$ref;
        }

        foreach my $arr (@arrs) {
            $p->unique_push('additional', $arr);
        }
    }

    if ($p->do) {
        my $name = $rrset->[0]->name;
        my $dsset = $self->get_rrset($name, 'DS');
        if ($dsset and @$dsset > 0) {
            foreach my $ds (@$dsset) {
                $p->unique_push('authority', $ds)
            }
        }
    }

    return $self->dnssec_extra($p);
}

sub nxdomain {
    my ( $self, $p, $soa ) = @_;

    $p->unique_push('authority', $soa);
    $p->rcode('NXDOMAIN');
    $p->aa(1);
    return $self->dnssec_extra($p);
}

sub answer {
    my ( $self, $rrset, $p ) = @_;

    foreach my $rr (@$rrset) {
        $p->unique_push('answer', $rr);

        if ($rr->type eq 'CNAME') {
            my $rrset = $self->get_rrset($rr->cname,(($p->question)[0]->type));
            if ($rrset) {
                foreach my $crr (@$rrset) {
                    $p->unique_push('answer', $crr);
                }
            }
        }
    }

    $p->aa(1);
    return $self->dnssec_extra($p);
}

###
### Overload implementations
###

sub string {
    my ( $self ) = @_;

    return $self->name->string . '/' . $self->address->short;
}

sub compare {
    my ( $self, $other, $reverse ) = @_;

    return $self->string cmp $other->string;
}

1;
