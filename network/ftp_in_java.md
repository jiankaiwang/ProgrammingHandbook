# FTP in Java

<script type="text/javascript" src="../js/general.js"></script>

* Necessary resource : [commons-net-3.4.jar (org.apache)](http://commons.apache.org/proper/commons-net/download_net.html)

* API 及範例 :
  1. FTP Upload :
  2. FTP Download :

###FTP Upload 函式
---

底下為實作出將串流傳入上傳至 ftp 的內容

* Parameter :
  * ftpHost : FTP 主機的 URL 或 IP 位址
  * ftpPort : FTP 服務於 FTP 主機上的開啟 port
  * ftpUser : 登入 FTP 主機的使用者
  * ftpPwd : 使用者的密碼
  * ftpKeepAliveTime : FTP 連線存活時間
  * ftpFulUploadFilePath : 上傳至 FTP 伺服器的哪個位址
  * getDataString : 要上傳的內容，可以從文字透過 ByteArray 而成，或是透過 FileInputStream 建立

* 回傳値 :
  * 0 : 上傳成功
  * -1 : 該 user 不能登入 FTP Server
  * -2 : 串流不能上傳至 FTP Server 的檔案位址 (可能該位址不存在或無法讀寫等)

```Java
public int ftpUploadBody(
  String ftpHost,
  int ftpPort,
  String ftpUser,
  String ftpPwd,
  int ftpKeepAliveTime,
  String ftpFulUploadFilePath,
  InputStream getDataString
) {   	
    // create a ftp client object
    FTPClient ftp = new FTPClient();

    try {
        ftp.connect(ftpHost, ftpPort);
        if(! ftp.login(ftpUser, ftpPwd)) {
            return -1;
        }

        // time for ftp keep alive
        ftp.setControlKeepAliveTimeout(ftpKeepAliveTime);
        ftp.setConnectTimeout(ftpKeepAliveTime);
        ftp.setControlKeepAliveReplyTimeout(ftpKeepAliveTime);

        // enable passive mode to prevent 500 illegal port number
        ftp.enterLocalPassiveMode();

        // upload to the ftp server by input stream
        if(! ftp.storeFile(ftpFulUploadFilePath, getDataString)) {
            // ftp connection close 
            ftp.disconnect();
            return -2;
        }

        // ftp connection close 
        ftp.disconnect();

    } catch (IOException e) {
        // ftp connection is failure 
        return -1;
    }

    return 0;
}
```

* 其他函式

  1. 移動 FTP Server 目錄位址

```java
// change the ftp server directory path
// return true (change successfully), false (can not change to the directory)
if(ftp.changeWorkingDirectory("/home/user/")) {
   ...
}
```

###FTP Download 函式
---