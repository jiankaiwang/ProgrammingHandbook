# upload & post in PHP

<script type="text/javascript" src="../js/general.js"></script>

### 調整 PHP 中 POST Request 與檔案上傳的限制
---

* 調整 php 組態檔即可

```bash
# 編輯此 php 組態檔案
$ sudo vim /etc/php.ini

# 調整上傳檔案大小限制
upload_max_filesize = 50M

# 調整 POST 請求限制
post_max_size = 20M

# 重新啟動 apache 取得最新組態値
$ sudo systemctl restart httpd
```


