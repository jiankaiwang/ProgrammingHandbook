# FTP in CSharp

<script type="text/javascript" src="../gitbook/app.js"></script>
<script type="text/javascript" src="../js/general.js"></script>

### Web.config 設定

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

```C#
protected void ftpUpload()
{

	// Get the object used to communicate with the server.
	FtpWebRequest request = (FtpWebRequest)WebRequest.Create(upload_to);
	request.Method = WebRequestMethods.Ftp.UploadFile;

	// Use user and its password to login the ftp server
	request.Credentials = new NetworkCredential(ftpUser, ftpPassword);

	// Copy the contents of the file to the request stream.
	StreamReader sourceStream = new StreamReader(upload_from);
	byte[] fileContents = System.Text.Encoding.UTF8.GetBytes(sourceStream.ReadToEnd());
	sourceStream.Close();
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
		
	}

	// get status of ftp
	FtpWebResponse response = (FtpWebResponse)request.GetResponse();
	

	// regular expression to check 226 status reporting
	string pattern = "226";
	foreach (Match match in Regex.Matches(response.StatusDescription, pattern, RegexOptions.IgnoreCase))
	{
		
	}
	Response.Write("OK");
	response.Close();
}
```