var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR01 - [Supports Swedish language]', 3, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	//
	casper.then(function() {
		test.assertExists(x('//lang[@lang="sw"]'), "Link for Swedish language exists");
	});

	//start the tests
	casper.then(
		function() {
			this.click(x('//lang[@lang="sw"]//a'));
		}
	);

	casper.then(function() {
		test.assertExists(x('//h1[.="Domännamn"]'), "The interface seems to speak Swedish");
	});

	casper.run(function() {
		test.done();
	});
	
});
