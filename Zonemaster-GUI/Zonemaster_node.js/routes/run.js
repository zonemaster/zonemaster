var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET run. */
router.post('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  var data = req.param('data');
  client.request({method:'start_domain_test', params:JSON.parse(data)}, function(err, error, response) {
    if(err) throw err;
    res.json({ job_id : response });
  });
});

module.exports = router;
