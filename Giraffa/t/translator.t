use Test::More;

BEGIN { use_ok('Giraffa::Translator')}

my $trans = new_ok('Giraffa::Translator' => [{lang => 'sv'}]);

eval { Giraffa::Translator->new; };
like($@, qr/Must have at least one of lang and file/);

done_testing;