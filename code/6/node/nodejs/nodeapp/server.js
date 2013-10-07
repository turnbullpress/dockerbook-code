var fs = require('fs');
var express = require('express'),
    app = express(),
    redis = require('redis'),
    RedisStore = require('connect-redis')(express),
    server = require('http').createServer(app);

var logFile = fs.createWriteStream('/var/log/nodeapp/nodeapp.log', {flags: 'a'});

app.configure(function() {
  app.use(express.logger({stream: logFile}));
  app.use(express.cookieParser('keyboard-cat'));
  app.use(express.session({
        store: new RedisStore({
            host: process.env.REDIS_HOST || 'redis_primary',
            port: process.env.REDIS_PORT || 6379,
            db: process.env.REDIS_DB || 0
        }),
        cookie: {
            expires: false,
            maxAge: 30 * 24 * 60 * 60 * 1000
        }
    }));
});

app.get('/', function(req, res) {
  res.json({
    status: "ok"
  });
});

app.get('/hello/:name', function(req, res) {
  res.json({
    hello: req.params.name
  });
});

var port = process.env.HTTP_PORT || 3000;
server.listen(port);
console.log('Listening on port ' + port);
