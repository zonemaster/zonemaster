package ZonemasterDB::CouchDB v0.0.1;
use Moose;
use utf8;
use 5.14.0;

use Data::Dumper;
use DBI qw(:utils);
use Store::CouchDB;
use Time::HiRes qw(gettimeofday);
use Digest::MD5 qw(md5_hex);

use ZonemasterDB;

with 'ZonemasterDB';

has 'db' => (
	is => 'ro',
	isa => 'Store::CouchDB',
	lazy => 1,
	builder => '_connect_to_couch_db',
);

sub _connect_to_couch_db {
	my $db = Store::CouchDB->new(host => '127.0.0.1',  debug => 1);
	$db->db('zonemaster');
	
	return $db;
}

sub create_db{
	my ($self) = @_;
	# Unusable without debug => 1
	
#	say Dumper( $self->db->delete_db('zonemaster') );
#	say Dumper( $self->db->create_db('zonemaster') );
# Kills CouchDB 1.0.4 (hangs, restart necesserry)

	my @dbs = $self->db->all_dbs;
	foreach my $db (@dbs) {
 		say "FOUND DB:$db";
		if ($db eq 'zonemaster') {
			say Dumper( $self->db->delete_db('zonemaster') );
		}
	}
	
	say Dumper( $self->db->create_db('zonemaster') );
	
	say "------------ Create Views START -------------------";
	# To create a new document dont put the _revision parameter
	my ($id, $rev) = $self->db->put_doc({ dbname => 'zonemaster', 
				doc => {
					"_id" => "_design/application", 
					"views" => {
							"users" => {
								"map" => "function(doc) {
									if(doc.doc_type == 'user' && doc.username) {
										emit(doc.username, null);
									}
								}"
							},

							"tests_by_deterministic_hash" => {
								"map" => "function(doc) {
									if(doc.doc_type == 'test') {
										emit(doc.deterministic_hash, { 'doc_id' : doc.doc_id, 'creation_time' : doc.creation_time });
									}
								}"
							}
						}
					}
				});

	say "id: $id";
	say "rev: $rev";
	say "------------ Create Views END -------------------";
	
	say "------------ Search Documet 1 START -------------------";
	my $hashref = $self->db->get_view({
		view => 'application/users',
		opts => { key => 'user1' },
	});
	print Dumper($hashref);
	say "------------ Search Documet 1 END -------------------";
    
	say "------------ INSERT Documet 1 START -------------------";
	($id, $rev) = $self->db->put_doc({ dbname => 'zonemaster', doc => { doc_type => 'user', username => 'user1' } } );
	say "------------ INSERT Documet 1 STOP -------------------";

	say "------------ Search Documet 1 START -------------------";
	$hashref = $self->db->get_view({
		view => 'application/users',
		opts => { key => 'user1' },
	});
	print Dumper($hashref);
	say "------------ Search Documet 1 STOP -------------------";
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
	
	$params->{doc_type} = 'user';
	my ($id, $rev) = $self->db->put_doc({ doc => $params });
	say "id: $id";
	say "rev: $rev";
	
	return $id;
};

sub user_authorized {
	my ($self, $user, $api_key) = @_;

	my $hashref = $self->db->get_view({
		view => 'application/users',
		opts => { key => $user },
	});
	  
	return ($hashref && $hashref->{$user} eq $api_key)?(1):(0);
}

sub create_new_batch_job {
	my ($self, $username) = @_;

	# find all batch jobs of the user
	die "create_new_batch_job NOT IMPLEMENTED in ".__PACKAGE__."\n";
}

sub create_new_test {
	my ($self, $domain, $test_params, $minutes_between_tests_with_same_params, $priority, $batch_id) = @_;
	my $result;
	say __PACKAGE__."::create_new_test";

	$test_params->{domain} = $domain;
	my $js = JSON->new;
	$js->canonical(1);
	my $encoded_params = $js->encode($test_params);
	my $test_params_deterministic_hash = md5_hex($encoded_params);
	
	my $hashref = $self->db->get_array_view({
		view => 'application/tests_by_deterministic_hash',
		opts => { key => $test_params_deterministic_hash },
	});
	
	# Find a recently started (within $minutes_between_tests_with_same_params) tests with the exact same params ($test_params_deterministic_hash)
	if ($hashref) {
		foreach my $test (@$hashref) {
			say Dumper($test);
			if ((defined $test->{creation_time}) && ($test->{creation_time} > time() - 60 * $minutes_between_tests_with_same_params) ) {
				$result = $test->{doc_id};
			}
		}
	}

	say "Result:".Dumper($result);
	
	unless ($result) {
		my ($s, $usec) = gettimeofday();
		my $id = $s*100000 + $usec;
		my $doc = {
			doc_type => 'test',
			batch_id => $batch_id,
			priority => $priority,
			deterministic_hash => $test_params_deterministic_hash,
			params => $test_params,
			doc_id => $id,
			test_start_time => time(),
			creation_time => time(),
			progress => 0,
		};
		my ($id, $rev) = $self->db->put_doc({ dbname => 'zonemaster', doc => $doc } );
		$result = $id;
	}

	return $result;
}

sub get_test_history {
	my($self, $p) = @_;
}

sub get_test_params {
	my($self, $test_id) = @_;
	
	my ($result) = ();
	
	return $result;
}

sub test_progress {
	my($self, $test_id, $progress) = @_;
	
#	$self->dbh->do("UPDATE test_results SET progress=$progress WHERE id=$test_id") if ($progress);
	
	my ($result);
	
	return $result;
}

sub test_results {
	my($self, $test_id, $results) = @_;
}

no Moose;
__PACKAGE__->meta()->make_immutable();


1;