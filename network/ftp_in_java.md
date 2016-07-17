# FTP in Java

<script type="text/javascript" src="../js/general.js"></script>

* Necessary resource : [commons-net-3.4.jar (org.apache)](http://commons.apache.org/proper/commons-net/download_net.html)

* API 及範例 :
  1. FTP Upload :
  2. FTP Download :

###FTP Upload 函式
---

* 底下為實作出將串流傳入上傳至 ftp 的內容

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

###FTP Download 函式
---