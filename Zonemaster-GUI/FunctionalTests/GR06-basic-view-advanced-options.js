var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR06 - [The simple view should support an advanced view expanding when the checkbox is enabled]', 5, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	casper.then(function() {
  		test.assertNot(
			this.visible(x('//label[@class="checkbox" and contains(., "IPv4")]')),
			'[IPv4 checkbox] NOT visible'
		);
	});

	casper.then(function() {
  		test.assertNot(
			this.visible(x('//label[@class="checkbox" and contains(., "IPv6")]')),
			'[IPv6 checkbox] NOT visible'
		);
	});
	
	casper.then(
		function() {
			this.click(x('//label[contains(., "Advanced options")]//input[@type="checkbox"]'));
		}
	);

	casper.then(function() {
  		test.assert(
			this.visible(x('//label[@class="checkbox" and contains(., "IPv4")]')),
			'[IPv4 checkbox] IS visible'
		);
	});

	casper.then(function() {
  		test.assert(
			this.visible(x('//label[@class="checkbox" and contains(., "IPv6")]')),
			'[IPv6 checkbox] IS visible'
		);
	});

	casper.run(function() {
		test.done();
	});
	
});