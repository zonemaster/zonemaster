package Zonemaster::Distributed;

use 5.014002;
use warnings;
use Sys::Hostname;
use Zonemaster::Distributed::QHandler;
use Zonemaster::Distributed::Setup;
use Daemon::Control;
use Log::Log4perl qw[:easy];

use Moose;
with 'MooseX::Getopt';

our $VERSION = '0.01';

has 'dbhost' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    default       => 'localhost',
    documentation => 'Hostname (or IP address) of primary CouchDB server. Defaults to "localhost".'
);
has 'dbname' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    default       => 'zonemaster',
    documentation => 'Database name in primary CouchDB server. Defaults to "zonemaster".'
);
has 'dbuser' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'User name at primary CouchDB server. Required unless CouchDB is in "admin party" mode.'
);
has 'dbpass' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Password at primary CouchDB server. Required if --user is given.'
);
has 'limit' => (
    is            => 'ro',
    isa           => 'Int',
    default       => 10,
    documentation => 'The maximum number of concurrently running scanning processes. Default 10.'
);
has 'nodename' => (
    is            => 'ro',
    isa           => 'Str',
    default       => sub { hostname() },
    documentation => 'The name of this scanning node. Defaults to hostname.'
);
has 'run' => (
    is            => 'ro',
    isa           => 'Bool',
    default       => 1,
    documentation => 'Boolean flag specifying if the dispatcher should run or not. Default on.'
);
has 'setup' => (
    is            => 'ro',
    isa           => 'Bool',
    default       => 0,
    documentation => 'Boolean flag specifying if setup should be done to primary CouchDB server. Default off.'
);
has 'peer' => (
    is            => 'ro',
    isa           => 'ArrayRef',
    required      => 0,
    documentation => 'URL to another CouchDB database we should set up replication to. Can be given multiple times.'
);
has 'verbosity' => (
    is            => 'ro',
    isa           => 'Str',
    default       => 'error',
    documentation => 'trace, debug, info, warn, error or fatal (Log4perl level)',
);
has 'clean' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
    documentation =>
      'If this flag is set, un-finished documents from this node with no living scanning process will be deleted.',
);

has 'command' => (
    is            => 'ro',
    isa           => 'Str',
    default       => 'start',
    documentation => 'start|stop|restart|reload|status|show_warnings|get_init_file'
);
has 'pid_file' => ( is => 'ro', isa => 'Str', lazy_build => 1, documentation => 'Path to a file where the daemon PID will be stored.' );

sub _build_pid_file {
    my ( $self ) = @_;

    return '/var/run/' . $self->dbname . '_' . $self->nodename . '.pid';
}

sub do_run {
    my ( $self ) = @_;

    my %args;

    if ( lc( $self->verbosity ) eq 'fatal' ) {
        Log::Log4perl->easy_init( $FATAL );
    }
    elsif ( lc( $self->verbosity ) eq 'error' ) {
        Log::Log4perl->easy_init( $ERROR );
    }
    elsif ( lc( $self->verbosity ) eq 'warn' ) {
        Log::Log4perl->easy_init( $WARN );
    }
    elsif ( lc( $self->verbosity ) eq 'info' ) {
        Log::Log4perl->easy_init( $INFO );
    }
    elsif ( lc( $self->verbosity ) eq 'debug' ) {
        Log::Log4perl->easy_init( $DEBUG );
    }
    elsif ( lc( $self->verbosity ) eq 'trace' ) {
        Log::Log4perl->easy_init( $TRACE );
    }
    else {
        die "Unknown log level: " . $self->verbosity;
    }

    $args{dbhost} = $self->dbhost;
    $args{dbname} = $self->dbname;
    $args{dbuser} = $self->dbuser if $self->dbuser;
    $args{dbpass} = $self->dbpass if $self->dbuser;

    if ( $self->setup or $self->peer or $self->clean ) {
        my $setup = Zonemaster::Distributed::Setup->new( \%args );

        if ( $self->peer ) {
            INFO "Installing replications documents.";
            $setup->install_replication( @{ $self->peer } );
        }

        if ( $self->setup ) {
            INFO "Creating database and installing design document.";
            $setup->do_it;
        }

        if ( $self->clean ) {
            $setup->clean_crashed( $self->nodename );
        }
    }

    if ( $self->run ) {
        my %dargs;

        $dargs{name}     = $self->dbname . '_' . $self->nodename;
        $dargs{pid_file} = $self->pid_file;
        $dargs{program}  = sub {
            my $qhandler = Zonemaster::Distributed::QHandler->new( \%args );
            $qhandler->loop_forever;
        };

        INFO "Handing control to Daemon::Control.";
        exit Daemon::Control->new( \%dargs )->run_command( $self->command );
    }

    return;
}

1;    # End of Zonemaster::Distributed
