var express = require('express');
var router = express.Router();
var jayson = require('jayson');

/* GET result. */
router.get('/', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request('get_test_results', {id:req.param('id'), language:req.param('language')}, function(err, error, response) {
    if(err) throw err;
    res.json({ result : response });
  });
});

router.get('/:id', function(req, res) {
  var client = jayson.client.http({
      host: 'zonemaster.rd.nic.fr',
      port: 5000
  });
  client.request('get_test_results', {id:req.param('id'), language:req.acceptsLanguages()[0]}, function(err, error, response) {
    if(err) throw err;
    res.render('index',{ result : response });
  });
});

module.exports = router;
