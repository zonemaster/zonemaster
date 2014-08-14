package Zonemaster::Distributed::QHandler;

use 5.14.2;
use warnings;

use Moose;
use Store::CouchDB;
use Zonemaster::Distributed::Runner;
use Sys::Hostname;
use List::Util qw[shuffle];
use Time::HiRes qw[time sleep];
use Net::LibIDN qw[idn_to_ascii];
use Log::Log4perl qw[:easy];

has 'dbhost'   => ( is => 'ro', isa => 'Str',                             required   => 1 );
has 'dbname'   => ( is => 'ro', isa => 'Str',                             required   => 1 );
has 'dbuser'   => ( is => 'ro', isa => 'Str',                             required   => 0 );
has 'dbpass'   => ( is => 'ro', isa => 'Str',                             required   => 0 );
has 'limit'    => ( is => 'ro', isa => 'Int',                             default    => 10 );
has 'runner'   => ( is => 'ro', isa => 'Zonemaster::Distributed::Runner', lazy_build => 1 );
has 'db'       => ( is => 'ro', isa => 'Store::CouchDB',                  lazy_build => 1 );
has 'nodename' => ( is => 'ro', isa => 'Str',                             default    => sub { hostname() } );
has 'entries'  => ( is => 'ro', isa => 'HashRef',                         default    => sub { {} } );

###
### Builders
###

sub _build_runner {
    my ( $self ) = @_;

    my %args;
    $args{entry_cb}    = sub { $self->_log_entry( @_ ) };
    $args{finished_cb} = sub { $self->_run_finished( @_ ) };
    $args{limit}       = $self->limit;

    my $r = Zonemaster::Distributed::Runner->new( \%args );

    return $r;
}

sub _build_db {
    my ( $self ) = @_;

    my %args;
    $args{host} = $self->dbhost;
    $args{db}   = $self->dbname;
    $args{user} = $self->dbuser if $self->dbuser;
    $args{pass} = $self->dbpass if $self->dbuser;

    my $db = Store::CouchDB->new( %args );

    return $db;
}

###
### Callback targets
###

sub _log_entry {
    my ( $self, $id, $e, ) = @_;

    my $name = $self->entries->{$id}{name};
    my $doc  = $self->db->get_doc( $id );
    my %h    = (
        timestamp => $e->timestamp,
        tag       => $e->tag,
        module    => $e->module,
        level     => $e->level,
        args      => $e->args,
    );

    # $doc->{results}[0]{scanner_pid} = $pid;
    push @{ $doc->{results}[0]{messages} }, \%h;
    $self->db->update_doc( { doc => $doc } );

    return;
}

sub _run_finished {
    my ( $self, $id, $err_ref ) = @_;

    my $name = $self->entries->{$id}{name};
    INFO "$name finished";
    my $doc = $self->db->get_doc( $id );

    # delete $doc->{results}[0]{scanner_pid};
    $doc->{results}[0]{end_time} = time();
    $doc->{results}[0]{stderr} = $$err_ref if $err_ref;
    $self->db->update_doc( { doc => $doc } );

    delete $self->entries->{$id};
    return;
}

###
### Instance methods
###

# Fetch an unclaimed entry from the database
sub get_new_entry {
    my ( $self ) = @_;

    my @rows = shuffle $self->db->get_view_array( { view => 'dispatch/unclaimed', opts => { limit => 10 } } );
    if ( @rows > 0 ) {
        my $id  = $rows[0]{id};
        my $doc = $self->db->get_doc( $id );

        return $doc;
    }
    else {
        return;
    }
}

# Claim an entry
sub claim_entry {
    my ( $self, $entry ) = @_;

    my %r;
    $r{nodename}   = $self->nodename;
    $r{ulabel}     = $entry->{name};
    $r{alabel}     = idn_to_ascii( $r{ulabel}, 'UTF-8' );
    $r{start_time} = time();

    push @{ $entry->{results} }, \%r;
    $self->db->update_doc( { doc => $entry } );
    $self->start_running_entry( $entry );
    INFO $entry->{name} . " started.";

    return;
}

sub start_running_entry {
    my ( $self, $entry ) = @_;

    $self->entries->{ $entry->{_id} } = $entry;
    $self->runner->start_child(
        $entry,
        sub {
            my $r = $entry->{request};
            if ( $r->{ds} ) {
                INFO "Adding fake DS for " . $entry->{name};
                Zonemaster->add_fake_ds( $entry->{name}, $r->{ds} );
            }
            if ( $r->{ns} ) {
                INFO "Adding fake delegation for " . $entry->{name};
                Zonemaster->add_fake_delegation( $entry->{name}, $r->{ns} );
            }
            if ( $r->{ipv4} ) {
                INFO "Setting IPv4 flag for " . $entry->{name};
                Zonemaster->config->ipv4_ok( $r->{ipv4} );
            }
            if ( $r->{ipv6} ) {
                INFO "Setting IPv6 flag for " . $entry->{name};
                Zonemaster->config->ipv6_ok( $r->{ipv6} );
            }
        },
    );
}

sub check_for_conflicts {
    my ( $self ) = @_;

    foreach my $id ( keys %{ $self->entries } ) {
        my $name = $self->entries->{$id}{name};
        my $doc  = $self->db->get_doc( $id );
        if ( $doc->{results}[0]{nodename} ne $self->nodename ) {
            INFO "Conflict for $name ($id), killing it.";
            $self->runner->terminate($id);
        }
    }

    return;
}

sub loop_once {
    my ( $self ) = @_;

    my $r = $self->runner;
    if ( $r->has_free_slot ) {
        my $entry = $self->get_new_entry;
        if ( $entry ) {
            $self->claim_entry( $entry );
        }
    }

    sleep( $r->delay );
    $self->check_for_conflicts;
    $r->process_once;

    return;
}

sub loop_until_empty {
    my ( $self ) = @_;

    INFO "Looping until queue is empty";
    my $r = $self->runner;
    while ( $r->active_count > 0 ) {
        $self->loop_once;
    }
}

sub loop_forever {
    my ( $self ) = @_;

    INFO "Looping forever";
    while ( 1 ) {
        $self->loop_once;
    }
}

1;
