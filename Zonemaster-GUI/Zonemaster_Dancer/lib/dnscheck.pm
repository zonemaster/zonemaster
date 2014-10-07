package dnscheck;
use Dancer ':syntax';
use Plack::Builder;
use PocketIO;
use Data::Dumper;
use Client;

no warnings;
our $VERSION = '0.1';
#my $url = 'http://zonemaster.rd.nic.fr:5000';
my $url = 'http://localhost:5000';

get '/' => sub {
  template 'index';
};

get '/ang/:file' => sub {
  template 'ang/'.param('file'),{},{layout => undef};
};

get '/test/:id' => sub {
  my $c = Client->new({url => $url });
  
  my $lang = request->{'accept_language'};
  $lang=~s/,.*$//;
  my $result = $c->get_test_results({ params, language=>$lang });
  template 'index', { result => to_json($result), {allow_blessed => 1, convert_blessed => 1}};
};

get '/parent' => sub {
  my $c = Client->new({url => $url });
  
  my $result = $c->get_data_from_parent_zone_1( param('domain') );
  debug Dumper($result);
  content_type 'application/json';
  return to_json ({ result => $result }, {allow_blessed => 1, convert_blessed => 1});
};

get '/version' => sub {
  my $c = Client->new({url => $url });
  
  my $result = $c->version_info({ });
  debug Dumper($result);
  content_type 'application/json';
  return to_json ({ result => $result . ", IP address: " . request->address }, {allow_blessed => 1, convert_blessed => 1});
};

get '/check_syntax' => sub {
  my $c = Client->new({url => $url });
  
  my $data = from_json(param('data')); 
  my $result = $c->validate_syntax({ %$data });
  content_type 'application/json';
  return to_json ({ result => $result }, {allow_blessed => 1, convert_blessed => 1});
};

get '/history' => sub {
  my $c = Client->new({url => $url });
  
  my $data = from_json(param('data')); 
  my $result = $c->get_test_history({ frontend_params => { %$data }, limit=>200, offset=>0 });
  content_type 'application/json';
  return to_json ({ result => $result }, {allow_blessed => 1, convert_blessed => 1});
};

get '/resolve' => sub {
  my $c = Client->new({url => $url });
  
  my $data = param('data'); 
  my $result = $c->get_ns_ips( $data );
  content_type 'application/json';
  return to_json ({ result => $result }, {allow_blessed => 1, convert_blessed => 1});
};

post '/run' => sub {
  my $c = Client->new({url => $url });
  
  my $data = from_json(param('data')); 
  my $job_id = $c->start_domain_test({ %$data });
  content_type 'application/json';
  return to_json ({ job_id => $job_id }, {allow_blessed => 1, convert_blessed => 1});
};

get '/progress' => sub {
  my $c = Client->new({url => $url });
  
  my $progress = $c->test_progress(param('id'));
  content_type 'application/json';
  return to_json ({ progress => $progress }, {allow_blessed => 1, convert_blessed => 1});
};

get '/result' => sub {
  my $c = Client->new({url => $url });
  
  my $result = $c->get_test_results({ params });
  content_type 'application/json';
  return to_json ({ result => $result }, {allow_blessed => 1, convert_blessed => 1});
};

true;
