var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET version. */
router.get('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request('version_info', {}, function(err, error, response) {
    if(err) throw err;
    res.json({result: response + ", IP address: " + req.ip});
  });
});

module.exports = router;
