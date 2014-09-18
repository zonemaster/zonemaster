var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR01 - [Supports French language]', 3, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	//
	casper.then(function() {
		test.assertExists(x('//lang[@lang="fr"]'), "Link fro French language exists");
	});

	//start the tests
	casper.then(
		function() {
			this.click(x('//lang[@lang="fr"]//a'));
		}
	);

	casper.then(function() {
		test.assertExists(x('//h1[.="Noom de domaine"]'), "The interface seems to speak French");
	});

	casper.run(function() {
		test.done();
	});
	
});