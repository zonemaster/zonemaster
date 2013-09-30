package Giraffa::FixNetDNS v0.0.1;

use strict;
use warnings;
no warnings 'redefine';

use Net::DNS;

BEGIN {
    if ($Net::DNS::VERSION != 0.72) {
        warn "This module is only tested with Net::DNS v0.72. You have version " . $Net::DNS::VERSION . "\n";
    }
}

# In version 0.69, Net::DNS changed to a "more user-friendly" version of this
# function. This new version hides information that we want to be able to show
# to our users, so we replace the function with one that works as it did before.
require Net::DNS::Mailbox;
*Net::DNS::Mailbox::address = sub {
    return join('.', $_[0]->label);
};

# The method unique_push in Net::DNS::Package does not work on packets read from
# the net, only on ones made up from scratch locally. A fix for this bug was
# rejected by the maintainers, so we have to fix it here.
require Net::DNS::Packet;
our $orig = \&Net::DNS::Packet::decode;
*Net::DNS::Packet::decode = sub {
    my ($self, $offset) = $orig->(@_);

    foreach my $rr ( @{$self->{answer}}, @{$self->{authority}}, @{$self->{additional}} ) {
        next if $rr->type eq 'OPT';
        $self->{seen}->{lc( $rr->name ) . $rr->class . $rr->type . $rr->rdatastr} += 1;
    }

    return wantarray ? ( $self, $offset ) : $self;
};

1;

=head1 NAME

Giraffa::FixNetDNS - change behaviors in Net::DNS that are unsuitable for our needs

=head1 SYNOPSIS

    use Giraffa::FixNetDNS;

=head1 DESCRIPTION

This module changes two L<Net::DNS> behaviors that are unlikely to be changed in the module itself. It does this by messing directly with the
internals of the L<Net::DNS> module, and is thus tightly coupled to the exact version of that module. A warning will be emitted if an attempt is
made to use this module with a version of L<Net::DNS> it has not been tested with.

=head2 Net::DNS::RR::SOA::rname()

The first is to remove the change to L<Net::DNS::RR::SOA::rname> that was added in L<Net::DNS> version 0.69, where it tries to be helpful and
transforms the data before it returns it to the caller. This module changes the behavior back to what it used to be, where the returned value is
nothing more than the labels joined with C<.> characters.

=head2 Net::DNS::Packet::unique_push()

In the standard distribution, this method ignores RRs that were added to a packet by decoding it from wire format, thus making it possible for it
to add duplicate RRs to the packet. This module fixes that problem, making the method reliable for any packet.
