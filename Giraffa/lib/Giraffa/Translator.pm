package Giraffa::Translator v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Moose;
use Carp;

# Not necessary if a filename is given
has 'lang' => ( is => 'ro', isa => 'Str', required => 0);

# Can be auto-generated from language code
has 'file' => ( is => 'ro', isa => 'Maybe[Str]', lazy => 1, builder => 'find_file');

# Loaded from file
has 'data' => ( is => 'ro', isa => 'HashRef', lazy => 1, builder => 'load_language');

around 'new' => sub {
    my $orig = shift;
    my $class = shift;

    my $obj = $class->$orig(@_);

    croak 'Must have at least one of lang and file' if not ($obj->lang or $obj->file);

    return $obj;
};

###
### Builder Methods
###

sub find_file {

}

sub load_language {

}

1;