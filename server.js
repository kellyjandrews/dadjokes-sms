const express = require('express');
const bodyParser = require('body-parser');
const request = require('superagent');
const Nexmo = require('nexmo');

const app = express();
const port = process.env.PORT || 3000;

const nexmo = new Nexmo({
    apiKey: process.env.NEXMO_KEY,
    apiSecret: process.env.NEXMO_SECRET
  });

app.use(bodyParser.json());

app.get('/up', (req, res) => {
  res.sendStatus(200);
});

app.post('/sms', (req, res) => {
  let message;
  if (req.body.keyword === "JOKE") {
    request
      .get('https://icanhazdadjoke.com/')
      .set('accept', 'application/json')
      .then((res) => {
        nexmo.message.sendSms(req.body.to, req.body.msisdn, res.body.joke, (err, res) =>{
          console.log(res);
        });
      });
  } else {
    nexmo.message.sendSms(req.body.to, req.body.msisdn, 'Did not recognize that keyword', (err, res) =>{
      console.log(res);
    });
  }
  res.sendStatus(200);
});


app.listen(port, () => console.log(`Example app listening on port ${port}!`));
