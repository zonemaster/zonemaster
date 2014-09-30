#!/usr/bin/env perl

use 5.14.2;
use warnings;

use Moose;
use JSON::XS;
use Zonemaster::Nameserver;

my $json = JSON->new->allow_blessed->convert_blessed->canonical;

sub wrap_query {
    my ($orig, $self, $name, $type, $args) = @_;

    open my $fh, '>>', 'output.txt';
    printf $fh "%-40s %-20s %-10s %s\n", $self->string, $name, $type, $json->encode($args);
    close $fh;
    return $self->$orig($name, $type, $args);
}

my $meta = Zonemaster::Nameserver->meta;
my $method = $meta->get_method('_query');
my $wrap = Class::MOP::Method::Wrapped->wrap($method);

$meta->remove_method('_query');
$wrap->add_around_modifier(\&wrap_query);
$meta->add_method( '_query', $wrap);

Zonemaster->logger->callback(sub { say $_[0]->tag });
Zonemaster->new->test_zone('lysator.liu.se');