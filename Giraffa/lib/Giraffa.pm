package Giraffa v0.0.1;

use 5.014002;
use Moose;

use Giraffa::Nameserver;
use Giraffa::Logger;
use Giraffa::Config;
use Giraffa::Zone;
use Giraffa::Test;

our $logger;
our $config;

sub logger {
    return $logger //= Giraffa::Logger->new;
}

sub config {
    return $config //= Giraffa::Config->new;
}

sub ns {
    my ( $class, $name, $address ) = @_;

    return Giraffa::Nameserver->new( { name => $name, address => $address } );
}

sub zone {
    my ( $class, $name ) = @_;

    return Giraffa::Zone->new({ name => $name });
}

sub test_zone {
    my ( $class, $zname ) = @_;

    return Giraffa::Test->run_all_for($class->zone($zname));
}

=head1 NAME

Giraffa - The great new Giraffa!

=head1 VERSION

Version 0.1

=cut

=head1 SYNOPSIS

    Giraffa->ns($name, $address)

    Giraffa->logger()

    Giraffa->config()

=head1 AUTHOR

Calle Dybedahl, C<< <calle at init.se> >>

=cut

1;
