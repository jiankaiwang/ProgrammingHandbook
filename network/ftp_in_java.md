# FTP in Java

<script type="text/javascript" src="../js/general.js"></script>

* Necessary resource : [commons-net-3.4.jar (org.apache)](http://commons.apache.org/proper/commons-net/download_net.html)

* API 及範例 :
  1. FTP Upload :
  2. FTP Download :

###FTP Upload 函式
---

底下為實作出將串流傳入上傳至 ftp 的內容。

* Parameter :
  * ftpHost : FTP 主機的 URL 或 IP 位址
  * ftpPort : FTP 服務於 FTP 主機上的開啟 port (command port)
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
        // connect to the server, but this is void function in version 3.4
        ftp.connect(ftpHost, ftpPort);
        
        // try to login the ftp server, while login success, return true
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

* 底下為實作出 FTP Download 的函式，並透過 ** UTF-8 ** 編碼方式下載資料。
* 下載若為成功，可以透過讀取 ftpDataString 字串將下載內容取出。
* ftpDataString : 為下載檔案後的內容，以 String 方式儲存。
* Parameter
  * ftpHost : ftp server URL 或 IP 位址
  * ftpPort : FTP 服務於 FTP 主機上的開啟 port (command port)
  * ftpUser : 登入 FTP 主機的使用者
  * ftpPwd : 使用者的密碼
  * ftpKeepAliveTime : FTP 連線存活時間
  * ftpFullDownloadFilePath : 要從 FTP Server 下載的檔案位址
* return
  * 0 : success
  * -1 : can not login ftp server
  * -2 : can not read the file or file does not exist

```Java
public String ftpDataString;

public int FTPDownloadBody(
  String ftpHost,
  int ftpPort,
  String ftpUser,
  String ftpPwd,
  int ftpKeepAliveTime,
  String ftpFullDownloadFilePath
) {
  int ftpDownloadStatus = 0;

  FTPClient ftpClient = new FTPClient();

  try {
      ftpClient.connect(ftpHost, ftpPort);

      if(! ftpClient.login(ftpUser, ftpPwd)) {
          // ftp login is failure
          return -1;
      }

      // time for ftp keep alive
      ftpClient.setControlKeepAliveTimeout(ftpKeepAliveTime);
      ftpClient.setConnectTimeout(ftpKeepAliveTime);
      ftpClient.setControlKeepAliveReplyTimeout(ftpKeepAliveTime);

      // enable passive mode to prevent 500 illegal port number
      ftpClient.enterLocalPassiveMode();

      // download ftp data as stream	
      BufferedReader input = new BufferedReader(new InputStreamReader(ftpClient.retrieveFileStream(ftpFullDownloadFilePath),"UTF-8"));
      int str = input.read();
      if(str != -1) {
          while(str >= 0) {
              ftpDataString = String.format("%s%c", ftpDataString, (char)str);
              str = input.read();
          }
          input.close();
      } else {
          input.close();
          return -2;
      }

      // ftp disconnect
      ftpClient.disconnect();

  } catch (IOException e) {
      // ftp connection is failure
      ftpDownloadStatus = -1;
  } 

  return ftpDownloadStatus;
}
```








