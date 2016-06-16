# Web.config 組態檔

<script type="text/javascript" src="../js/general.js"></script>

Web.config 在微軟 Web 系統開發中扮演著硬體、伺服器設定或是關鍵訊息儲存等重要資訊的文件。

###Web.config 設置
---

```XML
<?xml version="1.0" encoding="utf-8"?>

<!--
  如需如何設定 ASP.NET 應用程式的詳細資訊，請造訪
  http://go.microsoft.com/fwlink/?LinkId=169433
  -->

<configuration>
    <connectionStrings>     
      <add name="DbConnectionString" connectionString="Data Source=url;Initial Catalog=initDB;User ID=user;Password=pwd" providerName="System.Data.SqlClient" />
    </connectionStrings>
    <appSettings>
      <add key="firewall" value="0.0.0.0/0.0.0.0"/>
    </appSettings>
    <system.web>
      <compilation debug="true" targetFramework="4.5" />
      <httpRuntime requestValidationMode="2.0" targetFramework="4.5" />
      <pages validateRequest="false"/>
      <customErrors mode="Off"/>
    </system.web>
  <system.webServer>
    <rewrite>
      <rules>
        <rule name="Force HTTPS" enabled="true">
          <match url="(.*)" ignoreCase="false" />
          <conditions>
            <add input="{HTTPS}" pattern="off" />
          </conditions>
          <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" appendQueryString="true" redirectType="Permanent" />
        </rule>
      </rules>
    </rewrite>
    <defaultDocument>
      <files>
        <clear />
        <add value="login.aspx"/>
      </files>
    </defaultDocument>
    <staticContent>
      <mimeMap fileExtension=".mp4" mimeType="video/mp4" />
      <mimeMap fileExtension=".m4v" mimeType="video/m4v" />
      <mimeMap fileExtension=".json" mimeType="application/json" />
      <mimeMap fileExtension=".css" mimeType="text/css" />
      <remove fileExtension=".woff" />
      <mimeMap fileExtension=".woff" mimeType="application/font-woff" />
      <remove fileExtension=".woff2" />
      <mimeMap fileExtension=".woff2" mimeType="application/font-woff2" />
      <mimeMap fileExtension="." mimeType="application/octet-stream" />
    </staticContent>
  </system.webServer>  
</configuration>
```



