var fs = require('fs');
var express = require('express'),
    session = require('express-session')
    cookieParser = require('cookie-parser')
    morgan = require('morgan')
    app = express(),
    redis = require('redis'),
    RedisStore = require('connect-redis')(session),
    server = require('http').createServer(app);

var logFile = fs.createWriteStream('/var/log/nodeapp/nodeapp.log', {flags: 'a'});

app.use(morgan('combined', {stream: logFile}));
app.use(cookieParser('keyboard-cat'));
app.use(session({
        resave: false,
        saveUninitialized: false,
        store: new RedisStore({
            host: process.env.REDIS_HOST || 'redis_primary',
            port: process.env.REDIS_PORT || 6379,
            db: process.env.REDIS_DB || 0
        }),
        secret: 'keyboard cat',
        cookie: {
            expires: false,
            maxAge: 30 * 24 * 60 * 60 * 1000
        }
}));

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
