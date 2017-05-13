# HTTPS over Node.js

<script type="text/javascript" src="../js/general.js"></script>

### Express 環境建立
---

```bash
# 建立 express 下，設計 https 協定之模組
$ express -e nodejs-https

# 移至該目錄並安裝必要模組
$ cd nodejs-https && npm install
```

### 透過 openssl 產生私鑰, 證明文件與證書
---

```bash
# 產生私鑰
$ openssl genrsa -out private.key 2048

# 透過私鑰加簽證明文件
$ openssl req -new -sha256 -key private.key -out certreq.csr

# 產生證書
$ openssl x509 -req -in certreq.csr -signkey private.key -out certificate.pem
```

### 建立於 express-https 上的應用
---

* 於 app.js 底下，建立 https 服務

```javascript
...

// create a https service

var https = require('https')
	,fs = require("fs");

var options = {
		key: fs.readFileSync('./private.key'),
		cert: fs.readFileSync('./certificate.pem')
};

https.createServer(options, app).listen(3443, function () {
	console.log('Https server listening on port ' + 3443);
});

...
```





