package Zonemaster::Logger v0.0.1;

use 5.14.2;
use Moose;

use Zonemaster::Logger::Entry;
use Zonemaster;
use List::MoreUtils qw[none];

has 'entries' => (
    is      => 'ro',
    isa     => 'ArrayRef[Zonemaster::Logger::Entry]',
    default => sub { [] }
);
has 'callback' => ( is => 'rw', isa => 'CodeRef', required => 0, clearer => 'clear_callback' );

sub add {
    my ( $self, $tag, $argref ) = @_;

    my $new =
      Zonemaster::Logger::Entry->new( { tag => uc( $tag ), args => $argref } );
    $self->_check_filter( $new );
    push @{ $self->entries }, $new;

    if ( $self->callback and ref( $self->callback ) eq 'CODE' ) {
        eval { $self->callback->( $new ) };
        if ( $@ ) {
            $self->clear_callback;
            $self->add( LOGGER_CALLBACK_ERROR => { exception => $@ } );
        }
    }

    return $new;
}

sub _check_filter {
    my ( $self, $entry ) = @_;
    my $config = Zonemaster->config->get->{logfilter};

    if ( $config ) {
        if ( $config->{ $entry->module } ) {
            if ( my $rule = $config->{ $entry->module }{ $entry->tag } ) {
                foreach my $key ( keys %{ $rule->{when} } ) {
                    my $cond = $rule->{when}{$key};
                    if ( ref( $cond ) and ref( $cond ) eq 'ARRAY' ) {
                        # No match in list, so overall fail, so return
                        no warnings 'uninitialized';
                        return if none { $_ eq $entry->args->{$key} } @$cond;
                    }
                    else {
                        # No match, so overall fail, so return
                        no warnings 'uninitialized';
                        return if $cond ne $entry->args->{$key};
                    }
                }
                # Still here, so all rules matched
                $entry->_set_level( $rule->{set} );
            }
        }
    }
} ## end sub _check_filter

1;

=head1 NAME

Zonemaster::Logger - class that holds L<Zonemaster::Logger::Entry> objects.

=head1 SYNOPSIS

    my $logger = Zonemaster::Logger->new;
    $logger->add( TAG => {some => 'arguments'});

=head1 ATTRIBUTES

=over

=item entries

A reference to an array holding L<Zonemaster::Logger::Entry> objects.

=back

=head1 METHODS

=over

=item add($tag, $argref)

Adds an entry with the given tag and arguments to the logger object.

=back

=cut
