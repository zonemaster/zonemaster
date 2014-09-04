var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET parent. */
router.get('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request({method:'get_data_from_parent_zone_1', params:req.param('domain')}, function(err, error, response) {
    if(err) throw err;
    res.json({result: response});
  });
});

module.exports = router;
