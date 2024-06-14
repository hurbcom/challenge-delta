var express = require('express');
var router = express.Router();
var request = require('request');


var api_url = process.env.API_HOSTT + '/api/status';

/* GET home page. */
router.get('/', function(req, res, next) {
  request(
    {
      method: 'GET',
      url: api_url,
      json: true
    },
    function (error, response, body) {
      if (error || response.statusCode !== 200) {
        return res.status(500).send('error running request to ' + api_url);
      } else {
        res.render('index', {
          title: 'Up and Running!' ,
          request_uuid: body.request_uuid,
          time: body.time
        });
      }
    }
  );
});

router.get('/healthcheck', (req, res) => {
  res.status(200).send('OK');
});

router.get('/readiness', (req, res) => {

  res.status(200).send('OK');
});

module.exports = router;
