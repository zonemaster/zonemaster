use Test::More;

BEGIN { use_ok('Giraffa::Translator')}

my $trans = new_ok('Giraffa::Translator' => [{lang => 'sv'}]);

eval { Giraffa::Translator->new; };
like($@, qr/Must have at least one of lang and file/, 'expected error message');

is($trans->lang, 'sv', 'expected language code');

eval {$trans->file};
like($@, qr[Cannot read translation file .+/lib/auto/share/dist/Giraffa/language_sv.json], 'expected error message');

$trans = Giraffa::Translator->new({lang => 'tech'});
eval {$trans->data};
ok(!$@, 'no error reading translation data');

ok(exists $trans->data->{BASIC}{NO_GLUE}, 'expected key exists');

done_testing;