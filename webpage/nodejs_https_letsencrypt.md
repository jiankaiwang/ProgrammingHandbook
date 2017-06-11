# Nodejs over https on let's Encrypt

<script type="text/javascript" src="../js/general.js"></script>

### Start Let's Encrypt
---

* Refer to the [page](https://jiankaiwang.gitbooks.io/itsys/content/information_security/server_lets_letsencrypt.html).

### On Let's Encrypt
---

```javascript
var https = require('https');
var fs = require('fs');

var options = {
  key: fs.readFileSync('/etc/letsencrypt/live/example.com/privkey.pem'),
  cert: fs.readFileSync('/etc/letsencrypt/live/example.com/cert.pem'),
  ca: fs.readFileSync('/etc/letsencrypt/live/example.com/chain.pem')
};

https.createServer(options, function (req, res) {
  res.writeHead(200);
  res.end("hello world\n");
}).listen(8000);
```

### Expressjs On Let's Encrypt
---

```javascript
var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , fs = require('fs')
  , http = require('http')
  , https = require('https')
  , path = require('path');

var app = express();

// all environments
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));
app.use('/node_modules', express.static(path.join(__dirname, '/node_modules')));

var port = { "http" : 80, "https" : 443 }
  , allowService = { "http" : true, "https" : true };

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/users', user.list);

// http
if ( allowService["http"] ) {
  http.createServer(app).listen(port["http"], function(){
    console.log('Express listening on port ' + port["http"]);
  });
}

// https
if ( allowService["https"] ) {
  var options = {
    key: fs.readFileSync('/etc/letsencrypt/live/example.com/privkey.pem'),
    cert: fs.readFileSync('/etc/letsencrypt/live/example.com/cert.pem'),
    ca: fs.readFileSync('/etc/letsencrypt/live/example.com/chain.pem')
  };

  https.createServer(options, app).listen(port["https"], function(){
    console.log('Express listening on port ' + port["https"]);
  });
}
```





