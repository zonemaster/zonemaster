#!/home/toma/perl5/perlbrew/perls/perl-5.20.0/bin/perl -wT
use strict;
use warnings;
use CGI;
use Data::UUID;
use Data::Dumper;
use Carp;
use lib qw/ lib /;
use DataRecord;
use Environment;
use Page;
use Api;

my $cgi = CGI->new ;

return_bad_request('Invalid request') 
	unless(defined($ENV{HTTP_REFERER}) && length($ENV{HTTP_REFERER})); # only ajax calls allowed

my $action = $cgi->param('action');
	return_bad_request('Invalid action requested') unless defined($action) && length($action)
		&& scalar( grep {$_ eq $action} qw/ register retrieve modify retrieve_about retrieve_faq 
		fetch_test_history fetch_from_parent verify_domain verify_progress retrieve_report nameserver_ips / );

my $env = Environment->new ;
my $user_agent = $cgi->user_agent;
if($action eq 'register'){
	my $uuid = lc Data::UUID->new()->create_str();
	my $language = $cgi->param('language');
	my $function = $cgi->param('function');
	$function = 'delegated_domains' unless defined($function) && length($function); 
	$language = $env->{default_language} unless defined($language) && length($language);
    	my %uuid_hash = (
        	id           => $uuid,
        	language     => $language,
        	last_ip      => $env->remote_ip,
        	created      => $env->now,
        	last_updated => $env->now,
        	parameters   => ''
    	);

    	my $session = DataRecord->new( $env, 'Session' )->clone(%uuid_hash);
    	$session->insert(%uuid_hash);

	print $cgi->header( 'application/json', '200 Ok' );
	print "{\"uuid\":\"$uuid\",\"language\":\"$language\",\"function\":\"$function\"}";
}
elsif($action eq 'retrieve'){
	my $uuid = $cgi->param('session_uuid');
	my $language = $cgi->param('language');
	$language = $env->{default_language} unless defined($language) && length($language);
	my $function = $cgi->param('function');
	$function = 'delegated_domains' unless defined($function) && length($function); 
	$uuid = lc Data::UUID->new()->create_str() unless defined($uuid) && length($uuid);
	my $UUID = DataRecord->new($env, 'Session', $uuid);
	if($UUID->id){
		$language = $UUID->language if $UUID->language;
		$function = $UUID->function if $UUID->function;
		$uuid = $UUID->id;
	} else {
    		my %uuid_hash = (
        		id           => $uuid,
        		language     => $language,
        		function     => $function,
        		last_ip      => $env->remote_ip,
        		created      => $env->now,
        		last_updated => $env->now,
        		parameters   => ''
    		);

    		my $session = DataRecord->new( $env, 'Session' )->clone(%uuid_hash);
    		$session->insert(%uuid_hash);
	}
	print $cgi->header( 'application/json', '200 Ok' );
	print "{\"uuid\":\"$uuid\",\"language\":\"$language\",\"function\":\"function\"}";
}
elsif($action eq 'modify'){
	my $uuid = $cgi->param('session_uuid');
	my $language = $cgi->param('language');
	$language = $env->{default_language} unless defined($language) && length($language);
	my $function = $cgi->param('function');
	$function = 'delegated_domains' unless defined($function) && length($function); 
	$uuid = lc Data::UUID->new()->create_str() unless defined($uuid) && length($uuid);
	my $UUID = DataRecord->new($env, 'Session', $uuid);
	if($UUID->id){
		$UUID->language($language);
		$UUID->function($function);
		$UUID->last_updated($env->now);
		$UUID->last_ip($env->remote_ip);
		$UUID->save ;
		$uuid = $UUID->id;
	} else {
    		my %uuid_hash = (
        		id           => $uuid,
        		language     => $language,
        		function     => $function,
        		last_ip      => $env->remote_ip,
        		created      => $env->now,
        		last_updated => $env->now,
        		parameters   => ''
    		);

    		my $session = DataRecord->new( $env, 'Session' )->clone(%uuid_hash);
    		$session->insert(%uuid_hash);
	}
	print $cgi->header( 'application/json', '200 Ok' );
	print "{\"uuid\":\"$uuid\",\"language\":\"$language\",\"function\":\"$function\"}";
}
elsif($action eq 'verify_domain'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $testing_domain = $cgi->param('testing_domain');
	return_bad_request('Invalid domain string') 
		unless defined($testing_domain) && length($testing_domain);
        my $api = Api->new($env) ;
	unless($api->validate_domain($testing_domain)){
		return_bad_request('Domain validation failed for domain: ' . $testing_domain);
        }
	my $testing_parameters = {domain => $testing_domain};
	my $adv_option = $cgi->param('adv_option');
	$adv_option = 0 unless defined($adv_option) && length($adv_option);
	if($adv_option){
		$testing_parameters->{advanced_options} = $adv_option;
		$testing_parameters->{ipv4} = $cgi->param('ipv4');
		$testing_parameters->{ipv6} = $cgi->param('ipv6');
		$testing_parameters->{test_profile} = $cgi->param('test_prof');
	} 
	if($function eq 'un_delegated_domains'){
		$testing_parameters->{nameservers} = [];
		$testing_parameters->{ds_digest_pairs} = [];
		my @cgi_params = $cgi->param;
		if(scalar grep {$_ =~ m/ns_ip_pairs/} @cgi_params){
			$testing_parameters->{nameservers} = [];
			foreach my $k (0 .. 32){
				my $ns_val = $cgi->param('ns_ip_pairs[' . $k . '][ns]');
				my $ip_val = $cgi->param('ns_ip_pairs[' . $k . '][ip]');
				if(defined($ns_val) && defined($ip_val) && length($ns_val) && length($ip_val)){
					push(@{$testing_parameters->{nameservers}}, {$ns_val => $ip_val});
				}
			}	
			
		}
		if(scalar grep {$_ =~ m/ds_dig_pairs/} @cgi_params){
			$testing_parameters->{ds_digest_pairs} = [];
			foreach my $k (0 .. 32){
				my $ds_val = $cgi->param('ds_dig_pairs[' . $k . '][ds]');
				my $dig_val = $cgi->param('ds_dig_pairs[' . $k . '][dig]');
				if(defined($ds_val) && defined($dig_val) && length($ds_val) && length($dig_val)){
					push(@{$testing_parameters->{ds_digest_pairs}}, {$ds_val => $dig_val});
				}
			}			
		}
	} 
	my $test_id = $api->start_domain_test($testing_parameters);
	my $dictionary ;
	if($language eq 'fr'){
		$dictionary = $env->load_dictionary('french');
	}
	elsif($language eq 'sv'){
		$dictionary = $env->load_dictionary('swedish');
	}
	else{
		$dictionary = $env->load_dictionary('english');
	}
	print $cgi->header( 'application/json', '200 Ok' );
	print "{\"message\":\"" . $dictionary->{processing_domain_test} . 
		" $testing_domain\",\"test_id\":\"$test_id\"}";
}
elsif($action eq 'verify_progress'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $testing_id = $cgi->param('testing_id');
	return_bad_request('Invalid test id') 
		unless defined($testing_id) && length($testing_id);
        my $api = Api->new($env) ;
	my $test_progress = $api->test_progress($testing_id);
	print $cgi->header( 'application/json', '200 Ok' );
	print "{\"message\":\"$test_progress\",\"test_id\":\"$testing_id\"}";
}
elsif($action eq 'nameserver_ips'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $nameserver = $cgi->param('nameserver');
	return_bad_request('Invalid nameserver') 
		unless defined($nameserver) && length($nameserver);
        my $api = Api->new($env) ;
	my @nameserver_ips = $api->get_ns_ips($nameserver);
	print $cgi->header( 'application/json', '200 Ok' );
	print JSON->new()->encode(\@nameserver_ips);
}
elsif($action eq 'fetch_from_parent'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $domain = $cgi->param('domain');
	return_bad_request('Invalid domain name to fetch from parent zone') 
		unless defined($domain) && length($domain);
	my @chunks = split /\./, $domain;
	my $parent_zone = $chunks[$#chunks - 1] . '.' . $chunks[$#chunks];
        my $api = Api->new($env) ;
	my @nameservers_ips = $api->get_data_from_parent_zone($parent_zone);
	print $cgi->header( 'application/json', '200 Ok' );
	print JSON->new()->encode(\@nameservers_ips);
}
elsif($action eq 'fetch_test_history'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $domain = $cgi->param('domain');
	return_bad_request('Invalid domain name to fetch from parent zone') 
		unless defined($domain) && length($domain);
        my $api = Api->new($env) ;
	my @test_history = $api->get_test_history({domain => $domain});
	unless(scalar @test_history){
		my $dictionary ;
		if($language eq 'fr'){
        		$dictionary = $env->load_dictionary('french');
		}
		elsif($language eq 'sv'){
        		$dictionary = $env->load_dictionary('swedish');
		}
		else{
        		$dictionary = $env->load_dictionary('english');
		}
		my $page = Page->new($env, $cgi, 'history.html.tmpl');
		print $cgi->header( -type => 'text/html', -status => '200 Ok', -charset => 'UTF-8' );
		eval { $page->template->process( $page->template_file, {
			no_results => $dictionary->{no_results_for}, 
			language => $language,  
			domain => $domain, function => $function, uuid => $uuid},
			\*STDOUT, {binmode => ':utf8'} ) };
		croak 'Failed to ptocess template: ' . $@ if $@;
	}
	else{
		my %test_history;
		my %test_advanced;
		my %test_pages;
		my $index = 0;
		foreach my $rec (sort {$b->{id} cmp $a->{id}} @test_history){
			$test_history{$rec->{id}} = $rec->{creation_time};
			$test_advanced{$rec->{id}} = $rec->{advanced_options} || 0;
			$test_pages{$rec->{id}} = int(($index + 1.0e-8) / 10. );
			$index++;
		}
		my $total_pages = 1 + int(($index + 1.0e-8 - 1.) / 10. );
		my $page = Page->new($env, $cgi, 'history.html.tmpl');
		my $local_cgi_url; 
		if( $env->{cgi_url} =~ m/(\/cgi-bin.+)/ ){
			$local_cgi_url = $1;
		}
		$local_cgi_url =~ s/\/$//;
		$local_cgi_url = '/Zonemaster';

		print $cgi->header( -type => 'text/html', -status => '200 Ok', -charset => 'UTF-8' );
		eval { $page->template->process( $page->template_file, {history => \%test_history, 
			advanced_options => \%test_advanced, pages => \%test_pages, 
			total_pages => $total_pages,
			local_cgi_prefix => $local_cgi_url, language => $language, 
			domain => $domain, function => $function, uuid => $uuid}, 
			\*STDOUT, {binmode => ':utf8'} ) };
		croak 'Failed to ptocess template: ' . $@ if $@;
	}
}
elsif($action eq 'retrieve_report'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $testing_id = $cgi->param('testing_id');
	return_bad_request('Invalid test id') 
		unless defined($testing_id) && length($testing_id);
	$language = 'en' if $language =~ m/^en/i;
        my $api = Api->new($env) ;
	my $test_results = $api->get_test_results({id => $testing_id, language => $language});
	my @results = @{$test_results->{results}};
	my $results;
	my $statuses;
	my $status = {};
	foreach (qw/ ADDRESS BASIC CONNECTIVITY CONSISTENCY 
		DELEGATION HOSTNAME NAMESERVER SYNTAX ZONE /){
		$status->{$_} = 'gray';
	}
	foreach my $result (@results){
		my $key = delete $result->{'module'};
		my $level = $key eq 'NAMESERVER' ? $result->{'level'} : delete $result->{'level'};
		$results->{$key} = [] unless defined($results->{$key}) && ref($results->{$key});
		$statuses->{$key} = [] unless defined($statuses->{$key}) && ref($statuses->{$key});
		push(@{$results->{$key}}, $result);
		push(@{$statuses->{$key}}, $level);
	}
	foreach my $key (keys %$statuses){
		if(scalar grep { $_ =~ m/error/i } @{$statuses->{$key}}){
			$status->{$key} = 'red';
		}
		elsif(scalar grep { $_ =~ m/warning/i } @{$statuses->{$key}}){
			$status->{$key} = 'orange';
		}
		else{
			$status->{$key} = 'green';
		}
	}
	my $ns_details = {};
	my $ns_statuses = {};
	if ($results->{NAMESERVER}) {
		for(my $k = 0; $k < scalar @{$results->{NAMESERVER}}; $k++){
			my $ns = delete $results->{NAMESERVER}[$k]{ns};
			my $st = delete $results->{NAMESERVER}[$k]{level};
			$ns_details->{$ns} = [] unless defined($ns_details->{$ns}) && ref($ns_details->{$ns});
			$ns_statuses->{$ns} = [] unless defined($ns_statuses->{$ns}) && ref($ns_statuses->{$ns});
			push @{$ns_details->{$ns}}, $results->{NAMESERVER}[$k];
			push @{$ns_statuses->{$ns}}, $st;
		}
	}
	my $dictionary ;
	if($language eq 'fr'){
		$dictionary = $env->load_dictionary('french');
	}
	elsif($language eq 'sv'){
		$dictionary = $env->load_dictionary('swedish');
	}
	else{
		$dictionary = $env->load_dictionary('english');
	}
	my $page = Page->new($env, $cgi, 'report.html.tmpl');
	print $cgi->header( -type => 'text/html', -status => '200 Ok', -charset => 'UTF-8' );
	eval { $page->template->process( $page->template_file, {report => $results, status => $status, 
		statuses => $statuses, test_id => $test_results->{id}, 
		creation_time => $test_results->{creation_time}, ns_details => $ns_details, 
		dictionary => $dictionary, uuid => $uuid, cgi_url => $env->{cgi_url}, ns_statuses => $ns_statuses}, 
		\*STDOUT, {binmode => ':utf8'}) };
	croak 'Failed to ptocess template: ' . $@ if $@;
}
elsif($action eq 'retrieve_faq'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $template_file = 'faq_en.html.tmpl';
	if($language eq 'fr'){
		$template_file = 'faq_fr.html.tmpl';
	}
	elsif($language eq 'sv'){
		$template_file = 'faq_sv.html.tmpl';
	}
	my $page = Page->new($env, $cgi, $template_file);
	print $cgi->header( -type => 'text/html', -status => '200 Ok', -charset => 'UTF-8' );
	eval { $page->template->process( $page->template_file, {}, \*STDOUT, {binmode => ':utf8'} ) };
	croak 'Failed to ptocess template: ' . $@ if $@;
}
elsif($action eq 'retrieve_about'){
	my($uuid, $language, $function) = check_mandatory_entries();
	my $template_file = 'about_en.html.tmpl';
	if($language eq 'fr'){
		$template_file = 'about_fr.html.tmpl';
	}
	elsif($language eq 'sv'){
		$template_file = 'about_sv.html.tmpl';
	}
	my $page = Page->new($env, $cgi, $template_file);
	print $cgi->header( -type => 'text/html', -status => '200 Ok', -charset => 'UTF-8' );
	eval { $page->template->process( $page->template_file, {}, \*STDOUT, {binmode => ':utf8'} ) };
	croak 'Failed to ptocess template: ' . $@ if $@;
}
sub check_mandatory_entries {
	my $uuid = $cgi->param('session_uuid');
	my $language = $cgi->param('language');
	$language = $env->{default_language} unless defined($language) && length($language);
	my $function = $cgi->param('function');
	$function = 'delegated_domains' unless defined($function) && length($function); 
	my $UUID = DataRecord->new($env, 'Session', $uuid);
		return_bad_request('Invalid session') unless $UUID->id; 
	return ($UUID->id, $language, $function);
}

sub return_bad_request {
    my $message = shift;
    $message = 'Unrecognized error' unless defined($message) && length($message);
    print $cgi->header( 'application/json', '400 Bad request' );
    print "{\"error\":\"$message\"}";
    exit(0);
}
