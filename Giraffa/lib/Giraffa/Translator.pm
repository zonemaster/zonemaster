package Giraffa::Translator v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Moose;
use Carp;

use File::ShareDir qw[dist_dir];
use File::Slurp;
use JSON;

# Not necessary if a filename is given
has 'lang' => ( is => 'ro', isa => 'Str', required => 0 );

# Can be auto-generated from language code
has 'file' => ( is => 'ro', isa => 'Maybe[Str]', lazy => 1, builder => '_find_file' );

# Loaded from file
has 'data' => ( is => 'ro', isa => 'HashRef', lazy => 1, builder => '_load_language' );

around 'new' => sub {
    my $orig  = shift;
    my $class = shift;

    my $obj = $class->$orig( @_ );

    croak 'Must have at least one of lang and file'
      if not( $obj->lang or $obj->file );

    return $obj;
};

###
### Builder Methods
###

sub _find_file {
    my ( $self ) = @_;

    return unless defined( $self->lang );

    my $filename = sprintf( '%s/language_%s.json', dist_dir( 'Giraffa' ), $self->lang );
    if ( not -r $filename ) {
        croak "Cannot read translation file " . $filename . "\n";
    }

    return $filename;
}

sub _load_language {
    my ( $self ) = @_;

    return decode_json read_file $self->file;
}

###
### Working methods
###

sub to_string {
    my ( $self, $entry ) = @_;

    my $string = $self->data->{ $entry->module }{ $entry->tag };

    if ( not $string ) {
        return $entry->string;
    }

    foreach my $arg ( keys %{ $entry->args } ) {
        if ( not $string =~ s/\{$arg\}/$entry->args->{$arg}/e ) {
            # warn "Unused entry argument '$arg";
        }
    }

    while ( $string =~ /\{(\w+)\}/g ) {
        warn "Expected argument $1 not provided";
    }

    return sprintf( "%7.2f %-7s %s", $entry->timestamp, $entry->level, $string );
} ## end sub to_string

1;

=head1 NAME

Giraffa::Translator - translation support for Giraffa

=head1 SYNOPSIS

    my $trans = Giraffa::Translator->new({ lang => 'tech' });
    say $trans->to_string($entry);

=head1 ATTRIBUTES

=over

=item lang

The language code for the language the translator should use. Either this or C<file> must be provided.

=item file

The file from which the translation data will be loaded. If it is not provided but C<lang> is, an attempt will be made to load a file called
F<language_lang.json> from the Giraffa distribution directory.

=item data

A reference to a hash with translation data.

=back

=head1 METHODS

=over

=item to_string($entry)

Takes a L<Giraffa::Logger::Entry> object as its argument and returns a to_stringd string for the message and arguments in the entry.

=back

=cut
