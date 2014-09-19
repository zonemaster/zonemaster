var main_url = 'http://zonemaster.rd.nic.fr:5080/';

casper.test.begin('Zonemaster test GR28 - Valid title for the Web interface', 2, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	// Start the test
	casper.then(function() {
		this.test.assertTitle('Zonemaster');   
	});

	casper.run(function() {
		test.done();
	});
	
});
