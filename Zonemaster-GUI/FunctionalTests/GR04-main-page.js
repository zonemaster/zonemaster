var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR04 - [On launching the URL opens with a default simple view]', 5, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
		test.assert(response != undefined && response.status == 200 , 'Page loaded');
	});

	casper.then(function() {
		test.assert(
			this.evaluate(
				function() {
					return (document.evaluate('//h1[(.="Domain name")]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue.offsetParent != null)?true:false;
				}
			),
			'[Domain name] label visible'
		);
	});

	casper.then(function() {
		test.assert(
			this.evaluate(
				function() {
					return (document.evaluate('//label[contains(., "Advanced options")]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue.offsetParent != null)?true:false;
				}
			),
			'[Advanced options] label visible'
		);
	});

	casper.then(function() {
  		test.assertNot(
			this.evaluate(
				function() {
					return (document.evaluate('//legend[contains(., "Nameservers")]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue.offsetParent != null)?true:false;
				}
			),
			'[Nameservers label] NOT visible'
		);
	});

	casper.then(function() {
  		test.assertNot(
			this.evaluate(
				function() {
					return (document.evaluate('//legend[contains(., "Digests")]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue.offsetParent != null)?true:false;
				}
			),
			'[Digests] NOT visible'
		);
	});

	casper.run(function() {
		test.done();
	});
	
});
