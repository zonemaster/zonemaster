var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET progress. */
router.get('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request({method:'test_progress', params:req.param('id')}, function(err, error, response) {
    if(err) throw err;
    res.json({ progress : response });
  });
});

module.exports = router;
