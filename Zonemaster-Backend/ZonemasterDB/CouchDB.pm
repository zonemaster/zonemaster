package ZonemasterDB::CouchDB v0.0.1;
use Moose;
use utf8;
use 5.14.0;

use Data::Dumper;
use DBI qw(:utils);
use Store::CouchDB;

use ZonemasterDB;

with 'ZonemasterDB';

has 'db' => (
	is => 'ro',
	isa => 'Store::CouchDB',
	lazy => 1,
	builder => '_connect_to_couch_db',
);

sub _connect_to_couch_db {
	my $db = Store::CouchDB->new(host => 'localhost',  debug => 1);
	$db->db('zonemaster');
	
	return $db;
}

sub user_exists_in_db {
	my ($self, $user) = @_;
	say __PACKAGE__."::user_exists_in_db";
	
	my $hashref = $self->db->get_view({
		view => 'application/users',
		opts => { key => $user },
	});
  
	return ($hashref)?(1):(0);
}

sub add_api_user_to_db {
	my ($self, $params) = @_;
	say __PACKAGE__."::add_api_user_to_db";
	
	my ($id, $rev) = $self->db->put_doc({ doc => $params });
	say "id: $id";
	say "rev: $rev";
	
	return $id;
};

sub user_authorized {
	my ($self, $user, $api_key) = @_;


}

sub create_new_batch_job {
	my ($self, $user, $api_key) = @_;


}

sub create_new_test {
	my ($self, $user, $api_key) = @_;


}


no Moose;
__PACKAGE__->meta()->make_immutable();


1;