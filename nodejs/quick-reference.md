# Quick Reference



## 運行指令

```javascript
// 初始化一個 node.js 專案
$ npm init

// 安裝一個 node.js 模組入現在的專案底下
// --save 將此模組資訊加入 package.json 中
// -g 將此模組加入本機 node.js 運行環境中，而非僅於此專案
$ npm install [--save] [-g] (module-name)

/* 
 * desc : 運行 node.js 服務
 * 單一入口 : node index.js
 * 依 package.json 啟動整個服務 : npm start
 */
$ node index.js
$ npm start
```



## Node.js 基礎

```nodejs
/*
 * 引用 http 套件
 */
var http = require("http");

/*
 * 自訂套件函式輸出
 * expFun : 外部引用套件函式名
 * funName : 原套件函式名
 */
exports.expFun = funName;

// 啟動伺服器
http.createServer(function(request, response) {
 // request : client 請求，包含 GET/POST、Pathname 與 query 等
 
 /*
  * response : 回應內容
  * status_code : 200 (OK), 404 (not found), 500 (internal error) 等
  */
 response.writeHead(status_code, {"Content-type" : "text/plain"});
 response.write("回應內容");
 response.end();		
 
}).listen(Port);
```



## 建立 Node.js 服務

- 建立 /etc/systemd/system/nodeapp.service 服務

```bash
$ sudo vim /etc/systemd/system/nodeapp.service
```

```conf
[Unit]
Description=Nodejs application
After=network.target

[Service]
User=root
Group=root
ExecStart=/usr/bin/node /home/user/nodeapp/app.js > /var/tmp/nodeapp.log & 2>&1
Restart=always
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/home/user/nodeapp

[Install]
WantedBy=multi-user.target
```

- 管理服務

```bash
# 服務管理
sudo systemctl start redis
sudo systemctl stop redis
sudo systemctl restart redis
sudo systemctl status redis

# 開機啟動
sudo systemctl enable redis
sudo systemctl disable redis
```











