package dnscheck;

use Dancer ':syntax';
use Plack::Builder;
use Data::Dumper;
use Encode;
use Text::Markdown 'markdown';
use File::Slurp;

use Client;

use FindBin qw($RealScript $Script $RealBin $Bin);
##################################################################
my $PROJECT_NAME = "Zonemaster-GUI/Zonemaster_Dancer";

my $SCRITP_DIR = __FILE__;
$SCRITP_DIR = $Bin unless ($SCRITP_DIR =~ /^\//);

#warn "SCRITP_DIR:$SCRITP_DIR\n";
#warn "RealScript:$RealScript\n";
#warn "Script:$Script\n";
#warn "RealBin:$RealBin\n";
#warn "Bin:$Bin\n";
#warn "__PACKAGE__:".__PACKAGE__;
#warn "__FILE__:".__FILE__;

my ($PROD_DIR) = ($SCRITP_DIR =~ /(.*?\/)$PROJECT_NAME/);
#warn "PROD_DIR:$PROD_DIR\n";

my $PROJECT_BASE_DIR = $PROD_DIR.$PROJECT_NAME."/";
#warn "PROJECT_BASE_DIR:$PROJECT_BASE_DIR\n";
unshift(@INC, $PROJECT_BASE_DIR);
##################################################################

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
  content_type 'application/json';
  my $ip = request->address;
  $ip =~ s/::ffff:// if ($ip =~ /::ffff:/);
  return to_json ({ result => $result . ", IP address: $ip" }, {allow_blessed => 1, convert_blessed => 1});
};

get '/check_syntax' => sub {
  my $c = Client->new({url => $url });
  
  my $data = from_json(encode_utf8(param('data'))); 
  my $result = $c->validate_syntax({ %$data });
  content_type 'application/json';
  return to_json ({ result => $result }, {allow_blessed => 1, convert_blessed => 1});
};

get '/history' => sub {
  my $c = Client->new({url => $url });
  
  my $data = from_json(encode_utf8(param('data'))); 
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
  
  my $data = from_json(encode_utf8(param('data'))); 
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

get '/faq' => sub {
	my %allparams = params;
	$allparams{lang} =~ s/sw/sv/;
	my $md = read_file("$PROD_DIR/docs/documentation/gui-faq-$allparams{lang}.md");
	my $html = decode_utf8(markdown($md));
	return to_json ({ FAQ_CONTENT => $html }, {allow_blessed => 1, convert_blessed => 1});
};

true;
