package Page;
use strict;
use warnings;
use Carp;
use Template;

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;
    my $self  = {};
    $self->{env} = shift;
    croak 'Invalid environment passed'
      unless ( defined( $self->{env} ) && ref( $self->{env} ) );
    $self->{cgi} = shift;
    croak 'Invalid cgi object passed'
      unless ( defined( $self->{cgi} ) && ref( $self->{cgi} ) );
    $self->{template} = Template->new(
        {
            INCLUDE_PATH => $self->{env}{template_path},    # or list ref
            INTERPOLATE => 1,    # expand "$var" in plain text
            POST_CHOMP  => 1,    # cleanup whitespace
            EVAL_PERL   => 1,    # evaluate Perl code blocks
	    ENCODING => 'utf8'
        }
    );
    $self->{template_file} = shift if @_;
    $self->{header}        = shift if @_;
    bless $self, $class;
}

sub cgi {
    my $self = shift;
    croak 'Invalid page' unless $self && ref($self);
    return $self->{cgi};
}

sub cookie {
    my $self = shift;
    croak 'Invalid page' unless $self && ref($self);
    while (@_) {
        $self->{cookie} = []
          unless ( exists( $self->{cookie} ) && ref( $self->{cookie} ) );
        my $new_cookie = shift;
        push @{ $self->{cookie} }, $new_cookie;
    }
    return ''
      unless ( exists( $self->{cookie} )
        && ref( $self->{cookie} )
        && scalar( @{ $self->{cookie} } ) );
    return $self->{cookie};
}

sub env {
    my $self = shift;
    croak 'Invalid page' unless $self && ref($self);
    return $self->{env};
}

sub set_redirect {
    my $self = shift;
    croak 'Invalid page' unless $self && ref($self);
    $self->{redirect} = shift;
    return unless defined( $self->{redirect} ) && length( $self->{redirect} );
    $self->add_header(
        -script => {
            -language => 'javascript',
            -code =>
              "jQuery(document).ready(function(){window.location.replace(\'"
              . $self->{redirect}
              . "\');});"
        }
    );
}

sub template {
    my $self = shift;
    croak 'Invalid page' unless $self && ref($self);
    return $self->{template};
}

sub template_file {
    my $self = shift;
    croak 'Invalid page' unless $self && ref($self);
    $self->{template_file} = shift if @_;
    return $self->{template_file};
}

sub header {
    my $self = shift;
    Carp::croak 'Invalid page' unless $self && ref($self);
    $self->{header} = shift if @_;
    return () unless scalar keys %{ $self->{header} };
    return %{ $self->{'header'} };
}

sub add_header {
    my $self = shift;
    Carp::croak 'Invalid page' unless $self && ref($self);
    while (@_) {
        my $key = shift;
        $key =~ s/^\s+|\s+$//sg;
        my $val = shift;
        Carp::croak 'Odd amount elements in hash' unless defined($val);
        unless ( exists $self->{header}{$key} ) {
            $self->{header}{$key} = $val;
        }
        else {
            if ( ref( $self->{header}{$key} ) eq 'ARRAY' ) {
                push @{ $self->{header}{$key} }, $val;
            }
            else {
                my $old_ref = $self->{header}{$key};
                $self->{header}{$key} = [];
                push @{ $self->{header}{$key} }, $val;
                push @{ $self->{header}{$key} }, $old_ref;
            }
        }
    }
}

sub render {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    croak 'No template file to render' unless $self->template_file;
    my @cookie_header = $self->cookie ? ( -cookie => $self->cookie ) : ();
    print STDOUT $self->cgi->header(@cookie_header, -charset => 'UTF-8');
    print STDOUT $self->cgi->start_html( $self->header );
    eval { $self->{template}->process( $self->template_file, @_, \*STDOUT, {binmode => ':utf8'} ) };
    croak 'Failed to process template: ' . $@ if $@;
}

sub finalize {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    print STDOUT $self->cgi->end_html;
    $self->env->close;
    $self->env->flush_log;
}

sub cgi_params {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    croak 'Invalid cgi object' unless $self->cgi && ref( $self->cgi );
    my $params = {};
    foreach my $key ( $self->cgi->param ) {
        $params->{$key} = $self->cgi->param($key);
    }
    return %{$params} if wantarray;
    return $params;
}

1;
