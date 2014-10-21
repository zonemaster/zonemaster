package Api;
use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Carp;
use Encode;

use constant { JSONRPC => '2.0', CLIENTID => 'Zonemaster CGI/DNS/SESSION.CGI', CLIENTVERSION => '1.0' };

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;
    my $self  = {};
    $self->{env} = shift;
    croak 'Invalid environment passed'
	unless defined($self->{env}) && ref($self->{env});
    $self->{ua} = 
	LWP::UserAgent->new( agent => 'Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0' );	
    bless $self, $class;
}

sub env {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    return unless defined($self->{env}) && ref($self->{env});
    return $self->{env};
}

sub ua {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    return unless defined($self->{ua}) && ref($self->{ua});
    return $self->{ua};
}

sub call {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    croak 'Invalid user agent'
    	unless defined($self->{ua}) && ref($self->{ua});
    my $request_content = shift;
    croak 'Invalid request content'
    	unless defined($request_content) && ref($request_content);
    my $response = $self->ua->post($self->env->{api_url},    
			Content_Type => 'application/json',
                        Content => encode('utf-8', JSON->new()->encode($request_content)));
    my $response_content ;
    eval{
	$response_content = JSON->new()->decode($response->{_content})
    };
    return {error => @_, content => $response->{_content} } if @_;
    return {status => $response->{_rc}, content => $response_content };	
}

sub get_ns_ips {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $ns_domain       = shift;
    croak 'Invalid nameserver domain passed'
	unless defined($ns_domain) && length($ns_domain);
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => "$ns_domain", method => "get_ns_ips"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';
    return unless defined($call->{content}{result}) && ref($call->{content}{result}); 			
    my @result = grep {$_ ne '0.0.0.0'} map {$_->{$ns_domain}} @{$call->{content}{result}};	
    return unless scalar @result;
    return @result if wantarray;
    return \@result;	
}

sub get_data_from_parent_zone {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $zone       = shift;
    croak 'Invalid parent zone passed'
	unless defined($zone) && length($zone);
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => "$zone", method => "get_data_from_parent_zone"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';
    return unless defined($call->{content}{result}) && ref($call->{content}{result}); 			
    my @result;	
    foreach my $res (@{$call->{content}{result}}){
	foreach (keys %$res){
		next if $res->{$_} eq '0.0.0.0';
		push(@result, {$_ => $res->{$_}});
	}
    
    }	
    return unless scalar @result;
    return @result if wantarray;
    return \@result;	
}

sub validate_domain {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $domain       = shift;
    croak 'Invalid domain passed'
	unless defined($domain) && length($domain);
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => "$domain", method => "validate_domain_syntax"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return 1 if(defined($call->{content}{result}) && $call->{content}{result} eq 'syntax_ok');
    return;
}

sub version_info {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), params => "", method => "version_info"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return $call->{content}{result};
}

sub test_progress {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $test_id       = shift;
    croak 'Invalid test id passed'
	unless defined($test_id) && length($test_id);
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => $test_id, method => "test_progress"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return $call->{content}{result} if(defined($call->{content}{result}) && length($call->{content}{result}));
    return;
}

sub get_test_results {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $test_params       = shift;
    croak 'Invalid test parameters passed'
	unless defined($test_params) && ref($test_params);
    croak 'Invalid test id to process results'
	unless defined($test_params->{id}) && length($test_params->{id});
    $test_params->{language} = 'en' unless 
		defined($test_params->{language}) && length($test_params->{language});	
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => $test_params, method => "get_test_results"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return unless defined(defined($call->{content}{result}) && ref($call->{content}{result}));
    return {results => $call->{content}{result}{results}, id => $call->{content}{result}{id},
		creation_time => $call->{content}{result}{creation_time}};
}

sub get_complete_test_results {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $test_params       = shift;
    croak 'Invalid test parameters passed'
	unless defined($test_params) && ref($test_params);
    croak 'Invalid test id to process results'
	unless defined($test_params->{id}) && length($test_params->{id});
    $test_params->{language} = 'en' unless 
		defined($test_params->{language}) && length($test_params->{language});	
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => $test_params, method => "get_test_results"});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return unless defined(defined($call->{content}{result}) && ref($call->{content}{result}));
    return $call->{content};
}

sub start_domain_test {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $params       = shift;
    croak 'Invalid parameters to start domain test'
	unless defined($params) && ref($params);
    croak 'No valid domain passed to start domain test'
	unless defined($params->{domain}) && length($params->{domain});
    $params->{client_version} = CLIENTVERSION;	
    $params->{client_id} = CLIENTID;	
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => $params,
				method => "start_domain_test"}
				);
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return $call->{content}{result} if(defined($call->{content}{result}) && length($call->{content}{result}));
    return;

}

sub get_test_history {
    my $self       = shift;
    croak 'Invalid object passed'
	unless defined($self) && ref($self);
    my $params       = shift;
    croak 'Invalid parameters to retrieve test history'
	unless defined($params) && ref($params);
    croak 'No valid domain passed to start domain test'
	unless defined($params->{domain}) && length($params->{domain});
    my $call = $self->call({jsonrpc => JSONRPC, id => random_id(), 
				params => { 
					frontend_params => {
						client_version => CLIENTVERSION,
						client_id => CLIENTID,
						domain => $params->{domain}
						},
					limit => 1000,
					offset => 0
					}, method => 'get_test_history'
				});
    carp 'Call failed with error: ' . $call->{error} if $call->{error};			
    carp 'Call returned erroneous status: ' . $call->{status} unless $call->{status} eq '200';			
    return unless defined(defined($call->{content}{result}) && ref($call->{content}{result}));
    return @{$call->{content}{result}} if wantarray;
    return $call->{content}{result};
}

sub random_id {
	return 1 + int(999999999. * rand());
}

1;	
	
