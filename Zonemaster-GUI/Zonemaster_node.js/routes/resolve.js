var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET resolve. */
router.get('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request({method:'get_ns_ips', params:req.param('data')}, function(err, error, response) {
    if(err) throw err;
    res.json({result: response});
  });
});

module.exports = router;
