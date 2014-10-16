use strict;
use warnings;
use 5.10.1;

use Data::Dumper;
use Test::More;   # see done_testing()
use threads;

use FindBin qw($RealScript $Script $RealBin $Bin);
FindBin::again();
##################################################################
my $PROJECT_NAME = "Zonemaster-Backend/t";

my $SCRITP_DIR = __FILE__;
$SCRITP_DIR = $Bin unless ($SCRITP_DIR =~ /^\//);

#warn "SCRITP_DIR:$SCRITP_DIR\n";
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

unshift(@INC, $PROD_DIR."Zonemaster-Backend/JobRunner") unless $INC{$PROD_DIR."Zonemaster-Backend/JobRunner"};

# Require Engine.pm test
require_ok( 'Engine' );
#require Engine;

# Create Engine object
my $engine = Engine->new({ db => 'ZonemasterDB::SQLite'} );
isa_ok($engine, 'Engine');

# create a new memory SQLite database
ok($engine->{db}->create_db());

# add test user
ok($engine->add_api_user({username => "zonemaster_test", api_key => "zonemaster_test's api key"}) == 1);
ok(scalar($engine->{db}->dbh->selectrow_array(q/SELECT * FROM users WHERE user_info like '%zonemaster_test%'/)) == 1);

# add a new test to the db
my $frontend_params_1 = {
        client_id => 'Zonemaster CGI/Dancer/node.js', # free string
        client_version => '1.0',                        # free version like string
        
        domain => 'afnic.fr',                         # content of the domain text field
        advanced_options => 1,                          # 0 or 1, is the advanced options checkbox checked
        ipv4 => 1,                                                      # 0 or 1, is the ipv4 checkbox checked
        ipv6 => 1,                                                      # 0 or 1, is the ipv6 checkbox checked
        test_profile => 'test_profile_1',       # the id if the Test profile listbox
        nameservers => [                                        # list of the namaserves up to 32
                { ns => 'ns1.nic.fr', ip => '1.2.3.4'},                   # key values pairs representing nameserver => namesterver_ip
                { ns => 'ns2.nic.fr', ip => '192.134.4.1'},
        ],
        ds_digest_pairs => [                            # list of DS/Digest pairs up to 32
                {'ds1' => 'ds-test1'},                   # key values pairs representing ds => digest
                {'ds2' => 'digest2'},                   
        ],
};
ok($engine->start_domain_test($frontend_params_1) == 1);
ok(scalar($engine->{db}->dbh->selectrow_array(q/SELECT id FROM test_results WHERE id=1/)) == 1);

# test test_progress API
ok($engine->test_progress(1) == 0);

require_ok('Runner');
threads->create( sub { Runner->new({ db => 'ZonemasterDB::SQLite'} )->run(1); } )->detach();

sleep(5);
ok($engine->test_progress(1) > 0);

foreach my $i (1..12) {
	sleep(5);
	my $progress = $engine->test_progress(1);
	print STDERR "pregress: $progress\n";
	last if ($progress == 100);
}
ok($engine->test_progress(1) == 100);
my $test_results = $engine->get_test_results({ id => 1, language => 'fr-FR' });
ok(defined $test_results->{id});
ok(defined $test_results->{params});
ok(defined $test_results->{creation_time});
ok(defined $test_results->{results});
ok(scalar(@{$test_results->{results}}) > 1);

my $frontend_params_2 = {
        client_id => 'Zonemaster CGI/Dancer/node.js', # free string
        client_version => '1.0',                        # free version like string
        
        domain => 'afnic.fr',                         # content of the domain text field
        advanced_options => 1,                          # 0 or 1, is the advanced options checkbox checked
        ipv4 => 1,                                                      # 0 or 1, is the ipv4 checkbox checked
        ipv6 => 1,                                                      # 0 or 1, is the ipv6 checkbox checked
        test_profile => 'test_profile_1',       # the id if the Test profile listbox
        nameservers => [                                        # list of the namaserves up to 32
                { ns => 'ns1.nic.fr', ip => '1.2.3.4'},                   # key values pairs representing nameserver => namesterver_ip
                { ns => 'ns2.nic.fr', ip => '192.134.4.1'},
        ],
        ds_digest_pairs => [                            # list of DS/Digest pairs up to 32
                { algorithm => 'ds1', digest => 'ds-test1'},                   
                { algorithm => 'ds2', digest => 'ds-test2'},                   
        ],
};
ok($engine->start_domain_test($frontend_params_2) == 2);
ok(scalar($engine->{db}->dbh->selectrow_array(q/SELECT id FROM test_results WHERE id=2/)) == 2);

# test test_progress API
ok($engine->test_progress(2) == 0);

require_ok('Runner');
threads->create( sub { Runner->new({ db => 'ZonemasterDB::SQLite'} )->run(2); } )->detach();

sleep(5);
ok($engine->test_progress(2) > 0);

foreach my $i (1..12) {
	sleep(5);
	my $progress = $engine->test_progress(2);
	print STDERR "pregress: $progress\n";
	last if ($progress == 100);
}
ok($engine->test_progress(2) == 100);
$test_results = $engine->get_test_results({ id => 1, language => 'fr-FR' });
ok(defined $test_results->{id});
ok(defined $test_results->{params});
ok(defined $test_results->{creation_time});
ok(defined $test_results->{results});
ok(scalar(@{$test_results->{results}}) > 1);


my $frontend_params_3 = {
        client_id => 'Zonemaster CGI/Dancer/node.js', # free string
        client_version => '1.0',                        # free version like string
        
        domain => 'nic.fr',                         # content of the domain text field
        advanced_options => 1,                          # 0 or 1, is the advanced options checkbox checked
        ipv4 => 1,                                                      # 0 or 1, is the ipv4 checkbox checked
        ipv6 => 1,                                                      # 0 or 1, is the ipv6 checkbox checked
        test_profile => 'test_profile_1',       # the id if the Test profile listbox
        nameservers => [                                        # list of the namaserves up to 32
                { ns => 'ns1.nic.fr', ip => '1.2.3.4'},                   # key values pairs representing nameserver => namesterver_ip
                { ns => 'ns2.nic.fr', ip => '192.134.4.1'},
        ],
        ds_digest_pairs => [                            # list of DS/Digest pairs up to 32
                {'ds1' => 'ds-test1'},                   # key values pairs representing ds => digest
                {'ds2' => 'digest2'},                   
        ],
};
ok($engine->start_domain_test($frontend_params_3) == 3);
ok(scalar($engine->{db}->dbh->selectrow_array(q/SELECT id FROM test_results WHERE id=3/)) == 3);

# test test_progress API
ok($engine->test_progress(3) == 0);

require_ok('Runner');
threads->create( sub { Runner->new({ db => 'ZonemasterDB::SQLite'} )->run(3); } )->detach();

sleep(5);
ok($engine->test_progress(3) > 0);

foreach my $i (1..20) {
	sleep(5);
	my $progress = $engine->test_progress(3);
	print STDERR "pregress: $progress\n";
	last if ($progress == 100);
}
ok($engine->test_progress(3) == 100);
$test_results = $engine->get_test_results({ id => 1, language => 'fr-FR' });
ok(defined $test_results->{id});
ok(defined $test_results->{params});
ok(defined $test_results->{creation_time});
ok(defined $test_results->{results});
ok(scalar(@{$test_results->{results}}) > 1);


my $offset = 0;
my $limit = 10;
my $test_history = $engine->get_test_history( { frontend_params => $frontend_params_1, offset => $offset, limit => $limit } );
print STDERR Dumper($test_history);
ok(scalar(@$test_history) == 2);
ok($test_history->[0]->{id} == 1 || $test_history->[1]->{id} == 1);
ok($test_history->[0]->{id} == 2 || $test_history->[1]->{id} == 2);

done_testing();