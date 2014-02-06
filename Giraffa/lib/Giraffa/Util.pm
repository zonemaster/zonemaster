package Giraffa::Util v0.0.1;

use 5.14.2;
use parent 'Exporter';
use warnings;

use Giraffa;
use Giraffa::DNSName;

## no critic (Modules::ProhibitAutomaticExportation)
our @EXPORT = qw[ ns info config name policy ];

## no critic (Subroutines::RequireArgUnpacking)
sub ns {
    return Giraffa->ns( @_ );
}

sub info {
    my ( $tag, $argref ) = @_;

    return Giraffa->logger->add( $tag, $argref );
}

sub config {
    return Giraffa->config->get;
}

sub policy {
    return Giraffa->config->policy;
}

sub name {
    my ( $name ) = @_;

    return Giraffa::DNSName->new( $name );
}

1;

=head1 NAME

Giraffa::Util - utility functions for other Giraffa modules

=head1 SYNOPSIS

    use Giraffa::Util;
    info(TAG => { some => 'argument'});
    my $ns = ns($name, $address);
    config->{resolver}{defaults}{tcp_timeout} = 4711;
    my $name = name('whatever.example.org');

=head1 EXPORTED FUNCTIONS

=over

=item info($tag, $href)

Creates and returns a L<Giraffa::Logger::Entry> object. The object is also added to the global logger object's list of entries.

=item ns($name, $address)

Creates and returns a nameserver object with the given name and address.

=item config()

Returns the global L<Giraffa::Config> object.

=item policy()

Returns a reference to the global policy hash.

=item name($string)

Creates and returns a L<Giraffa::DNSName> object for the given string.

=back
