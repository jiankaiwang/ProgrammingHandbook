# FTP in CSharp

<script type="text/javascript" src="../js/general.js"></script>

* 範例檔案 : 
  1. 20160519_FTPinCSharpTemplate.rar
  2. 20160715_ftp.rar
* API 及範例 : 
  1. FTPUpload : [https://github.com/jiankaiwang/seed/blob/master/csharp/FTPUpload.cs](https://github.com/jiankaiwang/seed/blob/master/csharp/FTPUpload.cs)
  2. FTPDownload : [https://github.com/jiankaiwang/seed/blob/master/csharp/FTPDownload.cs](https://github.com/jiankaiwang/seed/blob/master/csharp/FTPDownload.cs)

### Web.config 設定

Web.config 於微軟開發環境中常用來儲存重要的字串內容，如帳號、密碼、資料庫連接與實體路徑等字串。

```Xml
<?xml version="1.0" encoding="utf-8"?>

<!--
  如需如何設定 ASP.NET 應用程式的詳細資訊，請造訪
  http://go.microsoft.com/fwlink/?LinkId=169433
  -->

<configuration>

    <system.web>
      <compilation debug="true" targetFramework="4.5.2" />
      <httpRuntime targetFramework="4.5.2" />
    </system.web>

    <appSettings>

      <!-- production -->
      <add key="ftpUser" value="user"/>
      <add key="ftpPassword" value="password"/>
      <add key="upload_to" value="ftp://ip:port/folder/file.txt"/>
      <add key="upload_from" value="filepath\file.txt"/>

    </appSettings>
  
</configuration>
```

###FTP 上傳函式
---

使用的必要資源

```C#
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
```

從 Web.config 取得 ftp 必要上傳資料

```C#
private string ftpUser = System.Web.Configuration.WebConfigurationManager.AppSettings["ftpUser"];   // ftp user name
private string ftpPassword = System.Web.Configuration.WebConfigurationManager.AppSettings["ftpPassword"];   // ftp user password
private string upload_to = System.Web.Configuration.WebConfigurationManager.AppSettings["upload_to"];
private string upload_from = System.Web.Configuration.WebConfigurationManager.AppSettings["upload_from"];
```

ftp 上傳實作內容，執行後會回傳一個 ftp 上傳狀態字串，可以透過檢核此上傳狀態進行上傳結果確認；相關內容如下：

```C#
/*
 * desc : upload file to ftp server
 * parameter :
 * 1. ftpUser : ftp user
 * 2. ftpPassword : used password
 * 3. upload_from : the local file in complete path ready for uploading to ftp server
 * 4. upload_to : the complete path on the server for get the file
 * return :
 * 0 : upload successfully
 * 1 : can not access to the ftp server
 * 2 : ftp uploading is failure
 */

public int ftpUpload(String ftpUser, String ftpPassword, String upload_from, String upload_to)
{
    // Get the object used to communicate with the server.
    FtpWebRequest request = (FtpWebRequest)WebRequest.Create(upload_to);
    
    // set ftp connection type to uploadfile
    request.Method = WebRequestMethods.Ftp.UploadFile;

    // Use user and its password to login the ftp server
    request.Credentials = new NetworkCredential(ftpUser, ftpPassword);

    // Copy the contents of the file to the request stream.
    StreamReader sourceStream = new StreamReader(upload_from);

    // Use UTF-8 as encoding type
    byte[] fileContents = System.Text.Encoding.UTF8.GetBytes(sourceStream.ReadToEnd());

    sourceStream.Close();

    // get content length
    request.ContentLength = fileContents.Length;

    // make sure access to the remote is connected
    try
    {
        Stream requestStream = request.GetRequestStream();
        requestStream.Write(fileContents, 0, fileContents.Length);
        requestStream.Close();
    }
    catch (Exception e)
    {
        // can not access the ftp server
        return 1;
    }

    FtpWebResponse response = (FtpWebResponse)request.GetResponse();

    // regular expression to check 226 status reporting
    string pattern = "226";

    // use check flag to make sure ftp uploading is complete
    int checkStatus = 0;

    foreach (Match match in Regex.Matches(response.StatusDescription, pattern, RegexOptions.IgnoreCase))
    {
        if (match.ToString().Equals(pattern)) {
            checkStatus = 1;
        }
    }

    response.Close();

    switch(checkStatus)
    {
        case 1:
            // Status : FTP upload successfully.
            return 0;
        default:
            // Status : FTP uploading is failure.
            return 2;
    }
}
```

###FTP 下載函式
---

* 底下實作出 FTP 下載資料的內容
  1. 下載是否成功可以透過檢核狀態來達成
  2. 下載結果會取得字串串流，可以視狀況決定是否寫入檔案

```C#
/*
 * desc : download file from ftp server
 * parameter :
 * 1. ftpUser : ftp user
 * 2. ftpPwd : used password
 * 3. ftpFullDownloadPath : the file path on the ftp server
 * return :
 * -1 : can not login ftp server
 * -2 : download process is not complete
 * (other) : the content of downloaded file
 */

public String ftpDownloadBody(String ftpUser, String ftpPwd, String ftpFullDownloadPath) {
    String retRes = String.Empty;

    // Get the object used to communicate with the ftp server.
    FtpWebRequest request = (FtpWebRequest)WebRequest.Create(String.Format("{0}", ftpFullDownloadPath));

    // set ftp connection type is download
    request.Method = WebRequestMethods.Ftp.DownloadFile;

    // Login FTP Server
    request.Credentials = new NetworkCredential(ftpUser, ftpPwd);

    // get FTP response
    try {
        FtpWebResponse response = (FtpWebResponse)request.GetResponse();

        // convert to stream ready for data stream
        Stream responseStream = response.GetResponseStream();

        // create a object to read data by stream
        StreamReader reader = new StreamReader(responseStream);

        // get all data
        retRes = reader.ReadToEnd();

        // check download status
        string pattern = "226";
        foreach (Match match in Regex.Matches(response.StatusDescription, pattern, RegexOptions.IgnoreCase)) {
            if (! match.Value.Equals(pattern)) {
                retRes = "-2";
            }
        }

        reader.Close();
        response.Close();
    }
    catch {
        retRes = "-1";
    }

    return retRes;
}
```



