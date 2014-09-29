use strict;
use warnings;
use 5.10.1;

use Data::Dumper;
use Test::More;   # see done_testing()

# Require Engine.pm test
require_ok( 'Engine' );
require Engine;

# Create Engine object
my $engine = Engine->new({ db => 'ZonemasterDB::SQLite'} );
isa_ok($engine, 'Engine');

# create a new memory SQLite database
ok($engine->{db}->create_db());

# add test user
ok($engine->add_api_user({username => "zonemaster_test", api_key => "zonemaster_test's api key"}) == 1);
ok(scalar($engine->{db}->dbh->selectrow_array(q/SELECT * FROM users WHERE user_info like '%zonemaster_test%'/)) == 1);

# add a new test to the db
my $frontend_params = {
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
ok($engine->start_domain_test($frontend_params) == 1);
ok(scalar($engine->{db}->dbh->selectrow_array(q/SELECT id FROM test_results WHERE id=1/)) == 1);

# test test_progress API
ok($engine->test_progress(1) == 0);
sleep(1);
ok($engine->test_progress(1) > 0);

my $zm_answer = '[{"args":{"ns":"ns1.nic.fr/2001:660:3003:2::4:1","type":"NS"},"level":"NOTICE","module":"BASIC","tag":"IPV6_DISABLED","timestamp":10.8784198760986},{"args":{"ns":"ns2.nic.fr/2001:660:3005:1::1:2","type":"NS"},"level":"NOTICE","module":"BASIC","tag":"IPV6_DISABLED","timestamp":10.9100270271301},{"args":{"ns":"ns3.nic.fr/2001:660:3006:1::1:1","type":"NS"},"level":"NOTICE","module":"BASIC","tag":"IPV6_DISABLED","timestamp":10.9415099620819},{"args":{"address":"2001:660:3003:2::4:1","ns":"ns1.nic.fr"},"level":"ERROR","module":"CONNECTIVITY","tag":"NAMESERVER_NO_UDP_53","timestamp":54.9922239780426},{"args":{"address":"2001:660:3005:1::1:2","ns":"ns2.nic.fr"},"level":"ERROR","module":"CONNECTIVITY","tag":"NAMESERVER_NO_UDP_53","timestamp":54.9956109523773},{"args":{"address":"2001:660:3006:1::1:1","ns":"ns3.nic.fr"},"level":"ERROR","module":"CONNECTIVITY","tag":"NAMESERVER_NO_UDP_53","timestamp":55.0000920295715},{"args":{"address":"2001:660:3003:2::4:1","ns":"ns1.nic.fr"},"level":"ERROR","module":"CONNECTIVITY","tag":"NAMESERVER_NO_TCP_53","timestamp":55.0046410560608},{"args":{"address":"2001:660:3005:1::1:2","ns":"ns2.nic.fr"},"level":"ERROR","module":"CONNECTIVITY","tag":"NAMESERVER_NO_TCP_53","timestamp":55.0092289447784},{"args":{"address":"2001:660:3006:1::1:1","ns":"ns3.nic.fr"},"level":"ERROR","module":"CONNECTIVITY","tag":"NAMESERVER_NO_TCP_53","timestamp":55.0135390758514},{"args":{"address":"192.134.4.2","ns":"dnsmaster.nic.fr"},"level":"WARNING","module":"ZONE","tag":"MNAME_NO_RESPONSE","timestamp":70.9114940166473},{"args":{"mname":"dnsmaster.nic.fr","ns":"ns1.nic.fr;ns2.nic.fr;ns3.nic.fr"},"level":"NOTICE","module":"ZONE","tag":"MNAME_NOT_IN_GLUE","timestamp":70.9120888710022},{"args":{"refresh":7200,"required_refresh":14400},"level":"WARNING","module":"ZONE","tag":"REFRESH_MINIMUM_VALUE_LOWER","timestamp":70.9141309261322},{"args":{"required_retry":3600,"retry":1800},"level":"WARNING","module":"ZONE","tag":"RETRY_MINIMUM_VALUE_LOWER","timestamp":70.9193060398102},{"args":{"address":"2001:660:3003:2::4:1","ns":"ns1.nic.fr"},"level":"WARNING","module":"NAMESERVER","tag":"QUERY_DROPPED","timestamp":71.4672119617462},{"args":{"address":"2001:660:3005:1::1:2","ns":"ns2.nic.fr"},"level":"WARNING","module":"NAMESERVER","tag":"QUERY_DROPPED","timestamp":71.498596906662},{"args":{"address":"2001:660:3006:1::1:1","ns":"ns3.nic.fr"},"level":"WARNING","module":"NAMESERVER","tag":"QUERY_DROPPED","timestamp":71.528205871582},{"args":{"name":"afnic.fr"},"level":"NOTICE","module":"SYNTAX","tag":"ONLY_ALLOWED_CHARS","timestamp":71.5300140380859}]';
ok($engine->{db}->dbh->do( "UPDATE test_results SET progress=100, test_end_time=datetime('now'), results = ".$engine->{db}->dbh->quote($zm_answer)." WHERE id=1 ") == 1);

ok($engine->test_progress(1) == 100);

$engine->get_test_results($id_test));
say "--------------------------";


done_testing();