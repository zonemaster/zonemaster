package Zonemaster::Mock::Nameserver;

use 5.14.2;
use Moose;

use Zonemaster::Util;
use Zonemaster::Net::IP;

subtype 'Zonemaster::Net::IP', as 'Object', where { $_->isa( 'Net::IP' ) };
coerce 'Zonemaster::Net::IP', from 'Str', via { Net::IP->new( $_ ) };

has 'name'    => ( is => 'ro', isa => 'Zonemaster::DNSName', coerce => 1, required => 0 );
has 'address' => ( is => 'ro', isa => 'Zonemaster::Net::IP', coerce => 1, required => 1 );

has 'db' => ( is => 'ro', isa => 'HashRef', default => sub {{}});

sub load {
    my ( $self, @rrs ) = @_;

    foreach my $rr (@rrs) {
        push @{$self->db->{name($rr->name)}}{$rr->class}{$rr->type}, $rr;
    }

    return;
}

sub query {
    my ( $self, $name, $type, $href ) = @_;
    my $class = $href->{class} // 'IN';
    my $p = Net::LDNS::Packet->new("$name",$type,$class);

    $name = name($name);

    my $rrset = $self->db->{$name}{uc($class)}{uc($type)};

    if (not $rrset or @$rrset == 0) {
        if ($self->db->{$name}) {
            return $self->empty_response($p);
        }
        elsif (my $super = $self->known_superdomain($name)) {
            return $self->referral($super, $p);
        }
        else {
            return $self->nxdomain($p);
        }
    }
    else {
        return $self->answer($rrset, $p);
    }
}

sub empty_response {
    my ( $self, $p ) = @_;

    ...;
}

sub referral {
    my ( $self, $super, $p ) = @_;

    ...;
}

sub nxdomain {
    my ( $self, $p ) = @_;

    ...;
}

sub answer {
    my ( $self, $rrset, $p ) = @_;

    ...;
}

sub known_superdomain {
    my ( $self, $name ) = @_;

    while ($name = $name->next_higher) {
        if ($self->db->{$name}{'IN'}{'NS'}) {
            return $name;
        }
    }

    return;
}

1;