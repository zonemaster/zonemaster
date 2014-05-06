use Test::More;

BEGIN {
    use_ok('Zonemaster');
    use_ok('Zonemaster::Test::Delegation');
}

my $datafile = 't/delegation.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->{no_network} = 1;
}

my $iis = Zonemaster->zone('iis.se');
my %res = map {$_->tag => $_} Zonemaster::Test::Delegation->all($iis);
ok($res{ADDRESSES_MATCH},'ADDRESSES_MATCH');
ok($res{ENOUGH_NS}, 'ENOUGH_NS');
ok($res{ENOUGH_NS_GLUE}, 'ENOUGH_NS_GLUE');
ok(!$res{INZONE_HAS_GLUE}, 'INZONE_HAS_GLUE');
ok($res{NAMES_MATCH}, 'NAMES_MATCH');
ok($res{REFERRAL_SIZE_OK}, 'REFERRAL_SIZE_OK');

%res = map {$_->tag => $_} Zonemaster->test_module('delegation', 'nic.se');
ok($res{INZONE_HAS_GLUE}, 'INZONE_HAS_GLUE');

%res = map {$_->tag => $_} Zonemaster->test_module('delegation', 'crystone.se');
ok($res{EXTRA_NAME_PARENT}, 'EXTRA_NAME_PARENT');
ok($res{EXTRA_NAME_CHILD}, 'EXTRA_NAME_CHILD');
ok($res{TOTAL_NAME_MISMATCH}, 'TOTAL_NAME_MISMATCH');

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;