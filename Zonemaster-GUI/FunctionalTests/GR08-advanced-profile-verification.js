var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR08 - [The advanced view should support the possibility of choosing a profile from multiple profiles]', 4, function suite(test) {

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

	//
	casper.then(function() {
		test.assertExists(".ng-valid.ng-dirty");
		this.click(".ng-valid.ng-dirty");
		test.assert(
                        this.click(x('//option[@value="test_profile_1" and contains(., "Test profile 1")]')),
                        'Able to select Test profile 1'
                );
		this.click(".ng-valid.ng-dirty");
                test.assert(
                        this.click(x('//option[@value="test_profile_2" and contains(., "Test profile 2")]')),
                        'Able to select Test profile 2'
                );
               
	});

	casper.run(function() {
		test.done();
	});
	
});
