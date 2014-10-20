use strict;
use warnings;
use utf8;
use 5.14.0;

use JSON::RPC::Dispatch;
use Router::Simple::Declare;
use Data::Dumper;
use JSON;
use POSIX;
use FindBin;

use Plack::Builder;

local $| = 1;

builder {
	enable 'Debug',
};

my $router = router {
############## FRONTEND ####################
	connect "version_info" => {
		handler => "+Engine",
		action => "version_info"
	};

	connect "get_ns_ips" => {
		handler => "+Engine",
		action => "get_ns_ips"
	};

	connect "get_data_from_parent_zone" => {
		handler => "+Engine",
		action => "get_data_from_parent_zone"
	};

	connect "get_data_from_parent_zone_1" => {
		handler => "+Engine",
		action => "get_data_from_parent_zone_1"
	};

	connect "validate_syntax" => {
		handler => "+Engine",
		action => "validate_syntax"
	};
	
	connect "start_domain_test" => {
		handler => "+Engine",
		action => "start_domain_test"
	};
	
	connect "test_progress" => {
		handler => "+Engine",
		action => "test_progress"
	};
	
	connect "get_test_params" => {
		handler => "+Engine",
		action => "get_test_params"
	};

	connect "get_test_results" => {
		handler => "+Engine",
		action => "get_test_results"
	};

	connect "get_test_history" => {
		handler => "+Engine",
		action => "get_test_history"
	};

############ BATCH MODE ####################

	connect "add_api_user" => {
		handler => "+Engine",
		action => "add_api_user"
	};
	
############################################
	connect "api1" => {
		handler => "+Engine",
		action => "api1"
	};
};

my $dispatch = JSON::RPC::Dispatch->new(
	router => $router,
);

sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    eval {
		say '-----------------------------------------------------------------------------------------';
		my $json = $req->content;
		my $content = decode_json($json);
		say "[".strftime("%F %T", localtime())."][IP:".$env->{REMOTE_ADDR}."][id:".$content->{id}."][method:".$content->{method}."]";
		say $json;
	};
    
    $dispatch->handle_psgi($env, $env->{REMOTE_HOST} );
};
