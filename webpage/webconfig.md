# Web.config 組態檔

<script type="text/javascript" src="../js/general.js"></script>

Web.config 在微軟 Web 系統開發中扮演著硬體、伺服器設定或是關鍵訊息儲存等重要資訊的文件。

###Web.config 設置內容
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

* connectionStrings : 常定義連接資料庫字串，如 SQL Server 等

* appSettings : 常定義使用的常數値

* rewrite : IIS 或 Azure 的頁面重導原則，底下為 Azure 上強制使用 https 的設定

```XML
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
</system.webServer>
```

* 設定首頁頁面

```Xml
<system.webServer>
  <defaultDocument>
    <files>
      <clear />
      <add value="login.aspx"/>
    </files>
  </defaultDocument>
</system.webServer>
```

* MIME Type 定義

```Xml
<system.webServer>
  <staticContent>
    <mimeMap fileExtension=".mp4" mimeType="video/mp4" />
    <mimeMap fileExtension=".css" mimeType="text/css" />
    <remove fileExtension=".woff" />
    <mimeMap fileExtension=".woff" mimeType="application/font-woff" />
    <mimeMap fileExtension="." mimeType="application/octet-stream" />
  </staticContent>
<system.webServer>
```

  1. mimeMap 定義附檔名與處理方式
  2. remove 則是將伺服器處理此類檔案的規則去除，此將導致伺服器無法取得此類型檔案資源
  3. 若附檔名為 "."， 處理方式為 "application/octet-stream"，則代表將所有資料都以串流方式下載。

###C# 使用方法
---

* 使用 connectionStrings

若 Web.config 設定如下：

```Xml
<connectionStrings>     
  <add name="DbConnectionString" connectionString="Data Source=url;Initial Catalog=initDB;User ID=user;Password=pwd" providerName="System.Data.SqlClient" />
</connectionStrings>
```

則在 C# 中使用方式為：

```Xml
using System.Web.Configuration;

string connectionString = WebConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;
```

* 使用 appSettings

若 Web.config 設定如下：

```Xml
<appSettings>
  <add key="firewall" value="0.0.0.0/0.0.0.0"/>
</appSettings>
```

則在 C# 中使用方式為：

```Xml
using System.Web.Configuration;

string appString = System.Web.Configuration.WebConfigurationManager.AppSettings["firewall"];
```









