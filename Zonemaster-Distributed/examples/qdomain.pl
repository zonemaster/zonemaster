#!/usr/bin/env perl

use 5.14.2;
use warnings;

use Store::CouchDB;
use Encode;

binmode STDOUT, ':utf8';

my $db = Store::CouchDB->new(
    host => '127.0.0.1',
    db   => 'zonemaster',
    user => 'calle',
    pass => 'foobar',
);

foreach my $name ( <> ) {
    $name = decode('utf-8', $name);
    chomp($name);
    say 'Adding ' . $name;
    $db->put_doc( { doc => { name => $name, request => {} } } );
}
