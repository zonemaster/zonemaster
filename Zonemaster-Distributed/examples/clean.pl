#!/usr/bin/env perl

use 5.14.2;
use warnings;

use lib 'lib';

use Zonemaster::Distributed::Setup;
use Data::Dumper;

my $s = Zonemaster::Distributed::Setup->new({
    dbhost => 'localhost',
    dbname => 'zonemaster',
    dbuser => 'calle',
    dbpass => 'foobar'
});

$s->clean_crashed('Necronomicon-II.local');