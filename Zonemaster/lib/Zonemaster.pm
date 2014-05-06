package Zonemaster v0.0.2;

use 5.014002;
use Moose;

use Zonemaster::Nameserver;
use Zonemaster::Logger;
use Zonemaster::Config;
use Zonemaster::Zone;
use Zonemaster::Test;
use Zonemaster::Recursor;

our $logger;
our $config;
our $recursor = Zonemaster::Recursor->new;

sub logger {
    return $logger //= Zonemaster::Logger->new;
}

sub config {
    return $config //= Zonemaster::Config->new;
}

sub ns {
    my ( $class, $name, $address ) = @_;

    return Zonemaster::Nameserver->new( { name => $name, address => $address } );
}

sub zone {
    my ( $class, $name ) = @_;

    return Zonemaster::Zone->new( { name => $name } );
}

sub test_zone {
    my ( $class, $zname ) = @_;

    return Zonemaster::Test->run_all_for( $class->zone( $zname ) );
}

sub test_module {
    my ( $class, $module, $zname ) = @_;

    return Zonemaster::Test->run_module( $module, $class->zone( $zname ) );
}

sub test_method {
    my ( $class, $module, $method, @arguments ) = @_;

    return Zonemaster::Test->run_one( $module, $method, @arguments );
}

sub all_tags {
    my ( $class ) = @_;
    my @res;

    foreach my $module ( 'Basic', Zonemaster::Test->modules ) {
        my $full = "Zonemaster::Test::$module";
        my $ref  = $full->metadata;
        foreach my $list ( values %$ref ) {
            push @res, map { uc( $module ) . ':' . $_ } @$list;
        }
    }

    return @res;
}

sub all_methods {
    my ( $class ) = @_;
    my %res;

    foreach my $module ( 'Basic', Zonemaster::Test->modules ) {
        my $full = "Zonemaster::Test::$module";
        my $ref  = $full->metadata;
        foreach my $method ( keys %$ref ) {
            push @{$res{$module}}, $method;
        }
    }

    return %res;
}

sub recurse {
    my ($class, $qname, $qtype, $qclass ) = @_;
    $qtype //= 'A';
    $qclass //= 'IN';

    return $recursor->recurse($qname, $qtype, $qclass);
}

sub add_fake_delegation {
    my ( $class, $domain, $href ) = @_;

    my $parent = $class->zone($recursor->parent($domain));
    foreach my $ns (@{$parent->ns}) {
        $ns->add_fake_delegation($domain => $href);
    }

    return;
}

sub save_cache {
    my ( $class, $filename ) = @_;

    return Zonemaster::Nameserver->save( $filename );
}

sub preload_cache {
    my ( $class, $filename ) = @_;

    return Zonemaster::Nameserver->restore( $filename );
}

=head1 NAME

Zonemaster - A tool to check the quality of a DNS zone

=head1 SYNOPSIS

    my @results = Zonemaster->test_zone('iis.se')

=head1 METHODS

=over

=item test_zone($name)

Runs all available tests and returns a list of L<Zonemaster::Logger::Entry> objects.

=item test_module($module, $name)

Runs all available tests for the zone with the given name in the specified module.

=item test_method($module, $method, @arguments)

Run one particular test method in one particular module. The requested module must be in the list of active loaded modules (that is, not the Basic
module and not a module disabled by the current policy), and the method must be listed in the metadata the module exports. If those requirements
are fulfilled, the method will be called with the provided arguments.

=item zone($name)

Returns a L<Zonemaster::Zone> object for the given name.

=item ns($name, $address)

Returns a L<Zonemaster::Nameserver> object for the given name and address.

=item config()

Returns the global L<Zonemaster::Config> object.

=item logger()

Returns the global L<Zonemaster::Logger> object.

=item all_tags()

Returns a list of all the tags that can be logged for all avilable test modules.

=item all_methods()

Returns a hash, where the keys are test module names and the values are lists with the names of the test methods in that module.

=item recurse($name, $type, $class)

Does a recursive lookup for the given name, type and class, and returns the resulting packet (if any). Simply calls
L<Zonemaster::Recursor::recurse()> on a globally stored object.

=item save_cache($filename)

After running the tests, save the accumulated cache to a file with the given name.

=item preload_cache($filename)

Before running the tests, load the cache with information from a file with the given name. This file must have the same format as is produced by
L<save_cache()>.

=item add_fake_delegation($domain, $data)

This method adds some fake delegation information to the system. The arguments are a domain name, and a reference to a hash with delegation
information. The keys in the hash must be nameserver names, and the values references to lists of IP addresses for the corresponding nameserver.

Example:

    Zonemaster->add_fake_delegation(
        'lysator.liu.se' => {
            'ns.nic.se'  => [ '212.247.7.228',  '2a00:801:f0:53::53' ],
            'i.ns.se'    => [ '194.146.106.22', '2001:67c:1010:5::53' ],
            'ns3.nic.se' => [ '212.247.8.152',  '2a00:801:f0:211::152' ]
        }
    );

=back

=head1 AUTHOR

Calle Dybedahl, C<< <calle at init.se> >>

=cut

1;
