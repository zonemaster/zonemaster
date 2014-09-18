var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR06 - [The simple view should have a shortcut to undelegated view and FAQ]', 3, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	casper.then(function() {
  		test.assert(
			this.visible(x('//a[contains(., "Inactive domain check")]')),
			'The tab [Inactive domain check] IS visible'
		);
	});

	casper.then(function() {
		test.assert(
			this.visible(x('//a[contains(., "FAQ")]')),
			'The tab [FAQ] IS visible'
		);
	});

	casper.run(function() {
		test.done();
	});
	
});