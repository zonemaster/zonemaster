var express = require('express');
var router = express.Router();

/* GET angular pages. */
router.get('/:file', function(req, res) {
  res.render('ang/'+req.param('file'), { title: 'Express' });
});

module.exports = router;
