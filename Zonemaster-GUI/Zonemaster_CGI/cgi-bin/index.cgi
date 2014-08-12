#!/home/toma/perl5/perlbrew/perls/perl-5.20.0/bin/perl -wT
use strict;
use warnings;
use CGI;
use Carp;
use lib qw/ lib /;
use Api;
use Environment;
use Page;
use DataRecord;

use constant IndexPageHeader => {
    header => {
        -style => { -src => '/css/dnscheckup.css' },
        -script => [ { -src => '/js/jquery.js' }, { -src => '/js/dnscheckup.js' } ],
        -title => 'Online DNS checkup',
	-encoding => 'utf-8',
    }
};
my $cgi = CGI->new;
my $env = Environment->new();
my $uuid;

my $test_id = $cgi->param('test_id');
if($env->is_post_request && defined($test_id) && length($test_id)){
	my $content = $cgi->param('unformated_input');
	my $uuid = $cgi->param('uuid');
    	print $cgi->header( 'text/plain', '400 Bad request' ) unless 
		defined($content) && defined($uuid) && length($content) && length($uuid);
	if($content && $uuid){
		my $UUID = DataRecord->new($env, 'Session', $uuid);
		unless($UUID->id){
    			print $cgi->header( 'text/plain', '400 Bad request' );
		}
		else{
			my @content;
			while($content =~ m/__INPUT_ITEM__START(.*?)END__INPUT_ITEM__/g){
				push @content, $1;
			}
    			print $cgi->header( 'text/plain', '200 Ok' ); 
			print 'Test id: ' . $test_id . "\n\n";
			foreach(@content){
				$_ =~ s/^\s+|\s+$//sg;
				next unless length ;
				$_ =~ s/__INPUT_ITEM__START//g;
				$_ =~ s/END__INPUT_ITEM__//g;
				if($_ =~ m/[^A-Z]/){
					print ' ' . $_ . "\n";
				}
				else{
					print "\n" . $_ . "\n";
				}
			}
		}
	}
	exit(0);
}

if(defined($ENV{HTTP_COOKIE}) && length($ENV{HTTP_COOKIE}) && 
	($ENV{HTTP_COOKIE} =~ m/uuid=([0-9a-f\-]+)/)){
		$uuid = $1;
}
elsif($ENV{'REQUEST_URI'} =~ m/\/(([0-9a-f]+\-){4}[0-9a-f]+)\// ){
		$uuid = $1;
}

my $language = $env->{default_language};
if(defined($ENV{HTTP_ACCEPT_LANGUAGE}) && length($ENV{HTTP_ACCEPT_LANGUAGE})){
	if($ENV{HTTP_ACCEPT_LANGUAGE} =~ m/sv/){
		$language = 'sv';
	}
	elsif($ENV{HTTP_ACCEPT_LANGUAGE} =~ m/fr/){
		$language = 'fr';
	}
}
my $function = 'delegated_domains';
if(defined($uuid) && length($uuid)){ 
	my $session = DataRecord->new($env, 'Session', $uuid);
	$language = $session->language if $session->id && $session->language;
	$function = $session->function if $session->id && $session->function;
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
my $local_cgi_url; 
if( $env->{cgi_url} =~ m/(\/cgi-bin.+)/ ){
	$local_cgi_url = $1;
}
$local_cgi_url =~ s/\/$//;
$local_cgi_url = '/Zonemaster';

my $version_info = Api->new($env)->version_info();
carp 'Failed to retrieve version information from api:' . $env->{api_url} 
	unless defined($version_info) && length($version_info);
my $remote_addr = $env->remote_ip ;
my $preset_test_id = $cgi->param('test_id');
unless(defined($preset_test_id) && length($preset_test_id)){ 
	my $page = Page->new( $env, $cgi, 'index.html.tmpl', IndexPageHeader->{header} );
	$page->render({language => $language, function => $function, uuid => $uuid,
		version_info => $version_info, remote_addr => $remote_addr, 
		dictionary => $dictionary, local_cgi_url => $local_cgi_url});
	$page->finalize ;
}
else {
	my $lang = $language =~ m/^en/i ? 'en' : $language;
	my $test_results = Api->new($env)->get_complete_test_results({id => $preset_test_id, language => $lang});
	my $preseting = $test_results->{result}{params};
	$preseting->{function} = 'delegated_domains';
	if(defined($preseting->{nameservers}) && ref($preseting->{nameservers})){
		$preseting->{function} = 'un_delegated_domains'; 
	}
	$function = $preseting->{function};
	if(defined($preseting->{advanced_options}) && $preseting->{advanced_options}){
		$preseting->{uncheck_ipv4} = $preseting->{ipv4} ? 0 : 1;
		$preseting->{uncheck_ipv6} = $preseting->{ipv6} ? 0 : 1;
	} 
	if(defined($test_results->{result}{params}{nameservers}) && 
		ref($test_results->{result}{params}{nameservers})){
		my $index = 29;
		$preseting->{ns_ip_pair} = {};
		$preseting->{ns_value} = {};
		$preseting->{ip_value} = {};
		foreach my $ns (@{$test_results->{result}{params}{nameservers}}){
			$preseting->{ns_ip_pair}{$index} = 1;
			foreach my $ky (keys %$ns){
				$preseting->{ns_value}{$index} = $ky;
				$preseting->{ip_value}{$index} = $ns->{$ky};
			}
			$index--;
		}
	}
	if(defined($test_results->{result}{params}{ds_digest_pairs}) && 
		ref($test_results->{result}{params}{ds_digest_pairs})){
		my $index = 29;
		$preseting->{ds_dig_pair} = {};
		$preseting->{ds_value} = {};
		$preseting->{dig_value} = {};
		foreach my $ns (@{$test_results->{result}{params}{ds_digest_pairs}}){
			$preseting->{ds_dig_pair}{$index} = 1;
			foreach my $ky (keys %$ns){
				$preseting->{ds_value}{$index} = $ky;
				$preseting->{dig_value}{$index} = $ns->{$ky};
			}
			$index--;
		}
	}
	$preseting->{test_id} = $preset_test_id;
	my $page = Page->new( $env, $cgi, 'index.html.tmpl', IndexPageHeader->{header} );
	$page->render({language => $language, function => $function, uuid => $uuid,
		version_info => $version_info, remote_addr => $remote_addr, 
		dictionary => $dictionary, local_cgi_url => $local_cgi_url, preseting => $preseting});
	$page->finalize ;
}

