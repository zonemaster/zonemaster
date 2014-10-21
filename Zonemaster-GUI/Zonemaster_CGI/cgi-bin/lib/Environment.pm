package Environment;
use strict qw/vars subs/;
use warnings;
use Carp;
use DBI;
use JSON;
use File::Slurp qw/ read_file write_file /;

use constant RequiredParameters => [
    qw/ template_path cgi_url /
];

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;
    my $self  = {};
    open my $INPUT, '<', 'environment.dat';
    while (<$INPUT>) {
        $_ =~ s/^\s+|\s+$//sg;
        next unless length();
        next if $_ =~ m/^\#/;    # skip comments
        my ( $key, $val, @extra ) = split /:/;
        $key =~ s/^\s+|\s+$//sg;
        $val =~ s/^\s+|\s+$//sg;
        $_ =~ s/^\s+|\s+$//sg foreach (@extra);
        $self->{$key} = scalar(@extra) ? join ':', ( $val, @extra ) : $val;
    }
    CORE::close $INPUT;
    no warnings 'redefine';
    while (@_) {                 # custom parameters
        my $key = shift;
        croak 'Odd number of parameters' unless @_;
        my $val = shift;
        $key =~ s/^\s+|\s+$//sg;
        $val =~ s/^\s+|\s+$//sg;
        $self->{$key} = $val;
        *{ __PACKAGE__ . '::' . $key } = sub {
            my $self = shift;
            croak 'Invalid object' unless $self && ref($self);
            return $self->{$key};
          }
          unless __PACKAGE__->can($key);
    }
    my @missing_required_parameters;
    foreach my $key ( @{ +RequiredParameters } ) {
        push @missing_required_parameters, $key
          unless defined( $self->{$key} ) && length( $self->{$key} );
    }
    croak 'Missing mandatory parameters: '
      . join( ' ', @missing_required_parameters )
      	if scalar @missing_required_parameters;
    $self->{connection_string} = 'dbi:mysql:database=' . $self->{db_name};
    $self->{connection_string} .= ';mysql_socket=' . $self->{db_socket}
          if exists( $self->{db_socket} );
    $self->{db} = DBI->connect(
            $self->{connection_string}, $self->{db_user},
            $self->{db_password}, { RaiseError => 1 }
    );
    croak 'Failed database connection'
          unless ( defined( $self->{db} )
            && ref( $self->{db} )
            && $self->{db}->ping );
    $self->{log_entries} = []
      if ( exists( $self->{log_path} ) && length( $self->{log_path} ) );
    bless $self, $class;
}

sub db_user {
    my $self = shift;
    croak 'Invalid environment' unless ( $self && ref($self) );
    return $self->{db_user};
}

sub db_password {
    my $self = shift;
    croak 'Invalid environment' unless ( $self && ref($self) );
    return $self->{db_password};
}

sub db_connection_string {
    my $self = shift;
    croak 'Invalid environment' unless ( $self && ref($self) );
    return $self->{connection_string} if exists( $self->{connection_string} );
    $self->{connection_string} = 'dbi:mysql:database=' . $self->{db_name};
    $self->{connection_string} .= ';mysql_socket=' . $self->{db_socket}
      if exists( $self->{db_socket} );
    return $self->{connection_string};
}

sub db {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->{db};
}

sub close {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return unless ( defined( $self->{db} ) && ref( $self->{db} ) );
    $self->db->disconnect;
}

sub is_post_request {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return 1
      if ( defined( $ENV{'REQUEST_METHOD'} )
        && $ENV{'REQUEST_METHOD'} eq 'POST' );
    return '';
}

sub is_get_request {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return 1
      if ( defined( $ENV{'REQUEST_METHOD'} )
        && $ENV{'REQUEST_METHOD'} eq 'GET' );
    return '';
}

sub remote_ip {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $ENV{'REMOTE_ADDR'}
      if ( defined( $ENV{'REMOTE_ADDR'} )
        && length( $ENV{'REMOTE_ADDR'} ) );
    return;
}

sub request_uri {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $ENV{'REQUEST_URI'}
      if ( defined( $ENV{'REQUEST_URI'} )
        && length( $ENV{'REQUEST_URI'} ) );
    return;
}

sub user_agent_language {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $ENV{'HTTP_ACCEPT_LANGUAGE'}
      if ( defined( $ENV{'HTTP_ACCEPT_LANGUAGE'} )
        && length( $ENV{'HTTP_ACCEPT_LANGUAGE'} ) );
    return;
}


sub user_agent {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $ENV{'HTTP_USER_AGENT'}
      if ( defined( $ENV{'HTTP_USER_AGENT'} )
        && length( $ENV{'HTTP_USER_AGENT'} ) );
    return;
}

sub request_script {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $ENV{'SCRIPT_NAME'}
      if ( defined( $ENV{'SCRIPT_NAME'} )
        && length( $ENV{'SCRIPT_NAME'} ) );
    return;
}

sub request_cookie {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $ENV{'HTTP_COOKIE'}
      if ( defined( $ENV{'HTTP_COOKIE'} )
        && length( $ENV{'HTTP_COOKIE'} ) );
    return;
}

sub now {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    my ( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) =
      localtime(time);
    $mon++;
    $year += 1900;
    return sprintf( '%04d-%02d-%02d %02d:%02d:%02d',
        $year, $mon, $mday, $hour, $min, $sec );
}

sub log {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return
      unless ( exists( $self->{log_entries} )
        && ref( $self->{log_entries} ) );
    my $log_entry = shift;
    $log_entry =~ s/^\s+|\s+$//sg if defined($log_entry);
    return
      unless ( defined($log_entry) && length($log_entry) );
    croak 'Attempt to log object' if ref($log_entry);
    my $uri = defined( $ENV{'REQUEST_URI'} ) ? $ENV{'REQUEST_URI'} : '';
    push @{ $self->{log_entries} },
      $self->now . "\t" . $uri . "\t" . $log_entry ;
}

sub truncate_log {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    my $log_path = '';
    if ( $self->{log_path} =~ m/(^[\/\\0-9a-zA-Z\-]+\.log)$/ )
    {    # to run in taint mode
        $log_path = $1;
    }
    return unless $log_path;
    write_file( $log_path, '' );
}

sub flush_log {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return
      unless ( exists( $self->{log_entries} )
        && ref( $self->{log_entries} )
        && scalar( @{ $self->{log_entries} } ) );
    my $log_path = '';
    if ( $self->{log_path} =~ m/(^[\/\\0-9a-zA-Z\-\_]+\.log)$/ )
    {    # to run in taint mode
        $log_path = $1;
    }
    return unless $log_path;
    open my $LOG_FILE, '>>', $log_path;
    print $LOG_FILE $_ . "\n" foreach @{ $self->{log_entries} };
    CORE::close $LOG_FILE;

}

sub parse_parameters {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    my $params = shift;
    $params =~ s/^\s+\s+$//sg if defined($params);
    return unless defined($params) && length( defined($params) );
    my @key_vals = split /;/, $params;
    return unless @key_vals;
    my $parameters = {};

    foreach my $key_val (@key_vals) {
        $key_val =~ s/^\s+|\s+$//sg;
        my ( $key, $val ) = split /:/, $key_val;
        $key =~ s/^\s+|\s+$//sg if defined($key);
        $val =~ s/^\s+|\s+$//sg if defined($val);
        next
          unless defined($key)
          && defined($val)
          && length($key)
          && length($val);
        $parameters->{$key} = $val;
    }
    return unless scalar keys %$parameters;
    return %{$parameters} if wantarray;
    return $parameters;
}

sub load_dictionary {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    my $dict = shift;
    croak 'Invalid dictionary requested' unless defined($dict) && length($dict);
    $dict =~ s/\.json$//;	
    croak 'Dictionary file not found' 
	unless -f $self->{dict_path} . '/' . $dict . '.json';
    my $dict_data = '';
    open INPUT, '<' . $self->{dict_path} . '/' . $dict . '.json';	
    while(<INPUT>){
	$_ =~ s/^\s+|\s+$//sg;
	$dict_data .= $_;
    }
    return JSON->new()->decode($dict_data);
}

1;
