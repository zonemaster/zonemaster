var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET history. */
router.get('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request('get_test_history', { frontend_params : JSON.parse(req.param('data')), limit:200, offset:0 }, function(err, error, response) {
    if(err) throw err;
    res.json({result: response});
  });
});

module.exports = router;
