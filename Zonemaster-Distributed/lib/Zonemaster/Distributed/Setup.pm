package Zonemaster::Distributed::Setup;

use 5.14.2;
use warnings;

use Moose;
use Store::CouchDB;
use List::Util qw[any];
use JSON::XS;
use Digest::SHA qw[sha1_hex];
use Log::Log4perl qw[:easy];

has 'dbhost' => ( is => 'ro', isa => 'Str',            required   => 1 );
has 'dbname' => ( is => 'ro', isa => 'Str',            required   => 1 );
has 'dbuser' => ( is => 'ro', isa => 'Str',            required   => 0 );
has 'dbpass' => ( is => 'ro', isa => 'Str',            required   => 0 );
has 'db'     => ( is => 'ro', isa => 'Store::CouchDB', lazy_build => 1 );

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

sub our_db_exists {
    my ( $self ) = @_;

    return any { $_ eq $self->dbname } $self->db->all_dbs;
}

sub create_db_if_needed {
    my ( $self ) = @_;

    if ( not $self->our_db_exists ) {
        INFO "Creating database.";
        $self->db->create_db( $self->dbname );
        return 1;
    }

    return;
}

sub install_design_dispatch {
    my ( $self ) = @_;

    my $json = <<'DISPATCH';
    {
       "views" : {
          "unclaimed" : {
             "map" : "function (doc) {\n    if (doc.request && !doc.results) {\n        emit(doc.name, null);\n    }\n}"
          },
          "inprogress" : {
             "map" : "function(doc){\n    if (doc.results[0][\"start_time\"] && !doc.results[0][\"end_time\"]) {\n        var r = doc.results[0];\n        emit([r.nodename, r.scanner_pid, doc.name], 1);\n    }\n}"
          }
       },
       "_id" : "_design/dispatch",
       "language" : "javascript"
    }
DISPATCH
    if ( $self->db->head_doc( { id => '_design/dispatch' } ) ) {
        $self->db->del_doc( { id => '_design/dispatch' } );
    }
    INFO "Installing design document";
    $self->db->put_doc( { doc => decode_json( $json ) } );

    return;
}

sub install_replication {
    my ( $self, @urls ) = @_;

    foreach my $url ( @urls ) {
        INFO "Installing replications for $url";
        $self->db->del_doc( { id => 'zonemaster-out', dbname => '_replicator' } );
        $self->db->del_doc( { id => 'zonemaster-in',  dbname => '_replicator' } );

        # 48 bits of pseduo-randomness to identify URL
        my $sha1 = substr( sha1_hex( $url ), 0, 12 );

        my ( $id, $rev ) = $self->db->put_doc(
            {
                doc => {
                    _id           => 'zonemaster-out-' . $sha1,
                    source        => $self->dbname,
                    target        => $url,
                    owner         => $self->dbuser,
                    create_target => JSON::XS::true(),
                },
                dbname => '_replicator'
            }
        );
        if ( $self->db->has_error ) {
            warn $self->db->error;
            next;
        }

        ( $id, $rev ) = $self->db->put_doc(
            {
                doc => {
                    _id           => 'zonemaster-in-' . $sha1,
                    target        => $self->dbname,
                    source        => $url,
                    owner         => $self->dbuser,
                    continuous    => JSON::XS::true(),
                    create_target => JSON::XS::true(),
                },
                dbname => '_replicator'
            }
        );
        if ( $self->db->has_error ) {
            warn $self->db->error;
            next;
        }
    }

    return;
}

sub clean_crashed {
    my ( $self, $node ) = @_;

    my @not_finished = $self->db->get_view_array(
        {
            view => 'dispatch/inprogress',
            opts => {
                startkey => [$node],
                endkey   => [ $node . 'Z' ],
            },
        }
    );

    foreach my $d ( @not_finished ) {
        my ( undef, $pid, $domain ) = @{ $d->{key} };
        if ( not $pid ) {
            $self->db->del_doc( $d );
        }
        else {
            if ( kill 0, $pid ) {

                # There is a process with that PID
                say STDERR "$pid is alive";
            }
            else {
                # No such process
                $self->db->del_doc( $d );
            }
        }
    }

    return;
}

sub do_it {
    my ( $self ) = @_;

    $self->create_db_if_needed;
    $self->install_design_dispatch;

    return;
}

1;
