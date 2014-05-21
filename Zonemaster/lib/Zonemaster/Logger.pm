package Zonemaster::Logger v0.0.1;

use 5.14.2;
use Moose;

use Zonemaster::Logger::Entry;
use Zonemaster;
use List::MoreUtils qw[none];
use Scalar::Util qw[blessed];

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
            my $err = $@;
            if ( blessed( $err ) and $err->isa( "Zonemaster::Exception" ) ) {
                die $err;
            }
            else {
                $self->clear_callback;
                $self->add( LOGGER_CALLBACK_ERROR => { exception => $err } );
            }
        }
    }

    return $new;
} ## end sub add

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
    } ## end if ( $config )
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

=item callback($coderef)

If this attribute is set, the given code reference will be called every time a
log entry is added. The referenced code will be called with the newly created
entry as its single argument. The return value of the called code is ignored.

If the called code throws an exception, and the exception is not an object of
class L<Zonemaster::Exception> (or a subclass of it), the exception will be
logged as a system message at default level C<CRITICAL> and the callback
attribute will be cleared.

If an exception that is of (sub)class L<Zonemaster::Exception> is called, the
exception will simply be rethrown until it reaches the code that started the
test run that logged the message.

=back

=head1 METHODS

=over

=item add($tag, $argref)

Adds an entry with the given tag and arguments to the logger object.

=back

=cut
