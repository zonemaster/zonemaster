package Zonemaster::Util v0.0.1;

use 5.14.2;
use parent 'Exporter';
use warnings;

use Zonemaster;
use Zonemaster::DNSName;
use Pod::Simple::SimpleTree;

## no critic (Modules::ProhibitAutomaticExportation)
our @EXPORT = qw[ ns info config name policy pod_extract_for ];

## no critic (Subroutines::RequireArgUnpacking)
sub ns {
    return Zonemaster->ns( @_ );
}

sub info {
    my ( $tag, $argref ) = @_;

    return Zonemaster->logger->add( $tag, $argref );
}

sub config {
    return Zonemaster->config->get;
}

sub policy {
    return Zonemaster->config->policy;
}

sub name {
    my ( $name ) = @_;

    return Zonemaster::DNSName->new( $name );
}

# Functions for extracting POD documentation from test modules

sub _pod_process_tree {
    my ( $node, $flags ) = @_;
    my ( $name, $ahash, @subnodes ) = @$node;
    my @res;

    $flags //= {};

    foreach my $node ( @subnodes ) {
        if ( ref( $node ) ne 'ARRAY' ) {
            $flags->{tests} = 1 if $name eq 'head1' and $node eq 'TESTS';
            if ( $name eq 'item-text' and $flags->{tests} ) {
                $node =~ s/^(\w+).*$/$1/;
                $flags->{item} = $node;
                push @res, $node;
            }
        }
        else {
            if ( $flags->{item} ) {
                push @res, _pod_extract_text( $node );
            }
            else {
                push @res, _pod_process_tree( $node, $flags );
            }
        }
    }

    return @res;
} ## end sub _pod_process_tree

sub _pod_extract_text {
    my ( $node ) = @_;
    my ( $name, $ahash, @subnodes ) = @$node;
    my $res = '';

    foreach my $node ( @subnodes ) {
        if ( $name eq 'item-text' ) {
            $node =~ s/^(\w+).*$/$1/;
        }

        if ( ref( $node ) eq 'ARRAY' ) {
            $res .= _pod_extract_text( $node );
        }
        else {
            $res .= $node;
        }
    }

    return $res;
} ## end sub _pod_extract_text

sub pod_extract_for {
    my ( $name ) = @_;

    my $parser = Pod::Simple::SimpleTree->new;
    $parser->no_whining( 1 );

    my %desc = eval { _pod_process_tree( $parser->parse_file( $INC{"Zonemaster/Test/$name.pm"} )->root ) };

    return \%desc;
}

1;

=head1 NAME

Zonemaster::Util - utility functions for other Zonemaster modules

=head1 SYNOPSIS

    use Zonemaster::Util;
    info(TAG => { some => 'argument'});
    my $ns = ns($name, $address);
    config->{resolver}{defaults}{tcp_timeout} = 4711;
    my $name = name('whatever.example.org');

=head1 EXPORTED FUNCTIONS

=over

=item info($tag, $href)

Creates and returns a L<Zonemaster::Logger::Entry> object. The object is also added to the global logger object's list of entries.

=item ns($name, $address)

Creates and returns a nameserver object with the given name and address.

=item config()

Returns the global L<Zonemaster::Config> object.

=item policy()

Returns a reference to the global policy hash.

=item name($string)

Creates and returns a L<Zonemaster::DNSName> object for the given string.

=item pod_extract_for($testname)

Will attempt to extract the POD documentation for the test methods in the test module for which the name is given. If it can, it returns a reference to a hash where the keys are the test method names and the values the documentation strings.

This method blindly assumes that the structure of the POD is exactly like that in the Example and Basic test modules. If it's not, the results are undefined.

=back
