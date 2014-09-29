package ZonemasterDB::SQLite v0.0.1;
use Moose;
use utf8;
use 5.14.0;

use Data::Dumper;
use DBI qw(:utils);
use JSON;
use Digest::MD5 qw(md5_hex);

use ZonemasterDB;

with 'ZonemasterDB';

#TODO read from config file
my $connection_string = "DBI:SQLite:database=:memory:";

has 'dbh' => (
	is => 'ro',
	isa => 'DBI::db',
	default => sub { DBI->connect($connection_string, {RaiseError => 1, AutoCommit => 1}) },
);

sub create_db {
	my ($self) = @_;

	####################################################################
	# TEST RESULTS
	####################################################################
	$self->dbh->do('DROP TABLE IF EXISTS test_specs') or die "SQLite Fatal error: " . $self->dbh->errstr();

	$self->dbh->do('DROP TABLE IF EXISTS test_results') or die "SQLite Fatal error: " . $self->dbh->errstr();

	$self->dbh->do('CREATE TABLE test_results (
					id integer PRIMARY KEY,
					batch_id integer NULL,
					creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
					test_start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
					test_end_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
					priority integer DEFAULT 10,
					progress integer DEFAULT 0,
					params_deterministic_hash character varying(32),
					params json1 NOT NULL,
					results json DEFAULT NULL
			)
	') or die "SQLite Fatal error: " . $self->dbh->errstr();

	####################################################################
	# BATCH JOBS
	####################################################################
	$self->dbh->do('DROP TABLE IF EXISTS batch_jobs') or die "SQLite Fatal error: " . $self->dbh->errstr();

	$self->dbh->do('CREATE TABLE batch_jobs (
					id integer PRIMARY KEY,
					username character varying(50) NOT NULL,
					creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
			)
	') or die "SQLite Fatal error: " . $self->dbh->errstr();

	####################################################################
	# USERS
	####################################################################
	$self->dbh->do('DROP TABLE IF EXISTS users');
	$self->dbh->do('CREATE TABLE users (
					id integer primary key,
					user_info json DEFAULT NULL
			)
	') or die "SQLite Fatal error: " . $self->dbh->errstr();
	
	return 1;
}

sub user_exists_in_db {
	my ($self, $user) = @_;
	my $user_id;

	my $href = $self->dbh->selectall_hashref( "SELECT * FROM users", 'id' );
	foreach my $id (keys %$href) {
		my $user_info = decode_josn($href->{$id}->{user_info});
		$user_id = $id if ($user_info->{username} eq $user);
	}

	return $user_id;
}

sub add_api_user_to_db {
	my ($self, $user_info) = @_;

	my $nb_inserted = $self->dbh->do( "INSERT INTO users (user_info) VALUES(".$self->dbh->quote(encode_json($user_info)).")" );

	return $nb_inserted; 
};

sub user_authorized {
	my ($self, $user, $api_key) = @_;

	my $user_id;
	
	my $href = $self->dbh->selectall_hashref( "SELECT * FROM users", 'id' );
	foreach my $id (keys %$href) {
		my $user_info = decode_josn($href->{$id}->{user_info});
		if ($user_info->{username} eq $user && $user_info->{api_key} eq $api_key) {
			$user_id = $id;
		}
	}

	return $user_id;
}

sub create_new_batch_job {
	my ($self, $username) = @_;

	my ($batch_id, $creaton_time) = $self->dbh->selectrow_array( "
			SELECT 
				batch_id, 
				batch_jobs.creation_time AS batch_creation_time 
			FROM 
				test_results 
			JOIN batch_jobs 
				ON batch_id=batch_jobs.id 
				AND username=".$self->dbh->quote($username).
			" WHERE 
				test_results.progress<>100
			LIMIT 1
			") ;
			
	die "You can't create a new batch job, job:[$batch_id] started on:[$creaton_time] still running " if ($batch_id);
	
	my ($new_batch_id) = $self->dbh->selectrow_array("INSERT INTO batch_jobs (username) VALUES(".$self->dbh->quote($username).") RETURNING id");

	return $new_batch_id;
}

sub create_new_test {
	my ($self, $domain, $test_params, $minutes_between_tests_with_same_params, $priority, $batch_id) = @_;
	my $result;

	$test_params->{domain} = $domain;
	my $js = JSON->new;
	$js->canonical(1);
	my $encoded_params = $js->encode($test_params);
	my $test_params_deterministic_hash = md5_hex($encoded_params);
	
	my $query = "INSERT INTO test_results (batch_id, priority, params_deterministic_hash, params) SELECT ".
				$self->dbh->quote($batch_id).", ".
				$self->dbh->quote(5).", ".
				$self->dbh->quote($test_params_deterministic_hash).", ".
				$self->dbh->quote($encoded_params).
				" WHERE NOT EXISTS (SELECT * FROM test_results WHERE params_deterministic_hash='$test_params_deterministic_hash' AND creation_time > datetime('now', '-$minutes_between_tests_with_same_params minute'))";
				
	my $nb_inserted = $self->dbh->do($query);
	
	($result) = $self->dbh->selectrow_array("SELECT MAX(id) AS id FROM test_results WHERE params_deterministic_hash='$test_params_deterministic_hash'");
	
	return $result;
}

sub test_progress {
	my($self, $test_id) = @_;
	
	my $result = 0;
	
	my $sth1 = $self->dbh->prepare("SELECT strftime('\%s', datetime('now')) - strftime('\%s', creation_time) AS t FROM test_results WHERE id=$test_id");
	$sth1->execute;
	if (my $h = $sth1->fetchrow_hashref) {
		my $time_from_test_start = ($h->{t}>60)?(60):($h->{t});
		$result = int($time_from_test_start/60*100);
	}

	return $result;
}

no Moose;
__PACKAGE__->meta()->make_immutable();

1;