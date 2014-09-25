var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR07 - [The advanced view should support the possibility of enabling or disabling IPv4 or IPv6]', 7, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	// Click advanced options
	casper.then(
		function() {
			this.click(x('//label[contains(., "Advanced options")]//input[@type="checkbox"]'));
		}
	);

	// Check enable/disable IPv4
        casper.then(function() {
                test.assert(
                        this.visible(x('//label[@class="checkbox" and contains(., "IPv4")]')),
                        '[IPv4 checkbox] IS visible'
                );
		test.assert(
			this.click(x('//label[@class="checkbox" and contains(., "IPv4")]')),
                        'Possible to enable [IPv4 checkbox]'
                );
		test.assert(
                        this.click(x('//label[@class="checkbox" and contains(., "IPv4")]')),
                        'Possible to disable [IPv4 checkbox]'
                );
        });

	// Check enable/disable IPv6
	casper.then(function() {
  		test.assert(
			this.visible(x('//label[@class="checkbox" and contains(., "IPv6")]')),
			'[IPv6 checkbox] IS visible'
		);
                test.assert(
                        this.click(x('//label[@class="checkbox" and contains(., "IPv6")]')),
                        'Possible to enable [IPv6 checkbox]'
                );
                test.assert(
                        this.click(x('//label[@class="checkbox" and contains(., "IPv6")]')),
                        'Possible to disable [IPvo6 checkbox]'
                );
	});

	casper.run(function() {
		test.done();
	});
	
});
