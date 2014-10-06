package ZonemasterDB v0.0.1;
use Moose::Role;

use utf8;
use 5.14.0;

use Data::Dumper;

requires 'add_api_user_to_db', 'user_exists_in_db', 'user_authorized', 'test_progress', 'test_results', 'create_new_batch_job', 'create_new_test', 'get_test_params', 'get_test_history';

sub user_exists {
	my ($self, $user) = @_;
	say __PACKAGE__."::user_exists";
	say Dumper($self);
	
	die "username not provided to the method user_exists\n" unless ($user);

	return $self->user_exists_in_db($user);
}

sub add_api_user {
	my ($self, $params) = @_;
	say __PACKAGE__."::add_api_user";

	die "username or api_key not provided to the method add_api_user\n" unless ($params->{username} && $params->{api_key});
	
	die "User already exists\n" if ( $self->user_exists($params->{username}) );
	
	my $result = $self->add_api_user_to_db($params);
	
	die "add_api_user_to_db not successfull" unless($result);
	
	return $result;
}

no Moose::Role;

1;