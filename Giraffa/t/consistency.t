use Test::More;

use Giraffa;
use Giraffa::Nameserver;

# my $datafile = 't/consistency.yaml';
# if ( not $ENV{GIRAFFA_RECORD} ) {
#     die "Stored data file missing" if not -r $datafile;
#     Giraffa::Nameserver->restore( $datafile );
#     Giraffa->config->{no_network} = 1;
# }

my %res = map {$_->tag => 1} Giraffa->test_module('consistency', 'iis.se');
ok($res{ONE_NS_SET}, 'One NS set');
ok($res{ONE_SOA_SERIAL}, 'One SOA serial');

%res = map {$_->tag => 1} Giraffa->test_module('consistency', 'com');
ok($res{ONE_NS_SET}, 'One NS set');
ok($res{MULTIPLE_SOA_SERIALS}, 'One SOA serial');
ok($res{SOA_SERIAL}, 'SOA serial');

# if ( $ENV{GIRAFFA_RECORD} ) {
#     Giraffa::Nameserver->save( $datafile );
# }

done_testing;