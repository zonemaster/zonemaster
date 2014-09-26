var main_url = 'http://zonemaster.rd.nic.fr:5080/';

var x = require('casper').selectXPath;
casper.test.begin('Zonemaster test GR21 - [Check the existence of broken links]', 4, function suite(test) {

	casper.start();

	casper.thenOpen(main_url, function(response) {
                test.assert(response != undefined && response.status == 200 , 'Page loaded');
        });

        
	// Click Default link
        casper.then(
		function() {
           		this.click(x("//a[normalize-space(text())='Domain check']"	  		  ));
		}
	);
	// Check Default link is broken
	casper.then(
                function() {
			test.assertExists(x('//h1[.="Domain name"]'), 
			"Some content is visible on clicking home link - Hence not broken");
		}
	);

	// Click Undelegated link
        casper.then(
                function() {
			this.click(x("//a[normalize-space(text())='Inactive domain check']"));
                }
        );
        // Check undelegated link is broken
        casper.then(
                function() {
                        test.assertExists(x('//h1[.="Domain name"]'),
                        "Some content is visible on undelegated link - Hence not broken");
                }
        );

 	// Click FAQ
        casper.then(
                function() {
                	this.click(x("//a[normalize-space(text())='FAQ']"));
		}
        );
        // Check FAQ link is broken
        casper.then(
                function() {
                        test.assertExists(x('//h1[.="FAQ"]'),
                        "Some content is visible on FAQ - Hence not broken");
                }
        );

	casper.run(function() {
		test.done();
	});
	
});
